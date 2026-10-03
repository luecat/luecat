# Orange Pi 3B 客製系統計畫

## 目標

1. **日常桌面**：可以當一般電腦使用，穩定、不閃爍
2. **NPU**：在板子上跑內嵌模型，推論要用 NPU 加速
3. **修 issue**：把官方不修的各種詭異問題一個一個修掉，並記錄在 [ISSUES.md](ISSUES.md)

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
- [ ] 要跑哪些模型？（例如文字 embedding 模型、影像辨識、物件偵測）模型名稱和大小是多少？
- [ ] 螢幕型號、解析度、更新率，有沒有用轉接頭
- [ ] 遇到過的 issue 清單（記錄在 [ISSUES.md](ISSUES.md)）

## 階段

| 階段 | 內容 | 完成標準 |
|---|---|---|
| **0. 診斷** | 在現在的 NVMe 系統上跑 `tools/diag.sh`，收集硬體和顯示資訊 | 知道板子版本、目前的核心、閃爍屬於哪一類 |
| **1. 基礎系統** | SD 卡燒 Armbian 26.04 Vendor + KDE 測試，修閃爍 | 連續使用 1 小時不閃 |
| **2. 客製映像檔** | 建立 `userpatches/`，把修正寫進映像檔，能自己編譯 | 自己編的映像檔開機就沒有已知問題 |
| **3. NPU** | 裝 RKNN runtime、建立 Python 環境，把目標模型轉成 `.rknn` 並在 NPU 上執行 | 目標模型跑在 NPU 上，結果和 CPU 版本一致，連續跑 1 小時不出錯 |
| **4. 修 issue** | 照 [ISSUES.md](ISSUES.md) 一個一個修 | 每個 issue 都有原因和修法，或註明修不了的理由 |
| **5. 安裝到 NVMe** | 用 `armbian-install` 裝到 NVMe | 拔掉 SD 卡也能正常開機 |
| **6. 實驗軌（選做）** | 主線 6.18 + Rocket、PanVK | 能和 Vendor 核心切換使用 |

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
