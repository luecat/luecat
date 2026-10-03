# 校園智慧接送系統：論文閱讀報告

> 高中「大數據物聯網」專題｜每篇論文在做什麼、怎麼做、發現什麼、對我們有什麼用
> 整理日期：2026-10-03（第 2 版：全文閱讀與核實）

---

## 目錄

1. [讀前說明](#讀前說明)
2. [一頁總結：讀完之後我們知道什麼](#一頁總結讀完之後我們知道什麼)
3. [第一版的錯誤更正](#第一版的錯誤更正)
4. [原本排除的 4 篇（重新閱讀）](#原本排除的-4-篇重新閱讀)
5. [問題 1：如何偵測車流](#問題-1如何偵測車流)
6. [問題 2：如何避免誤觸發](#問題-2如何避免誤觸發)
7. [問題 3：如何模擬、實測](#問題-3如何模擬實測)
8. [問題 4：如何定位、資安](#問題-4如何定位資安)
9. [延伸方向](#延伸方向)
10. [對系統設計的建議](#對系統設計的建議)
11. [實地量測方案](#實地量測方案)
12. [研究缺口](#研究缺口)
13. [還沒讀到全文的文獻](#還沒讀到全文的文獻)
14. [參考文獻（APA 格式）](#參考文獻apa-格式)

---

## 讀前說明

### 每篇的閱讀程度

| 標示 | 意思 | 篇數 |
|---|---|---|
| **全文** | 下載全文，讀過研究方法和結果 | 31 |
| **摘要** | 全文下載不到（付費或網站阻擋），只讀到摘要與資料庫描述 | 8 |
| **投影片** | 只取得作者的簡報 | 1 |

- 書目資料（作者、卷期、頁碼、DOI）都用 Crossref 資料庫或全文首頁核對過。
- 摘要等級的論文，內容細節請自己再讀原文確認。

### 每篇的固定欄位

- **在做什麼**：研究問題
- **怎麼做**：實驗設計、資料、工具
- **發現**：主要結果（附數字）
- **限制**：要注意的地方
- **對我們的用處**

---

## 一頁總結：讀完之後我們知道什麼

### 問題 1：偵測車流

- **單一低價感測器不夠準，組合起來才準。** Bernas (2018) 實測：磁力計單獨偵測車輛約 93%，加上光感測器後達 98%。
- **超音波便宜，但有固定弱點**：兩台車並排時，遠的那台會被擋住（Jo & Jung 2014）。只適合車道少、車流不大的地方。
- **攝影機＋小型神經網路**：一台 Raspberry Pi 可以同時判斷 50 個車位。換到沒看過的角度時，準確率掉到約 90%（Amato 2017）。
- **台灣車牌辨識已有公開方法**：在台灣車牌資料集（AOLP）上辨識率約 99%（Laroca 2021）。

### 問題 2：避免誤觸發

- 手機 GPS 在校園平均誤差 7–13 m，偶爾會跳到 100 m（Merry 2019）。
- 高樓區的低價接收器誤差可達約 50 m（Hsu 2018）。
- **地理圍欄的實測表現**（Shevchenko 2024）：
  - 半徑 10 m 時常常漏掉。
  - 「進入」通知約三成是誤報。
  - 「離開」事件在真實使用中只抓到 18%。
  - iOS 常在跨過邊界「之前」就通知，Android 則平均晚約 2.5 分鐘。
- **藍牙 beacon 判斷「停在哪一格」很慢**：要 3–9 分鐘才穩定（Chien 2020），遠比一台車停留的時間（約 1 分鐘）長。

### 問題 3：模擬與實測

- 美國 20 所小學實測：約 60% 家長在鐘響前就到。平均總接送時間約 14 分鐘，但車隊真正開始移動後只花 4 分 25 秒（Tsai 2004）。
- 模擬研究：每台車停靠時間從 10 秒增加到 60 秒，周邊車輛延誤會跟著增加（Liu 2022）。
- 實測方法有現成的 SOP：
  - 三站人工計時（Tsai 2004）
  - 無人機或固定攝影機錄影，再看影片標時間（Kearns 2021）
  - 用 Google Maps API 量旅行時間（Shokry 2024）

### 問題 4：隱私與資安

- 只要 4 個「時間＋地點」資料點，就能認出 95% 的人（de Montjoye 2013）。
- 親子監控 App 普遍有問題（Feal 2020、Ali 2020）：
  - 72% 把資料分給第三方。
  - 13 套 Android 方案中有 7 套用未加密的 HTTP 傳個資。
- IoT 裝置最常被攻破的原因是**預設密碼**。Mirai 病毒只用 62 組預設帳密就感染了 60 萬台（Antonakakis 2017）。

### 最接近我們的前人系統

**菲律賓 RFID 接送系統（Alagos 2025）**：

- **做法**：車進校門刷卡後，等候區螢幕顯示學生姓名。
- **限制**：
  - 卡片要靠近到 5 cm 內才讀得到。
  - 是在大學校園模擬測試，不是在真的學校。
- **和我們的差別**：我們系統的新意，是**車還沒到校門就預先通知**。

---

## 第一版的錯誤更正

第一版有 12 處錯誤，來源是搜尋引擎的摘要。讀全文後已全部更正：

| # | 論文 | 第一版寫的 | 原文實際內容 |
|---|---|---|---|
| 1 | Chien 2020（淡江） | 偵測準確率 >98%、運作一年以上、電池 >5 年 | **原文沒有這些數字。** 實際是 3 個車位的原型，在大樓前空地模擬，判定車位要 3–9 分鐘才穩定 |
| 2 | TTI 4286-2 報告 | 有「放學人數 × 0.20」的排隊公式 | **報告裡沒有這個公式。** 報告說德州資料找不到統計上顯著的排隊模型，改提供建議的排隊車道長度表 |
| 3 | Shevchenko 2024 | 觸發地點和「邊界」相差 87 m／234 m | 是通知當下位置到圍欄**中心**的平均距離（研究 1） |
| 4 | Shevchenko 2024 | （漏寫） | 真實使用中「離開」事件只偵測到 18% |
| 5 | Ali 2020 | 分析 75 款 App | 75 款是它引用的另一篇研究。它自己分析的是 8 台網路裝置、8 個 Windows 程式、10 個 Chrome 擴充、29 個 Android App（13 套方案） |
| 6 | Ali 2020 | 是該會議的傑出論文 | 論文和會議網站都查不到，已刪除 |
| 7 | 臺北市 2015 民調 | 57.4% 是「安全顧慮」 | 是「考量**治安**問題」 |
| 8 | Zheng 2023 | 用排隊理論推導「接送區」容量 | 研究的是機場、火車站等交通樞紐的接客區，用的是模擬資料，不是學校 |
| 9 | Čulík 2023 | 感測器少算 4.8–9.0% | 4.8–9.0% 是單一感測器以 2 小時為單位的結果。全天誤差是 4.99% 和 8.32%；15 分鐘短時段誤差達 29.71–42.42% |
| 10 | van Diggelen 2015 | 全球實測平均誤差 4.9 m | 取得的投影片中找不到 4.9 m，無法確認，已刪除 |
| 11 | Hsu 2018 | 70% 誤差在 50 m 內 | 是「虛擬距離（pseudorange）誤差」，不是最終定位誤差 |
| 12 | 接送 App 廠商數字 | Carline.app 宣稱 75% | 該網頁無法讀取確認，已刪除；其餘廠商數字已核對網頁 |

---

## 原本排除的 4 篇（重新閱讀）

### E1｜Field Studies of Operations and Conflicts in Drop-Off–Pick-Up Zones【摘要】

- **書目**：Scott A. Cooner 等，2009，*Transportation Research Record* 2137: 129–139，DOI 10.3141/2137-14
- **作者有出入**：Crossref 只列 Cooner 一人，其他資料庫列 Cooner, Fitzpatrick, Wooldridge, Ford 四人。請以你手上的版本為準。
- **在做什麼**：調查德州學校接送區的運作情形，以及人車衝突。
- **怎麼做**：
  - 對 13 所小學、5 所國中做實地調查，涵蓋大小城市，早上和下午都有。
  - 記錄排隊區的設計、管理方式（例如有沒有人員指揮上下車），以及搭校車與坐家長車的人數。
  - 量測隊伍形成和消散的過程，以及行人與車輛的衝突次數。
- **限制**：全文是付費的，我沒讀到結果數字。
- **補充**：同一團隊在同一研究計畫（德州 TxDOT 0-4286）寫了 TTI 4286-2 準則報告。那份我讀了全文，見[問題 3 補充](#tti-4286-2traffic-operations-and-safety-at-schools-recommended-guidelines全文)。

### E2｜Development of an Efficient Schoolchildren Drop-Off and Pick-Up System in the Philippines【全文】

- **書目**：Alagos, Turija, Ramoran, Dadula, Banal，2025，*Journal of Engineering, Environment, and Agriculture Research* 4，DOI 10.34002/jeear.v4i1.126

**在做什麼**
- 菲律賓學校接送時段混亂，常見問題包括並排停車、找不到學生、人工核對身分很慢。
- 作者做了一套 RFID 接送管理系統。

**怎麼做**

- **硬體**：
  - NodeMCU ESP8266 微控制器＋MFRC522 RFID 讀卡機，裝在校門入口和出口。
  - 每台註冊車輛發一張 RFID 卡。
- **軟體**：MySQL 資料庫加網頁介面，共 8 個頁面，包括註冊、刷卡紀錄、等候區姓名顯示、剩餘車位、控制室總覽。
- **流程**：
  1. 車到校門刷卡。
  2. 系統比對資料庫，有空位就放行。
  3. 等候區螢幕顯示該學生姓名。
  4. 出校門再刷一次，記錄接走時間。
- **測試方式**：
  - 因學校規定不能收集真實學童資料，改在大學校園內一塊 25×25 m 的場地模擬。
  - 用機車當測試車，大學生扮演學童。
  - 分「學生有延遲」和「學生沒延遲」兩種情況，各 30 次。

**發現**

| 情境 | 有學生延遲 | 沒有學生延遲 |
|---|---|---|
| 原型系統（模擬） | 平均 165.9 秒 | 平均 34.1 秒 |
| 作者觀察的實際學校（傳統作法） | 706 秒（11.77 分） | 290 秒（4.83 分） |

- 讀卡距離在 1.27–6.35 cm 之間測試，**超過 5.08 cm 可靠度就下降**。作者建議改用超高頻（UHF）RFID。
- 列出的風險：標籤被複製、網路中斷、硬體故障。

**限制**
- 原型是在模擬環境測的，數字和真實學校**不能直接比較**，作者自己也提醒這點。
- 家長和學生的接受度沒有評估。
- 原文表 2 的「有延遲／無延遲」標籤和內文顛倒，引用時要小心。

**對我們的用處**
- 這是和我們最接近的前人系統。它在**車進校門**時才觸發，我們用 GPS 圍欄**在車到之前就通知**，這是我們的差異點。
- 它提供了一組實際學校的基準數字：每台車 4.83–11.77 分鐘。
- 它的教訓：近距離 RFID 讀卡距離太短，不適合車子開過去時讀取。

**難度**：易

### E3｜Geofencing as Applied Within the Field of …（標題對不上）【摘要】

- **你給的標題**：Geofencing as Applied Within the Field of Temporal and Location Tracking
- **我找到最接近的**：Kasandra Adams (2020)，*Geofencing as Applied Within the Field of Cybersecurity: An Overview of Potential Risks and Advantages*，美國加州州立大學聖貝納迪諾分校（CSUSB）碩士專題，ScholarWorks 編號 etd/1058
- 兩個標題的開頭一樣，但後半不同。**請對照你手上那份的封面。**
- **在做什麼**（依典藏庫描述）：從資安角度看地理圍欄。
- **怎麼做**：
  - 用「駭客方法論」示範現有圍欄應用可能被濫用。例如在使用者不知情、沒同意的情況下大量收集圍欄內的資料。
  - 再把圍欄對應到美國 NIST 資安框架，說明它也能用在防禦上。
- **限制**：網站有反爬蟲保護，全文沒下載到。
- **對我們的用處**：如果確定是這篇，它可以用在問題 4（圍欄的隱私風險）。

### E4｜An Efficient Android Based School Bus Tracking System【全文】

- **書目**：Hemalatha J, Hitaishi K, Mownika V S, Bharat Paul（Nagarjuna 工程學院大學部學生）、Vivek Sharma S、Swetha Vura，2021，*International Journal of Engineering Applied Sciences and Technology* 6(1): 383–389
- **在做什麼**：讓家長在手機上看校車的即時位置，減少乾等的時間。

**怎麼做**
- **硬體**：GPS 模組接 NodeMCU，把經緯度傳到 Blynk 雲端平台，再顯示在 Google 地圖上。
- **三個模組**：
  - 管理員：管理司機和路線，可以傳簡訊。
  - 司機：登入後開始和結束行程，位置被記錄。
  - 家長：查看校車即時位置。
- **通知**：
  - 校車「離開學校」「抵達學校」時通知家長。
  - 家長可以自己設「標記點」，校車經過時手機響鈴。

**發現**：只展示 App 操作畫面，**沒有任何量測數據**，例如定位誤差或通知延遲。

**限制**：期刊等級低，英文像是機器改寫，例如把 Kalman filtering 寫成「Kalman shifting」。可信度有限。

**對我們的用處**：「標記點響鈴」就是最簡單的地理圍欄。可以當作「前人只做到這樣，沒有驗證準確度」的例子。

**難度**：易

---

## 問題 1：如何偵測車流

### 1-1｜A Survey and Comparison of Low-Cost Sensing Technologies for Road Traffic Monitoring【全文】

- **書目**：Bernas, Płaczek, Korski, Loska, Smyła, Szymała，2018，*Sensors* 18(10): 3243，DOI 10.3390/s18103243
- **在做什麼**：哪些便宜的感測器裝在路邊，能準確偵測車輛和行人？

**怎麼做**

- **整理文獻**：用一張表比較 10 種技術（見下方「發現」第一點）。
- **兩種實驗節點**：
  - **SN1**：一支小米手機，用內建的加速度計、陀螺儀、磁力計、麥克風、光感測器和訊號強度。兩支手機放在車道兩側，相距 3.5 m。
  - **SN2**：自製的路邊節點，限定被動感測器 10 美元內、主動感測器 50 美元內。裝了磁力計、光感測器、紅外線、光達、微波雷達、超音波、振動感測器、氣壓計等。
- **標註正確答案**：由觀察員用 App 記錄真實的車輛事件。
- **分析**：每 1 秒的資料算統計值，再用決策樹、KNN、神經網路分類。

**發現**

- **各技術比較（文獻整理表）**：

| 技術 | 成本 | 裝設容易 |
|---|---|---|
| 地感線圈 | 低 | 否 |
| 攝影機 | 高 | 是 |
| 磁力計 | 低 | 是 |
| 超音波 | 低 | 是 |

- **單一感測器實測**：

| 感測器 | 偵測車輛準確率 | 備註 |
|---|---|---|
| 磁力計 | 93% | 範圍約 2 m |
| 光感測器 | 60–95% | 受日照影響 |
| 光達 | 83% | |
| 被動紅外線（PIR） | 39% | |

- **組合感測器**：多組被動感測器組合可達 97–98%，其中「磁力計＋光感測器」就有 98%。
- **偵測行人**：一定要用雷達或光達這類主動感測器（94–95%）。
- **定位**：要判斷車在偵測區內 1 m 精度的位置，單一節點只有 75% 以下。

**限制**：在一般道路測試，事件數不多，用 60 個事件訓練模型。

**對我們的用處**
- 接送格的落位偵測，可以考慮「磁力計＋光感測器」：便宜、不用切路面、實測 98%。
- 純超音波或 PIR 不建議單獨使用。

**難度**：需背景（比較表讀得懂）

### 1-2｜Analysis of Vehicle Detection with WSN-Based Ultrasonic Sensors【全文】

- **書目**：Youngtae Jo, Inbum Jung，2014，*Sensors* 14(8): 14050–14069，DOI 10.3390/s140814050
- **在做什麼**：用電池供電的路邊超音波感測器數車，同時要省電、運算要簡單。

**怎麼做**
- **硬體**：SRF04 超音波模組＋MICAz 無線節點（8 MHz 處理器，記憶體 4 KB）。
- **偵測間隔**：依車道寬、車速、聲速推算出可用的偵測間隔（32–50 ms），選最長的以省電。
  - 聲速會隨氣溫變化：331.5 + 0.61 × 溫度（m/s）。
- **演算法**：中位數濾波 → 依車道寬量化距離 → 判斷車輛形狀。
- **實地測試**：在雙車道路上測 1 小時，和錄影結果比對。

**發現**
- 錄影計數 522 台，超音波計數 514 台，總誤差 −1.53%。
- 遠側車道少算 6.37%，原因是兩台車並排時遠的那台被擋住（稱為「overlap」錯誤）。
- 結論：單顆路邊超音波適合車道少、車流不大的地方。

**限制**：只測 1 小時、一條路，年代稍舊。

**對我們的用處**
- 如果超音波從側面照接送車道，旁邊車道有車時會漏算。
- 建議從**上方往下照**單一車格。
- 夏天和冬天氣溫不同，聲速也會變，距離門檻要預留空間。

**難度**：易／需背景

### 1-3｜Ultrasonic sensor based traffic information acquisition system; a cheaper alternative for ITS application in developing countries【摘要】

- **書目**：Appiah, Quayson, Opoku，2020，*Scientific African* 9: e00487，DOI 10.1016/j.sciaf.2020.e00487
- **在做什麼**：給開發中國家用的便宜交通偵測方案。
- **怎麼做**（依摘要）：
  - 每個節點一顆超音波感測器，架在上方垂直往下照。
  - 用「佔有率」演算法估計壅塞。
- **發現**（依摘要）：
  - 能偵測汽車、機車和行人，反應時間 0.20–0.35 秒。
  - 橫向安裝容易被非車輛物體干擾。
- **限制**：全文被出版社網站擋住，數字未能以全文確認。
- **對我們的用處**：支持「從上方往下照」的裝法。

### 1-4｜Deep Learning for Decentralized Parking Lot Occupancy Detection【全文（作者預印本）】

- **書目**：Amato, Carrara, Falchi, Gennaro, Meghini, Vairo，2017，*Expert Systems with Applications* 72: 327–334，DOI 10.1016/j.eswa.2016.10.055
- **在做什麼**：讓便宜的「智慧攝影機」自己判斷每個車位有沒有車，只把結果傳回伺服器。

**怎麼做**
- **模型**：設計小型卷積神經網路 mAlexNet（3 層卷積＋2 層全連接），可以在 Raspberry Pi 2 上執行。
- **自建資料集**：在義大利 CNR 比薩園區架 9 台攝影機，跨季節拍攝，建立 CNRPark-EXT 資料集。
- **比較**：和既有的 PKLot 資料集方法比較，也測試換攝影機、換天氣時的表現。

**發現**
- 同一台攝影機的資料訓練和測試：約 99.5%。
- 換到沒看過的停車場或角度：mAlexNet 仍有 93–98%，其他方法掉到 84–88%。
- 遮擋嚴重的 CNRPark：約 90%。
- 一台 Raspberry Pi 約 15 秒判斷完 50 個車位。
- 成本：Raspberry Pi 加相機約 80 歐元，戶外機殼約 80 歐元。每個車位的成本比地面感測器低一個數量級。

**限制**：判斷一次要約 15 秒，不夠即時。換角度後準確率會下降。

**對我們的用處**
- 一台鏡頭可以顧整個接送區。
- 程式碼開源，可以拿學校的照片重新訓練。
- 學校的拍攝角度和光線，一定要自己收資料測試。

**難度**：需背景

### 1-5｜An Efficient and Layout-Independent Automatic License Plate Recognition System Based on the YOLO Detector【全文】

- **書目**：Laroca, Zanlorensi, Gonçalves, Todt, Schwartz, Menotti，2021，*IET Intelligent Transport Systems* 15(4): 483–503，DOI 10.1049/itr2.12030（CC BY 開放取用）
- **在做什麼**：一套不受車牌格式限制、能即時運作的車牌辨識系統。

**怎麼做**
- 三個步驟都用 YOLO 物件偵測器：
  1. 找出車輛。
  2. 找出車牌，並判斷版式（國家、單行或雙行）。
  3. 一次辨識所有字元，再依版式規則修正。
- 在 8 個公開資料集測試，涵蓋 5 個地區，其中包括台灣的 AOLP（2013 年，2,049 張）。

**發現**

| 資料集 | 本系統 | Sighthound（商用） | OpenALPR（商用） |
|---|---|---|---|
| 8 個資料集平均 | 96.9% | 87.8% | 90.7% |
| 台灣 AOLP | 99.2% | — | 98.8% |
| UFPR-ALPR（移動中拍攝，含機車） | 90.0% | 62.3% | 82.2% |

- 在高階 GPU（Titan XP）上可以跑到 73 FPS。

**限制**
- 需要 GPU 才能即時。
- AOLP 是 2013 年的資料，台灣現行車牌格式需要自己測試。

**對我們的用處**：可以用來做「只認註冊車輛」的路線之一，而且有機車車牌的測試資料。

**難度**：需背景

### 1-6｜Application of Wireless Magnetic Sensors in the Urban Environment and Their Accuracy Verification【全文】

- **書目**：Čulík, Štefancová, Hrudkay，2023，*Sensors* 23(12): 5740，DOI 10.3390/s23125740
- **在做什麼**：斯洛伐克日利納市在路面下埋了磁性感測器，這篇檢查它們數車到底準不準。

**怎麼做**
- 感測器每 5 分鐘透過 LoRa 網路回傳資料，失敗時改用 4G。
- 2021 年 11 月 11 日 5:00–17:00，在一個路段用錄影加 Sierzega 雷達做 12 小時交通調查，和感測器資料逐時段比對。

**發現**

| 比較時段 | 誤差 |
|---|---|
| 全天 | 進城 4.99%、出城 8.32%（感測器一律少算） |
| 15 分鐘短時段 | 29.71–42.42% |

- 車速和車種判斷不準。
- 通訊中斷後，資料會堆在一起送出。

**限制**：只測一天，而且是好天氣。

**對我們的用處**
- 放學接送正是「短時段」，感測器的短時誤差可能很大，一定要自己驗證。
- 它的「感測器 vs 錄影人工計數」流程可以照做。

**難度**：易

### 1-7｜Smart parking sensors, technologies and applications for open parking lots: a review【摘要】

- **書目**：Paidi, Fleyeh, Håkansson, Nyberg，2018，*IET Intelligent Transport Systems* 12(8): 735–741，DOI 10.1049/iet-its.2017.0406
- **在做什麼**（依摘要）：整理露天停車場可用的感測技術。
- **發現**（依摘要）：
  - 室內停車場常用磁力計、超音波、影像。
  - 露天停車場較適合影像＋神經網路或多代理人系統，因為較便宜、較不怕天氣。
- **限制**：期刊版付費。OpenAlex 顯示瑞典達拉納大學典藏庫有免費版，但我沒下載到。

---

## 問題 2：如何避免誤觸發

### 2-1｜Geofencing in location-based behavioral research: Methodology, challenges, and implementation【全文】

- **書目**：Shevchenko, Reips，2024，*Behavior Research Methods* 56(7): 6411–6439，DOI 10.3758/s13428-023-02213-2
- **在做什麼**：手機地理圍欄的通知到底準不準？受哪些因素影響？

**怎麼做**：用作者開發的 Samply App 做了三個研究。

| 研究 | 誰測 | 設計 |
|---|---|---|
| 研究 1 | 4 位測試者 | 走固定路線。3 種環境（市中心、住宅區、森林）× 3 種半徑（10、50、100 m）× iOS/Android × Wi-Fi 開或關，共 360 次 |
| 研究 2 | 2 位測試者 | 另外帶一台獨立 GPS 記錄器，量通知「在跨過邊界前或後幾公尺、幾秒」發出，共 120 次 |
| 研究 3 | 58 位學生 | 用自己的手機。進出大學校園時收到問卷，用回答算出漏報和誤報 |

**發現**

- **研究 1：半徑對偵測率的影響**

| 半徑 | 進入偵測率 | 離開偵測率 |
|---|---|---|
| 10 m | 0.65 | 0.62 |
| 50 m | 0.90 | 0.92 |
| 100 m | 0.92 | 0.95 |

  - 通知當下的位置到圍欄中心，平均距離是：進入 87 m、離開 234 m。

- **研究 2：iOS 和 Android 的時間差**
  - iOS 平均在跨過邊界**之前**約 44 m、55 秒就通知。
  - Android 平均在跨過**之後**約 53 m、146 秒才通知。

- **研究 3：真實使用**

| 事件 | 偵測率 | 精確率 |
|---|---|---|
| 進入 | 70% | 70% |
| 離開 | **18%** | 89% |

  - 整體而言 iOS 比 Android 好。

- **作者建議**：半徑至少 100 m；記錄手機型號；部分 Android 的省電機制會擋掉通知。
- **隱私設計**：圍欄座標只存在手機上，不傳給研究者。

**限制**：研究場景是歐洲的大學和城市，不是學校接送。

**對我們的用處**
- 半徑至少 100 m 有實證支持。
- 「離開」事件不可靠，不要用它來判斷車子已經離開。
- iOS 和 Android 的通知時間差可達數分鐘，ETA 倒數要考慮這點。

**難度**：易（看結果段）

### 2-2｜Smartphone GPS accuracy study in an urban environment【全文】

- **書目**：Merry, Bettinger，2019，*PLOS ONE* 14(7): e0219890，DOI 10.1371/journal.pone.0219890
- **在做什麼**：手機 GPS 在校園、都市環境裡到底差多少？

**怎麼做**
- 在美國喬治亞大學校園選 6 個「測量標」，這是座標已精確測量過的地面標記，當作正確答案。
- 用 iPhone 6 和 Avenza App，把手機放在單腳架加水平儀上，離地約 3 英尺。
- 每個點在 8 種情境下各量 20 次：落葉前／後 × 上午／下午 × 人多／人少的時段。
- 每次先量「只用 GPS」，再開 Wi-Fi 等 2 分鐘再量。
- 共 160 趟，取得 955 筆位置。

**發現**
- 平均水平誤差 7–13 m，只用 GPS 時 RMSE 約 9.9 m。
- 最小 0.05 m，**最大 99.7 m**（一次離群值，第二大約 30 m）。
- 四周空曠的點誤差最小。人多的時段誤差反而略小，推測是 Wi-Fi 熱點多幫助定位。

**限制**：手機型號舊（iPhone 6），只在一個校園測試。

**對我們的用處**
- 誤差量級是 10 m，偶爾會跳到 100 m，所以不能用單一一點決定觸發。
- 它的實驗設計（固定點、重複量測、分情境）可以直接搬到校門口做。

**難度**：易

### 2-3｜Analysis and modeling GPS NLOS effect in highly urbanized area【全文】

- **書目**：Li-Ta Hsu，2018，*GPS Solutions* 22(1): 7，DOI 10.1007/s10291-017-0667-9
- **在做什麼**：高樓區的 GPS 為什麼會亂跳？能不能建立誤差模型來修正？

**怎麼做**
- 在香港九龍用低價接收器 u-blox M8 收資料：一組 24 小時、一組 30 分鐘。
- 用 3D 建築模型模擬訊號路徑，判斷每顆衛星的訊號是直接收到，還是被大樓反射才收到（NLOS）。
- 再用差分 GPS 扣掉其他誤差，算出反射造成的距離誤差。

**發現**
- 圖 1：開闊地誤差約 5 m；高樓區（無人機上的移動測試）誤差可達約 50 m。
- 24 小時共收集 128,054 筆反射訊號，超過 70% 的虛擬距離誤差在 50 m 以內。誤差分布是長尾，不是常態分布。
- **誤差主要和衛星仰角有關，和訊號強度無關。** 訊號很強，不代表它沒被大樓反射過。
- 提出模型：誤差 = α × sec θ × (1 + cos 2θ)，α 是接收器到反射牆面的距離，θ 是衛星仰角。
- 定位誤差比較：

| 方法 | 平均誤差 |
|---|---|
| 不修正 | 8.67 m |
| 用作者的模型 | 6.27 m |
| 用 3D 建築模型模擬 | 5.05 m |

**限制**：用的是專用接收器，不是手機。

**對我們的用處**
- 學校旁邊有高樓時，GPS 可能偏 50 m。外圈要大，到位確認要交給近距離感測器。
- 誤差是長尾分布，要用「連續數點」或「停留時間」來過濾跳點。

**難度**：需背景（圖 1 和結論讀得懂）

### 2-4｜A Low-Cost On-Street Parking Management System Based on Bluetooth Beacons【全文】

- **書目**：Chien, Chen, Lin（淡江大學資工系），2020，*Sensors* 20(16): 4559，DOI 10.3390/s20164559
- **在做什麼**：
  - 磁力計只能知道「有車」，不知道「是誰的車」。
  - 有車牌辨識的智慧停車柱，每台要 2,000–4,000 美元，太貴（文中提到台北有超過 4 萬個路邊車位）。
  - 能不能用便宜的藍牙 beacon，同時知道「有車」和「是誰」？

**怎麼做**
- **架構**：
  - 車上（右側後照鏡）裝 beacon 發射器（Estimote）。
  - 路邊每格裝 Raspberry Pi 3 接收器，每 10 秒掃描一次。
  - 用一維 Kalman filter 平滑訊號強度，估算距離最近的兩個接收器，判斷車停在哪一格。
- **實驗**：
  - 在工學院大樓前的空地，用**模擬方式**佈置 3 個車位。
  - 做 3 個實驗：右側靠路邊、左側靠路邊、車頭反向停。
  - 每個實驗約 10 分鐘。

**發現**
- 估出來的距離很不準，但最後仍能判斷正確的車位。
- **平均要約 5 分鐘才穩定。** 實驗 1 中，一台車在前 4 分鐘反覆跳動，另一台到第 9 分鐘才收斂。
- 系統有網頁和 iOS App，可以查空位、看停車紀錄、繳費。

**限制**
- 只有 3 個車位，而且是模擬環境，不是真車停在真的路邊。
- 原文**沒有**長期運作的準確率數據。

**對我們的用處**
- 「車上 beacon ＝ 車輛身分」的想法很適合「只認註冊車輛」。
- 但判斷「停在哪一格」要好幾分鐘，**不適合**只停 1 分鐘的接送。比較適合用來判斷「已註冊的車到校門附近了」。

**難度**：架構易，Kalman filter 需背景

### 2-5｜Smart Parking System Based on Bluetooth Low Energy Beacons with Particle Filtering【全文（預印本）】

- **書目**：Mackey, Spachos, Plataniotis，2020，*IEEE Systems Journal* 14(3): 3371–3382，DOI 10.1109/JSYST.2020.2968883
- **在做什麼**：每個車位放一顆 beacon，用駕駛的手機判斷車停在哪格，再自動計費。這個架構和淡江那篇相反。

**怎麼做**
1. 先量訊號強度和距離的關係（0.2–4 m，室內和室外各一組）。
2. 用粒子濾波（particle filter）估距離。
3. 在相鄰 3 個車位（beacon 相距 2.7 m）測試「能否判斷正確的車位」。

**發現**
- 95% 的情況下距離誤差：

| 環境 | 原始資料 | 加粒子濾波 |
|---|---|---|
| 室內 | 2.5 m | 1.5 m |
| 室外 | 2.8 m | 2.0 m |

- 2 m 以內估得比較準。beacon 之間距離越大，判斷越準。

**限制**：只測少數車位，手機放的位置固定。

**對我們的用處**：如果改成「接送格放 beacon、家長手機偵測」，2–3 m 的車位間距在技術上可行，但要求家長的 App 一直在背景運作。

**難度**：需背景

### 2-6｜Android Developers：Create and monitor geofences【全文（官方文件，非論文）】

- **在做什麼**：說明 Android 地理圍欄怎麼用、限制是什麼。
- **重點**（已直接讀原文）：
  - 半徑建議至少 100–150 m。有 Wi-Fi 時定位精度通常 20–50 m。
  - 每個 App 最多 100 個圍欄。
  - 觸發延遲：通常不到 2 分鐘；有背景定位限制時平均 2–3 分鐘；手機靜止很久時最長約 6 分鐘。
  - 可以改用 `DWELL`（在範圍內停留一段時間才觸發），減少「路過就觸發」的通知轟炸。
- **對我們的用處**：系統參數直接照這份文件設定。

### 2-7｜Geofencing 2.0: Taking Location-based Notifications to the Next Level【摘要】

- **書目**：Rodriguez Garzon, Deva，2014，UbiComp '14: 921–932，DOI 10.1145/2632048.2636093
- **在做什麼**（依摘要）：一般的圍欄彼此獨立，沒辦法表達「先進 A 再進 B」這種時間順序。作者用「狀態與轉移」模型，把多個圍欄串起來。
- **對我們的用處**：可以支撐「外圈預告 → 內圈確認」的設計。這個例子是我們自己舉的，不是原文的例子。
- **限制**：全文付費，年代較舊。

### 2-8｜The World's first GPS MOOC and Worldwide Laboratory using Smartphones【投影片】

- **書目**：van Diggelen, Enge，ION GNSS+ 2015（只讀到 2015 年 11 月史丹佛的簡報）
- **在做什麼**：在線上 GPS 課程中，讓學員用手機在世界各地量定位精度。
- **投影片內容**：
  - 約 1,700 人在 100 個國家參加實驗。
  - 作者提出一個帶問號的「都市多路徑定律？」：平均誤差（m）≈ 建築物樓層數 + 5。
- **限制**：論文本身沒取得；第一版寫的「平均 4.9 m」無法確認。

---

## 問題 3：如何模擬、實測

### 3-1｜Best Practices in Managing School Campus Traffic Circulation【全文】

- **書目**：Tsai, Cranford, Lee，2004，*Transportation Research Record* 1865: 41–47，DOI 10.3141/1865-07
- **在做什麼**：小學放學時家長車隊怎麼管理最好？哪些因素決定隊伍有多長？

**怎麼做**
- 在北卡州 11 個郡的 20 所小學實測（每校 236–959 名學生）。
- **4 人一組量測**：
  - 站 1：在入口記錄每台車的車牌和加入隊伍的時間 T1，用交通錐量隊伍長度。
  - 站 2：在上車區記錄進入時間 T2、離開時間 T3。
  - 站 3：在出口記錄離校時間。
  - 第 4 人：記錄行人穿越和插隊車輛。
  - 同時從高處錄影。
- 用排隊模擬軟體 ARENA，以實測資料校正後，模擬各種改善策略，再做迴歸分析。

**發現**
- 超過 60% 的家長在鐘響前就到，等待時間是晚到者的 3 倍。
- 平均總接送時間將近 14 分鐘，但車隊開始動之後只要 4 分 25 秒。每台車在上車區平均停 63 秒。
- 範例學校：79 台車中 46 台在鐘響前就到。3:15 放學，3:17 第一台才離開；3:10–3:24 隊伍溢出到馬路上。
- 影響最大排隊長度的因素依序是：車輛數 > 到達速率 > 服務速率 > 排隊空間長度。
- 兩個可以縮短隊伍的策略：
  - **分年級錯開放學**，例如低年級提早 30 分鐘。
  - **管制到達時間**：規定家長什麼時候才能進來。
- **人工叫號流程**：家長把號碼牌放在擋風玻璃，一位老師用對講機報名字，另一位用擴音器叫學生。
- **作者建議**：
  - 每台車上下學生不超過 10 秒，全程不超過 45 秒。
  - 上車格最多 5 格。
  - 鐘響前 5–10 分鐘，先收集前 20 台車的學生名單。

**限制**
- 2004 年的美國資料，學校有校內專用車道。
- 原文寫上車停留時間「33 秒到 90 多分鐘」，對照平均 63 秒，看起來是筆誤。

**對我們的用處**
- 動機段的核心數據。
- 我們的 ETA 通知，就是「鐘響前先收集名單」的自動化版本。
- 三站量測法可以直接照做。

**難度**：易

### 3-2｜School Surrounding Region Traffic Commuting Analysis Based on Simulation【全文】

- **書目**：Liu, Deng, Li, Zhao, Li（吉林大學等），2022，*IJERPH* 19(11): 6566，DOI 10.3390/ijerph19116566
- **在做什麼**：學校設在號誌路口旁邊時，接送車對周邊交通的影響有多大？

**怎麼做**
- 用 VISSIM 7.0 建一個假想場景：學校在都市幹道號誌路口的西側出口。
- 一次只改一個參數：

| 參數 | 範圍 |
|---|---|
| 主線流量 | 100–2500 pcu/h |
| 送貨車的停車需求 | 多種設定 |
| 校門到路口距離 | 100–500 m |
| 接送車平均停靠時間 | 10–60 秒 |

- 觀察延誤、隊伍長度、停等次數、油耗、排放。

**發現**
- 流量越大越糟。
- 校門距離路口 400 m 時（流量 1000 pcu/h），各項指標最好。
- 停靠時間從 10 秒增加到 60 秒，路口和學校的延誤增加約 6–10 秒；超過一定值後，因為車位滿了，就不再惡化。

**限制**：是假想場景，沒有用真實學校的資料校正。

**對我們的用處**
- 告訴我們 VISSIM 模型要設哪些參數。
- 「停靠時間」正是我們系統想縮短的東西：學生先到等候點，車停的時間就短。

**難度**：需背景

### 3-3｜G/M/N Queuing Model-Based Research on the Parking Spaces for Primary and Secondary School【摘要】

- **書目**：Zhao, Zhou, Pan, Zhou，2020，*Discrete Dynamics in Nature and Society* 2020: 1–7，DOI 10.1155/2020/8870862
- **在做什麼**（依摘要）：中小學門口要劃幾個臨停車位才夠？
- **怎麼做**：
  1. 用 G/M/N 排隊模型（任意到達分布、指數服務時間、N 個車位），在 MATLAB 模擬「送學生」需要的車位。
  2. 用累計到達車數算「接學生」需要的車位。
  3. 再用最佳化模型決定總車位和短時車位。
  4. 用學校實際交通資料驗證。
- **發現**：接學生需要的車位比送學生多。
- **限制**：出版社網站擋下載，只讀到摘要。

### 3-4｜Analyzing the Traffic Operational Performance of School Pick-Up and Drop-Off Dynamics in Saudi Arabia【全文】

- **書目**：Shokry, Alrashidi, Elbany，2024，*Sustainability* 16(12): 5154，DOI 10.3390/su16125154
- **在做什麼**：接送時段到底讓學校周邊道路塞多少？

**怎麼做**
- 寫 Python 程式呼叫 Google Maps API。
- 抓沙烏地 6 座城市、40 所學校周邊 242 個路段的旅行時間。
- 分三個時段比較：早上送學生、下午接學生、離峰。
- 計算旅行時間指數（TTI = 實際旅行時間 ÷ 自由車流時間）、計畫時間指數（PTI），再換算成服務水準（LOS）。

**發現**
- 下午接學生的 TTI 比早上高，代表放學比上學更塞。
- 除了首都利雅德，其他城市的服務水準在 C–D 級。
- 作者提出的政策包括：錯開時間、劃設接送區、共乘、單向環狀動線、遠端接送點、多個接送點讓家長選。

**限制**：Google 的旅行時間是估計值，看不到校門口的排隊細節。

**對我們的用處**：不用買設備就能量周邊壅塞，適合做系統上線前後的對照。

**難度**：易（方法部分）

### 3-5｜School Traffic Trip Generation Calculator Evaluation and Data Collection（NCDOT 2019-27）【全文】

- **書目**：Kearns 等 15 人（北卡州立大學 ITRE、北卡大學 HSRC），2021，北卡交通部報告 FHWA/NC/2019-27
- **在做什麼**：更新北卡交通部「學校交通計算器」中的接送車輛數和最大排隊長度。

**怎麼做**
- 在 27 所學校實地錄影，其中公立小學 13 所。
- **錄影方式**：
  - 固定攝影機用束帶綁在路燈或樹上。
  - 有些學校用無人機從遠處拍，由合格駕駛員操作。
  - **畫質刻意調到看不清人臉和車牌。**
- **時間安排**：
  - 避開星期一早上和星期五下午，多在星期二、四。
  - 設備在接送時段外安裝。
- **分析**：
  - 分析員把影片看兩遍，記錄每台車「到達隊尾」和「進入上車區」的時間。
  - 進出車數差距不能超過 3 台。
  - 在線上地圖畫出隊伍路徑，量最大隊伍長度。

**發現**
- 公立小學的資料最可靠。原本計算器的估計值和實測差不多。
- 建議改用第 95 百分位數，讓估計保守一點。

**對我們的用處**
- 一套完整、可以照做的錄影量測 SOP，連保護隱私的做法都有。

**難度**：易

### 3-6｜Traffic Operations and Safety at Schools: Recommended Guidelines（TTI 4286-2）【全文】

- **書目**：Cooner, Fitzpatrick, Wooldridge, Ford（德州交通研究所），2003 年 10 月（2004 年 1 月修訂），報告 FHWA/TX-04/4286-2
- 這是排除論文 E1 同一團隊、同一計畫的成果。
- **在做什麼**：替德州學校規劃者寫交通設計準則。
- **怎麼做**：
  - 第一年在 14 所學校做觀察案例研究。
  - 第二年在 20 所學校做實地調查。
  - 加上文獻回顧，整理出 20 多條準則和一份審查清單。
- **發現**：
  - 德州實測的最大隊伍長度，常比南、北卡州的建議值短。
  - 用迴歸分析**找不到統計上顯著的排隊模型**。
  - 改為建議德州的校內排隊車道長度：小學 500 人以下 122–229 m；500 人以上 229–458 m。
  - 報告收錄了北卡的「家長接送最佳實務」示意圖：上車格寬至少 8 英尺，頭尾格長 20 英尺、中間格長 30 英尺，最多 4–5 格，每格配一位安全助理。
- **對我們的用處**：可以拿學校的排隊空間和建議值比較。

### 3-7｜Microscopic Traffic Simulation using SUMO【全文】

- **書目**：Lopez 等 10 人（德國航太中心 DLR），2018，*21st IEEE ITSC*: 2575–2582，DOI 10.1109/ITSC.2018.8569938
- **在做什麼**：介紹開源交通模擬軟體 SUMO 的功能和模型。SUMO 官網指定引用這篇。
- **內容**：
  - 模擬的工作流程。
  - 免費的範例場景。
  - 多種運具的模擬。
  - TraCI 介面：可以用 Python 即時控制模擬，例如在模擬中引導車輛到其他停車場。
- **對我們的用處**：
  - 用 SUMO 的話，可以用 Python 寫「收到通知才出發」或「導到側門」的邏輯，直接在模擬中測試。
  - 我沒找到用 SUMO 模擬學校接送的論文，要自己建模。

**難度**：需背景

### 3-8｜Traffic Stream Characteristics Analysis for Roadway Linking to Pick-up Zone of Passenger Transportation Hub【全文】

- **書目**：Zheng, Yang, Gao, Yang, Chen，2023，*Applied Sciences* 13(1): 175，DOI 10.3390/app13010175
- **在做什麼**：機場、火車站接客區前的道路，為什麼會突然塞住？
- **怎麼做**：
  - 把乘客上車看成兩階段服務的 M/M/1 門檻排隊系統。
  - 推導出流量和密度的關係（基本圖）。
  - 用模擬資料校正和比較。
- **發現**：
  - 模型能重現「接客區容量突然下降」的現象。
  - 誤差比傳統方法小：均方誤差 0.69，誤差平方和 0.90。
- **限制**：研究對象**不是學校**，用的是模擬資料。
- **對我們的用處**：如果想用排隊理論解釋「為什麼接送區一滿就整條路塞住」，可以參考。

**難度**：需背景

### 3-9｜Enhancing traffic safety at school zones by operation and engineering countermeasures: A microscopic simulation approach【摘要】

- **書目**：Rahman, Abdel-Aty, Lee, Rahman，2019，*Simulation Modelling Practice and Theory* 94: 334–348，DOI 10.1016/j.simpat.2019.04.001
- **在做什麼**（依摘要）：
  - 在佛州 Orange 和 Seminole 郡，找出事故率最高的學區路段，建立微觀模擬。
  - 測試三種改善：兩段式降速、減少車道出入口、把雙向左轉車道改成實體分隔島。
- **發現**：降速和減少出入口都能降低事故風險，兩者合併效果最好。
- **限制**：期刊付費。第一作者的 UCF 碩士論文被網站擋下載。

---

## 問題 4：如何定位、資安

### 4-1｜Unique in the Crowd: The privacy bounds of human mobility【全文】

- **書目**：de Montjoye, Hidalgo, Verleysen, Blondel，2013，*Scientific Reports* 3: 1376，DOI 10.1038/srep01376
- **在做什麼**：把姓名拿掉的位置資料，還能認出是誰嗎？
- **怎麼做**：
  - 分析一個國家 150 萬人、15 個月的手機基地台紀錄（每小時一筆，位置精度到基地台）。
  - 計算知道某人幾個時空點，就能在資料庫中唯一找到他。
  - 再把資料的時間和空間精度調粗，看結果怎麼變。
- **發現**：
  - 4 個時空點就能唯一辨識 95% 的人。
  - 資料變粗，唯一性只按約 1/10 次方下降，所以就算資料很粗，也幾乎沒有匿名效果。
- **對我們的用處**：家長每天固定時間到學校的軌跡非常好認。系統**不該保存軌跡**，只存「到了」這種事件。

**難度**：易

### 4-2｜The Long Road to Computational Location Privacy: A Survey【全文（預印本）】

- **書目**：Primault, Boutet, Ben Mokhtar, Brunie，2019，*IEEE Communications Surveys & Tutorials* 21(3): 2772–2793，DOI 10.1109/COMST.2018.2873950
- **在做什麼**：整理所有「位置隱私保護機制」，以及怎麼評估它們。
- **內容**：
  - **攻擊類型**：例如從軌跡推出家和工作地點。
  - **六類保護機制**：

| 類別 | 做法 |
|---|---|
| 混合區（mix-zones） | 在特定區域內交換使用者身分代號 |
| 概括化 | 把位置變成一塊範圍 |
| 假資料 | 混入假的位置或軌跡 |
| 加擾動 | 例如 geo-indistinguishability |
| 協定式 | 用密碼學協定保護 |
| 規則式 | 依使用者設定的規則決定揭露程度 |

  - **評估指標**：隱私、可用性、效能三方面。
- **對我們的用處**：報告裡說明「為什麼我們選擇不上傳軌跡」時，可以引用這篇的分類。

**難度**：需背景

### 4-3｜Angel or Devil? A Privacy Study of Mobile Parental Control Apps【全文】

- **書目**：Feal, Calciati, Vallina-Rodriguez, Troncoso, Gorla，2020，*Proceedings on Privacy Enhancing Technologies* 2020(2): 314–335，DOI 10.2478/popets-2020-0029
- **在做什麼**：親子監控 App 本身會不會侵犯孩子的隱私？
- **怎麼做**：
  - 分析 Google Play 上 46 款親子監控 App（43 家開發商，合計 2,000 萬次安裝）。
  - **靜態分析**：看程式碼要了哪些權限。
  - **動態分析**：實際執行並攔截網路流量。
  - 再對照它們的隱私政策和法規（GDPR、美國 COPPA）。
- **發現**：
  - 比 Google Play 前 150 名 App 要更多權限，而且改版越要越多。
  - 11% 用明文傳個資。
  - 34% 沒取得適當同意就蒐集資料。
  - 72% 把資料分享給第三方（廣告、分析服務），卻沒寫在隱私政策裡。
  - 連官方推薦的 App 也有這些問題。
- **對我們的用處**：可以當系統設計的「反面教材檢查表」：最少權限、全程加密、不接第三方廣告或分析套件、隱私政策寫清楚。

**難度**：易（結果段）

### 4-4｜Understanding the Mirai Botnet【全文】

- **書目**：Antonakakis 等，2017，*26th USENIX Security Symposium*: 1093–1110
- **在做什麼**：2016 年癱瘓大型網站的 Mirai 殭屍網路，是怎麼感染這麼多 IoT 裝置的？
- **怎麼做**：
  - 從 2016/8/1 到 2017/2/28 的 7 個月，結合多種資料：網路望遠鏡、全網掃描、IoT 誘捕系統、指揮伺服器監控、DNS 紀錄、受害者提供的攻擊紀錄。
- **發現**：
  - Mirai 掃描 Telnet 連接埠（23、2323），用內建的 **62 組預設帳號密碼**登入。
  - 前 20 小時就感染約 6.5 萬台，穩定期 20–30 萬台，2016 年 11 月底高峰 60 萬台。
  - 受害裝置主要是監視錄影機、網路攝影機、路由器、印表機。
  - 結論：根本原因是 IoT 缺乏最基本的資安實務。
- **對我們的用處**：
  - Raspberry Pi 和感測器上線前：改掉預設密碼、關掉 Telnet 和不用的連接埠、不要直接暴露在網際網路上。

**難度**：需背景（前言和結論讀得懂）

### 4-5｜Betrayed by the Guardian: Security and Privacy Risks of Parental Control Solutions【全文（預印本）】

- **書目**：Ali, Elgharabawy, Duchaussoy, Mannan, Youssef，2020，*ACSAC 2020*: 69–83，DOI 10.1145/3427228.3427287
- **在做什麼**：親子監控的硬體和軟體，本身有多少資安漏洞？
- **怎麼做**：
  - 2019/3 到 2020/5 間，實測 8 台網路裝置、8 個 Windows 程式、10 個 Chrome 擴充、29 個 Android App（13 套方案）。
  - 另外自動掃描 153 個 Android App。
  - 找到漏洞後通知廠商（負責任揭露）。
- **發現**：
  - 共找到 135 個漏洞。
  - 13 套 Android 方案中：8 套伺服器沒有好好驗證身分，5 套家長帳號容易被盜，7 套用 HTTP 傳個資。
  - Blocksi 路由器可以被遠端執行指令。
  - 兩個月後只有 10 家廠商回應。
- **對我們的用處**：「家長帳號被盜 → 別人能冒名接孩子」是接送系統最嚴重的風險。登入驗證和 HTTPS 是必要的，不是選配。

**難度**：需背景

### 4-6｜Foundational Cybersecurity Activities for IoT Device Manufacturers（NISTIR 8259）【全文】

- **書目**：美國國家標準與技術研究院（NIST），2020 年 5 月。2026/4/20 已被新版 NIST IR 8259r1 取代（Fagan 等）。
- **在做什麼**：IoT 產品出廠前，製造商應該做的 6 項資安工作：
  1. 找出預期的客戶與使用情境。
  2. 研究客戶的資安需求。
  3. 決定要提供哪些資安功能。
  4. 規劃支援這些功能所需的資源。
  5. 決定怎麼和客戶溝通。
  6. 決定溝通什麼內容。
- **對我們的用處**：寫報告的資安章節時，可以照這 6 項當架構。引用時請改用 2026 年新版。

---

## 延伸方向

### 多停車區分流：A Balanced Algorithm for In-City Parking Allocation: A Case Study of Al Madinah City【全文】

- **書目**：Abdeen, Nemer, Sheltami，2021，*Sensors* 21(9): 3148，DOI 10.3390/s21093148
- **在做什麼**：有多個停車場可以選時，系統要把每台車分到哪一個？
- **怎麼做**：
  - 設計多目標函數，用 5 個加權因素：路上的壅塞程度、行車距離、停車場空位率、入口等候時間、停車費。
  - 用排隊模型（考慮到達率、離開率、容量）預測每個停車場的空位率。
  - 在沙烏地麥地那市的大型停車設施，模擬高、低兩種車流情況。
- **發現**：各停車場的使用率更平均，路上的壅塞降低，開車時間縮短，表現優於對照的多屬性決策（MADM）演算法。
- **對我們的用處**：「正門滿了導去側門」可以照這個做法，寫成幾個加權因素：各區排隊長度、繞路距離、學生走過去的時間。

**難度**：需背景

### 停車引導綜述：A Survey of Smart Parking Solutions【全文（HAL 典藏版）】

- **書目**：Lin, Rivano, Le Mouël，2017，*IEEE Transactions on Intelligent Transportation Systems* 18(12): 3229–3253，DOI 10.1109/TITS.2017.2685143
- **在做什麼**：整理 2000–2016 年的智慧停車研究。
- **內容**：分成三大主題：資訊蒐集、系統部署、服務發布。文中也比較各城市路邊停車的比例，例如洛杉磯 63%、北京 5%。
- **對我們的用處**：寫「相關研究」時，可以照這個架構把我們的系統定位清楚。

**難度**：需背景

### 叫號／通知系統的實測效益

- **沒找到同儕審查的前後對照研究。**
- 廠商網頁宣稱的數字（2026/10/3 直接讀取確認）：

| 廠商 | 宣稱效果 |
|---|---|
| Carline Hound | 「最多減少 40%」、學校「通常減少 30–40%」 |
| Beeline | 「等待時間減少 50%」 |
| Nutrilink（CurbSmart） | 「客戶回報最多減少 75%」 |

- 這些都是**廠商自述，不能當證據**。

### 台灣資料

**臺北市政府交通局〈104 年第 3 次臺北市交通民意調查報告（改善國小學童上下學交通環境調查）〉（2015）【全文】**

- **怎麼做**：
  - 2015/10/12–11/6 面訪。
  - 從臺北市 125 所學生數超過 300 人的國小中，系統抽樣 36 所。
  - 有效樣本 1,156 份，抽樣誤差 ±2.9 個百分點。
- **發現**：
  - 65.0% 上下學都接送，22.8% 只送不接，12.2% 只接不送。
  - 接送者：母親 52.2%、父親 29.5%、祖父 7.9%、祖母 8.4%。
  - **放學接送運具：機車 37.4%、汽車 25.7%、步行 22.6%**（上學是機車 40.7%、汽車 26.3%、步行 20.4%）。
  - 年級越高，被接送的比例越低：一年級 28.8%，六年級 14.8%。
  - 接送原因（可複選）：考量治安 57.4%、孩子太小 48.9%、家長接送較快或較方便 38.3%、交通環境欠佳 32.2%、學校太遠 21.3%。
- **對我們的用處**：台灣接送以機車為主。系統一定要能處理機車，而且一個學生要能綁多位接送人。

**Built Environment Effects on Children's School Travel in Taipai: Independence and Travel Mode【全文】**

- **書目**：Jen-Jia Lin（林楨家）, Hsiao-Te Chang，2010，*Urban Studies* 47(4): 867–889，DOI 10.1177/0042098009351938（原文標題拼成 Taipai）
- **在做什麼**：社區環境（密度、人行道、路寬等）會不會影響小學生自己上學，以及用什麼交通方式？
- **怎麼做**：
  - 2006 年底調查文山區指南、景美、興華三所國小，有效問卷 330 份。
  - 用巢式羅吉特模型，分兩層分析：「有沒有大人陪」和「用什麼交通方式」。
- **發現**：
  - 約 35–40% 的學生自己上下學，約 40% 走路，36–45% 坐機車或汽車。
  - 樹蔭和人行道越多，越多學生自己走路；街廓越大、路口越多，越少學生自己走。
  - 早上家長可以順路上班，所以距離不影響上學方式；下午放學時間和下班時間對不上，很多孩子先去安親班，晚上 9 點前才被接走。
  - 事故數、犯罪數這類客觀指標大多不顯著，作者建議未來研究加入主觀安全感。
- **限制**：2006 年的資料，只有 3 所學校。
- **對我們的用處**：
  - 放學時有安親班車接多個孩子，系統要支援「一台車對多個學生」。
  - 接送變方便，可能讓更多家長開車，這點可以寫進報告的限制段。

**Enhancing Urban Traffic Safety: An Evaluation of Taipei's Neighborhood Traffic Environment Improvement Program【全文（預印本）】**

- **書目**：Frank Yao Huang, Po-Chun Huang，2024，arXiv:2401.16752
- **在做什麼**：臺北市 2015 年 8 月起推動的巷弄交通改善（綠色人行道、調整紅黃線、標示速限），有沒有讓事故減少？
- **怎麼做**：
  - 分析 6,856 條巷弄 2013–2020 年的事故資料。
  - 利用各巷弄「分批實施」的時間差，用差異中之差異（DID）加 Poisson 迴歸估計效果。
- **發現**：
  - 白天事故減少 5%、受傷減少 8%，夜間沒有顯著效果。
  - 整體事故減少約 3.5%（不顯著），受傷減少約 7%（顯著）。
  - 效果主要來自綠色人行道。
- **限制**：尚未經期刊審查。
- **對我們的用處**：引用台灣校園周邊「低成本交通改善確實有效」時的實證。

---

## 對系統設計的建議

依讀完全文後的發現修正：

| 項目 | 建議 | 依據 |
|---|---|---|
| 遠距觸發 | 圍欄半徑至少 100–150 m，只發「預告」；用 `DWELL` 或「連續數個點都在範圍內」才觸發 | Shevchenko 2024；Android 文件；Merry 2019；Hsu 2018 |
| ETA 倒數 | 預留 iOS／Android 數分鐘的時間差，用車速和距離估 ETA，不要只靠圍欄事件 | Shevchenko 2024 研究 2 |
| 離開偵測 | **不要用 GPS 的「離開」事件**（只抓到 18%），改用接送格感測器判斷車子離開 | Shevchenko 2024 研究 3 |
| 到位確認 | 優先考慮「磁力計＋光感測器」，或從上方往下照的超音波。藍牙 beacon 判斷車位太慢，不建議 | Bernas 2018；Jo & Jung 2014；Chien 2020 |
| 車輛身分 | 車上 beacon 判斷「註冊車輛到校門附近了」，或用車牌辨識。兩者都要實測機車 | Chien 2020；Laroca 2021 |
| 註冊模型 | 一個學生可綁多台車、多位接送人；一台車可接多個學生（安親班） | 臺北市民調 2015；Lin & Chang 2010 |
| 時段限制 | 放學前後 30 分鐘才啟動，有文獻支持；但要和家長溝通，避免改到外面路邊等 | Tsai 2004 |
| 多區分流 | 用加權分數（排隊長度、繞路距離、學生走路時間）選接送區 | Abdeen 2021；Tsai 2004 |
| 隱私 | 圍欄在手機上判斷，只上傳「已進入」事件和註冊編號；不保存軌跡；最少權限；不接第三方廣告或分析套件 | de Montjoye 2013；Shevchenko 2024；Feal 2020 |
| 資安 | 改掉預設密碼、關掉 Telnet、全程 HTTPS、家長帳號做強驗證 | Antonakakis 2017；Ali 2020；NIST IR 8259r1 |

---

## 實地量測方案

### A. 接送流程量測

結合 Tsai (2004) 和 Kearns (2021) 的做法。

**事前準備**
- 取得學校同意，並請學校通知家長。
- 避開星期一和星期五，選星期二或星期四。
- 設備在接送時段以外安裝。

**人力配置**（4 人）

| 位置 | 記錄內容 |
|---|---|
| 站 1：隊尾或入口 | 每台車加入隊伍的時間 T1；每 5 m 一個記號，讀隊伍長度 |
| 站 2：上車點 | 進入時間 T2、離開時間 T3 |
| 站 3：出口 | 離開時間 |
| 第 4 人 | 行人穿越、並排、違停 |

**錄影與隱私**
- 從高處錄影備查，畫質調到看不清人臉和車牌。
- 車牌只記末 3 碼或改用編號。

**紀錄表範例**

| 編號 | 車種（汽車／機車／安親班車） | T1 | T2 | T3 | 接走學生數 | 備註 |
|---|---|---|---|---|---|---|
| 001 | 機車 | 15:52:10 | 16:01:30 | 16:01:55 | 1 | |

**計算指標**
- 上車停留時間 = T3 − T2
- 總接送時間 = T3 − T1
- 提早到達時間 = 鐘響時間 − T1
- 提早到達比例 = 鐘響前就到的車數 ÷ 總車數
- 最大隊伍長度（車數或公尺）

**品質檢查**：進入和離開的車數差距不超過 3 台（Kearns 2021）。

**比較基準**

| 來源 | 數字 |
|---|---|
| Tsai 2004 | 提早到約 60%；總接送時間約 14 分；動態接送時間 4 分 25 秒；上車停 63 秒 |
| Alagos 2025 | 實際學校每台車 4.83–11.77 分 |
| TTI 4286-2 | 小學建議排隊長度 122–458 m |

### B. 手機 GPS 誤差實驗（參考 Merry 2019）

1. 在校門口選兩個點：一個靠高樓或騎樓，一個在開闊處。
2. 取得兩點的精確座標（例如內政部國土測繪中心圖資）。
3. 手機放在固定支架上，iOS 和 Android 各一支，每點記錄 10 分鐘。
4. 算出每筆紀錄和精確座標的距離，畫散佈圖，找出平均值和最大值。
5. 用結果決定圍欄半徑，以及「連續幾個點才觸發」。

### C. 地理圍欄觸發實驗（參考 Shevchenko 2024）

1. 設 50 m、100 m、150 m 三種半徑，iOS 和 Android 各測。
2. 每種組合開車或騎車進出 10 次。
3. 記錄：有沒有通知、通知時距離邊界多遠、晚了幾秒。
4. 算出偵測率和誤報率，分「進入」和「離開」兩種事件。

### D. 感測器準確度驗證（參考 Bernas 2018、Čulík 2023）

1. 感測器運作的同時錄影，事後人工計數。
2. 計算：
   - 漏報率 = 有車但沒偵測到的次數 ÷ 實際車數
   - 誤報率 = 沒車但說有車的次數 ÷ 感測器報告次數
3. 分整段時間和每 15 分鐘兩種算法。
4. 特別測試：機車、學生從旁邊走過、雨天、強烈日照。

### E. 周邊壅塞量測（參考 Shokry 2024）

- 用 Google Maps API 記錄校門前路段在放學時段和離峰時段的旅行時間。
- 算 TTI（尖峰旅行時間 ÷ 離峰旅行時間）。
- 系統上線前後各量兩週，比較差異。

---

## 研究缺口

以下是我在這次搜尋範圍內**沒找到**的研究，也就是本專題可以做出原創貢獻的地方：

1. **叫號、通知系統的實測效益**：只有廠商自述，沒有前後對照研究。
2. **台灣學校的接送排隊實測**：沒找到公開的排隊長度或接送時間資料。台灣以機車為主，國外數據不一定適用。
3. **「車到之前就通知」的效果**：菲律賓系統在進校門才觸發，美國的人工叫號也是車到了才叫。
4. **GPS 圍欄＋近距離感測的兩段式確認**：兩種技術各自都有研究，但沒找到套用在學校接送的整合實測。
5. **用 SUMO 模擬校園接送**：國外多用 VISSIM 或 ARENA。

---

## 還沒讀到全文的文獻

以下文獻我只讀到摘要或簡報。如果你能取得 PDF 傳給我，我可以補讀：

| 文獻 | 原因 |
|---|---|
| E1 Cooner 2009（排除名單） | 付費。也請確認作者是一位還是四位 |
| E3 Adams 2020（排除名單） | 網站有反爬蟲保護。也請確認標題 |
| Appiah 2020 | 出版社網站阻擋（本身是開放取用） |
| Zhao 2020 | 出版社網站阻擋（本身是開放取用） |
| Paidi 2018 | 付費；典藏庫版本沒下載到 |
| Rodriguez Garzon & Deva 2014 | 付費 |
| Rahman 2019 | 付費；碩士論文網站阻擋 |
| van Diggelen & Enge 2015 | 只取得簡報 |
| 工商時報 2025/3/24 新聞（新北 89.70% 學校設接送區、34.4% 有臨停格） | 未核對原文，**本版已不使用** |

> **著作權提醒**：付費論文的 PDF 請只在組內使用，不要上傳到公開的 GitHub 或雲端。

---

## 參考文獻（APA 格式）

> 書目資料已用 Crossref 或全文首頁核對。

**原本排除的 4 篇**

- Adams, K. (2020). *Geofencing as applied within the field of cybersecurity: An overview of potential risks and advantages* [Master's project, California State University, San Bernardino]. CSUSB ScholarWorks. https://scholarworks.lib.csusb.edu/etd/1058/（請確認是否為你讀的那篇）
- Alagos, S. C. S., Turija, C. J. C., Ramoran, D. F. D., Dadula, C. P., & Banal, R. G. (2025). Development of an efficient schoolchildren drop-off and pick-up system in the Philippines: Enhancing safety and accessibility. *Journal of Engineering, Environment, and Agriculture Research, 4*, 53–65. https://doi.org/10.34002/jeear.v4i1.126
- Cooner, S. A. (2009). Field studies of operations and conflicts in drop-off–pick-up zones. *Transportation Research Record, 2137*, 129–139. https://doi.org/10.3141/2137-14（作者人數請確認）
- Hemalatha, J., Hitaishi, K., Mownika, V. S., Paul, B., Vivek Sharma, S., & Vura, S. (2021). An efficient Android based school bus tracking system. *International Journal of Engineering Applied Sciences and Technology, 6*(1), 383–389.

**問題 1**

- Amato, G., Carrara, F., Falchi, F., Gennaro, C., Meghini, C., & Vairo, C. (2017). Deep learning for decentralized parking lot occupancy detection. *Expert Systems with Applications, 72*, 327–334. https://doi.org/10.1016/j.eswa.2016.10.055
- Appiah, O., Quayson, E., & Opoku, E. (2020). Ultrasonic sensor based traffic information acquisition system; a cheaper alternative for ITS application in developing countries. *Scientific African, 9*, e00487. https://doi.org/10.1016/j.sciaf.2020.e00487
- Bernas, M., Płaczek, B., Korski, W., Loska, P., Smyła, J., & Szymała, P. (2018). A survey and comparison of low-cost sensing technologies for road traffic monitoring. *Sensors, 18*(10), 3243. https://doi.org/10.3390/s18103243
- Čulík, K., Štefancová, V., & Hrudkay, K. (2023). Application of wireless magnetic sensors in the urban environment and their accuracy verification. *Sensors, 23*(12), 5740. https://doi.org/10.3390/s23125740
- Jo, Y., & Jung, I. (2014). Analysis of vehicle detection with WSN-based ultrasonic sensors. *Sensors, 14*(8), 14050–14069. https://doi.org/10.3390/s140814050
- Laroca, R., Zanlorensi, L. A., Gonçalves, G. R., Todt, E., Schwartz, W. R., & Menotti, D. (2021). An efficient and layout-independent automatic license plate recognition system based on the YOLO detector. *IET Intelligent Transport Systems, 15*(4), 483–503. https://doi.org/10.1049/itr2.12030
- Paidi, V., Fleyeh, H., Håkansson, J., & Nyberg, R. G. (2018). Smart parking sensors, technologies and applications for open parking lots: A review. *IET Intelligent Transport Systems, 12*(8), 735–741. https://doi.org/10.1049/iet-its.2017.0406

**問題 2**

- Chien, C.-F., Chen, H.-T., & Lin, C.-Y. (2020). A low-cost on-street parking management system based on Bluetooth beacons. *Sensors, 20*(16), 4559. https://doi.org/10.3390/s20164559
- Google. (n.d.). *Create and monitor geofences*. Android Developers. Retrieved October 3, 2026, from https://developer.android.com/develop/sensors-and-location/location/geofencing
- Hsu, L.-T. (2018). Analysis and modeling GPS NLOS effect in highly urbanized area. *GPS Solutions, 22*(1), 7. https://doi.org/10.1007/s10291-017-0667-9
- Mackey, A., Spachos, P., & Plataniotis, K. N. (2020). Smart parking system based on Bluetooth low energy beacons with particle filtering. *IEEE Systems Journal, 14*(3), 3371–3382. https://doi.org/10.1109/JSYST.2020.2968883
- Merry, K., & Bettinger, P. (2019). Smartphone GPS accuracy study in an urban environment. *PLOS ONE, 14*(7), e0219890. https://doi.org/10.1371/journal.pone.0219890
- Rodriguez Garzon, S., & Deva, B. (2014). Geofencing 2.0: Taking location-based notifications to the next level. In *Proceedings of the 2014 ACM International Joint Conference on Pervasive and Ubiquitous Computing* (pp. 921–932). https://doi.org/10.1145/2632048.2636093
- Shevchenko, Y., & Reips, U.-D. (2024). Geofencing in location-based behavioral research: Methodology, challenges, and implementation. *Behavior Research Methods, 56*(7), 6411–6439. https://doi.org/10.3758/s13428-023-02213-2
- van Diggelen, F., & Enge, P. (2015). *The world's first GPS MOOC and worldwide laboratory using smartphones* [Conference presentation]. Stanford PNT Symposium.

**問題 3**

- Cooner, S. A., Fitzpatrick, K., Wooldridge, M. D., & Ford, G. L. (2004). *Traffic operations and safety at schools: Recommended guidelines* (Report No. FHWA/TX-04/4286-2). Texas Transportation Institute.
- Kearns, B., Davis, J., Geiger, B. C., Coble, D., Klemann, K., Rhoney, M., Baird, C., Carnes, C., Vaughan, C., McCaleb, E., Nicholas, C., Dudley, T., Searcy, S., Findley, D. J., & O'Brien, S. (2021). *School traffic trip generation calculator evaluation and data collection* (Report No. FHWA/NC/2019-27). North Carolina Department of Transportation.
- Liu, H., Deng, H., Li, Y., Zhao, Y., & Li, X. (2022). School surrounding region traffic commuting analysis based on simulation. *International Journal of Environmental Research and Public Health, 19*(11), 6566. https://doi.org/10.3390/ijerph19116566
- Lopez, P. A., Wiessner, E., Behrisch, M., Bieker-Walz, L., Erdmann, J., Flötteröd, Y.-P., Hilbrich, R., Lücken, L., Rummel, J., & Wagner, P. (2018). Microscopic traffic simulation using SUMO. In *2018 21st International Conference on Intelligent Transportation Systems (ITSC)* (pp. 2575–2582). https://doi.org/10.1109/ITSC.2018.8569938
- Rahman, M. H., Abdel-Aty, M., Lee, J., & Rahman, M. S. (2019). Enhancing traffic safety at school zones by operation and engineering countermeasures: A microscopic simulation approach. *Simulation Modelling Practice and Theory, 94*, 334–348. https://doi.org/10.1016/j.simpat.2019.04.001
- Shokry, S., Alrashidi, A., & Elbany, M. (2024). Analyzing the traffic operational performance of school pick-up and drop-off dynamics in Saudi Arabia. *Sustainability, 16*(12), 5154. https://doi.org/10.3390/su16125154
- Tsai, J., Cranford, J., & Lee, J.-J. (2004). Best practices in managing school campus traffic circulation. *Transportation Research Record, 1865*, 41–47. https://doi.org/10.3141/1865-07
- Zhao, Y., Zhou, Z., Pan, Q., & Zhou, T. (2020). G/M/N queuing model-based research on the parking spaces for primary and secondary school. *Discrete Dynamics in Nature and Society, 2020*, 1–7. https://doi.org/10.1155/2020/8870862
- Zheng, H., Yang, Y., Gao, G., Yang, K., & Chen, J. (2023). Traffic stream characteristics analysis for roadway linking to pick-up zone of passenger transportation hub: A fundamental diagram derived from threshold queueing theory. *Applied Sciences, 13*(1), 175. https://doi.org/10.3390/app13010175

**問題 4**

- Ali, S., Elgharabawy, M., Duchaussoy, Q., Mannan, M., & Youssef, A. (2020). Betrayed by the guardian: Security and privacy risks of parental control solutions. In *Annual Computer Security Applications Conference (ACSAC 2020)* (pp. 69–83). https://doi.org/10.1145/3427228.3427287
- Antonakakis, M., April, T., Bailey, M., et al. (2017). Understanding the Mirai botnet. In *26th USENIX Security Symposium* (pp. 1093–1110). USENIX Association.
- de Montjoye, Y.-A., Hidalgo, C. A., Verleysen, M., & Blondel, V. D. (2013). Unique in the crowd: The privacy bounds of human mobility. *Scientific Reports, 3*, 1376. https://doi.org/10.1038/srep01376
- Fagan, M., Megas, K. N., Cuthill, B., Marron, J., & Hoehn, B. (2026). *Foundational cybersecurity activities for IoT product manufacturers* (NIST IR 8259r1). National Institute of Standards and Technology. https://doi.org/10.6028/NIST.IR.8259r1
- Feal, Á., Calciati, P., Vallina-Rodriguez, N., Troncoso, C., & Gorla, A. (2020). Angel or devil? A privacy study of mobile parental control apps. *Proceedings on Privacy Enhancing Technologies, 2020*(2), 314–335. https://doi.org/10.2478/popets-2020-0029
- Primault, V., Boutet, A., Ben Mokhtar, S., & Brunie, L. (2019). The long road to computational location privacy: A survey. *IEEE Communications Surveys & Tutorials, 21*(3), 2772–2793. https://doi.org/10.1109/COMST.2018.2873950

**延伸方向**

- Abdeen, M. A. R., Nemer, I. A., & Sheltami, T. R. (2021). A balanced algorithm for in-city parking allocation: A case study of Al Madinah City. *Sensors, 21*(9), 3148. https://doi.org/10.3390/s21093148
- Huang, F. Y., & Huang, P.-C. (2024). *Enhancing urban traffic safety: An evaluation of Taipei's neighborhood traffic environment improvement program* (arXiv:2401.16752). arXiv. https://arxiv.org/abs/2401.16752
- Lin, J.-J., & Chang, H.-T. (2010). Built environment effects on children's school travel in Taipai: Independence and travel mode. *Urban Studies, 47*(4), 867–889. https://doi.org/10.1177/0042098009351938
- Lin, T., Rivano, H., & Le Mouël, F. (2017). A survey of smart parking solutions. *IEEE Transactions on Intelligent Transportation Systems, 18*(12), 3229–3253. https://doi.org/10.1109/TITS.2017.2685143
- 臺北市政府交通局（2015）。*104 年第 3 次臺北市交通民意調查報告（改善國小學童上下學交通環境調查）*。臺北市政府。
