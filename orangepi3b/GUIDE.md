# Orange Pi 3B 安裝和設定指南

照順序一步一步做。每一步都有「完成的樣子」，確認做到了再往下。

## 目標

- [ ] **乾淨的 Ubuntu 26.04**：除了核心和開機程式，其他全部是 Ubuntu 官方套件
- [ ] **GNOME 桌面**，HDMI 不閃爍
- [ ] **主線核心 6.18 + NPU**（rknpu 模組）
- [ ] **繁體中文 + 注音輸入法**
- [ ] **Mac 風格**：⌘ 快捷鍵（終端機的 Ctrl+C 不受影響）和外觀
- [ ] **Vulkan 和遊戲**（實驗性）
- [ ] 最後**裝到 NVMe**，拔掉 SD 卡也能開機

## 硬體

- Orange Pi 3B **v2.1**、**4GB** RAM
- 目前的系統在 NVMe 上，開機程式在 SPI Flash
- 測試全程用 SD 卡，**NVMe 上的舊系統到第 9 步之前都不會動**

---

## 1. 準備

- SD 卡：**32GB 以上**
- 鍵盤、滑鼠、螢幕（第一次開機要設定帳號）
- USB 隨身碟（第 9 步備份資料用）
- 映像檔：到 Armbian 的 Orange Pi 3B 下載頁，選 **Ubuntu 26.04、Current（6.18）、Minimal 或 CLI 版**（**不要選有桌面的版本**，桌面我們自己裝官方的）
  - 有 stable 版就用 stable，沒有再用 Rolling

## 2. 燒 SD 卡

**做法 A：用電腦**
用 balenaEtcher 選映像檔、選 SD 卡，按 Flash。

**做法 B：讓板子上的 Claude 燒**（在現在的 NVMe 系統上做）

```bash
sudo apt update && sudo apt install -y git
curl -fsSL https://claude.ai/install.sh | bash
git clone -b claude/ubuntu-orange-pi-3b-yeevca https://github.com/luecat/luecat
cd luecat/orangepi3b
claude
```

插入 SD 卡，跟 Claude 說：「先讀 GUIDE.md。幫我把這個映像檔寫到 SD 卡：（貼上下載連結）」。它會先跟你確認哪個裝置是 SD 卡，再寫入。

**完成的樣子**：SD 卡燒好了。

## 3. 第一次開機，裝 GNOME

1. 關機，插 SD 卡，開機
   - 如果開進的還是舊系統：關機，拔掉 NVMe 再開機
2. 照畫面設定 root 密碼、建立使用者、時區
3. 確認是從 SD 卡開機：
   ```bash
   findmnt /      # 要看到 mmcblk...
   ```
4. 裝 Ubuntu 官方的 GNOME 桌面：
   ```bash
   sudo apt update && sudo apt full-upgrade -y
   sudo apt install -y ubuntu-desktop
   sudo reboot
   ```
5. 關掉用不到的 Armbian 附加功能（**關掉就好，不要移除套件**）：
   ```bash
   # log 放在記憶體裡是用來保護 SD 卡的，之後裝到 NVMe 就不需要
   sudo sed -i 's/^ENABLED=.*/ENABLED=false/' /etc/default/armbian-ramlog
   ```

**完成的樣子**：開機後是 GNOME 登入畫面，裡面的程式（終端機 Ptyxis、檔案、文字編輯器、設定）都是 Ubuntu 官方的。

## 4. 基本檢查和閃爍

```bash
sudo apt install -y git
curl -fsSL https://claude.ai/install.sh | bash
git clone -b claude/ubuntu-orange-pi-3b-yeevca https://github.com/luecat/luecat
cd luecat/orangepi3b
sudo bash tools/diag.sh
claude
```

跟 Claude 說：「讀 GUIDE.md 和 ISSUES.md，看 diag 結果，檢查 DTB 和閃爍」。

自己也確認：

- **有線網路能用**：代表 DTB 選對了（v2.1）
- **Wi-Fi 能用**
- **螢幕不閃**：用 1 小時看看。如果會閃，告訴 Claude 是哪一種：
  - A. 整個畫面黑一下
  - B. 雜點、橫線、抖動
  - C. 只有移動視窗的時候閃

閃爍常見的修法（Claude 會幫你試）：

```bash
# 固定 60.00Hz：在 /boot/armbianEnv.txt 的 extraargs= 加上
video=HDMI-A-1:1920x1080@60

# 關掉 GNOME 動畫，看是不是動畫造成的
gsettings set org.gnome.desktop.interface enable-animations false
```

**完成的樣子**：有線網路、Wi-Fi 正常，用 1 小時不閃。

## 5. 繁體中文和注音輸入法

```bash
sudo apt install -y $(check-language-support -l zh-hant) fonts-noto-cjk ibus-chewing
```

1. 設定 → 系統 → 區域和語言 → 語言改成**繁體中文（台灣）**，登出再登入
2. 設定 → 鍵盤 → 輸入來源 → 加入**漢語（台灣）→ 新酷音**
3. 切換輸入法改成 Mac 習慣的 **Ctrl+Space**：設定 → 鍵盤 → 檢視和自訂快捷鍵 → 打字（預設的 Super+Space 會跟第 6 步的 ⌘Space 衝突）
4. 新酷音裡用 **Shift** 或 **Caps Lock** 切換中英
5. Chromium、VS Code 這類程式要加啟動參數才能打中文：
   `--ozone-platform=wayland --enable-wayland-ime`
   Firefox 不用

**不要**設定 `GTK_IM_MODULE` 這類環境變數，GNOME 會自己處理，設了反而會出問題。

**完成的樣子**：終端機、Firefox、文字編輯器、LibreOffice 都能打注音，選字窗在游標旁邊；重開機後還是能用。

## 6. Mac 風格

### 快捷鍵：Toshy

```bash
git clone https://github.com/RedBearAK/toshy
cd toshy
./setup_toshy.py install
```

- 安裝程式會提示你裝一個 **GNOME 擴充功能**（Wayland 下 Toshy 要靠它知道目前是哪個程式），照著裝
- 如果安裝程式不認得 Ubuntu 26.04，從選單裡手動選 Ubuntu
- 裝完登出再登入

效果：

| 按鍵 | 功能 |
|---|---|
| ⌘C / ⌘V / ⌘X | 複製 / 貼上 / 剪下（終端機裡也可以） |
| ⌘Q / ⌘W | 關閉程式 / 關閉視窗或分頁 |
| ⌘Tab | 切換程式 |
| Ctrl+C（在終端機裡） | **還是中斷程式** |

鍵盤上的 Windows 鍵就是 ⌘。

萬一 Toshy 在這塊板子上不能用，請 Claude 改用 keyd，只做 ⌘C/V/X。

### 外觀

```bash
# 視窗按鈕放左邊（關閉、最小化、最大化）
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'

# Dock 放底部、置中、不要撐滿
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false

# 主題工具
sudo apt install -y gnome-tweaks
```

Mac 風格的主題、圖示、游標（例如 **WhiteSur**），請 Claude 幫你下載安裝，再用「調校工具」（GNOME Tweaks）套用。

覺得卡的話，把動畫關掉（第 4 步的指令）。

**完成的樣子**：⌘C/V 在每個程式都能用，終端機的 Ctrl+C 還是中斷；外觀像 Mac；重開機後設定都還在。

## 7. NPU

使用 [rknpu-module](https://github.com/w568w/rknpu-module)：作者就是在 Orange Pi 3B 上測的。

```bash
# 1. 編譯工具和核心標頭檔
sudo apt install -y dkms build-essential device-tree-compiler linux-headers-current-rockchip64

# 2. 安裝驅動模組（DKMS 會自動編譯，核心更新時也會自動重編）
git clone https://github.com/w568w/rknpu-module
cd rknpu-module
sudo cp -r . /usr/src/rknpu-0.9.8
sudo dkms add rknpu/0.9.8
sudo dkms build rknpu/0.9.8
sudo dkms install rknpu/0.9.8

# 3. 安裝 DTS overlay（主線 DTB 沒有 NPU 節點，用它補上）
make dtbo
sudo make install-dtbo
```

在 `/boot/armbianEnv.txt` 加一行（已經有 `user_overlays=` 的話，用空格接在後面）：

```
user_overlays=rk3566-rknpu
```

重開機後確認：

```bash
sudo modprobe rknpu
dmesg | grep -i rknpu      # 要看到 Initialized rknpu 0.9.8
ls -l /dev/dri/renderD*
```

再請 Claude 幫你裝 runtime（`librknnrt.so` v2.3.2，從 Rockchip 的 airockchip/rknn-toolkit2 下載）、用 `uv` 建一個獨立的 Python 環境裝 `rknn-toolkit-lite2`，跑一個官方範例模型。

已知限制：這個模組不能用 IOMMU，所以用 overlay 預設的非 IOMMU 模式，不用另外設定。

**完成的樣子**：`dmesg` 看得到 rknpu，官方範例模型在 NPU 上推論成功。

## 8. Vulkan 和遊戲（實驗性）

```bash
sudo apt install -y mesa-vulkan-drivers vulkan-tools
ls /usr/share/vulkan/icd.d/ | grep -i panfrost
PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=1 vulkaninfo --summary
PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=1 vkcube
```

- 這個環境變數只在要用 Vulkan 的程式前面加，**不要設成全系統預設**
- Ubuntu 的 Mesa 沒有附 PanVK 的話，可以自己編 Mesa（見 [BUILDING.md](BUILDING.md) 第 7 關）

遊戲：

| 類型 | 程式 | 預期 |
|---|---|---|
| 紅白機、超任、GBA、PS1 | RetroArch、DuckStation | 很順 |
| PSP、Dreamcast | PPSSPP、Flycast | 多數可以玩，可能要降解析度 |
| 原生 Linux 遊戲 | SuperTuxKart、Luanti、OpenTTD | 輕量的可以 |
| GameCube、Wii、PS2、Steam 的 PC 遊戲 | — | 大多跑不動 |

每個遊戲都試試 OpenGL 和 Vulkan，哪個順就用哪個（目前通常是 OpenGL 比較穩）。玩遊戲時建議裝散熱片，畫面設 720p。

**完成的樣子**：`vkcube` 連續轉 10 分鐘不當機；想玩的遊戲能順順地玩。

## 9. 裝到 NVMe

**SD 卡上的系統用幾天、確定都沒問題再做。這一步會清空整顆 NVMe。**

1. **備份 NVMe 上的資料**（請 Claude 幫你找分割區、複製到 USB 隨身碟）：
   ```bash
   lsblk
   sudo mount /dev/nvme0n1p1 /mnt      # p1 換成實際的分割區
   # 把要留的檔案複製到 USB 隨身碟
   sudo umount /mnt
   ```
2. **備份 SPI 裡的舊開機程式**：
   ```bash
   sudo dd if=/dev/mtdblock0 of=~/spi-backup.img
   # 也複製到 USB 隨身碟
   ```
3. **安裝**（選單介面，要你自己操作）：
   ```bash
   sudo armbian-install
   ```
   - 選 **Boot from SPI - system on SATA, USB or NVMe**
   - 目標選 `/dev/nvme0n1`，檔案系統選 **ext4**
   - 問要不要把開機程式寫進 SPI：**Yes**
4. 關機，**拔掉 SD 卡**，開機
5. 確認：
   ```bash
   findmnt /      # 要看到 nvme0n1...
   ```

SD 卡上做好的所有設定都會一起複製過去。SD 卡留著當救援卡。

**完成的樣子**：拔掉 SD 卡也能開機，所有功能都跟在 SD 卡上一樣。

## 10. 之後：修 issue

遇到怪問題，跟板子上的 Claude 說：「記一筆 issue：（描述症狀）」。它會記進 [ISSUES.md](ISSUES.md)，找原因、修正，並記下怎麼還原。

---

## 救援

| 狀況 | 處理方式 |
|---|---|
| 插 SD 卡還是開進舊系統 | 關機，拔掉 NVMe 再開機 |
| 裝到 NVMe 後開不了機 | 插回 SD 卡開機，重跑 `armbian-install`，確認有寫入 SPI |
| 插 SD 卡也開不了 | 用電腦重燒 SD 卡；必要時用 `spi-backup.img` 還原 SPI |
| 改壞了 GNOME 設定 | 登入畫面選別的使用者，或在 tty（Ctrl+Alt+F3）用指令改回來 |

## 給板子上 Claude 的開場白

在 `luecat/orangepi3b` 資料夾裡執行 `claude`，第一句貼這段：

> 讀 CLAUDE.md、GUIDE.md、ISSUES.md。我目前在 GUIDE.md 的第 X 步，幫我繼續。動 SPI、NVMe、開機設定之前一定要先問我。
