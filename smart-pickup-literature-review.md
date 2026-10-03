# 論文分析（全文閱讀＋核實）

> 主題：校園智慧接送系統（高中「大數據物聯網」專題）
> 整理日期：2026-10-03

本研究讀過的 38 篇文獻的逐篇分析，分兩批：

- **第一批（4 篇，第一節）**：專題一開始就讀過、原本請我排除的 4 篇。這次重新取得並閱讀。
- **第二批（34 篇，A～F 節）**：依四個待解決問題和延伸方向搜尋到的候選文獻。
  - A：車輛偵測
  - B：定位與誤觸發
  - C：模擬與實測
  - D：隱私與資安
  - E：多區分流
  - F：台灣資料

**每篇的格式：** 問題 → 資料 → 方法 → 結果 → 核實時發現的問題 → 對本研究。

**全文取得狀況：**
- 38 篇中，31 篇讀了全文。
- 6 篇只取得摘要：付費，或出版社網站阻擋自動下載。這 6 篇只根據學術資料庫（OpenAlex、Semantic Scholar）收錄的摘要原文寫，已標明。
- 1 篇完全無法取得：【Adams20?】，標題對不上。
- 其餘數字都是從原文抄的，並附頁碼或表號。從 PubMed Central 讀的全文沒有頁碼，改附表號或章節號。

**兩種核實標記：**
- **「⚠️ 核實」**：列出搜尋階段的摘要寫錯或寫得不精確的地方（文中「我先前寫」指的就是這些），以及論文本身的疑點。
- **「🔁 二次核對」**：重新逐條對照全文或摘要原文後的第二輪修正。完整清單見文末附註二、三。

> 各篇的場地、樣本數、設備、評估方式都不同，**準確率、誤差、延誤秒數都不能跨論文直接比大小**。

---

## 總覽

圖例：✅ 全文　📄 只有摘要　❌ 未取得

| 類別 | 代號 | 一句話 | 全文 |
|---|---|---|---|
| **第一批（4 篇）** | | | |
| 學校接送實地調查 | 【Cooner09】 | 德州 13 所小學＋5 所國中的接送區排隊與人車衝突調查 | 📄 |
| 學校接送系統 | 【Alagos25】 | 菲律賓 RFID 接送系統：車進校門刷卡，等候區顯示學生姓名；只在大學校園模擬測試 | ✅ |
| 地理圍欄 | 【Adams20?】 | 你給的標題查無此文；最接近的是一篇從資安角度看地理圍欄的碩士專題，未讀到內容 | ❌ |
| 校車追蹤 | 【Hemalatha21】 | GPS＋NodeMCU＋Blynk 的校車追蹤 App；只有操作畫面，沒有量測數據 | ✅ |
| **第二批（34 篇）** | | | |
| A 車輛偵測 | 【Bernas18】 | 10 種低價感測器比較＋實測：單一感測器不夠，磁力計＋光感測器融合達 98% | ✅ |
| | 【Jo14】 | 路邊超音波數車 1 小時，總誤差 −1.53%；兩車並排時遠車會漏算 | ✅ |
| | 【Appiah20】 | 超音波改成上方垂直安裝、單顆、用佔有率估壅塞 | 📄 |
| | 【Amato17】 | Raspberry Pi 攝影機＋小型 CNN 判斷車位；遮擋多時約 90% | ✅ |
| | 【Laroca21】 | YOLO 車牌辨識；台灣車牌資料集 99.2%，商用 OpenALPR 不支援台灣車牌 | ✅ |
| | 【Culik23】 | 路面磁性感測器和錄影比對：全天少算 5–8%，15 分鐘短時段誤差達 30–42% | ✅ |
| | 【Paidi18】 | 露天停車場感測技術綜述，建議影像＋CNN | 📄 |
| B 定位與誤觸發 | 【Shevchenko24】 | 三個實驗量地理圍欄準確度：真實使用中「離開」只偵測到 18% | ✅ |
| | 【Merry19】 | iPhone 6 在校園的 GPS 誤差平均 7–13 m，最大 99.7 m | ✅ |
| | 【Hsu18】 | 香港高樓區 GPS 反射誤差；誤差和衛星仰角有關，和訊號強度無關 | ✅ |
| | 【Chien20】 | 淡江：車上藍牙 beacon 判斷車位與身分；3 個車位的模擬，要 3–9 分鐘才穩定 | ✅ |
| | 【Mackey20】 | 每格一顆 beacon＋手機＋粒子濾波；室外 95% 誤差 2.0 m | ✅ |
| | 【Android】 | Android 官方地理圍欄文件：半徑 100–150 m、延遲最長約 6 分鐘、`DWELL` | ✅ |
| | 【Garzon14】 | 用狀態機把多個圍欄串成「依序穿過才通知」 | 📄 |
| C 模擬與實測 | 【Tsai04】 | 北卡 20 所小學：60% 家長鐘響前就到；總接送 14 分，真正移動只要 4 分 25 秒 | ✅ |
| | 【Liu22】 | VISSIM 假想場景：接送停靠時間 10→60 秒，延誤增加 6–10 秒 | ✅ |
| | 【Zhao20】 | G/M/N 排隊模型＋MATLAB 算中小學接送車位數 | 📄 |
| | 【Shokry24】 | 用 Google Maps API 量 40 所學校周邊旅行時間；放學比上學塞 | ✅ |
| | 【Kearns21】 | 北卡 27 所學校錄影／無人機量隊伍長度的完整 SOP | ✅ |
| | 【TTI03】 | 德州學校交通準則；找不到顯著的隊伍長度模型，改給建議長度表 | ✅ |
| | 【SUMO18】 | 開源模擬軟體 SUMO 的官方引用論文；可用 Python（TraCI）控制 | ✅ |
| | 【Zheng23】 | 交通樞紐接客區的排隊理論模型（不是學校，模擬資料） | ✅ |
| | 【Rahman19】 | 學區道路改善的微觀模擬：降速＋減少出入口最好 | 📄 |
| D 隱私與資安 | 【deMontjoye13】 | 4 個時空點就能認出 95% 的人 | ✅ |
| | 【Primault19】 | 位置隱私保護機制的六大類 | ✅ |
| | 【Feal20】 | 46 款親子監控 App：72% 把資料分給第三方 | ✅ |
| | 【Mirai17】 | Mirai 用 62 組預設帳密感染約 60 萬台 IoT 裝置 | ✅ |
| | 【Ali20】 | 親子監控軟硬體共找到 135 個漏洞 | ✅ |
| | 【NIST26】 | IoT 製造商資安基礎工作（NIST IR 8259 系列） | ✅ |
| E 多區分流 | 【Abdeen21】 | 多停車場的平衡分配演算法（5 個加權因素） | ✅ |
| | 【LinRivano17】 | 智慧停車研究綜述（2000–2016），三大主題 | ✅ |
| F 台灣資料 | 【臺北民調15】 | 臺北市國小接送調查：放學接送機車 37.4% 最多 | ✅ |
| | 【LinChang10】 | 臺北文山區 3 所國小：環境對學童獨立上學的影響 | ✅ |
| | 【Huang24】 | 臺北巷弄交通改善：白天事故 −5%、受傷 −8%（預印本） | ✅ |

---

## 讀完全文後，對 Q1～Q4 的結論

### Q1：如何偵測車流（哪種感測方式適合小規模接送區？）

| 論文 | 方法 | 結果（原文） | 注意 |
|---|---|---|---|
| 【Bernas18】 | 路邊多種低價感測器＋機器學習 | 單一感測器：磁力計 93%、光達 83%、被動紅外線 39%；磁力計＋光感測器 98%（表 8、表 9） | 偵測的是行經車輛，不是停車格；訓練只用 60 個事件 |
| 【Jo14】 | 路邊單顆超音波 | 1 小時 522 台中數到 514 台，總誤差 −1.53%；遠側車道 −6.37%（表 1） | 只測 1 小時、一條路 |
| 【Appiah20】 | 上方垂直安裝的超音波 | 摘要：能以較低成本判斷道路狀況 | 只讀到摘要，沒有數字 |
| 【Amato17】 | Raspberry Pi 攝影機＋CNN | 同停車場約 99.5%；遮擋多的 CNRPark 約 90%（表 2） | 判斷一次約 15 秒 |
| 【Laroca21】 | YOLO 車牌辨識 | 台灣 AOLP 99.2%（Sighthound 87.1%，OpenALPR 不支援）（p. 500） | 需要高階 GPU；AOLP 是 2013 年資料 |
| 【Culik23】 | 路面下磁性感測器 | 全天少算 4.99%／8.32%；15 分鐘短時段誤差 29.71–42.42%（表 3、表 4） | 只測一天，天氣良好 |
| 【Chien20】 | 車上藍牙 beacon | 能判斷車位和車輛身分，但要約 5 分鐘才穩定（§4.2、§5） | 3 個車位的模擬環境 |

**→ 證據的一致方向**
- 單一低價感測器不夠準，組合起來才可靠。
- 側裝的超音波會有「並排遮擋」問題。
- 短時段的計數誤差，比全天平均大得多。
- 接送是約 1 分鐘的短時事件，所以：
  - 「判斷有沒有車」適合用磁力計＋光感測器，或從上方往下照的超音波。
  - 「判斷是誰的車」適合用車牌辨識，或車上 beacon。但 beacon 只適合判斷「已到校門附近」，不適合判斷停在哪一格。
- 這 38 篇裡，**沒有任何一篇在學校接送區實測車輛偵測**。這是本研究可以補上的地方（整個領域是否都沒有，無法保證）。

### Q2：如何避免誤觸發（GPS 誤差有多大？圍欄要怎麼設？）

| 論文 | 比較的條件 | 結果（原文） | 注意 |
|---|---|---|---|
| 【Merry19】 | iPhone 6、校園 6 個測量標、8 種情境 | 平均 7–13 m；只用 GPS 時 RMSE 約 9.9 m；最大 99.7 m（p. 10） | 舊手機、單一校園 |
| 【Hsu18】 | 香港高樓區，低價接收器 | 開闊地約 5 m，高樓區可達約 50 m（圖 1，p. 2） | 不是手機 |
| 【Shevchenko24】 | 半徑 10／50／100 m、iOS／Android、真實使用 | 10 m 半徑進入偵測率 0.65、100 m 為 0.92；真實使用中「進入」精確率 70%、「離開」偵測率 18%（p. 6426–6427、6434） | 場景是歐洲大學，不是學校 |
| 【Shevchenko24】 | 研究 2「進入」事件 | iOS 平均提早約 44 m、55 秒；Android 平均晚約 53 m、146 秒（p. 6425） | 只有 2 位測試者 |
| 【Android】 | 官方文件 | 半徑建議 100–150 m；延遲通常 <2 分鐘，最長約 6 分鐘 | 不是研究，是使用說明 |
| 【Garzon14】 | 多圍欄狀態機 | 可設定「依序穿過才通知」「停留多久才通知」 | 只讀到摘要 |

**→ 證據的一致方向**
- 手機 GPS 的誤差量級是 10 m，偶爾會跳到 100 m；高樓區是 50 m 級。
- 所以圍欄半徑至少要 100 m，而且不能用單一一點決定觸發。
- 「離開」事件非常不可靠（18%），判斷車子離開要改用接送格的感測器。
- iOS 和 Android 的通知時間差可達數分鐘，ETA 倒數不能只靠圍欄事件。
- 這 38 篇裡，**沒有任何一篇把「GPS 圍欄＋近距離感測器」的兩段式確認，用在學校接送上實測過**。這正是本研究的貢獻點。

### Q3：如何模擬、實測（接送時間怎麼量？要模擬什麼？）

| 論文 | 做法 | 結果（原文） | 注意 |
|---|---|---|---|
| 【Tsai04】 | 20 所小學、4 人三站計時＋ARENA 模擬 | 60% 鐘響前就到，等待是晚到者的 3 倍；總接送近 14 分，車隊動後 4 分 25 秒；上車停 63 秒（p. 41、43） | 2004 年美國，校內專用車道 |
| 【Cooner09】 | 18 所德州學校實地調查 | 摘要：多數學校早上和下午都有明顯排隊 | 只讀到摘要 |
| 【Kearns21】 | 27 所學校錄影／無人機＋影片標註 | 建議用第 95 百分位數估隊伍長度（PDF p. 5） | 公立小學才 13 所 |
| 【TTI03】 | 德州 20 所學校實地調查 | 找不到顯著的隊伍長度迴歸模型；小學建議排隊車道 122–458 m（PDF p. 40，表 11） | 德州學校規模 |
| 【Shokry24】 | Google Maps API、40 校 242 路段 | 放學的旅行時間指數高於上學；多數城市服務水準 C–D（p. 10、14） | 看不到校門口的排隊細節 |
| 【Liu22】 | VISSIM 假想場景 | 停靠 10→60 秒，延誤增加 6.38–10.27 秒（§4.4） | 沒有用真實資料校正 |
| 【Alagos25】 | 觀察實際學校 | 每台車 4.83 分（無延遲）～11.77 分（有延遲）（p. 56） | 觀察方法沒有詳述 |

**→ 證據的一致方向**
- 接送問題的核心是「提早到、乾等」，不是「上車本身很慢」。【Tsai04】中真正移動只佔總時間的約三分之一。
- 隊伍長度很難用簡單公式預測（【TTI03】），所以本研究必須自己實測。
- 現成的量測方法有三種，可以組合使用：
  - 三站人工計時（【Tsai04】）
  - 錄影標註（【Kearns21】）
  - Google Maps 旅行時間（【Shokry24】）
- 這 38 篇裡，**沒有用 SUMO 模擬學校接送的論文**。

### Q4：如何定位、資安（位置資料和系統要怎麼保護？）

| 論文 | 研究對象 | 結果（原文） | 注意 |
|---|---|---|---|
| 【deMontjoye13】 | 150 萬人的手機基地台紀錄 | 4 個時空點認出 95% 的人；資料變粗也幾乎不能匿名（p. 1） | 資料精度是基地台，不是 GPS |
| 【Feal20】 | 46 款親子監控 App | 11% 明文傳輸、34% 沒取得同意、72% 分享給第三方（p. 314） | Android 平台 |
| 【Ali20】 | 親子監控軟硬體 | 135 個漏洞；13 套 Android 方案中 7 套用 HTTP 傳個資（arXiv 版 p. 2） | — |
| 【Mirai17】 | Mirai 殭屍網路 7 個月 | 62 組預設帳密，最多約 60 萬台受感染（p. 1093–1094） | — |
| 【Shevchenko24】 | 圍欄研究的隱私設計 | 圍欄座標只存在手機上，不傳給研究者 | 是研究工具，不是正式產品 |

**→ 證據的一致方向**
- 家長的到校軌跡本身就是可以認出身分的資料，所以系統不應保存軌跡，只存「已到達」事件。
- 兒童相關 App 最常見的問題是：權限要太多、傳輸沒加密、資料分給第三方、帳號容易被盜。
- IoT 裝置最基本的防線是改掉預設密碼、關掉不用的連接埠。

---

# 第一批：原本排除的 4 篇

### 【Cooner09】Field Studies of Operations and Conflicts in Drop-Off–Pick-Up Zones　📄

- **書目：** Cooner, S. A. (2009). *Transportation Research Record* 2137: 129–139. DOI 10.3141/2137-14
- **問題：** 小學接送時段常有長隊伍，影響周邊道路。哪些設計和管理方式會影響隊伍表現？
- **資料：** 德州 13 所小學、5 所國中，涵蓋大城市和小城市，大多早上和下午都調查。
- **方法：**
  - 記錄排隊區設計（例如車道數）、管理方式（例如有沒有學校人員指揮上下車），以及每台車載的學生數。
  - 量測隊伍形成與消散，以及行人與車輛的衝突。
- **結果（摘要）：**
  - 多數學校早上和下午都有明顯排隊。
  - 各校管理方式差異很大，有些學校用積極的人員指揮加上多條排隊車道。
  - 摘要沒有具體數字。
- **⚠️ 核實：**
  - 作者人數：我先前寫「Cooner、Fitzpatrick、Wooldridge、Ford 四人」。Crossref 和 OpenAlex 都只列 Cooner 一人，所以以一人為準。
  - 全文是付費的，我沒讀到結果數字。
  - 同一研究計畫（TxDOT 0-4286）的準則報告【TTI03】我讀了全文，四位作者都在那份報告上。
- **對本研究：** 支持「接送排隊是普遍問題」。你手上有全文的話，可以補上數字。

### 【Alagos25】Development of an Efficient Schoolchildren Drop-Off and Pick-Up System in the Philippines　✅

- **書目：** Alagos, Turija, Ramoran, Dadula, Banal (2025). *Journal of Engineering, Environment, and Agriculture Research* 4: 53–65. DOI 10.34002/jeear.v4i1.126
- **問題：** 菲律賓學校接送時段的常見問題：臨停區擁擠、並排停車、找不到學生、人工核對身分很慢。能不能用 RFID 把流程自動化？
- **資料：**
  - **基準：** 作者在一所「條件相近的學校」觀察傳統接送（p. 56）。
  - **原型測試：** 學校規定不能收集學童資料，所以改在大學校園 25×25 m 的場地模擬（p. 60）。用機車當測試車，大學生扮演學童。分「學生有延遲」和「沒延遲」兩種情境，各 30 次。
- **方法：**
  - **硬體：** NodeMCU ESP8266＋MFRC522 RFID 讀卡機，裝在校門入口和出口。每台註冊車輛發一張 RFID 卡。
  - **軟體：** MySQL＋網頁介面，共 8 個頁面（註冊、刷卡紀錄、等候區姓名顯示、剩餘車位、控制室總覽等）。
  - **流程：**
    1. 車到校門刷卡。
    2. 系統比對資料庫，有空位就放行。
    3. 等候區螢幕顯示學生姓名。
    4. 出校門再刷一次，記錄接走時間。
- **結果：**

| 情境 | 有學生延遲 | 沒有學生延遲 |
|---|---|---|
| 原型（模擬測試，p. 62） | 平均 165.9 秒 | 平均 34.1 秒 |
| 傳統作法（實際學校，p. 56） | 706 秒（11.77 分） | 290 秒（4.83 分） |

  - 統計檢定：t(58) = 5.6，p < 0.0001（p. 62）。
  - 讀卡距離在 1.27–6.35 cm 之間測試，超過 5.08 cm 可靠度就下降（p. 62）。作者建議改用超高頻（UHF）RFID。
  - 作者列出的風險：標籤被複製、網路中斷、硬體故障。家長和學生的接受度沒有評估。
- **⚠️ 核實：**
  - 表 2 的「有延遲／無延遲」標籤和內文顛倒（p. 63），以內文為準。
  - 原型（大學生、機車、模擬場地）和傳統作法（實際學校）的條件不同。作者自己也提醒不能直接比較（p. 62）。
  - 基準的觀察方法（幾台車、幾天）沒有詳述。
- **對本研究：**
  - 這是和本研究最接近的前人系統。它在車進校門時才觸發，本研究用 GPS 圍欄在車到之前就通知，這是差異點。
  - 4.83–11.77 分可以當比較基準，但要註明條件不同。
  - 近距離 RFID 的讀取距離太短，不適合車子開過時讀取。

### 【Adams20?】Geofencing as Applied Within the Field of Temporal and Location Tracking　❌

- **問題：** 在 Crossref、OpenAlex 和搜尋引擎都找不到這個完整標題。
- **最接近的候選：** Kasandra Adams (2020)，*Geofencing as Applied Within the Field of Cybersecurity: An Overview of Potential Risks and Advantages*，加州州立大學聖貝納迪諾分校（CSUSB）碩士專題。這筆資料來自搜尋結果。
- **⚠️ 核實：** 典藏庫網站有反爬蟲保護，我沒讀到內容，也無法確認是不是同一篇。
- **對本研究：** 請對照你手上那份的封面。確認後再補分析。

### 【Hemalatha21】An Efficient Android Based School Bus Tracking System　✅

- **書目：** Hemalatha J, Hitaishi K, Mownika V S, Bharat Paul, Vivek Sharma S, Swetha Vura (2021). *International Journal of Engineering Applied Sciences and Technology* 6(1): 383–389
- **問題：** 家長要等校車，又擔心孩子安全。能不能讓家長在手機上看校車的即時位置？
- **資料：** 沒有實驗資料。
- **方法：**
  - **硬體：** GPS 模組接 NodeMCU，把經緯度送到 Blynk 雲端平台，顯示在 Google 地圖上（p. 386）。
  - **三個模組：**
    - 管理員：管理司機和路線，可傳簡訊。
    - 司機：登入後開始、結束行程，位置會被記錄。
    - 家長：查看即時位置（p. 384–386）。
  - **通知：** 校車「從學校出發」「抵達學校」時通知家長；家長可以自設「標記點」，校車經過時手機響鈴（p. 384–385）。
- **結果：** 只有 Blynk 設定步驟的截圖（p. 386–388），**沒有任何量測數據**（定位誤差、通知延遲都沒有）。
- **⚠️ 核實：**
  - 作者共 6 人：4 位大學部學生、2 位助理教授。我先前只寫了 Bharat Paul 一人。
  - 文字有多處用詞錯誤，例如把 Kalman filtering 寫成「Kalman shifting」（p. 383），可信度需要保留。
- **對本研究：** 「標記點響鈴」就是最簡單的地理圍欄。可以當作「前人做過，但沒有驗證準確度」的例子。

---

# 第二批：依四個問題搜尋到的 34 篇

## A　車輛偵測（Q1）

### 【Bernas18】A Survey and Comparison of Low-Cost Sensing Technologies for Road Traffic Monitoring　✅

- **書目：** Bernas, Płaczek, Korski, Loska, Smyła, Szymała (2018). *Sensors* 18(10): 3243. DOI 10.3390/s18103243
- **問題：** 裝在路邊的便宜感測器裡，哪些能準確偵測車輛和行人？
- **資料：**
  - **SN1：** 兩支小米手機放在車道兩側，相距 3.5 m，用內建感測器。
  - **SN2：** 自製路邊節點，被動感測器限 10 美元內、主動感測器限 50 美元內（§3）。
  - **正確答案：** 由觀察員用 App 記錄。訓練用 60 個事件。
- **方法：** 每 1 秒的資料算統計值（最小、最大、中位數、平均、標準差），再用決策樹、KNN、神經網路分類。
- **結果：**
  - **文獻比較表（表 1）：**

| 技術 | 成本 | 裝設容易 |
|---|---|---|
| 地感線圈 | 低 | 否 |
| 攝影機 | 高 | 是 |
| 磁力計 | 低 | 是 |
| 超音波 | 低 | 是 |

  - **單一感測器偵測車輛（表 8）：** 磁力計 93%（範圍約 2 m）、光感測器 60–95%（受日照影響）、光達 83%、被動紅外線 39%。
  - **組合感測器（表 9）：** 被動感測器組合 97–98%，其中磁力計＋光感測器 98%。
  - **偵測行人（表 10）：** 需要雷達、光達這類主動感測器（94–95%）。
  - **定位：** 要在偵測區內定位到 1 m，單一節點只有 75% 以下（§5）。
- **⚠️ 核實：** 我先前寫的比較項目大致正確。但這篇偵測的是「行經的車」，不是「停在格子裡的車」。
- **對本研究：** 接送格落位偵測可以優先試「磁力計＋光感測器」：便宜、不用切路面、實測 98%。

### 【Jo14】Analysis of Vehicle Detection with WSN-Based Ultrasonic Sensors　✅

- **書目：** Jo, Y., Jung, I. (2014). *Sensors* 14(8): 14050–14069. DOI 10.3390/s140814050
- **問題：** 用電池供電的路邊超音波數車，怎麼省電又簡單？
- **資料：** 雙車道、速限 80 km/h 的道路，10:00–11:00 共 1 小時，和錄影比對。
- **方法：**
  - 硬體：SRF04 超音波＋MICAz 節點（8 MHz、4 KB 記憶體）。
  - 依車道寬、車速、聲速（331.5 + 0.61 × 溫度）推算可用的偵測間隔 32–50 ms，選最長的以省電。
  - 演算法：中位數濾波 → 依車道寬量化 → 判斷車輛形狀（§5）。
- **結果（表 1）：**
  - 錄影 522 台，超音波 514 台，總誤差 −1.53%。
  - 近側車道 +0.55%，遠側車道 −6.37%。
  - 誤差類型：並排遮擋 10 次、被雜訊濾掉 7 次、變換車道多算 9 次（近側 2、遠側 7）。
- **⚠️ 核實：** 無錯誤。只測 1 小時，年代較舊。
- **對本研究：** 從側面照，旁邊車道有車時會漏算。建議從上方往下照單一車格。季節氣溫會改變聲速，距離門檻要預留空間。

### 【Appiah20】Ultrasonic sensor based traffic information acquisition system; a cheaper alternative for ITS application in developing countries　📄

- **書目：** Appiah, Quayson, Opoku (2020). *Scientific African* 9: e00487. DOI 10.1016/j.sciaf.2020.e00487
- **問題：** 交通偵測設備的安裝和維護太貴，開發中國家用不起。
- **方法（摘要）：**
  - 既有超音波方案的問題：橫向安裝容易被非車輛物體干擾、需要多顆感測器、耗電。
  - 本篇改成上方或垂直安裝、每個節點一顆感測器、用「佔有率」演算法估計壅塞。
- **結果（摘要）：** 實驗顯示這個設計能判斷道路狀況，成本比其他超音波方案低。
- **⚠️ 核實：**
  - 🔁 二次核對：我先前寫「能偵測汽車、機車、行人，反應時間 0.20–0.35 秒」。摘要原文沒有這些內容，我也沒取得全文，已刪除。
- **對本研究：** 支持「從上方往下照」的裝法。

### 【Amato17】Deep Learning for Decentralized Parking Lot Occupancy Detection　✅（作者預印本）

- **書目：** Amato, Carrara, Falchi, Gennaro, Meghini, Vairo (2017). *Expert Systems with Applications* 72: 327–334. DOI 10.1016/j.eswa.2016.10.055
- **問題：** 能不能讓便宜的攝影機自己判斷車位，只把結果傳出去？
- **資料：**
  - 既有的 PKLot 資料集。
  - 自建的 CNRPark-EXT：義大利 CNR 比薩園區 9 台攝影機，跨季節拍攝，有遮擋和各種角度。
- **方法：**
  - 設計小型卷積神經網路 mAlexNet（3 層卷積＋2 層全連接），在 Raspberry Pi 上執行。
  - 和既有方法比較，並測試換攝影機、換天氣時的表現。
- **結果：**
  - 同一停車場約 99.5%。
  - 在 PKLot 換到沒看過的停車場：mAlexNet 92.72–98.27%，其他方法 84.20–89.83%（表 2，預印本 p. 15–16）。
  - CNRPark：90.13%／90.71%。
  - 一台 Raspberry Pi 約 15 秒判斷 50 格（p. 9）。
  - Raspberry Pi＋相機約 80 歐元，戶外機殼也約 80 歐元。每格成本比地面感測器低一個數量級（p. 24）。
- **⚠️ 核實：**
  - 🔁 二次核對：我先前寫「其他方法 84–88%」。表 2 最高到 89.83%，已改成 84–90%。
- **對本研究：** 一台鏡頭可以顧整個接送區，程式碼有開源。但每次判斷約 15 秒，而且一定要用學校的角度和光線實測。

### 【Laroca21】An Efficient and Layout-Independent Automatic License Plate Recognition System Based on the YOLO Detector　✅

- **書目：** Laroca, Zanlorensi, Gonçalves, Todt, Schwartz, Menotti (2021). *IET Intelligent Transport Systems* 15(4): 483–503. DOI 10.1049/itr2.12030
- **問題：** 做一套不受車牌格式限制、能即時運作的車牌辨識系統。
- **資料：** 8 個公開資料集、5 個地區。包括台灣的 AOLP：2013 年，2,049 張（表 5，p. 492）；每次測試用 683 張（p. 500）。
- **方法：** 三個階段都用 YOLO：
  1. 找出車輛。
  2. 找出車牌並判斷版式。
  3. 一次辨識所有字元，再依版式規則修正。
- **結果（表 9，p. 496）：**

| 資料集 | 本系統 | Sighthound | OpenALPR |
|---|---|---|---|
| 8 個資料集平均 | 96.9% | 87.8% | 90.7% |
| 台灣 AOLP | 99.2% | 87.1% | 不支援 |
| UFPR-ALPR（含機車） | 90.0% | 62.3% | 82.2% |

  - 在 Titan XP GPU 上可跑 73 FPS（p. 498）。
  - 錯誤多出在很像的字元，例如 E/F、B/8（p. 500）。
- **⚠️ 核實：**
  - 🔁 二次核對：我先前寫 AOLP 上「OpenALPR 98.8%」。原文是雙欄排版，表 9 轉成文字時欄位錯位。內文明寫 OpenALPR 不支援台灣車牌，比較的是 Sighthound 87.1% 和本系統 99.2%（p. 500）。
- **對本研究：** 可以用來做「只認註冊車輛」。台灣現行車牌格式需要自己測試，而且需要 GPU。

### 【Culik23】Application of Wireless Magnetic Sensors in the Urban Environment and Their Accuracy Verification　✅

- **書目：** Čulík, Štefancová, Hrudkay (2023). *Sensors* 23(12): 5740. DOI 10.3390/s23125740
- **問題：** 斯洛伐克日利納市埋在路面下的磁性感測器，數車到底準不準？
- **資料：** 在一個路段做 12 小時（5:00–17:00）交通調查，用錄影加 Sierzega 雷達當正確答案（§3.2）。
- **方法：** 感測器每 5 分鐘透過 LoRa 傳資料（失敗時改用 4G），和調查結果逐時段比對。
- **結果：**
  - 全天：進城 4.99%、出城 8.32%，感測器一律少算（表 3、表 4）。
  - 15 分鐘短時段：誤差 29.71–42.42%。
  - 以 2 小時為單位：出城感測器少算 4.8–9.0%。
  - 車速和車種判斷不準；通訊中斷後，資料會堆在一起送出（§6）。
- **⚠️ 核實：**
  - 我先前寫「感測器少算 4.8–9.0%」。這只是出城感測器、以 2 小時為單位的結果，現在把全天和短時段的數字都列出來。
  - 論文本身的疑點：方法段寫調查日期是 2021 年 11 月 11 日，討論段卻寫 2022 年 11 月 11 日，前後不一致。
- **對本研究：** 接送是「短時段」事件，感測器的短時誤差可能很大，一定要自己驗證。它的「感測器 vs 錄影人工計數」流程可以照做。

### 【Paidi18】Smart parking sensors, technologies and applications for open parking lots: a review　📄

- **書目：** Paidi, Fleyeh, Håkansson, Nyberg (2018). *IET Intelligent Transport Systems* 12(8): 735–741. DOI 10.1049/iet-its.2017.0406
- **問題：** 哪些智慧停車感測技術適合露天停車場？
- **結果（摘要）：**
  - 室內停車場常用磁力計、超音波、影像。
  - 露天停車場較適合影像＋CNN 或多代理人系統，因為較便宜、較不受天氣影響。
  - 當時沒有任何應用提供露天停車場的即時車位資訊。
- **⚠️ 核實：** OpenAlex 顯示瑞典達拉納大學典藏庫有免費版，但連線失敗，沒取得全文。
- **對本研究：** 支持「戶外接送區用影像」的選項。

---

## B　定位與誤觸發（Q2）

### 【Shevchenko24】Geofencing in location-based behavioral research: Methodology, challenges, and implementation　✅

- **書目：** Shevchenko, Y., Reips, U.-D. (2024). *Behavior Research Methods* 56(7): 6411–6439. DOI 10.3758/s13428-023-02213-2
- **問題：** 手機地理圍欄的通知準不準？受哪些因素影響？
- **資料（表 3，p. 6417）：**
  - 研究 1：4 位測試者，3 種環境 × 3 種半徑 × iOS/Android × Wi-Fi，共 360 次。
  - 研究 2：2 位測試者，另帶獨立 GPS 記錄器，共 120 次。
  - 研究 3：58 位學生用自己的手機，進出大學校園時填問卷。
- **方法：** 用作者開發的 Samply App。研究 1、2 由測試者走固定路線，研究 3 用問卷回答算出漏報和誤報。
- **結果：**
  - 研究 1，半徑對偵測率的影響（p. 6434）：

| 半徑 | 進入 | 離開 |
|---|---|---|
| 10 m | 0.65 | 0.62 |
| 50 m | 0.90 | 0.92 |
| 100 m | 0.92 | 0.95 |

  - 研究 1：通知當下的位置到圍欄中心，平均距離是進入 87 m、離開 234 m（p. 6421）。
  - 研究 2：
    - 半徑越大、在範圍內停 5 分鐘，偵測率越高。
    - 「進入」事件中，iOS 平均提早約 44 m、55 秒通知；Android 平均晚約 53 m、146 秒（p. 6425）。
  - 研究 3：
    - 「進入」偵測率 70%、精確率 70%。
    - 「離開」偵測率 **18%**、精確率 89%（p. 6426–6427）。
    - iOS 比 Android 好。
  - 作者建議（表 15，p. 6430）：半徑至少 100 m；記錄手機型號；部分 Android 會干擾通知。
  - 隱私設計：圍欄座標只存在手機上。
- **⚠️ 核實：**
  - 我先前寫「觸發地點和邊界相差 87 m／234 m」。原文是到圍欄**中心**的距離。
  - 我先前漏寫「離開」偵測率只有 18%。
  - 🔁 二次核對：iOS／Android 的時間差只限研究 2 的「進入」事件，已註明。
- **對本研究：**
  - 半徑至少 100 m 有實證支持。
  - 不能用「離開」事件判斷車子已經離開。
  - ETA 倒數要預留 iOS／Android 的時間差。

### 【Merry19】Smartphone GPS accuracy study in an urban environment　✅

- **書目：** Merry, K., Bettinger, P. (2019). *PLOS ONE* 14(7): e0219890. DOI 10.1371/journal.pone.0219890
- **問題：** 手機 GPS 在校園和都市環境的誤差有多大？
- **資料：**
  - 美國喬治亞大學校園，從 212 個測量標中選 6 個當正確答案（p. 3–4）。
  - 8 種情境：落葉前／後 × 上午／下午 × 人多／人少時段，每點每種情境量 20 次。
  - 共 160 趟，476 + 479 筆位置（p. 8）。
- **方法：**
  - iPhone 6＋Avenza App，手機放在單腳架加水平儀上，離地約 3 英尺。
  - 先量「只用 GPS」，再開 Wi-Fi 等 2 分鐘後再量。
- **結果：**
  - 平均水平誤差 7–13 m（p. 1）。
  - 只用 GPS 時：RMSE 約 9.9 m；最小 0.05 m、最大 99.7 m，第二大約 30 m（p. 10）。
  - 空曠的點誤差最小；建築比例和誤差的相關係數 0.32（只用 GPS）、0.42（開 Wi-Fi）（表 6，p. 14）。
  - 人多的時段誤差整體略小（p. 1）。
- **⚠️ 核實：**
  - 🔁 二次核對：我先前加了推測「人多時誤差小是因為 Wi-Fi 熱點多」。原文只描述現象，沒有這樣解釋，已刪除。
- **對本研究：**
  - 誤差量級是 10 m，偶爾會跳到 100 m。
  - 實驗設計（固定點、重複量、分情境）可以直接搬到校門口做。

### 【Hsu18】Analysis and modeling GPS NLOS effect in highly urbanized area　✅

- **書目：** Hsu, L.-T. (2018). *GPS Solutions* 22(1): 7. DOI 10.1007/s10291-017-0667-9
- **問題：** 高樓區的 GPS 為什麼會亂跳？能不能建立誤差模型修正？
- **資料：** 香港九龍，低價接收器 u-blox M8，一組 24 小時、一組 30 分鐘。
- **方法：**
  - 用 3D 建築模型模擬訊號路徑，判斷哪些衛星訊號是被大樓反射才收到的（NLOS）。
  - 用差分 GPS 扣掉其他誤差，算出反射造成的距離誤差。
- **結果：**
  - 開闊地靜態約 5 m；高樓區（接收器裝在無人機上移動）可達約 50 m（圖 1，p. 2）。
  - 24 小時共 128,054 筆反射訊號，超過 70% 的虛擬距離（pseudorange）誤差在 50 m 以內。誤差分布是長尾的 Gamma 分布（p. 6）。
  - 誤差和衛星仰角有關，和訊號強度（C/N₀）無關。
  - 提出的模型：誤差 = α·sec θ·(1 + cos 2θ)（式 9，p. 8）。
  - 平均定位誤差（表 1，p. 10）：不修正 8.67 m、用作者模型 6.27 m、3D 光線追蹤 5.05 m。
- **⚠️ 核實：**
  - 我先前寫「70% 誤差在 50 m 內」，沒有說明是虛擬距離誤差，不是最終定位誤差。
  - 我先前也沒說明 50 m 那組是無人機上的移動測試。
- **對本研究：** 學校附近有高樓時，GPS 可能偏 50 m。圍欄外圈要大，並用「連續數點」或「停留時間」過濾跳點。

### 【Chien20】A Low-Cost On-Street Parking Management System Based on Bluetooth Beacons　✅

- **書目：** Chien, C.-F., Chen, H.-T., Lin, C.-Y.（淡江大學資工系）(2020). *Sensors* 20(16): 4559. DOI 10.3390/s20164559
- **問題：**
  - 磁力計（每台 100–200 美元）只知道有車，不知道是誰的車。
  - 有車牌辨識的智慧停車柱每台 2,000–4,000 美元，臺北有超過 4 萬個路邊車位，裝不起。
  - 能不能用便宜的藍牙 beacon 同時知道「有車」和「是誰」？
- **資料：** 在工學院大樓前空地，以模擬方式佈置 3 個車位。三種停法（右側靠路邊、左側靠路邊、車頭反向）各做一次，每次約 10 分鐘（§4.2）。
- **方法：**
  - 車上（右側後照鏡）裝 Estimote beacon。
  - 路邊裝 Raspberry Pi 3 接收器，每 10 秒掃描一次（表 2）。
  - 用一維 Kalman filter 平滑訊號強度，找出最近的兩個接收器，判斷車停在哪一格。
- **結果：**
  - 估出來的距離很不準，但最後能判斷正確車位。
  - 平均約 5 分鐘才穩定（§5）。
  - 實驗 1：一台車前 4 分鐘反覆跳動；另一台在相鄰兩格之間來回，到約第 9 分鐘才收斂（§4.2.1）。
- **⚠️ 核實：**
  - **我先前寫「偵測準確率 >98%、運作一年以上、電池壽命 >5 年」，全文完全沒有這些數字**，是搜尋摘要捏造的。
  - 實際上只有 3 個車位的模擬，沒有長期數據。
- **對本研究：** 「車上 beacon＝車輛身分」適合用來判斷「註冊車輛到校門附近了」。但判斷停在哪一格要好幾分鐘，不適合約 1 分鐘的接送。

### 【Mackey20】Smart Parking System Based on Bluetooth Low Energy Beacons with Particle Filtering　✅（預印本）

- **書目：** Mackey, Spachos, Plataniotis (2020). *IEEE Systems Journal* 14(3): 3371–3382. DOI 10.1109/JSYST.2020.2968883
- **問題：** 每個車位放一顆 beacon，能不能用駕駛的手機判斷車停在哪一格，並自動計費？架構和【Chien20】相反。
- **資料：** 室內和室外停車場，測 0.2–4 m 的訊號強度和距離關係；相鄰 3 個車位，beacon 相距 2.7 m（p. 11）。
- **方法：**
  1. 先校正訊號強度和距離的關係。
  2. 再用粒子濾波估距離。
  3. 最後測能不能判斷正確車位。
- **結果：**
  - 95% 情況下的距離誤差：室內 2.5 m → 1.5 m、室外 2.8 m → 2.0 m（加粒子濾波前 → 後，圖 9，p. 8）。
  - 2 m 以內估得較準；beacon 間距越大，判斷越準。
- **⚠️ 核實：** 無錯誤。只測少數車位，手機擺放位置固定。
- **對本研究：** 「接送格放 beacon、家長手機偵測」在 2–3 m 間距下技術可行，但家長的 App 必須一直在背景運作。

### 【Android】Create and monitor geofences（Android Developers 官方文件）　✅

- **問題：** Android 地理圍欄怎麼用？有什麼限制？
- **內容（各段標題）：**
  - **Choose the optimal radius：** 半徑建議至少 100–150 m；有 Wi-Fi 時定位精度通常 20–50 m。
  - 每個 App 最多 100 個圍欄。
  - **Use the dwell transition type：** 改用 `DWELL` 可以減少「路過就觸發」的大量通知。
  - **Alerts can be late：** 延遲通常不到 2 分鐘；有背景定位限制時平均 2–3 分鐘；手機長時間靜止時最長約 6 分鐘。
- **⚠️ 核實：** 2026-10-03 直接讀取官方網頁核對。
- **對本研究：** 系統參數的直接依據。

### 【Garzon14】Geofencing 2.0: Taking Location-based Notifications to the Next Level　📄

- **書目：** Rodriguez Garzon, S., Deva, B. (2014). UbiComp '14: 921–932. DOI 10.1145/2632048.2636093
- **問題：** 一般的圍欄彼此獨立，無法表達「先 A 後 B」這種時間關係。
- **方法（摘要）：** 用「狀態與轉移」模型把多個圍欄串起來，並加入時間限制，例如在圍欄內待多久、在圍欄之間移動多久。另外做了設計圍欄模型的介面原型。
- **⚠️ 核實：** 全文付費。摘要明確提到「依序穿過多個圍欄才通知」的情境。
- **對本研究：** 可以用來描述「先進外圈、再進內圈才確認」的觸發規則。

---

## C　模擬與實測（Q3）

### 【Tsai04】Best Practices in Managing School Campus Traffic Circulation　✅

- **書目：** Tsai, J., Cranford, J., Lee, J.-J. (2004). *Transportation Research Record* 1865: 41–47. DOI 10.3141/1865-07
- **問題：** 小學放學時的家長車隊怎麼管理最好？哪些因素決定隊伍長度？
- **資料：** 北卡州 11 個郡、20 所小學，每校 236–959 名學生，搭校車比例 19–72%（p. 42）。
- **方法：**
  - 4 人一組分站記錄：
    - 站 1：入口，記車牌和加入隊伍的時間 T1，用交通錐量隊伍長度。
    - 站 2：上車區，記進入時間 T2、離開時間 T3。
    - 站 3：出口。
    - 第 4 人：記行人穿越和插隊車輛。
  - 從高處錄影（p. 42）。
  - 用 ARENA 排隊模擬軟體以實測資料校正，再做逐步迴歸（p. 46–47）。
- **結果：**
  - 超過 60% 的家長在鐘響前就到，等待時間是晚到者的 3 倍（p. 41、47）。
  - 上車區平均停 63 秒；總接送時間近 14 分，但車隊開始動後只要 4 分 25 秒（p. 43）。
  - 範例學校：79 台車中 46 台在鐘響前到；3:15 放學，3:17 第一台才離開；3:10–3:24 隊伍溢出到馬路（p. 43）。
  - 對最大隊伍長度影響最大的因素依序是：車輛數 > 到達速率 > 服務速率 > 排隊空間（p. 46）。迴歸模型 adjusted R² = 0.7932（表 1，p. 47）。
  - 縮短隊伍的策略：分年級錯開放學、管制到達時間（p. 46）。
  - 人工叫號：家長把號碼牌放在擋風玻璃，一位老師用對講機報名、另一位用擴音器叫學生（p. 43–44）。
  - 作者建議：每台車上下車 <10 秒、全程 <45 秒；上車格最多 5 格；鐘響前 5–10 分鐘先收集前約 20 台車的名單（p. 47）。
- **⚠️ 核實：**
  - 論文本身的疑點：「各校平均上車停留時間從 33 秒到 90 多分鐘」（p. 43），對照平均 63 秒，應該是筆誤。
  - 【Kearns21】引用 Tsai et al. (2004) 說「約 50% 學校下午隊伍超出校內空間」，但這篇 TRR 論文裡找不到這句。可能出自同團隊的其他報告。
- **對本研究：**
  - 動機段的核心數據。
  - 本研究的 ETA 通知，就是「鐘響前先收集名單」的自動化版本。
  - 三站量測法可以直接照做。

### 【Liu22】School Surrounding Region Traffic Commuting Analysis Based on Simulation　✅

- **書目：** Liu, Deng, Li, Zhao, Li (2022). *IJERPH* 19(11): 6566. DOI 10.3390/ijerph19116566
- **問題：** 學校設在號誌路口旁，接送車對周邊交通的影響有多大？
- **資料：** VISSIM 7.0 假想場景：學校位在都市幹道號誌路口的西側出口（§2）。
- **方法：** 一次只改一個參數（§3，表 4）：
  - 主線流量 100–2500 pcu/h（每次加 300）
  - 送貨車停車需求
  - 校門到路口距離 100–500 m（每次加 100）
  - 接送車平均停靠時間 10–60 秒（每次加 10）
- **結果：**
  - 流量越大，各項指標越差。
  - 流量 1000 pcu/h 時，校門距路口 400 m 最好（摘要）。
  - 停靠時間 10→60 秒，路口和學校的各項延誤增加 6.38–10.27 秒（§4.4）。超過一定值後因車位已滿，就不再惡化（§5）。
- **⚠️ 核實：** 無錯誤。論文本身的限制是假想場景，沒有用真實資料校正。
- **對本研究：** VISSIM 模型要設的參數清單。「停靠時間」正是本研究想縮短的東西。

### 【Zhao20】G/M/N Queuing Model-Based Research on the Parking Spaces for Primary and Secondary School　📄

- **書目：** Zhao, Zhou, Pan, Zhou (2020). *Discrete Dynamics in Nature and Society* 2020: 1–7. DOI 10.1155/2020/8870862
- **問題：** 中小學門口要劃幾個接送車位才夠？
- **方法（摘要）：**
  1. 用 G/M/N 排隊模型，在 MATLAB 模擬「送學生」需要的車位數。
  2. 用累計到達車數決定「接學生」需要的車位數。
  3. 用最佳化模型決定總車位和短時車位的規模。
  4. 用學校實際交通資料驗證。
- **結果（摘要）：** 模型算出的規模符合實際停車需求。
- **⚠️ 核實：**
  - 🔁 二次核對：我先前寫「接學生需要的車位比送學生多」。摘要原文沒有這句，我也沒取得全文，已刪除。
- **對本研究：** 用排隊理論估算接送格數量的方法參考。

### 【Shokry24】Analyzing the Traffic Operational Performance of School Pick-Up and Drop-Off Dynamics in Saudi Arabia　✅

- **書目：** Shokry, Alrashidi, Elbany (2024). *Sustainability* 16(12): 5154. DOI 10.3390/su16125154
- **問題：** 接送時段讓學校周邊道路塞多少？
- **資料：** 沙烏地 6 座城市、40 所學校、242 個路段（p. 1、14）。
- **方法：**
  - 寫 Python 程式呼叫 Google Maps API，抓早上送、下午接、離峰三個時段的旅行時間。
  - 計算三個指標：旅行時間指數（TTI = 實際時間 ÷ 自由車流時間）、計畫時間指數（PTI）、服務水準（LOS）。
- **結果：**
  - 放學的 TTI 高於上學（p. 10）。
  - 除了利雅德，其他城市的服務水準在 C–D 級（p. 1）。
  - 政策建議（表 7，p. 13–14）：錯開時間、劃設接送區、共乘、單向環狀動線、遠端接送點、多個接送點、定期調查評估。
- **⚠️ 核實：** 無錯誤。論文本身的限制是 Google 的旅行時間是估計值。
- **對本研究：** 不用設備就能量周邊壅塞，適合做系統上線前後的對照。

### 【Kearns21】School Traffic Trip Generation Calculator Evaluation and Data Collection（NCDOT 2019-27）　✅

- **書目：** Kearns 等 15 人 (2021)。北卡交通部報告 FHWA/NC/2019-27
- **問題：** 更新北卡「學校交通計算器」的接送車輛數與最大隊伍長度。
- **資料：** 27 所學校，其中公立小學 13 所（PDF p. 5）。
- **方法（PDF p. 19–22）：**
  - **錄影設備：** 固定攝影機用管夾固定在路燈或樹上；部分學校用持照人員操作的無人機，從操場等遠處拍攝。
  - **隱私保護：** 畫質調到看不清人臉和車牌。
  - **時間安排：** 避開星期一早上和星期五下午，多選星期二、四；設備在接送時段外安裝。
  - **標註：** 分析員把影片看兩遍，記錄每台車「到達隊尾」和「進入上車區」的時間；進出車數差距不能超過 3 台；在線上地圖畫出隊伍路徑，量最大長度。
- **結果：** 公立小學的資料最可靠，原本計算器的估計和實測差不多；建議改用第 95 百分位數（PDF p. 5）。
- **⚠️ 核實：** 無錯誤。引用【Tsai04】的那句話，在 Tsai 的 TRR 論文裡找不到（見【Tsai04】）。
- **對本研究：** 一套可以照做的錄影量測 SOP，含隱私保護。

### 【TTI03】Traffic Operations and Safety at Schools: Recommended Guidelines　✅

- **書目：** Cooner, Fitzpatrick, Wooldridge, Ford (2003 年 10 月，2004 年 1 月修訂)。Texas Transportation Institute, Report FHWA/TX-04/4286-2
- **問題：** 給德州學校規劃者的交通設計準則。
- **資料：** 第一年 14 所學校觀察案例，第二年 20 所學校實地調查（PDF p. 15）。
- **方法：** 文獻回顧加實地調查，整理出 20 多條準則和一份審查清單。
- **結果：**
  - 德州實測的最大隊伍長度常比南、北卡州建議值短。
  - 迴歸分析找不到統計上顯著的隊伍長度模型（PDF p. 40）。
  - 建議的校內排隊車道長度：小學 <500 人 122–229 m、≥500 人 229–458 m（表 11，PDF p. 40）。
  - 收錄北卡最佳實務示意圖（圖 16，PDF p. 39）：上車格寬 ≥8 英尺，頭尾格長 20 英尺、中間格長 30 英尺，最多 4–5 格，每格一位安全助理。
- **⚠️ 核實：**
  - **我先前寫報告有「最大排隊車數 ≈（放學人數 − 其他方式回家人數）× 0.20」的公式，全文沒有這個公式**，已刪除。
  - 我先前推測它「可能和德州那篇出自同一計畫」。確認是同一團隊、同一 TxDOT 0-4286 計畫。
- **對本研究：** 拿學校的排隊空間和建議長度比較。

### 【SUMO18】Microscopic Traffic Simulation using SUMO　✅

- **書目：** Lopez, Behrisch, Bieker-Walz, Erdmann, Flötteröd, Hilbrich, Lücken, Rummel, Wagner, Wießner (2018). *21st IEEE ITSC*: 2575–2582. DOI 10.1109/ITSC.2018.8569938
- **問題：** 介紹開源交通模擬軟體 SUMO 的功能和模型。
- **內容：**
  - 工作流程與免費範例場景。
  - 多運具模擬。
  - 交通引導，例如引導車輛到替代停車場（p. 2578）。
  - TraCI 介面，可以用 Python 即時控制模擬（p. 2581）。
- **⚠️ 核實：** SUMO 官網的 Publications 頁指定引用這篇（2026-10-03 讀取）。
- **對本研究：** 可以用 Python 寫「收到通知才出發」「導到側門」的邏輯，在模擬中測試。這 38 篇裡沒有用 SUMO 模擬學校接送的論文。

### 【Zheng23】Traffic Stream Characteristics Analysis for Roadway Linking to Pick-up Zone of Passenger Transportation Hub　✅

- **書目：** Zheng, Yang, Gao, Yang, Chen (2023). *Applied Sciences* 13(1): 175. DOI 10.3390/app13010175
- **問題：** 機場、火車站接客區前的道路，為什麼會突然塞住？
- **資料：** 模擬資料（p. 1）。
- **方法：** 把乘客上車看成兩階段服務的 M/M/1 門檻排隊系統，推導流量和密度的關係（基本圖）。
- **結果：** 模型能重現「容量突然下降」，誤差比傳統方法小：均方誤差 0.69、誤差平方和 0.90（p. 1）。
- **⚠️ 核實：** 我先前寫成「接送區」，沒說明研究對象是交通樞紐、不是學校，也沒說明用的是模擬資料。
- **對本研究：** 想用排隊理論解釋「接送區一滿，整條路就塞住」時可以參考。

### 【Rahman19】Enhancing traffic safety at school zones by operation and engineering countermeasures: A microscopic simulation approach　📄

- **書目：** Rahman, Abdel-Aty, Lee, Rahman (2019). *Simulation Modelling Practice and Theory* 94: 334–348. DOI 10.1016/j.simpat.2019.04.001
- **問題：** 學區道路的工程改善措施對安全有多少效果？
- **方法（摘要）：**
  - 在佛州 Orange 和 Seminole 郡找出事故率最高的學區，建立微觀模擬。
  - 測試三種措施：兩段式降速、減少車道出入口、把雙向左轉車道改成實體分隔島。
  - 用多種替代安全指標評估。
- **結果（摘要）：**
  - 兩段式降速、減少出入口都能顯著降低風險，兩者合併效果最好。
  - 改成實體分隔島反而讓風險比原本高。
- **⚠️ 核實：**
  - 🔁 二次核對：我先前漏寫「實體分隔島反而更危險」，已補上。
  - 全文付費；第一作者的碩士論文網站有反爬蟲保護。
- **對本研究：** 校門口道路設計會影響安全，可以放在報告的延伸討論。

---

## D　隱私與資安（Q4）

### 【deMontjoye13】Unique in the Crowd: The privacy bounds of human mobility　✅

- **書目：** de Montjoye, Hidalgo, Verleysen, Blondel (2013). *Scientific Reports* 3: 1376. DOI 10.1038/srep01376
- **問題：** 拿掉姓名的位置資料，還能認出是誰嗎？
- **資料：** 一個歐洲小國 150 萬人、15 個月的手機紀錄，每小時一筆，位置精度到基地台（p. 2）。
- **方法：** 計算知道某人幾個時空點就能唯一找到他，再把時間和空間的精度調粗，看結果怎麼變。
- **結果（p. 1）：**
  - 4 個時空點就能唯一辨識 95% 的人。
  - 唯一性只隨解析度以約 1/10 次方下降，所以即使資料很粗，也幾乎沒有匿名效果。
- **⚠️ 核實：** 無錯誤。
- **對本研究：** 系統不應保存家長的軌跡，只存「已到達」事件。

### 【Primault19】The Long Road to Computational Location Privacy: A Survey　✅（預印本）

- **書目：** Primault, Boutet, Ben Mokhtar, Brunie (2019). *IEEE Communications Surveys & Tutorials* 21(3): 2772–2793. DOI 10.1109/COMST.2018.2873950
- **問題：** 位置隱私有哪些攻擊方式、保護機制和評估方法？
- **內容：** 依演算法性質，把保護機制分成六類（§V，arXiv 版 p. 11–12）：

| 類別 | 說明 |
|---|---|
| 混合區（mix-zones） | 在特定區域內更換使用者代號 |
| 概括化 | 把精確位置變成一塊範圍 |
| 假資料 | 混入假的位置或軌跡 |
| 加擾動 | 例如 geo-indistinguishability |
| 協定式 | 不改資料，改用通訊協定保護 |
| 規則式 | 依規則選擇保護方式 |

  - 評估指標分成隱私、可用性、效能三方面。
- **⚠️ 核實：** 無錯誤。
- **對本研究：** 解釋「為什麼不上傳軌跡」時的分類依據。

### 【Feal20】Angel or Devil? A Privacy Study of Mobile Parental Control Apps　✅

- **書目：** Feal, Calciati, Vallina-Rodriguez, Troncoso, Gorla (2020). *PoPETs* 2020(2): 314–335. DOI 10.2478/popets-2020-0029
- **問題：** 親子監控 App 本身會不會侵犯孩子的隱私？
- **資料：** Google Play 上 46 款 App，來自 43 家開發商，合計 2,000 萬次安裝。
- **方法：**
  - 靜態分析：檢查要了哪些權限。
  - 動態分析：攔截實際的網路流量。
  - 對照隱私政策和法規（GDPR、COPPA）。
- **結果（p. 314）：**
  - 要的權限比 Google Play 前 150 名 App 還多。
  - 11% 用明文傳個資。
  - 34% 沒取得適當同意就蒐集資料。
  - 72% 把資料分享給第三方，卻沒寫在隱私政策裡。
  - 連官方推薦的 App 也有這些問題。
- **⚠️ 核實：** 無錯誤。
- **對本研究：** 設計檢查表：最少權限、全程加密、不接第三方廣告或分析套件。

### 【Mirai17】Understanding the Mirai Botnet　✅

- **書目：** Antonakakis et al. (2017). *26th USENIX Security Symposium*: 1093–1110
- **問題：** Mirai 是怎麼感染大量 IoT 裝置的？
- **資料：** 2016/8/1–2017/2/28，來源包括網路望遠鏡、全網掃描、IoT 誘捕系統、指揮伺服器監控、DNS 紀錄、受害者提供的紀錄（p. 1093）。
- **方法：** 綜合多種來源做長期量測。
- **結果：**
  - 用 Telnet（連接埠 23、2323）加上 62 組預設帳密登入（p. 1094）。
  - 前 20 小時約 6.5 萬台受感染；穩定期 20–30 萬台；高峰約 60 萬台（p. 1093）。
  - 受害裝置主要是錄影主機、網路攝影機、路由器、印表機。
- **⚠️ 核實：** 無錯誤。
- **對本研究：** Raspberry Pi 和感測器上線前：改掉預設密碼、關掉 Telnet、不要直接暴露在網際網路上。

### 【Ali20】Betrayed by the Guardian: Security and Privacy Risks of Parental Control Solutions　✅（預印本）

- **書目：** Ali, Elgharabawy, Duchaussoy, Mannan, Youssef (2020). *ACSAC 2020*: 69–83. DOI 10.1145/3427228.3427287
- **問題：** 親子監控的軟硬體本身有多少資安漏洞？
- **資料：** 2019/3–2020/5 實測 8 台網路裝置、8 個 Windows 程式、10 個 Chrome 擴充、29 個 Android App（代表 13 套方案），另外自動掃描 153 個 Android App。
- **方法：** 設計一套資安與隱私測試，發現漏洞後通知廠商。
- **結果（arXiv 版 p. 2）：**
  - 共找到 135 個漏洞。
  - 13 套 Android 方案中：8 套的伺服器 API 沒有好好驗證身分、5 套的家長帳號容易被盜、7 套用 HTTP 傳個資。
  - 通知廠商兩個月後，只有 10 家回應（其中 3 家是自動回覆）。
- **⚠️ 核實：**
  - 我先前寫「分析 75 款 App」。75 款是它引用的另一篇研究（Wisniewski et al.）。
  - 我先前寫「是該會議的傑出論文」。論文和會議網站都查不到，已刪除。
- **對本研究：** 「家長帳號被盜 → 別人能冒名接走孩子」是最嚴重的風險，必須做登入驗證和 HTTPS。

### 【NIST26】Foundational Cybersecurity Activities for IoT Product Manufacturers（NIST IR 8259r1）　✅

- **書目：** Fagan, Megas, Cuthill, Marron, Hoehn (2026). NIST IR 8259r1。取代 2020 年 5 月的 NISTIR 8259。
- **問題：** IoT 產品出廠前，製造商應該做哪些資安工作？
- **內容：** 2020 年版列出 6 項（PDF p. 8–10）：
  1. 找出預期的客戶和使用情境。
  2. 研究客戶的資安需求。
  3. 決定要提供哪些資安功能。
  4. 規劃支援這些功能的資源。
  5. 決定溝通方式。
  6. 決定溝通內容。
- **⚠️ 核實：** 2020 年版的 PDF 首頁註明已在 2026-04-20 撤回，被 8259r1 取代。引用時請用新版。
- **對本研究：** 資安章節的架構。

---

## E　多區分流（延伸）

### 【Abdeen21】A Balanced Algorithm for In-City Parking Allocation: A Case Study of Al Madinah City　✅

- **書目：** Abdeen, Nemer, Sheltami (2021). *Sensors* 21(9): 3148. DOI 10.3390/s21093148
- **問題：** 有多個停車場時，系統要把每台車分到哪裡？
- **資料：** 沙烏地麥地那市大型停車設施的模擬，分高、低兩種車流情況。
- **方法：**
  - 多目標函數，5 個加權因素：路上壅塞、行車距離、空位率、入口等候時間、停車費。
  - 用排隊模型（到達率、離開率、容量）估計各停車場的空位率。
- **結果（摘要、§7）：** 各停車場使用率更平均、路上壅塞降低、開車時間縮短，優於對照的 MADM 演算法。
- **⚠️ 核實：** 無錯誤。
- **對本研究：** 「正門滿了導去側門」可以寫成加權分數：各區排隊長度、繞路距離、學生走過去的時間。

### 【LinRivano17】A Survey of Smart Parking Solutions　✅（HAL 典藏版）

- **書目：** Lin, Rivano, Le Mouël (2017). *IEEE T-ITS* 18(12): 3229–3253. DOI 10.1109/TITS.2017.2685143
- **問題：** 整理 2000–2016 年的智慧停車研究。
- **內容（HAL 版 p. 2）：**
  - 分成三大主題：資訊蒐集、系統部署、服務發布。
  - 提到各城市路邊停車的比例，例如洛杉磯 63%、北京 5%。
- **⚠️ 核實：** 無錯誤。
- **對本研究：** 寫「相關研究」章節時，用來定位本系統。

### 補充：叫號／通知系統的實測效益

- 這 38 篇裡，**沒有同儕審查的前後對照研究**。
- 廠商網頁宣稱的數字（2026-10-03 直接讀取）：
  - Carline Hound：「最多減少 40%」，學校「通常減少 30–40%」
  - Beeline：「等待時間減少 50%」
  - Nutrilink（CurbSmart）：「客戶回報最多減少 75%」
- **⚠️ 核實：** 我先前還列了 Carline.app 宣稱的 75%，但它的網頁無法讀取確認，已刪除。這些都是廠商自述，不能當證據。

---

## F　台灣資料（延伸）

### 【臺北民調15】104 年第 3 次臺北市交通民意調查報告（改善國小學童上下學交通環境調查）　✅

- **書目：** 臺北市政府交通局 (2015)
- **問題：** 臺北市國小學童的接送情形和家長的考量。
- **資料：** 2015/10/12–11/6 面訪。從臺北市 125 所學生數超過 300 人的國小中，系統抽樣 36 所；有效樣本 1,156 份，抽樣誤差 ±2.9 個百分點（摘要 p. I，PDF 第 2 頁）。
- **結果（同頁）：**
  - 接送情形：65.0% 上下學都接送、22.8% 只送不接、12.2% 只接不送。
  - 接送者：母親 52.2%、父親 29.5%、祖父 7.9%、祖母 8.4%。
  - 交通工具：
    - 放學接：機車 37.4%、汽車 25.7%、步行 22.6%
    - 上學送：機車 40.7%、汽車 26.3%、步行 20.4%
  - 被接送學童的年級分布：一年級占 28.8%，逐年遞減到六年級的 14.8%。
  - 接送原因：考量治安 57.4%、學童年紀太小 48.9%、家長接送較快或較方便 38.3%、交通安全環境欠佳 32.2%、學校太遠 21.3%。
- **⚠️ 核實：** 我先前把 57.4% 寫成「安全顧慮」。原文是「考量**治安**問題」。
- **對本研究：**
  - 台灣接送以機車為主，系統一定要能處理機車。
  - 一個學生要能綁多位接送人。

### 【LinChang10】Built Environment Effects on Children's School Travel in Taipai: Independence and Travel Mode　✅

- **書目：** Lin, J.-J., Chang, H.-T. (2010). *Urban Studies* 47(4): 867–889. DOI 10.1177/0042098009351938（原文標題拼作 Taipai）
- **問題：** 社區環境會不會影響小學生「自己上學」以及「用什麼交通方式」？
- **資料：** 2006 年底，臺北文山區指南、景美、興華三所國小（表 2，p. 878）。457 人中 419 人回覆，有效問卷 330 份（p. 879）。
- **方法：** 巢式羅吉特模型，分兩層：「有沒有大人陪」和「用什麼交通方式」。
- **結果：**
  - 約 35–40% 自己上下學、約 40% 走路、36–45% 坐機車或汽車、公車 14–16%（p. 879）。
  - 景美國小走路 68–69%；指南國小走路僅約 1%（p. 879）。
  - 樹蔭和人行道越多，越多學生自己走路；街廓越大、路口越多，越少學生自己走（摘要）。
  - 早上家長順路上班，所以距離不影響上學方式；下午放學後很多孩子先去安親班，安親班常開到晚上 9 點左右（p. 885）。
  - 事故數、犯罪數這類客觀指標大多不顯著（p. 885）。
- **⚠️ 核實：**
  - 我先前寫「主觀安全感才是關鍵」，比原文說得重。作者只推測感受到的安全和官方統計不一定一致，建議未來研究納入主觀指標（p. 885）。
  - 論文本身的限制：「有沒有接送區」在模型中和學校虛擬變數合併，無法單獨檢驗（p. 880）。
- **對本研究：**
  - 系統要支援安親班車「一台車接多個學生」。
  - 接送變方便可能讓更多家長選擇開車，可以寫進報告的限制段。

### 【Huang24】Enhancing Urban Traffic Safety: An Evaluation of Taipei's Neighborhood Traffic Environment Improvement Program　✅（預印本）

- **書目：** Huang, F. Y., Huang, P.-C. (2024). arXiv:2401.16752（尚未經期刊審查）
- **問題：** 臺北市 2015 年 8 月起的巷弄交通改善（綠色人行道、調整紅黃線、標示速限）有沒有讓事故減少？
- **資料：** 6,856 條巷弄，2013–2020 年的事故資料（p. 9）。
- **方法：** 利用各巷弄分批實施的時間差，用差異中之差異（DID）加 Poisson 迴歸估計效果。
- **結果：**
  - 白天事故減少 5%、受傷減少 8%；夜間沒有顯著效果（p. 1）。
  - 整體事故減少約 3.5%（不顯著），受傷減少約 7%（顯著）（p. 4）。
  - 效果主要來自綠色人行道。
- **⚠️ 核實：** 無錯誤。白天和整體的數字不同，引用時要寫清楚是哪一個。
- **對本研究：** 台灣低成本交通改善確實有效的實證。

---

## 附錄一　對系統設計的建議

| 項目 | 建議 | 依據 |
|---|---|---|
| 遠距觸發 | 圍欄半徑至少 100–150 m，只發「預告」；用 `DWELL` 或「連續數點在範圍內」才觸發 | 【Shevchenko24】【Android】【Merry19】【Hsu18】 |
| 觸發規則 | 「先進外圈、再進內圈」才確認 | 【Garzon14】 |
| ETA 倒數 | 預留 iOS／Android 數分鐘的時間差；用車速和距離估 ETA | 【Shevchenko24】 |
| 離開偵測 | 不用 GPS 的「離開」事件，改用接送格感測器 | 【Shevchenko24】 |
| 到位確認 | 「磁力計＋光感測器」或從上方往下照的超音波；不用 beacon 判斷車格 | 【Bernas18】【Jo14】【Appiah20】【Chien20】 |
| 車輛身分 | 車上 beacon 判斷「到校門附近」，或用車牌辨識；兩者都要實測機車 | 【Chien20】【Laroca21】 |
| 註冊模型 | 一個學生可綁多台車、多位接送人；一台車可接多個學生 | 【臺北民調15】【LinChang10】 |
| 時段限制 | 放學前後 30 分鐘才啟動；同時和家長溝通，避免改到路邊等 | 【Tsai04】 |
| 多區分流 | 用加權分數選接送區 | 【Abdeen21】 |
| 隱私 | 圍欄在手機上判斷，只上傳「已進入」事件；不保存軌跡；最少權限 | 【deMontjoye13】【Shevchenko24】【Feal20】 |
| 資安 | 改掉預設密碼、關掉 Telnet、全程 HTTPS、家長帳號強驗證 | 【Mirai17】【Ali20】【NIST26】 |

## 附錄二　實地量測方案

1. **接送流程**（【Tsai04】【Kearns21】）
   - 4 人分站，記錄 T1（加入隊伍）、T2（到上車點）、T3（離開上車點）。
   - 錄影時畫質調到看不清人臉和車牌；避開星期一早上和星期五下午。
   - 進出車數差距不超過 3 台。
   - 計算指標：上車停留時間（T3 − T2）、總接送時間（T3 − T1）、提早到達比例、最大隊伍長度。
2. **手機 GPS 誤差**（【Merry19】）：在校門口的開闊處和高樓旁各選一點，iOS 和 Android 各放 10 分鐘，算出誤差分布。
3. **圍欄觸發**（【Shevchenko24】）：50、100、150 m 三種半徑 × iOS／Android，各進出 10 次，記錄偵測率、誤報率和延遲。
4. **感測器驗證**（【Bernas18】【Culik23】）：同步錄影，分整段時間和每 15 分鐘兩種算法，計算漏報率與誤報率；另外特別測機車、行人經過、雨天。
5. **周邊壅塞**（【Shokry24】）：用 Google Maps API 算旅行時間指數，系統上線前、後各量兩週。

---

## 附註

### 一、沒讀到全文的 7 篇

| 代號 | 原因 | 本文根據 |
|---|---|---|
| 【Cooner09】 | 付費 | 摘要（OpenAlex） |
| 【Adams20?】 | 標題查無此文；候選典藏庫有反爬蟲保護 | 無 |
| 【Appiah20】 | 出版社網站阻擋自動下載 | 摘要（OpenAlex） |
| 【Paidi18】 | 付費；典藏庫連線失敗 | 摘要（OpenAlex） |
| 【Garzon14】 | 付費 | 摘要（OpenAlex） |
| 【Zhao20】 | 出版社網站阻擋自動下載 | 摘要（OpenAlex） |
| 【Rahman19】 | 付費；碩士論文網站阻擋 | 摘要（Semantic Scholar） |

如果你能取得這幾篇的 PDF，傳給我就補讀。

### 二、第一輪核實：搜尋階段摘要寫錯的地方

| 代號 | 搜尋階段寫的 | 原文 |
|---|---|---|
| 【Chien20】 | 準確率 >98%、運作一年以上、電池 >5 年 | 全文沒有這些數字；是 3 個車位的模擬，約 5 分鐘才穩定 |
| 【TTI03】 | 有「放學人數 × 0.20」排隊公式 | 沒有這個公式；報告說找不到顯著模型 |
| 【Shevchenko24】 | 觸發點離「邊界」87／234 m | 是離圍欄「中心」的距離；另外漏寫「離開」偵測率 18% |
| 【Ali20】 | 分析 75 款 App；是傑出論文 | 75 款是引用的研究；傑出論文查無證據 |
| 【臺北民調15】 | 「安全顧慮」57.4% | 「考量治安問題」 |
| 【Zheng23】 | 學校接送區 | 交通樞紐接客區，模擬資料 |
| 【Culik23】 | 少算 4.8–9.0% | 那是單一感測器、2 小時單位；全天 4.99%／8.32%，15 分鐘 29.71–42.42% |
| 【Hsu18】 | 70% 誤差在 50 m 內 | 是虛擬距離誤差；50 m 那組是無人機移動測試 |
| 【LinChang10】 | 主觀安全感是關鍵 | 作者只建議未來研究納入主觀指標 |
| 【Cooner09】 | 4 位作者 | Crossref、OpenAlex 只列 1 位 |
| 【Hemalatha21】 | 作者只寫 Bharat Paul | 作者共 6 人 |
| 廠商數字 | Carline.app 減少 75% | 網頁無法確認，已刪 |
| van Diggelen & Enge (2015) | 全球手機實測平均 4.9 m | 取得的簡報中找不到，整篇移除 |

### 三、🔁 二次核對：第二輪修正

| 代號 | 修正內容 |
|---|---|
| 【Laroca21】 | 表 9 雙欄轉文字欄位錯位：AOLP 上 OpenALPR 不支援台灣車牌，Sighthound 是 87.1%（不是「OpenALPR 98.8%」） |
| 【Appiah20】 | 「反應時間 0.20–0.35 秒、能偵測機車和行人」不在摘要原文裡，已刪 |
| 【Zhao20】 | 「接學生車位需求大於送學生」不在摘要原文裡，已刪 |
| 【Amato17】 | 其他方法 84–88% → 84–90%（表 2 最高 89.83%） |
| 【Merry19】 | 刪除我自己加的推測「人多時誤差小是因 Wi-Fi 熱點多」 |
| 【Shevchenko24】 | iOS／Android 時間差限定為研究 2 的「進入」事件 |
| 【Rahman19】 | 補上摘要中「改成實體分隔島反而更危險」 |
| 【Kearns21】 | 「管夾」（原文 hose clamps），原寫「束帶」 |
| 【Jo14】 | 表 1 的錯誤類型：變換車道多算是 9 次（近側 2、遠側 7），不是 2 次 |
| 【SUMO18】 | 作者順序改依論文首頁（Crossref 的順序不同） |

---

## 參考文獻（APA 格式）

**第一批**

- Alagos, S. C. S., Turija, C. J. C., Ramoran, D. F. D., Dadula, C. P., & Banal, R. G. (2025). Development of an efficient schoolchildren drop-off and pick-up system in the Philippines: Enhancing safety and accessibility. *Journal of Engineering, Environment, and Agriculture Research, 4*, 53–65. https://doi.org/10.34002/jeear.v4i1.126
- Cooner, S. A. (2009). Field studies of operations and conflicts in drop-off–pick-up zones. *Transportation Research Record, 2137*, 129–139. https://doi.org/10.3141/2137-14
- Hemalatha, J., Hitaishi, K., Mownika, V. S., Paul, B., Vivek Sharma, S., & Vura, S. (2021). An efficient Android based school bus tracking system. *International Journal of Engineering Applied Sciences and Technology, 6*(1), 383–389.

**A 車輛偵測**

- Amato, G., Carrara, F., Falchi, F., Gennaro, C., Meghini, C., & Vairo, C. (2017). Deep learning for decentralized parking lot occupancy detection. *Expert Systems with Applications, 72*, 327–334. https://doi.org/10.1016/j.eswa.2016.10.055
- Appiah, O., Quayson, E., & Opoku, E. (2020). Ultrasonic sensor based traffic information acquisition system; a cheaper alternative for ITS application in developing countries. *Scientific African, 9*, e00487. https://doi.org/10.1016/j.sciaf.2020.e00487
- Bernas, M., Płaczek, B., Korski, W., Loska, P., Smyła, J., & Szymała, P. (2018). A survey and comparison of low-cost sensing technologies for road traffic monitoring. *Sensors, 18*(10), 3243. https://doi.org/10.3390/s18103243
- Čulík, K., Štefancová, V., & Hrudkay, K. (2023). Application of wireless magnetic sensors in the urban environment and their accuracy verification. *Sensors, 23*(12), 5740. https://doi.org/10.3390/s23125740
- Jo, Y., & Jung, I. (2014). Analysis of vehicle detection with WSN-based ultrasonic sensors. *Sensors, 14*(8), 14050–14069. https://doi.org/10.3390/s140814050
- Laroca, R., Zanlorensi, L. A., Gonçalves, G. R., Todt, E., Schwartz, W. R., & Menotti, D. (2021). An efficient and layout-independent automatic license plate recognition system based on the YOLO detector. *IET Intelligent Transport Systems, 15*(4), 483–503. https://doi.org/10.1049/itr2.12030
- Paidi, V., Fleyeh, H., Håkansson, J., & Nyberg, R. G. (2018). Smart parking sensors, technologies and applications for open parking lots: A review. *IET Intelligent Transport Systems, 12*(8), 735–741. https://doi.org/10.1049/iet-its.2017.0406

**B 定位與誤觸發**

- Chien, C.-F., Chen, H.-T., & Lin, C.-Y. (2020). A low-cost on-street parking management system based on Bluetooth beacons. *Sensors, 20*(16), 4559. https://doi.org/10.3390/s20164559
- Google. (n.d.). *Create and monitor geofences*. Android Developers. Retrieved October 3, 2026, from https://developer.android.com/develop/sensors-and-location/location/geofencing
- Hsu, L.-T. (2018). Analysis and modeling GPS NLOS effect in highly urbanized area. *GPS Solutions, 22*(1), 7. https://doi.org/10.1007/s10291-017-0667-9
- Mackey, A., Spachos, P., & Plataniotis, K. N. (2020). Smart parking system based on Bluetooth low energy beacons with particle filtering. *IEEE Systems Journal, 14*(3), 3371–3382. https://doi.org/10.1109/JSYST.2020.2968883
- Merry, K., & Bettinger, P. (2019). Smartphone GPS accuracy study in an urban environment. *PLOS ONE, 14*(7), e0219890. https://doi.org/10.1371/journal.pone.0219890
- Rodriguez Garzon, S., & Deva, B. (2014). Geofencing 2.0: Taking location-based notifications to the next level. In *Proceedings of the 2014 ACM International Joint Conference on Pervasive and Ubiquitous Computing* (pp. 921–932). https://doi.org/10.1145/2632048.2636093
- Shevchenko, Y., & Reips, U.-D. (2024). Geofencing in location-based behavioral research: Methodology, challenges, and implementation. *Behavior Research Methods, 56*(7), 6411–6439. https://doi.org/10.3758/s13428-023-02213-2

**C 模擬與實測**

- Cooner, S. A., Fitzpatrick, K., Wooldridge, M. D., & Ford, G. L. (2004). *Traffic operations and safety at schools: Recommended guidelines* (Report No. FHWA/TX-04/4286-2). Texas Transportation Institute.
- Kearns, B., Davis, J., Geiger, B. C., Coble, D., Klemann, K., Rhoney, M., Baird, C., Carnes, C., Vaughan, C., McCaleb, E., Nicholas, C., Dudley, T., Searcy, S., Findley, D. J., & O'Brien, S. (2021). *School traffic trip generation calculator evaluation and data collection* (Report No. FHWA/NC/2019-27). North Carolina Department of Transportation.
- Liu, H., Deng, H., Li, Y., Zhao, Y., & Li, X. (2022). School surrounding region traffic commuting analysis based on simulation. *International Journal of Environmental Research and Public Health, 19*(11), 6566. https://doi.org/10.3390/ijerph19116566
- Lopez, P. A., Behrisch, M., Bieker-Walz, L., Erdmann, J., Flötteröd, Y.-P., Hilbrich, R., Lücken, L., Rummel, J., Wagner, P., & Wießner, E. (2018). Microscopic traffic simulation using SUMO. In *2018 21st International Conference on Intelligent Transportation Systems (ITSC)* (pp. 2575–2582). https://doi.org/10.1109/ITSC.2018.8569938
- Rahman, M. H., Abdel-Aty, M., Lee, J., & Rahman, M. S. (2019). Enhancing traffic safety at school zones by operation and engineering countermeasures: A microscopic simulation approach. *Simulation Modelling Practice and Theory, 94*, 334–348. https://doi.org/10.1016/j.simpat.2019.04.001
- Shokry, S., Alrashidi, A., & Elbany, M. (2024). Analyzing the traffic operational performance of school pick-up and drop-off dynamics in Saudi Arabia. *Sustainability, 16*(12), 5154. https://doi.org/10.3390/su16125154
- Tsai, J., Cranford, J., & Lee, J.-J. (2004). Best practices in managing school campus traffic circulation. *Transportation Research Record, 1865*, 41–47. https://doi.org/10.3141/1865-07
- Zhao, Y., Zhou, Z., Pan, Q., & Zhou, T. (2020). G/M/N queuing model-based research on the parking spaces for primary and secondary school. *Discrete Dynamics in Nature and Society, 2020*, 1–7. https://doi.org/10.1155/2020/8870862
- Zheng, H., Yang, Y., Gao, G., Yang, K., & Chen, J. (2023). Traffic stream characteristics analysis for roadway linking to pick-up zone of passenger transportation hub: A fundamental diagram derived from threshold queueing theory. *Applied Sciences, 13*(1), 175. https://doi.org/10.3390/app13010175

**D 隱私與資安**

- Ali, S., Elgharabawy, M., Duchaussoy, Q., Mannan, M., & Youssef, A. (2020). Betrayed by the guardian: Security and privacy risks of parental control solutions. In *Annual Computer Security Applications Conference (ACSAC 2020)* (pp. 69–83). https://doi.org/10.1145/3427228.3427287
- Antonakakis, M., April, T., Bailey, M., et al. (2017). Understanding the Mirai botnet. In *26th USENIX Security Symposium* (pp. 1093–1110). USENIX Association.
- de Montjoye, Y.-A., Hidalgo, C. A., Verleysen, M., & Blondel, V. D. (2013). Unique in the crowd: The privacy bounds of human mobility. *Scientific Reports, 3*, 1376. https://doi.org/10.1038/srep01376
- Fagan, M., Megas, K. N., Cuthill, B., Marron, J., & Hoehn, B. (2026). *Foundational cybersecurity activities for IoT product manufacturers* (NIST IR 8259r1). National Institute of Standards and Technology. https://doi.org/10.6028/NIST.IR.8259r1
- Feal, Á., Calciati, P., Vallina-Rodriguez, N., Troncoso, C., & Gorla, A. (2020). Angel or devil? A privacy study of mobile parental control apps. *Proceedings on Privacy Enhancing Technologies, 2020*(2), 314–335. https://doi.org/10.2478/popets-2020-0029
- Primault, V., Boutet, A., Ben Mokhtar, S., & Brunie, L. (2019). The long road to computational location privacy: A survey. *IEEE Communications Surveys & Tutorials, 21*(3), 2772–2793. https://doi.org/10.1109/COMST.2018.2873950

**E、F 延伸**

- Abdeen, M. A. R., Nemer, I. A., & Sheltami, T. R. (2021). A balanced algorithm for in-city parking allocation: A case study of Al Madinah City. *Sensors, 21*(9), 3148. https://doi.org/10.3390/s21093148
- Huang, F. Y., & Huang, P.-C. (2024). *Enhancing urban traffic safety: An evaluation of Taipei's neighborhood traffic environment improvement program* (arXiv:2401.16752). arXiv. https://arxiv.org/abs/2401.16752
- Lin, J.-J., & Chang, H.-T. (2010). Built environment effects on children's school travel in Taipai: Independence and travel mode. *Urban Studies, 47*(4), 867–889. https://doi.org/10.1177/0042098009351938
- Lin, T., Rivano, H., & Le Mouël, F. (2017). A survey of smart parking solutions. *IEEE Transactions on Intelligent Transportation Systems, 18*(12), 3229–3253. https://doi.org/10.1109/TITS.2017.2685143
- 臺北市政府交通局（2015）。*104 年第 3 次臺北市交通民意調查報告（改善國小學童上下學交通環境調查）*。臺北市政府。
