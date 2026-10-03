# Orange Pi 3B 客製系統

這個資料夾是 Orange Pi 3B（Rockchip RK3566）的客製 Ubuntu 專案。使用者說繁體中文，回覆一律用繁體中文。

## 背景

- 硬體：Orange Pi 3B，板子版本（v1.1 或 v2.1）和 RAM 大小待確認
- 目前系統：裝在 NVMe 上，開機程式在 SPI Flash
- 目標：
  1. 當日常桌面電腦使用
  2. 用 NPU 跑文字嵌入模型（embedding）
  3. 修掉官方不修的各種 issue
- 計畫和架構決策見 [ROADMAP.md](ROADMAP.md)，issue 紀錄見 [ISSUES.md](ISSUES.md)

## 規則

- 修改 SPI Flash、分割區、NVMe、開機設定、核心之前，先備份，並且**先問使用者**
- 測試新系統一律用 SD 卡，NVMe 上能用的系統先不要動
- 修正優先用影響最小、可以還原的方法；每個修正都要在 ISSUES.md 記下改了什麼、怎麼還原
- 使用者看得到螢幕，你看不到。閃爍這類顯示問題要請使用者描述，不要從截圖判斷
- 重開機會中斷對話，重開機前先把進度寫進 ISSUES.md，告訴使用者用 `claude --continue` 接回來
- 新的發現（原因、修正、測試結果）都寫進 ISSUES.md，不要只留在對話裡

## 工具

- `tools/diag.sh`：收集診斷資訊，只讀取不修改。用 `sudo bash tools/diag.sh` 執行，輸出存成 `diag-<時間>.txt`
