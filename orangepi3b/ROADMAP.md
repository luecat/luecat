# Orange Pi 3B 客製系統計畫

## 目標

1. **日常桌面**：可以當一般電腦使用，穩定、不閃爍
2. **NPU**：在板子上跑嵌入模型（embedding，把文字轉成向量），推論要用 NPU 加速
3. **修 issue**：把官方不修的各種詭異問題一個一個修掉，並記錄在 [ISSUES.md](ISSUES.md)

**目前的優先順序：先把作業系統弄好（Phase 0 到 2、4、5）。** NPU 本身在 Phase 1 就要確認能正常運作（和桌面同時使用沒有衝突）；延後的只有嵌入模型的轉換和服務（Phase 3），之後也可能改用 CPU 跑。

## 架構決策

| 層 | 主線（日常使用） | 實驗軌（之後再做） |
|---|---|---|
| 編譯框架 | Armbian build + `userpatches/` | 同左 |
| 系統 | Ubuntu 26.04 | 同左 |
| 桌面 | KDE Plasma 6（可以切 X11 和 Wayland，方便排查） | 同左 |
| 核心 | **Vendor 6.1**（Rockchip BSP） | 主線 6.18 + Rocket RK3568 patch |
| NPU | **rknpu 驅動 + RKNN**（`.rknn` 模型） | Rocket + Mesa Teflon（TFLite 模型） |
| GPU | panfrost + 最新 Mesa（Phase 0 要確認 Vendor 核心能不能用 panfrost） | panfrost + PanVK（Vulkan，實驗性） |

**為什麼日常使用選 Vendor 核心：**

- RKNN 的工具鏈最成熟：ONNX、TFLite、PyTorch 都能轉成 `.rknn`，支援的運算子也最多（包括 transformer 類模型需要的 op）
- HDMI 的相容性比主線好
- Rocket 和 Teflon 目前主要支援卷積網路，transformer 或 embedding 模型很可能大部分會退回 CPU

**NPU 的 Python 版本問題：** RKNN 的 Python 套件通常落後於 Ubuntu 26.04 的 Python 版本，所以 NPU 用 `uv` 建立獨立環境，裝它支援的 Python 版本。系統本身照樣用最新版。

## 待確認

- [ ] 板子版本：v1.1 或 v2.1（看電路板上的印字，或 Wi-Fi 模組上有沒有印 AP6256）
- [ ] RAM 大小：2、4 或 8GB
- [x] 模型類型：文字嵌入模型（embedding）
- [ ] 文字語言：中文、英文還是多語言？（決定用哪個模型）
- [ ] 用途和規模：RAG、搜尋還是其他？大概要處理多少文件、每段多長？
- [ ] 螢幕型號、解析度、更新率，有沒有用轉接頭
- [ ] 遇到過的 issue 清單（記錄在 [ISSUES.md](ISSUES.md)）

## 階段

| 階段 | 內容 | 完成標準 |
|---|---|---|
| **0. 診斷** | 在現在的 NVMe 系統上跑 `tools/diag.sh`，收集硬體和顯示資訊 | 知道板子版本、目前的核心、閃爍屬於哪一類 |
| **1. 基礎系統** | SD 卡燒 Armbian 26.04 Vendor + KDE 測試，修閃爍；確認 NPU 驅動載入，裝 librknnrt 跑官方範例模型 | 連續使用 1 小時不閃；NPU 範例模型推論成功 |
| **2. 客製映像檔** | 建立 `userpatches/`，把修正寫進映像檔，能自己編譯 | 自己編的映像檔開機就沒有已知問題 |
| **3. NPU（延後）** | 嵌入模型轉成 `.rknn`，在 NPU 上執行並包成 API，細節見下方「嵌入模型」 | 達到下方「嵌入模型」的完成標準 |
| **4. 修 issue** | 照 [ISSUES.md](ISSUES.md) 一個一個修 | 每個 issue 都有原因和修法，或註明修不了的理由 |
| **5. 安裝到 NVMe** | 用 `armbian-install` 裝到 NVMe | 拔掉 SD 卡也能正常開機 |
| **6. 實驗軌（選做）** | 主線 6.18 + Rocket、PanVK | 能和 Vendor 核心切換使用 |

## 嵌入模型（Phase 3）

### 流程

```
[x86_64 電腦]
HuggingFace 模型 → 匯出 ONNX（固定序列長度）→ rknn-toolkit2 轉換 + 量化 → .rknn

[Orange Pi]
文字 → tokenizer（CPU）→ NPU 推論（rknn-toolkit-lite2 或 librknnrt）
     → pooling + L2 正規化（CPU）→ 向量 → HTTP API（相容 OpenAI embeddings 格式）
```

rknn-toolkit2 只能在 x86_64 上執行，所以轉換在電腦或 GitHub Actions 上做，板子只負責推論。

### 候選模型

| 模型 | 參數量 | 維度 | 語言 | 備註 |
|---|---|---|---|---|
| bge-small-zh-v1.5 | 約 33M | 512 | 中文 | 主要是中文的話選這個 |
| all-MiniLM-L6-v2 | 約 22M | 384 | 英文 | 最輕，適合先把流程跑通 |
| multilingual-e5-small | 約 118M | 384 | 多語言 | 比較慢 |
| bge-m3 | 約 568M | 1024 | 多語言 | 對 0.8 TOPS 太大，不考慮 |

### 要處理的問題

- **固定輸入長度**：轉換時固定序列長度（例如 128 或 256），短句補齊並用 attention mask，長文分段
- **量化**：用實際的文字當校正資料做 INT8 量化；準確度不夠時改用混合量化，敏感的層保留 FP16
- **不支援的 op**：看轉換報告，確認 LayerNorm、Softmax、GELU 等有沒有退回 CPU
- **跟 CPU 比較**：同一個模型用 ONNX Runtime 在 CPU 上跑一次當基準。NPU 不一定比較快，但能把 CPU 空出來給桌面用

### 完成標準

1. **準確度**：NPU 輸出和 FP32 原版的 cosine similarity 平均 > 0.99
2. **檢索一致**：用一組測試問題搜尋，NPU 版和原版的前 10 名結果大致相同
3. **速度**：記錄每秒處理的句數，和 CPU 版比較
4. **穩定**：連續跑 1 小時不出錯、記憶體不持續增加

## 修 issue 的流程

1. **記錄**：在 [ISSUES.md](ISSUES.md) 新增一筆，寫下症狀和重現方式
2. **重現**：確認每次都能重現，並記錄在什麼條件下發生
3. **收集資訊**：跑 `tools/diag.sh`，看 `dmesg` 和 `journalctl`
4. **找原因**：判斷問題在哪一層：硬體、DTS、核心 config、驅動、使用者端軟體
5. **修正**：優先用影響最小、可以還原的方法
   - 設定檔（sysfs、udev、systemd）
   - DTS overlay
   - 核心 config
   - 核心 patch（放在 `userpatches/`）
6. **驗證**：修正之後重新測試，確認沒有影響到其他功能
7. **回饋**：能送回上游（Armbian、Linux、Mesa）的修正就送回去，之後就不用自己維護

## 安全規則

- 動 SPI Flash、分割區、NVMe 之前，**一定要先備份**，而且要先問過使用者
- 測試新系統一律用 SD 卡，NVMe 上能用的系統在確認新系統沒問題之前都不動
- 每個修正都要能還原，並記錄還原的方法

## 預計的 repo 結構

```
orangepi3b/
├── CLAUDE.md          # 給板子上的 Claude Code 看的背景說明
├── ROADMAP.md         # 這份計畫
├── ISSUES.md          # issue 紀錄
├── tools/
│   └── diag.sh        # 診斷腳本（只讀取資訊，不修改系統）
└── userpatches/       # Phase 2 建立：Armbian 客製設定、核心 patch、overlay
```
