# Issue 紀錄

每個問題一筆。狀態：`待診斷` → `已找到原因` → `已修正` / `修不了`。

修正要寫清楚**改了什麼**和**怎麼還原**。

---

## 001 HDMI 閃爍

- **狀態**：待診斷
- **症狀**：螢幕會閃爍（細節待補：整個畫面黑一下？雜點或橫線？還是只有移動視窗時閃？）
- **環境**：NVMe 上的現有系統（版本待補）
- **可能原因**：
  - A. 整個畫面黑一下：pixel clock 有誤差（例如 59.94Hz），或電源、HDMI 線的問題
  - B. 雜點或抖動：Vendor 核心的 DDR 調頻（dmc devfreq）造成顯示控制器 underflow
  - C. 只有移動視窗時閃：桌面合成器或 GPU 驅動
- **診斷**：跑 `tools/diag.sh`，看「顯示」和「devfreq」兩段
- **要試的修正**：
  - 固定 60.00Hz：核心參數 `video=HDMI-A-1:1920x1080@60`
  - DDR 固定高頻：`echo performance | sudo tee /sys/class/devfreq/dmc/governor`（重開機後會失效，要永久生效再寫成 systemd service）
  - GNOME 在 26.04 只有 Wayland，沒辦法切 X11 比較；改用關閉動畫（`gsettings set org.gnome.desktop.interface enable-animations false`）和比較兩個核心來判斷
  - 比較 Vendor 6.1 和 Current 6.18 核心

---

## 002 v2.1 板子用到 v1.1 的 DTB，有線網路完全不能用

- **狀態**：會影響這塊板子（已確認是 v2.1）；待確認目前系統用的 DTB 正確
- **原因**：v1.1 和 v2.1 的乙太網路 PHY IO 電壓（3.3V 和 1.8V）、reset 腳位（GPIO3_C2 和 GPIO4_C4）不同
- **修正**：確認 `/boot/armbianEnv.txt` 的 `fdtfile` 指向 v2.1 的 DTB。主線核心是 `rockchip/rk3566-orangepi-3b-v2.1.dtb`；Vendor 核心的檔名可能不同，以 `/boot/dtb/rockchip/` 裡實際有的檔案為準
- **檢查**：有線網路正常就代表 DTB 正確；`diag.sh` 的「基本資訊」會列出 `fdtfile`
- **參考**：[LKML: Add Xunlong Orange Pi 3B](https://lkml.iu.edu/2406.3/05012.html)

---

## 新增 issue 的格式

```
## 00X 標題

- **狀態**：
- **症狀**：
- **重現方式**：
- **環境**：核心版本、映像檔版本
- **原因**：
- **修正**：
- **還原方式**：
```
