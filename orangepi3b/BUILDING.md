# 自己編譯：一關一關來

每一關都有看得到的成果。前一關成功再往下走。

## 準備

**編譯用的電腦**（擇一）：

| 電腦 | 說明 |
|---|---|
| **x86_64 Linux**（建議 Ubuntu 24.04 或更新） | 最順，Armbian 官方主要支援的環境 |
| Windows | 用 WSL2 裝 Ubuntu，在 WSL2 裡面操作 |
| macOS | 用 Docker；Apple Silicon 也可以，但比較少人用，可能遇到小問題 |
| Orange Pi 本身 | 可以，但很慢：完整映像檔要好幾個小時，而且要 50GB 以上空間（放在 NVMe 上） |

**最低需求**：4 核心、8GB RAM、**50GB 以上**的可用空間，網路要穩（第一次會下載很多東西）。

```bash
sudo apt install -y git
git clone --depth=1 https://github.com/armbian/build
cd build
```

Armbian 會自己用 Docker 或安裝需要的套件，其他東西不用先裝。

---

## 第 1 關：編出第一個映像檔

**目標**：用預設值編出一個能開機的映像檔，熟悉整個流程。

```bash
./compile.sh
```

不加參數會出現選單，依序選：

1. 板子：`orangepi3b`
2. 核心：`current`（主線 6.18）
3. 系統：Ubuntu 26.04
4. 類型：桌面版，桌面環境選 GNOME

第一次大概要 **1 到 2 小時**（大部分時間在下載和編核心），之後有快取會快很多。

**成果**：`output/images/` 裡的 `.img` 檔。燒進 SD 卡，能開機就過關。

**小技巧**：編完之後，畫面上會印出等效的完整指令。把它記下來，之後就不用再走選單。

---

## 第 2 關：在核心裡留下你的名字

**目標**：學會改核心設定，並且只編核心、不編整個系統。

```bash
./compile.sh kernel-config BOARD=orangepi3b BRANCH=current
```

會打開 menuconfig（文字介面的設定畫面）：

1. 進入 `General setup`
2. 找到 `Local version - append to kernel release`
3. 填入 `-luecat`
4. 存檔離開

接著只編核心：

```bash
./compile.sh kernel BOARD=orangepi3b BRANCH=current
```

**成果**：`output/debs/` 裡的 `linux-image-*.deb`。複製到板子上安裝：

```bash
sudo dpkg -i linux-image-*.deb linux-dtb-*.deb
sudo reboot
uname -r        # 會看到 ...-luecat
```

**安全提醒**：先在 SD 卡的系統上試，不要直接裝在 NVMe 的主系統上。

---

## 第 3 關：寫你的第一個核心 patch

**目標**：學會用 patch 改核心原始碼。

在核心開機時印一行字：

1. 找出這塊板子用的核心 patch 目錄名稱：
   ```bash
   ls patch/kernel/archive/ | grep rockchip64
   ```
   例如看到 `rockchip64-6.18`
2. 建立你自己的 patch 目錄：
   ```bash
   mkdir -p userpatches/kernel/archive/rockchip64-6.18
   ```
3. 寫 patch（可以請 Claude 幫你產生）：在 `init/main.c` 的開機流程裡加一行
   `pr_info("Hello from luecat!\n");`
4. 把 `.patch` 檔放進上面的目錄，重新編核心：
   ```bash
   ./compile.sh kernel BOARD=orangepi3b BRANCH=current
   ```

**成果**：裝上新核心、重開機後：

```bash
dmesg | grep luecat     # Hello from luecat!
```

---

## 第 4 關：把 NPU 放進映像檔

**目標**：讓編出來的映像檔，開機就有 NPU。

- 把 [rknpu-module](https://github.com/w568w/rknpu-module) 的 DTS overlay 放進 `userpatches/overlay/`
- 用 `userpatches/customize-image.sh`（編映像檔時會在映像檔裡面自動執行的腳本）安裝 DKMS 模組和 librknnrt
- 設定 `armbianEnv.txt` 啟用 overlay

**成果**：燒好映像檔開機後，`dmesg | grep -i rknpu` 看得到驅動載入，NPU 範例模型能跑。

---

## 第 5 關：把修正和 Mac 風格都放進去

**目標**：做出「你自己的發行版」。

- 修閃爍的設定（dmc、60Hz）放進 `customize-image.sh`
- Toshy 和 Mac 外觀的設定一起放進去
- 你修好的每個 issue，都變成一個 patch 或一段設定

**成果**：燒完就是你調好的系統，不用再手動設定。

---

## 第 6 關：自動化

**目標**：不用自己的電腦，推上 GitHub 就自動編譯。

- 用 GitHub Actions 跑 Armbian 編譯
- 編好的映像檔自動上傳到 Releases

---

## 第 7 關（番外）：自己編 Mesa，開啟 Vulkan

**目標**：編出最新版的 Mesa，讓 Mali-G52 支援 Vulkan（PanVK，實驗性）。需要主線核心（`current`）。

直接在 Orange Pi 上編最簡單（大約 30 到 60 分鐘）：

```bash
sudo apt build-dep -y mesa      # 需要先在 /etc/apt/sources.list.d/ 開啟 deb-src
sudo apt install -y git meson ninja-build
git clone --depth=1 https://gitlab.freedesktop.org/mesa/mesa.git
cd mesa
meson setup build \
  -Dprefix=$HOME/mesa-install \
  -Dgallium-drivers=panfrost \
  -Dvulkan-drivers=panfrost \
  -Dbuildtype=release
ninja -C build install
```

裝在自己的家目錄，不會蓋掉系統的 Mesa。只在要測試時使用：

```bash
export VK_ICD_FILENAMES=$HOME/mesa-install/share/vulkan/icd.d/panfrost_icd.aarch64.json
export PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=1
vulkaninfo --summary
vkcube
```

**成果**：`vulkaninfo` 列出 Mali-G52，`vkcube` 的方塊在轉。

---

## 遇到問題時

- 錯誤訊息整段貼給 Claude
- 編譯 log 在 `output/logs/`
- 空間不夠是最常見的失敗原因，先用 `df -h` 看看
