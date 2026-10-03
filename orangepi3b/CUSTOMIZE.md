# Orange Pi 3B 個人化設定

系統裝好之後的個人化設定。每一項都可以單獨做，不分先後。

**前提**：Ubuntu 26.04 + GNOME + Armbian 主線核心（Current 6.18）。NPU 那一項一定要用主線核心。

## 清單

- [ ] [Mac 風格的快捷鍵](#1-mac-風格的快捷鍵)
- [ ] [Mac 風格的外觀](#2-mac-風格的外觀)
- [ ] [繁體中文和注音輸入法](#3-繁體中文和注音輸入法)
- [ ] [NPU](#4-npu)

---

## 1. Mac 風格的快捷鍵

用 [Toshy](https://github.com/RedBearAK/toshy)，現成工具，不用編譯。

```bash
git clone https://github.com/RedBearAK/toshy
cd toshy
./setup_toshy.py install
```

- 安裝程式會提示你裝一個 **GNOME 擴充功能**（Wayland 下 Toshy 要靠它知道目前是哪個程式），照著裝
- 安裝程式不認得 Ubuntu 26.04 的話，從選單裡手動選 Ubuntu
- 裝完登出再登入

效果（鍵盤上的 Windows 鍵就是 ⌘）：

| 按鍵 | 功能 |
|---|---|
| ⌘C / ⌘V / ⌘X | 複製 / 貼上 / 剪下（終端機裡也可以） |
| ⌘Q / ⌘W | 關閉程式 / 關閉視窗或分頁 |
| ⌘Tab | 切換程式 |
| ⌘Space | 搜尋 |
| Ctrl+C（在終端機裡） | **還是中斷程式** |

**備案**：Toshy 在這塊板子上不能用的話，改用 keyd，只做複製貼上：

```bash
sudo apt install -y keyd
sudo tee /etc/keyd/default.conf > /dev/null <<'EOF'
[ids]
*

[meta]
c = C-insert
v = S-insert
x = S-delete
EOF
sudo systemctl enable --now keyd
```

**完成的樣子**：在終端機、瀏覽器、文字編輯器、檔案管理員裡，⌘C/V 都能用；終端機裡 Ctrl+C 還是能中斷程式。

---

## 2. Mac 風格的外觀

```bash
# 視窗按鈕放左邊（關閉、最小化、最大化）
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'

# Dock 放底部、置中、不撐滿
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false

# 調校工具，用來套用主題
sudo apt install -y gnome-tweaks
```

Mac 風格的主題、圖示、游標（[WhiteSur](https://github.com/vinceliuice/WhiteSur-gtk-theme)）：

```bash
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-gtk-theme
WhiteSur-gtk-theme/install.sh

git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme
WhiteSur-icon-theme/install.sh

git clone --depth=1 https://github.com/vinceliuice/WhiteSur-cursors
WhiteSur-cursors/install.sh
```

裝完打開「調校工具」（GNOME Tweaks）→ 外觀，把圖示、游標、舊版應用程式換成 WhiteSur。

觸控板自然捲動：設定 → 滑鼠和觸控板。

**覺得卡的話**，RK3566 的 GPU 比較弱，把動畫關掉：

```bash
gsettings set org.gnome.desktop.interface enable-animations false
```

**還原**：

```bash
gsettings reset org.gnome.desktop.wm.preferences button-layout
gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position
gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height
gsettings reset org.gnome.desktop.interface enable-animations
```

---

## 3. 繁體中文和注音輸入法

```bash
sudo apt install -y $(check-language-support -l zh-hant) fonts-noto-cjk ibus-chewing
```

1. 設定 → 系統 → 區域和語言 → 語言改成**繁體中文（台灣）**，登出再登入
2. 設定 → 鍵盤 → 輸入來源 → 加入**漢語（台灣）→ 新酷音**
3. 切換輸入法改成 Mac 習慣的 **Ctrl+Space**：設定 → 鍵盤 → 檢視和自訂快捷鍵 → 打字。預設的 Super+Space 會跟 Toshy 的 ⌘Space 衝突
4. 新酷音裡用 **Shift** 或 **Caps Lock** 切換中英

其他輸入法：倉頡、速成裝 `ibus-table-cangjie`、`ibus-table-quick`；想自訂的話用 `ibus-rime`。

注意：

- **不要**設定 `GTK_IM_MODULE` 這類環境變數，GNOME 會自己處理，設了反而會出問題
- Chromium、VS Code 這類程式要加啟動參數才能打中文：
  `--ozone-platform=wayland --enable-wayland-ime`
  Firefox 不用

**完成的樣子**：終端機、Firefox、文字編輯器、LibreOffice 都能打注音，選字窗在游標旁邊；重開機後還是能用。

---

## 4. NPU

用 [rknpu-module](https://github.com/w568w/rknpu-module)：把 Rockchip 的 NPU 驅動做成模組，裝在主線核心上。作者就是在 Orange Pi 3B 上測的。

### 安裝驅動

```bash
# 編譯工具和核心標頭檔
sudo apt install -y dkms build-essential device-tree-compiler linux-headers-current-rockchip64

# 安裝驅動模組（DKMS 會自動編譯，核心更新時也會自動重編）
git clone https://github.com/w568w/rknpu-module
cd rknpu-module
sudo cp -r . /usr/src/rknpu-0.9.8
sudo dkms add rknpu/0.9.8
sudo dkms build rknpu/0.9.8
sudo dkms install rknpu/0.9.8

# DTS overlay（主線 DTB 沒有 NPU 節點，用它補上）
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

### 安裝 runtime 和 Python 套件

- **runtime**：從 Rockchip 的 [airockchip/rknn-toolkit2](https://github.com/airockchip/rknn-toolkit2) 下載 `rknpu2/runtime/Linux/librknn_api/aarch64/librknnrt.so`（**v2.3.2**，跟驅動搭配測試過的版本），放到 `/usr/lib/`
- **Python**：Ubuntu 26.04 的 Python 太新，RKNN 不支援，所以用 `uv` 另外建一個環境：
  ```bash
  curl -LsSf https://astral.sh/uv/install.sh | sh
  uv venv ~/rknn-env --python 3.12
  source ~/rknn-env/bin/activate
  uv pip install rknn-toolkit-lite2
  ```
  PyPI 上找不到的話，改從 rknn-toolkit2 repo 的 `rknn-toolkit-lite2/packages/` 安裝對應 Python 3.12 的 `.whl`

### 測試

跑 [rknn_model_zoo](https://github.com/airockchip/rknn_model_zoo) 裡 RK3566 的範例模型（例如 MobileNet），推論成功就代表 NPU 正常。

### 已知限制

- 這個模組不能用 IOMMU，overlay 預設就是非 IOMMU 模式，不用另外設定
- 模型要先在 **x86_64 電腦**上用 rknn-toolkit2 轉成 `.rknn`，板子上只負責推論

**完成的樣子**：`dmesg` 看得到 rknpu，範例模型在 NPU 上推論成功。

---

## 給板子上 Claude 的開場白

在 `luecat/orangepi3b` 資料夾裡執行 `claude`，第一句貼這段：

> 讀 CLAUDE.md 和 CUSTOMIZE.md，幫我做第 X 項。動開機設定之前先問我。
