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
| 桌面 | **GNOME**（Ubuntu 官方桌面，用 `ubuntu-desktop` 安裝；26.04 只有 Wayland）。原本選 KDE，使用者改成 GNOME | 同左 |
| 核心 | **Vendor 6.1**（Rockchip BSP） | 主線 6.18 + Rocket RK3568 patch |
| NPU | **rknpu 驅動 + RKNN**（`.rknn` 模型） | Rocket + Mesa Teflon（TFLite 模型） |
| GPU | panfrost + 最新 Mesa（Phase 0 要確認 Vendor 核心能不能用 panfrost） | panfrost + PanVK（Vulkan，實驗性） |

**為什麼日常使用選 Vendor 核心：**

- RKNN 的工具鏈最成熟：ONNX、TFLite、PyTorch 都能轉成 `.rknn`，支援的運算子也最多（包括 transformer 類模型需要的 op）
- HDMI 的相容性比主線好
- Rocket 和 Teflon 目前主要支援卷積網路，transformer 或 embedding 模型很可能大部分會退回 CPU

**新核心的選項：** 主線 Current 6.18 加上 [w568w/rknpu-module](https://github.com/w568w/rknpu-module)（把 Vendor 的 rknpu 驅動做成 DKMS 模組，給主線核心用），可能同時得到新核心和官方 RKNN 工具鏈。Phase 1 要同時測 Vendor 6.1 和 Current 6.18（`armbian-config` 可以切換核心）：如果 6.18 的閃爍和其他 issue 比較少，而且 rknpu-module 能在 6.18 上正常運作，就改用 6.18 當主線核心。

**混合核心策略（主線為底，從 BSP 補功能）：** 不把 BSP 整個合併進主線（改動量太大、衝突太多），而是以主線為底，缺什麼功能就從 BSP 挑什麼移植，每項都做成獨立的模組或 patch，出問題可以單獨拿掉。

| 功能 | 主線 6.18 | 補法 |
|---|---|---|
| CPU、USB、NVMe、網路、Wi-Fi、RGA | 有 | 不用補 |
| GPU | panfrost，比 BSP 好 | 不用補 |
| HDMI 顯示、聲音 | 有 | 閃爍要測，有問題再加 patch |
| NPU | 沒有 | 從 BSP 補：rknpu DKMS 模組 |
| 影片硬體解碼 | 部分（V4L2） | 優先用主線方式 + 支援 V4L2 的 FFmpeg；BSP 的 MPP 依賴太深，不移植 |
| 影片硬體編碼、相機 ISP | 有限 | 實測後再評估 |

**NPU 的 Python 版本問題：** RKNN 的 Python 套件通常落後於 Ubuntu 26.04 的 Python 版本，所以 NPU 用 `uv` 建立獨立環境，裝它支援的 Python 版本。系統本身照樣用最新版。

## 待確認

- [x] 板子版本：**v2.1**（Wi-Fi/藍牙是 AP6256，用 brcmfmac 驅動；主線 DTB 是 `rk3566-orangepi-3b-v2.1.dtb`）
- [x] RAM 大小：**4GB**（GNOME 加上小型嵌入模型夠用）
- [x] 模型類型：文字嵌入模型（embedding）
- [ ] 文字語言：中文、英文還是多語言？（決定用哪個模型）
- [ ] 用途和規模：RAG、搜尋還是其他？大概要處理多少文件、每段多長？
- [ ] 螢幕型號、解析度、更新率，有沒有用轉接頭
- [ ] 遇到過的 issue 清單（記錄在 [ISSUES.md](ISSUES.md)）

## 階段

| 階段 | 內容 | 完成標準 |
|---|---|---|
| **0. 診斷** | 在現在的 NVMe 系統上跑 `tools/diag.sh`，收集硬體和顯示資訊 | 知道板子版本、目前的核心、閃爍屬於哪一類 |
| **1. 基礎系統** | SD 卡燒 Armbian 26.04 Minimal + `ubuntu-desktop`（GNOME）測試，修閃爍；確認 NPU 驅動載入，裝 librknnrt 跑官方範例模型；切到 Current 6.18 比較閃爍和 issue，試 rknpu-module | 連續使用 1 小時不閃；NPU 範例模型推論成功；決定日常用哪個核心 |
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

## 客製功能

系統穩定之後（Phase 1 之後）在板子上加上的使用習慣調整。

### Mac 風格的操作習慣（已決定：整台改成 Mac 習慣）

**快捷鍵：用 [Toshy](https://github.com/RedBearAK/toshy)**（現成工具，不用自己編譯）

- 安裝：`git clone https://github.com/RedBearAK/toshy && cd toshy && ./setup_toshy.py install`，安裝程式會自己建 Python 環境、裝相依套件、設定 systemd 使用者服務
- GNOME Wayland 要裝一個 GNOME Shell 擴充功能，Toshy 才知道目前是哪個程式（依程式切換按鍵要靠它）；安裝程式會提示要裝哪一個
- Ubuntu 26.04 太新的話，安裝程式可能不認得，選單裡可以手動指定成 Ubuntu
- ARM64 沒有官方測試紀錄，要實測
- 效果：Super（⌘）當 Mac 的 Command；複製貼上、⌘Q、⌘W、⌘Tab、⌘Space 等都改成 Mac 習慣，終端機會自動對應成 Ctrl+Shift 的版本，Ctrl+C 仍然是中斷程式
- 備案：Toshy 在這塊板子上不能用的話，改用 keyd，只把 Super+C/V/X 對應到 Ctrl+Insert、Shift+Insert、Shift+Delete

**外觀（選做）：** GNOME 設定加上主題就能做到，不用另外編譯

- 視窗按鈕放左邊：`gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'`
- Ubuntu Dock 改成底部置中、只占需要的寬度（設定 → Ubuntu 桌面 → Dock）
- Mac 風格的 GTK 主題、圖示、游標（例如 WhiteSur），用 GNOME Tweaks 套用
- 觸控板自然捲動（設定 → 滑鼠和觸控板）
- GNOME 的動畫比較吃 GPU，在 RK3566 上覺得卡的話：`gsettings set org.gnome.desktop.interface enable-animations false`

**完成標準：** 在終端機（Ptyxis 或 GNOME Terminal）、Firefox 或 Chromium、文字編輯器、檔案管理員裡，⌘+C/V 都能正常複製貼上；終端機裡 Ctrl+C 仍然能中斷程式；重開機後設定仍然有效

### 中文環境和輸入法

**語系和字型**

```bash
sudo apt install -y $(check-language-support -l zh-hant) fonts-noto-cjk
```

`check-language-support` 會列出繁體中文缺少的語言包，再到設定 → 系統 → 區域和語言，把語言改成繁體中文（台灣）。

**輸入法：IBus**（GNOME 內建整合的輸入法框架，GNOME 上比 fcitx5 省事）

```bash
sudo apt install -y ibus-chewing
```

- 注音用 `ibus-chewing`（新酷音）；倉頡、速成等在 `ibus-table-cangjie`、`ibus-table-quick` 等套件；也可以用 `ibus-rime`
- 設定 → 鍵盤 → 輸入來源 → 加入「漢語（台灣）→ 新酷音」
- GNOME 預設用 Super+Space 切換輸入來源，跟 Toshy 的 ⌘Space 會衝突。照 Mac 習慣改成 Ctrl+Space（設定 → 鍵盤 → 快捷鍵 → 打字），新酷音裡用 Shift 或 Caps Lock 切換中英
- 不用設定 `GTK_IM_MODULE` 等環境變數，GNOME 會自己處理
- Chromium 和 Electron 程式（例如 VS Code）要加啟動參數 `--ozone-platform=wayland --enable-wayland-ime` 才能打中文；Firefox 不用

**完成標準**：終端機、Firefox、Chromium、文字編輯器、LibreOffice 都能打中文，選字窗出現在游標旁邊；重開機後輸入法自動啟動

### Vulkan（實驗性，使用者決定不做）

使用者決定不需要 Vulkan，遊戲用 panfrost 的 OpenGL。以下保留當參考。


- Mesa 的 **PanVK** 已經支援 Mali-G52（Bifrost），回報 Vulkan 1.3，但仍是實驗性質，預設不會載入
- 需要主線核心的 **panfrost** 驅動，所以走 Current 6.18；Vendor 6.1 預設用 Mali 閉源的 kbase 驅動，不適用
- 啟用方式：
  ```bash
  sudo apt install mesa-vulkan-drivers vulkan-tools
  ls /usr/share/vulkan/icd.d/ | grep -i panfrost     # 確認 Ubuntu 的 Mesa 有附 PanVK
  PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=1 vulkaninfo --summary
  PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=1 vkcube
  ```
- Ubuntu 的套件沒有附 PanVK，或版本太舊的話，自己編 Mesa（見 [BUILDING.md](BUILDING.md) 第 7 關）
- **完成標準**：`vulkaninfo` 列出 Mali-G52；`vkcube` 連續跑 10 分鐘不當機；再依照要用的程式逐一測試
- 不建議設成全系統預設：桌面繼續用 panfrost 的 OpenGL，只對需要 Vulkan 的程式開啟
- **用途：玩遊戲**。測試清單（每項都比較 OpenGL 和 Vulkan，記錄哪個比較順、哪個比較穩）：

  | 類型 | 程式 | 預期 |
  |---|---|---|
  | 復古遊戲（8/16 位元、GBA、PS1） | RetroArch、DuckStation | 很順，最適合這塊板子 |
  | PSP、Dreamcast | PPSSPP、Flycast | 多數遊戲可玩，可能要降解析度 |
  | 原生 Linux 遊戲 | SuperTuxKart、Luanti、OpenTTD | 輕量的可以；SuperTuxKart 要調低畫質 |
  | GameCube、Wii、PS2 | Dolphin 等 | CPU 和 GPU 都太弱，大多跑不動 |
  | x86 的 PC 遊戲（Steam） | box64 + Wine + DXVK | 不建議，A55 核心太慢，只有很輕的舊遊戲有機會 |

- 效能相關：裝散熱片或風扇；玩遊戲時 CPU governor 設成 performance；畫面解析度設 720p 比較順

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
├── GUIDE.md           # 照著做的安裝和設定步驟
├── CUSTOMIZE.md       # 個人化設定（Mac 風格、輸入法、NPU、Vulkan）
├── ROADMAP.md         # 這份計畫
├── ISSUES.md          # issue 紀錄
├── BUILDING.md        # 自己編譯的練習關卡
├── tools/
│   └── diag.sh        # 診斷腳本（只讀取資訊，不修改系統）
└── userpatches/       # Phase 2 建立：Armbian 客製設定、核心 patch、overlay
```
