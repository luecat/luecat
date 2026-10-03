# 校園智慧接送系統：文獻整理

> 高中「大數據物聯網」專題用文獻清單與閱讀筆記
> 整理日期：2026-10-03

---

## 目錄

1. [專題概要](#專題概要)
2. [使用說明（請先讀）](#使用說明請先讀)
3. [總覽表](#總覽表)
4. [問題 1：如何偵測車流](#問題-1如何偵測車流)
5. [問題 2：如何避免誤觸發](#問題-2如何避免誤觸發)
6. [問題 3：如何模擬、實測](#問題-3如何模擬實測)
7. [問題 4：如何定位、資安](#問題-4如何定位資安)
8. [延伸方向](#延伸方向)
9. [精讀筆記（三篇全文）](#精讀筆記三篇全文)
10. [對系統設計的建議](#對系統設計的建議)
11. [實地量測方案](#實地量測方案)
12. [研究缺口](#研究缺口)
13. [付費論文的取得方式](#付費論文的取得方式)
14. [延伸搜尋關鍵字](#延伸搜尋關鍵字)
15. [參考文獻（APA 格式）](#參考文獻apa-格式)

---

## 專題概要

**問題**：放學時段家長車輛集中、提早排隊，造成校門口壅塞與人車衝突。

**系統構想**：

| 模組 | 做法 |
|---|---|
| 遠距離 | 家長手機 GPS ＋ 地理圍欄（geofence）。車輛接近學校時通知學生，教室大螢幕顯示 ETA 倒數 |
| 近距離 | 接送區用地感線圈、超音波等感測器確認車輛落位 |
| 多區分流 | 偵測各接送區車流，引導家長到較空的接送區（如側門） |
| 條件式觸發 | 只在放學前後 30 分鐘啟動，只認註冊車輛 |

**已讀過、本清單排除的文獻**：

1. Field Studies of Operations and Conflicts in Drop-Off–Pick-Up Zones（德州）
2. Development of an Efficient Schoolchildren Drop-Off and Pick-Up System in the Philippines（RFID）
3. Geofencing as Applied Within the Field of Temporal and Location Tracking
4. An Efficient Android Based School Bus Tracking System

---

## 使用說明（請先讀）

- **真實性**：每篇的標題、作者、年份、出處都用網路搜尋核對過，確認真實存在。標「未核實」的是我查不到確切資料的欄位，例如 DOI 或卷期。
- **重點來源**：大部分論文的「重點」是根據摘要和檢索結果整理，不是讀全文。**引用數字到報告前，請回原文確認。**
- **例外**：Tsai et al. (2004)、Lin & Chang (2010)、Hsu (2018) 三篇已讀過全文，詳見[精讀筆記](#精讀筆記三篇全文)。
- **難度標示**：
  - 「易」＝高中生讀得懂
  - 「需背景」＝需要統計、程式或工程背景知識
- **取得方式標示**：
  - 「免費」＝開放取用
  - 「免費預印本」＝期刊版付費，但作者有合法的免費版本
  - 「付費」＝需要訂閱或購買
  - 「不確定」＝我無法確認

---

## 總覽表

| 編號 | 論文（第一作者, 年份） | 回答問題 | 難度 | 取得 |
|---|---|---|---|---|
| 1-1 | Bernas 2018：低成本交通感測技術比較 | 1 | 需背景 | 免費 |
| 1-2 | Appiah 2020：超音波車流偵測 | 1 | 易 | 免費 |
| 1-3 | Amato 2017：Raspberry Pi 攝影機偵測車位 | 1 | 需背景 | 免費預印本 |
| 1-4 | Laroca 2021：YOLO 車牌辨識 | 1 | 需背景 | 免費預印本 |
| 2-1 | Shevchenko 2024：地理圍欄準確度實測 | 2 | 易 | 免費 |
| 2-2 | Merry 2019：都市中手機 GPS 誤差 | 2 | 易 | 免費 |
| 2-3 | Hsu 2018：高樓區 GPS 反射誤差 ★精讀 | 2 | 需背景 | 付費 |
| 2-4 | Chien 2020：藍牙 beacon 路邊停車（淡江） | 1, 2 | 易／需背景 | 免費 |
| 3-1 | Tsai 2004：校園接送車流最佳實務 ★精讀 | 3 | 易 | 付費 |
| 3-2 | Liu 2022：VISSIM 模擬學校周邊 | 3 | 需背景 | 免費 |
| 3-3 | Zhao 2020：排隊理論算接送車位 | 3 | 需背景 | 免費 |
| 3-4 | Shokry 2024：用 Google Maps 量化接送壅塞 | 3 | 易 | 免費 |
| 4-1 | de Montjoye 2013：4 個位置點就能認出人 | 4 | 易 | 免費 |
| 4-2 | Primault 2019：位置隱私保護技術綜述 | 4 | 需背景 | 免費預印本 |
| 4-3 | Feal 2020：親子監控 App 隱私問題 | 4 | 易 | 免費 |
| 4-4 | Antonakakis 2017：Mirai IoT 殭屍網路 | 4 | 需背景 | 免費 |
| 延伸 | Lin & Chang 2010：台北學童通學 ★精讀 | 背景 | 需背景 | 付費 |

---

## 問題 1：如何偵測車流

> 低成本車輛偵測：超音波、紅外線、地感線圈、攝影機＋影像辨識、車牌辨識

### 1-1｜A Survey and Comparison of Low-Cost Sensing Technologies for Road Traffic Monitoring

- **作者**：Marcin Bernas, Bartłomiej Płaczek, Wojciech Korski, Piotr Loska, Jarosław Smyła, Piotr Szymała
- **年份／來源**：2018，*Sensors* 18(10): 3243
- **連結**：[DOI 10.3390/s18103243](https://doi.org/10.3390/s18103243)
- **重點**：
  - 比較磁力計、超音波、紅外線、雷達、攝影機等低成本感測器。
  - 比較面向包括準確度、成本、安裝難度。
  - 適合用來做專題的「感測器選型比較表」。
- **回答**：哪種感測器適合小規模場域
- **難度**：需背景（比較表本身讀得懂）｜**取得**：免費

### 1-2｜Ultrasonic sensor based traffic information acquisition system; a cheaper alternative for ITS application in developing countries

- **作者**：Obed Appiah, Ebenezer Quayson, Eric Opoku
- **年份／來源**：2020，*Scientific African*（卷期未核實）
- **連結**：[ScienceDirect](https://www.sciencedirect.com/science/article/pii/S2468227620302258)
- **重點**：
  - 只用一顆超音波感測器，裝在車道上方往下照，就能偵測汽車、機車和行人。
  - 用「佔有率」估計壅塞程度，反應時間 0.20–0.35 秒。
  - 作者指出：橫向安裝容易被行人等非車輛物體干擾。
- **回答**：用超音波確認車輛落位是否可行。**設計啟示**：感測器要往下照，學生從旁邊走過才不會誤判。
- **難度**：易｜**取得**：免費

### 1-3｜Deep Learning for Decentralized Parking Lot Occupancy Detection

- **作者**：Giuseppe Amato, Fabio Carrara, Fabrizio Falchi, Claudio Gennaro, Carlo Meghini, Claudio Vairo
- **年份／來源**：2017，*Expert Systems with Applications* 72: 327–334
- **連結**：
  - DOI 10.1016/j.eswa.2016.10.055
  - [作者預印本 PDF](https://openportal.isti.cnr.it/data/2017/366883/2017_366883.preprint.pdf)
  - [開源程式碼](https://github.com/fabiocarrara/deep-parking)
- **重點**：
  - 在 Raspberry Pi 攝影機上跑小型神經網路（mAlexNet），判斷每個車格有沒有車。
  - 約 15 秒可以判斷 50 個車格。
  - 公開了 CNRPark-EXT 資料集，涵蓋不同季節與光線條件。
- **回答**：攝影機＋影像辨識方案。一台鏡頭可以顧整個接送區，可能比每格裝一顆感測器便宜。
- **難度**：需背景（CNN），但程式碼可以直接拿來試｜**取得**：免費預印本

### 1-4｜An Efficient and Layout-Independent Automatic License Plate Recognition System Based on the YOLO Detector

- **作者**：Rayson Laroca, Luiz A. Zanlorensi, Gabriel R. Gonçalves, Eduardo Todt, William Robson Schwartz, David Menotti
- **年份／來源**：2021，*IET Intelligent Transport Systems* 15(4): 483–503
- **連結**：[arXiv:1909.01754](https://arxiv.org/abs/1909.01754)（期刊版 DOI 未核實）
- **重點**：
  - 用 YOLO 偵測車牌並辨識字元，在 8 個公開資料集上平均辨識率 96.9%。
  - 測試資料包含**台灣車牌（AOLP 資料集）**和**機車車牌（UFPR-ALPR 資料集）**。
  - 不受車牌版式限制。
- **回答**：用車牌辨識做「只認註冊車輛」
- **難度**：需背景｜**取得**：免費預印本

### 問題 1 補充文獻

| 文獻 | 一句話重點 | 取得 |
|---|---|---|
| Paidi, Fleyeh, Håkansson, Nyberg (2018). Smart parking sensors, technologies and applications for open parking lots: a review. *IET ITS* 12(8): 735–741. [連結](https://ietresearch.onlinelibrary.wiley.com/doi/10.1049/iet-its.2017.0406) | 停車感測器綜述，結論是露天停車場較適合用影像辨識 | 不確定 |
| Jo & Jung (2014). Analysis of Vehicle Detection with WSN-Based Ultrasonic Sensors. *Sensors* 14(8): 14050. [連結](https://www.mdpi.com/1424-8220/14/8/14050) | 超音波無線感測器在真實道路的偵測演算法與省電設計（年代稍舊） | 免費 |
| Čulík, Štefancová, Hrudkay (2023). Application of Wireless Magnetic Sensors in the Urban Environment and Their Accuracy Verification. *Sensors* 23(12): 5740. [DOI](https://doi.org/10.3390/s23125740) | 磁性感測器計數和人工計數對照，感測器少算 4.8–9.0% | 免費 |

> **關於地感線圈**：需要切開路面施工，校園自行架設的可行性低。Bernas 的比較表有提到這類取捨。

---

## 問題 2：如何避免誤觸發

> geofence 誤觸發、GPS 誤差、城市峽谷訊號遮蔽、GPS 與近距離感測器融合

### 2-1｜Geofencing in location-based behavioral research: Methodology, challenges, and implementation

- **作者**：Yury Shevchenko, Ulf-Dietrich Reips
- **年份／來源**：2024，*Behavior Research Methods* 56: 6411–6439
- **連結**：[DOI 10.3758/s13428-023-02213-2](https://link.springer.com/article/10.3758/s13428-023-02213-2)
- **重點**（依摘要與檢索結果）：
  - 用手機實測地理圍欄。「進入」通知的精確率約 70%，也就是約三成是誤報；「離開」約 89%。
  - 半徑 100 m 時，「進入」事件的偵測率約 92%。
  - 觸發地點和邊界平均相差：進入約 87 m、離開約 234 m。
  - 圍欄判斷可以在手機端完成，不需要把位置上傳給伺服器，對隱私有利。
- **回答**：誤觸發有多常見、會延遲多少、隱私怎麼設計
- **難度**：易（看結果與討論段）｜**取得**：免費

### 2-2｜Smartphone GPS accuracy study in an urban environment

- **作者**：Krista Merry, Pete Bettinger
- **年份／來源**：2019，*PLOS ONE* 14(7): e0219890
- **連結**：[DOI 10.1371/journal.pone.0219890](https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0219890)
- **重點**：
  - 用 iPhone 6 在都市中量測，分季節、時段、Wi-Fi 開或關比較。
  - 水平誤差平均 7–13 m。
  - 實驗設計簡單，可以照著在校門口量自己的數據。
- **回答**：手機 GPS 誤差有多大
- **難度**：易｜**取得**：免費

### 2-3｜Analysis and modeling GPS NLOS effect in highly urbanized area ★精讀

- **作者**：Li-Ta Hsu（香港理工大學；成大航太系學士、博士）
- **年份／來源**：2018，*GPS Solutions* 22(1): 7
- **連結**：[DOI 10.1007/s10291-017-0667-9](https://doi.org/10.1007/s10291-017-0667-9)
- **重點**：
  - 在香港九龍高樓區實測，低價 GPS 接收器的誤差可達約 50 m（開闊地約 5 m）。
  - 誤差大小主要看衛星仰角，而不是訊號強度。訊號很強，不代表它沒被大樓反射過。
- **回答**：城市峽谷為什麼讓 GPS 亂跳，以及為什麼不能用單一 GPS 點決定觸發
- **難度**：需背景（圖 1 和結論讀得懂）｜**取得**：付費
- 詳見[精讀筆記](#hsu-2018analysis-and-modeling-gps-nlos-effect-in-highly-urbanized-area)

### 2-4｜A Low-Cost On-Street Parking Management System Based on Bluetooth Beacons

- **作者**：Chi-Fang Chien, Hui-Tzu Chen, Chi-Yi Lin（淡江大學資工系）
- **年份／來源**：2020，*Sensors* 20(16): 4559
- **連結**：[DOI 10.3390/s20164559](https://doi.org/10.3390/s20164559)
- **重點**：
  - 架構：車上裝藍牙 beacon 發射器，路邊車格裝接收器，用 Kalman filter 處理訊號強度。
  - 同時判斷「這格有沒有車」和「是哪台車」。
  - 實際運作一年以上，偵測準確率 >98%，節點電池壽命 >5 年。
- **回答**：近距離確認＋只認註冊車輛。這幾乎就是本專題「近距離＋條件式觸發」的現成架構，而且是台灣團隊做的。
- **難度**：架構部分易，Kalman filter 需背景｜**取得**：免費

### 問題 2 補充文獻

| 文獻 | 一句話重點 | 取得 |
|---|---|---|
| Android Developers: [Create and monitor geofences](https://developer.android.com/develop/sensors-and-location/location/geofencing)（官方技術文件，非論文） | 建議半徑至少 100–150 m。觸發延遲通常不到 2 分鐘，手機靜止很久時最長約 6 分鐘。改用 `DWELL`（在範圍內停留一段時間才觸發）可以減少路過造成的誤觸發 | 免費 |
| Mackey, Spachos, Plataniotis (2020). Smart Parking System Based on Bluetooth Low Energy Beacons with Particle Filtering. *IEEE Systems Journal* 14(3). [arXiv](https://arxiv.org/abs/2001.07266) | 每格放一顆 BLE beacon，手機收訊後用粒子濾波判斷停車位置 | 免費預印本 |
| Rodriguez Garzon & Deva (2014). Geofencing 2.0: Taking Location-based Notifications to the Next Level. UbiComp '14. [DOI](https://dl.acm.org/doi/10.1145/2632048.2636093) | 把多個圍欄串成狀態機，例如「先進外圈、再進內圈」才算數，對應「外圈預告、內圈確認」的設計（年代較舊） | 不確定 |
| van Diggelen & Enge (2015). The World's first GPS MOOC and Worldwide Laboratory using Smartphones. ION GNSS+ 2015. [連結](https://www.semanticscholar.org/paper/The-World%E2%80%99s-first-GPS-MOOC-and-Worldwide-Laboratory-Diggelen-Enge/2c70562887bc09908bb75cdae9156512aff4680c) | 全球上千人用手機實測，平均誤差 4.9 m；都市中的誤差和周圍建築高度高度相關 | 不確定 |

---

## 問題 3：如何模擬、實測

> 交通模擬軟體（SUMO、VISSIM）、排隊理論、實地量測方法

### 3-1｜Best Practices in Managing School Campus Traffic Circulation ★精讀

- **作者**：Jeff Tsai, Joel Cranford, Jae-Joon Lee
- **年份／來源**：2004，*Transportation Research Record* 1865: 41–47
- **連結**：[DOI 10.3141/1865-07](https://journals.sagepub.com/doi/10.3141/1865-07)
- **重點**：
  - 實測美國北卡州 20 所小學：超過 60% 的家長在放學鐘響前就到，等待時間是晚到者的 3 倍。
  - 平均總接送時間將近 14 分鐘，但車隊開始移動後只花 4 分 25 秒。
  - 提供完整的「三站量測法」，並用排隊模擬軟體 ARENA 評估改善策略。
- **回答**：專題動機（提早排隊的實證）、實地量測方法、排隊模擬
- **難度**：易｜**取得**：付費｜**注意**：年代較舊（2004）
- 詳見[精讀筆記](#tsai-cranford-lee-2004best-practices-in-managing-school-campus-traffic-circulation)

### 3-2｜School Surrounding Region Traffic Commuting Analysis Based on Simulation

- **作者**：Huasheng Liu, Haoran Deng, Yu Li, Yuqi Zhao, Xiaowen Li
- **年份／來源**：2022，*IJERPH* 19(11): 6566
- **連結**：[DOI 10.3390/ijerph19116566](https://doi.org/10.3390/ijerph19116566)
- **重點**：
  - 用 VISSIM 模擬學校周邊交通。
  - 調整的參數：主線流量、接送停車需求、校門到路口的距離、每台接送車平均停留時間。
  - 觀察這些參數對交通效率和排放的影響。
- **回答**：VISSIM 要設定哪些參數。其中「每台車平均停留時間」正是本系統想縮短的指標。
- **難度**：需背景｜**取得**：免費

### 3-3｜G/M/N Queuing Model-Based Research on the Parking Spaces for Primary and Secondary School

- **作者**：Yi Zhao, Zhen Zhou, Qilong Pan, Tianhua Zhou
- **年份／來源**：2020，*Discrete Dynamics in Nature and Society*，Article 8870862
- **連結**：[DOI 10.1155/2020/8870862](https://doi.org/10.1155/2020/8870862)
- **重點**：
  - 把中小學接送當成 G/M/N 排隊系統，用 MATLAB 模擬，算出合理的接送車位數。
  - 用學校實際交通資料驗證模型。
  - 發現放學接人需要的車位比上學送人多。
- **回答**：排隊理論怎麼套用到接送區、接送格該設幾格
- **難度**：需背景（模擬流程可以改用 Python 做）｜**取得**：免費

### 3-4｜Analyzing the Traffic Operational Performance of School Pick-Up and Drop-Off Dynamics in Saudi Arabia

- **作者**：Sherif Shokry, Ali Alrashidi, Marwa Elbany
- **年份／來源**：2024，*Sustainability* 16(12): 5154
- **連結**：[DOI 10.3390/su16125154](https://doi.org/10.3390/su16125154)
- **重點**：
  - 用 Google Maps API 抓 6 座城市、40 所學校在上下學尖峰的旅行時間。
  - 計算旅行時間指數（TTI）和服務水準（LOS）。
- **回答**：不用買設備也能量化接送造成的壅塞。系統上線前後各量一次，就能做對照。
- **難度**：易（方法部分）｜**取得**：免費

### 問題 3 補充文獻

| 文獻 | 一句話重點 | 取得 |
|---|---|---|
| Kearns et al. (2021). *School Traffic Trip Generation Calculator Evaluation and Data Collection*（NCDOT 報告 2019-27）. [PDF](https://connect.ncdot.gov/projects/research/RNAProjDocs/2019-27%20Final%20Report.pdf) | 美國北卡交通部到學校實地收集接送車輛數與最大排隊長度，有完整的資料收集流程 | 免費 |
| Texas Transportation Institute. *Traffic Operations and Safety at Schools: Recommended Guidelines*（報告 FHWA/TX-04/4286-2）. [PDF](https://static.tti.tamu.edu/tti.tamu.edu/documents/4286-2.pdf) | 有估算放學最大排隊長度的經驗公式（見下方）。可能和已讀過的德州論文出自同一研究計畫，內容會有重疊 | 免費 |
| Lopez et al. (2018). Microscopic Traffic Simulation using SUMO. IEEE ITSC. [PDF](https://elib.dlr.de/127994/1/08569938.pdf) | SUMO 官方建議的引用文獻。**沒找到**用 SUMO 模擬校園接送的論文，用 SUMO 的話需要自己建模 | 免費 |
| Zheng et al. (2023). Traffic Stream Characteristics Analysis for Roadway Linking to Pick-up Zone of Passenger Transportation Hub. *Applied Sciences* 13(1): 175. [DOI](https://doi.org/10.3390/app13010175) | 用排隊理論推導接送區容量，能解釋接送區容量為什麼會突然下降 | 免費 |
| Rahman, Abdel-Aty, Lee, Rahman (2019). Enhancing traffic safety at school zones by operation and engineering countermeasures: A microscopic simulation approach. *Simulation Modelling Practice and Theory* 94: 334–348. | 用微觀模擬評估學區的安全改善措施。第一作者的[碩士論文](https://stars.library.ucf.edu/etd/6560/)可以免費下載 | 付費（碩論免費） |

**TTI 經驗公式**：

> 最大接送排隊車輛數 ≈（該時段放學人數 − 用其他方式回家的人數）× 0.20

---

## 問題 4：如何定位、資安

> 位置隱私、去識別化、IoT 裝置資安、學童資料保護

### 4-1｜Unique in the Crowd: The privacy bounds of human mobility

- **作者**：Yves-Alexandre de Montjoye, César A. Hidalgo, Michel Verleysen, Vincent D. Blondel
- **年份／來源**：2013，*Scientific Reports* 3: 1376
- **連結**：[DOI 10.1038/srep01376](https://www.nature.com/articles/srep01376)
- **重點**：
  - 研究 150 萬人、15 個月的手機位置資料。
  - 只要 4 個「時間＋地點」資料點，就能唯一辨識 95% 的人。
- **回答**：為什麼「拿掉姓名」不等於去識別化，以及為什麼不該保存家長的完整移動軌跡
- **難度**：易｜**取得**：免費｜**注意**：超過 10 年，但是經典

### 4-2｜The Long Road to Computational Location Privacy: A Survey

- **作者**：Vincent Primault, Antoine Boutet, Sonia Ben Mokhtar, Lionel Brunie
- **年份／來源**：2019，*IEEE Communications Surveys & Tutorials* 21(3): 2772–2793
- **連結**：DOI 10.1109/COMST.2018.2873950｜[arXiv:1810.03568](https://arxiv.org/pdf/1810.03568)
- **重點**：
  - 把位置隱私保護技術分成六大類，例如模糊化、加雜訊、k-匿名。
  - 整理衡量「隱私」和「實用性」的指標。
- **回答**：去識別化有哪些技術可以選
- **難度**：需背景｜**取得**：免費預印本

### 4-3｜Angel or Devil? A Privacy Study of Mobile Parental Control Apps

- **作者**：Álvaro Feal, Paolo Calciati, Narseo Vallina-Rodriguez, Carmela Troncoso, Alessandra Gorla
- **年份／來源**：2020，*Proceedings on Privacy Enhancing Technologies* 2020(2): 314–335
- **連結**：[DOI 10.2478/popets-2020-0029](https://petsymposium.org/popets/2020/popets-2020-0029.php)
- **重點**：分析 46 款 Android 親子監控 App，發現：
  - 11% 用明文傳送個資。
  - 34% 沒取得適當同意就蒐集資料。
  - 72% 把資料分享給第三方。
- **回答**：學童相關 App 常犯哪些隱私錯誤，可以當設計時的「反面教材清單」
- **難度**：易（看結果段）｜**取得**：免費

### 4-4｜Understanding the Mirai Botnet

- **作者**：Manos Antonakakis 等
- **年份／來源**：2017，26th USENIX Security Symposium，pp. 1093–1110
- **連結**：[論文頁](https://research.google/pubs/understanding-the-mirai-botnet/)
- **重點**：
  - 分析 2016 年 Mirai 病毒如何利用 IoT 裝置的弱點（主要是預設帳號密碼）大量入侵。
  - 最多時約 60 萬台裝置受感染。
- **回答**：Raspberry Pi、感測器這類 IoT 裝置最基本的資安風險
- **難度**：需背景（前言和結論讀得懂）｜**取得**：免費

### 問題 4 補充文獻

| 文獻 | 一句話重點 | 取得 |
|---|---|---|
| Ali, Elgharabawy, Duchaussoy, Mannan, Youssef (2020). Betrayed by the Guardian: Security and Privacy Risks of Parental Control Solutions. ACSAC 2020. [arXiv](https://arxiv.org/abs/2012.06502) | 分析親子監控的硬體和 75 款 App，是該會議的傑出論文 | 免費預印本 |
| NIST (2020). *Foundational Cybersecurity Activities for IoT Device Manufacturers*（NISTIR 8259）. [PDF](https://nvlpubs.nist.gov/nistpubs/ir/2020/NIST.IR.8259.pdf) | 美國政府的 IoT 資安檢核文件，2026 年 4 月已出修訂版（8259r1） | 免費 |

---

## 延伸方向

### 多停車區動態分流、停車引導

| 文獻 | 一句話重點 | 取得 |
|---|---|---|
| Lin, Rivano, Le Mouël (2017). A Survey of Smart Parking Solutions. *IEEE T-ITS* 18(12): 3229–3253. [HAL](https://hal.inria.fr/hal-01501556) | 智慧停車綜述，分成資訊蒐集、系統部署、服務發布三大塊 | 免費預印本 |
| Abdeen, Nemer, Sheltami (2021). A Balanced Algorithm for In-City Parking Allocation: A Case Study of Al Madinah City. *Sensors* 21: 3148. [連結](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8125470/) | 在多個停車場之間平衡分配車輛的演算法，可對應「正門滿了就引導去側門」（全文細節未核對） | 免費 |
| Tsai et al. (2004)，見 3-1 | 有學校在主車道滿了以後，把車導進備用停車區當第二條車道，再由老師分批放行。這是「多區分流」的人工版本 | 付費 |

### 叫號、通知系統的實測效益

- **沒找到同儕審查的實測論文。**
- 市面上接送 App（Carline、Beeline 等）宣稱能縮短 30–75% 時間，但都是廠商自己說的，不能當證據。
- 間接證據：Tsai et al. (2004) 描述的「老師用名牌＋對講機＋擴音器叫號」流程，是本系統可以對照的人工作法。
- 這是本專題可以填補的[研究缺口](#研究缺口)。

### 台灣學校接送與周邊交通

| 文獻 | 重點 | 取得 |
|---|---|---|
| 臺北市政府交通局（2015）〈104 年第 3 次臺北市交通民意調查報告（改善國小學童上下學交通環境調查）〉[PDF](https://www-ws.gov.taipei/Download.ashx?u=LzAwMS9VcGxvYWQvMzkwL3JlbGZpbGUvNTI5MDYvODE4MDgxNC9mMmM1YThhNS03Y2FmLTQ2YjAtYmUzOS0wYTMwMzZiOWU4ZDcucGRm&n=MTA0LTMucGRm&icon=..pdf) | 見下方說明 | 免費 |
| Lin & Chang (2010). Built Environment Effects on Children's School Travel in Taipai: Independence and Travel Mode. *Urban Studies* 47(4): 867–889. [DOI](https://journals.sagepub.com/doi/10.1177/0042098009351938) ★精讀 | 台北文山區三所國小，周邊環境如何影響學童上學方式 | 付費 |
| Huang & Huang (2024). Enhancing Urban Traffic Safety: An Evaluation of Taipei's Neighborhood Traffic Environment Improvement Program. [arXiv:2401.16752](https://arxiv.org/abs/2401.16752) | 台北巷弄交通改善計畫（綠色人行道、紅黃線調整、標字）讓白天事故減少 5%、受傷減少 8%。這是預印本，尚未經期刊審查 | 免費 |
| Chien et al. (2020)，見 2-4 | 淡江大學的藍牙 beacon 停車系統 | 免費 |
| 工商時報（2025-03-24）〈新北國中小僅 35% 設臨停區〉[連結](https://www.ctee.com.tw/news/20250324701164-431401)（新聞，非論文） | 新北市 89.70% 學校設有家長接送區，但只有約 34.4% 設有路邊臨停格 | 免費 |

**臺北市 2015 年民調重點**（2015 年 10–11 月調查，1,156 份有效樣本）：

- 65.0% 上下學都接送，22.8% 只送不接，12.2% 只接不送。
- 接送者：母親 52.2%、父親 29.5%、祖父 7.9%、祖母 8.4%。
- **放學接送運具：機車 37.4%、汽車 25.7%、步行 22.6%**（上學則是機車 40.7%、汽車 26.3%）。
- 接送原因：安全顧慮 57.4%、孩子太小 48.9%、家長方便 38.3%。
- **對專題的提醒**：台灣接送以機車最多。系統如果只偵測汽車，會漏掉最大的一群接送者。

> **台灣碩博士論文**：本次無法直接查詢。建議到「[臺灣博碩士論文知識加值系統](https://ndltd.ncl.edu.tw)」用[延伸搜尋關鍵字](#延伸搜尋關鍵字)自己查。

---

## 精讀筆記（三篇全文）

### Tsai, Cranford, Lee (2004)：Best Practices in Managing School Campus Traffic Circulation

**研究對象**：美國北卡州 11 個郡的 20 所小學。每校 236–959 名學生，搭校車比例 19–72%。

#### 量測方法（可以直接照做）

**事前準備**：
- 確認車隊起點、終點與車道數。
- 沿車道每隔固定距離放交通錐，用來讀排隊長度。
- 把碼錶和攝影機對時，從高處或屋頂錄影。

**4 人一組的分工**：

| 位置 | 記錄內容 |
|---|---|
| 站 1：車隊入口 | 每台車的車牌和加入隊伍的時間 **T1**；排隊長度 |
| 站 2：上車區 | 車牌、進入上車區時間 **T2**、離開時間 **T3** |
| 站 3：出口 | 車牌和回到外面馬路的時間 |
| 第 4 人 | 穿越車道的行人數、繞過車隊的違規車輛、步行與騎車學生數 |

**另外記錄**：上車區長度、上車格數量與標線、配對學生的方法、人力配置、人行道與斑馬線。

#### 計算指標

| 指標 | 公式 | 實測結果 |
|---|---|---|
| 上車停留時間 | Tb = T3 − T2 | 平均 63 秒 |
| 總接送時間 | Tc = T3 − T1 | 平均將近 14 分鐘 |
| 動態接送時間 | Td = T3 − Tm（Tm＝車隊開始移動的時間，只用在鐘響前就到的車） | 平均 4 分 25 秒 |

> **注意**：原文寫上車停留時間「各校從 33 秒到 90 多**分鐘**」。對照平均值 63 秒，看起來是筆誤，引用時建議避開這個數字。

#### 範例學校

- 79 台車中有 46 台在鐘響前就到，有些提早 30 分鐘以上。
- 3:15 放學，3:17 第一台車才離開上車區。
- 3:10–3:24 之間，車隊溢出到外面的馬路上。

#### 人工叫號流程（本系統要自動化的對象）

- 家長把學生名牌或號碼放在儀表板上。
- 一位老師走到車隊下游看名牌，用對講機依序回報。
- 另一位老師在上車區用擴音器叫學生，有多個上車格時還要分派位置。
- 原文提到：學校很在意「只讓授權的人接走孩子」。

#### 其他觀察

- **協助上車**：超過一半是休旅車，小學生開關車門很慢。有學校安排老師或高年級生協助。
- **管制**：有些學校在接送時段禁止左轉出校、禁止在其他地方停車，避免家長繞過車隊造成危險。
- **雙排車道與備用停車區**：主車道滿了以後，把車導進備用停車區當第二條車道，再由老師分批放行。

#### 模擬結果

- 用排隊模擬軟體 ARENA，並以各校的平均與最大排隊長度校正模型。
- 影響最大排隊長度的因素依序是：**車輛需求量** > 到達速率 > 服務速率 > 車道長度。
- 兩個改善策略：
  - **分年級錯開放學**：例如低年級提早 30 分鐘放學。
  - **管制到達時間**：概念類似號誌連鎖，規定車輛何時才可以進校。
- 作者也提醒：一家有多個孩子時，錯開放學容易造成混亂；管制到達時間需要事先溝通，否則家長會改到外面馬路排隊。
- 迴歸模型的 adjusted R² = 0.79，但單位是英尺、輛/小時，用的是北卡學校的資料，**不能直接套用**。

#### 作者建議

- 每台車上下學生不超過 10 秒，從進入到離開整個過程不超過 45 秒。
- 上車格最多 5 格，頭尾格約 20 英尺（約 6 m），中間格約 30 英尺（約 9 m），並清楚標示。
- 至少 2 位老師負責配對學生。
- 鐘響前 5–10 分鐘，先收集前約 20 台車的學生名單，讓學生依序排好。
- 學生步行比例高的學校，讓步行學生先放學。
- 車隊溢出到外面馬路時，考慮開雙排車道。

#### 對專題的用法

1. **動機段**：直接引用「60%、3 倍、14 分鐘 vs 4 分 25 秒」這組數字。
2. **系統定位**：可以寫成「把名牌＋對講機＋擴音器流程自動化」。ETA 通知就是「鐘響前先收集前 20 台名單」的電子版。
3. **實測**：上線前用三站法人工量。系統上線後，geofence 和接送格感測器本身就能自動記錄 T1、T2、T3。
4. **條件式觸發（放學前後 30 分鐘）**：這就是作者說的「管制到達時間」，有文獻支持。但要設計對策，避免家長改到外面路邊等。
5. **限制**：2004 年的美國資料，學校有校內專用車道，和台灣多數學校在路邊接送不同。

### Lin & Chang (2010)：Built Environment Effects on Children's School Travel in Taipai

> 原文標題的城市名就拼成「Taipai」，引用時照原文寫。

**研究對象**：

- 台北文山區三所國小：指南（山區，無接送區）、景美（舊市區，有接送區與志工）、興華（新社區，有接送區與志工）。
- 2006 年底發問卷：457 人中 419 人回覆，有效問卷 330 份（有效率 78.89%）。
- 方法：巢式羅吉特模型（nested logit），把「是否大人陪同」和「交通方式」分兩層分析。

#### 重點數據

- 約 35–40% 的學生自己上下學，約 40% 走路，36–45% 由家長騎機車或開車接送，公車約 14–16%。
- 陪同接送的媽媽比爸爸多。放學回家用私人機動車的比例比上學低。
- 三校差異很大：
  - 景美國小：約 68–69% 走路。
  - 指南國小：走路只有約 1%，汽車 37–48%，公車 31–41%。
- 從圖 2 目測（不是精確數字）：放學回家約 20% 坐汽車、17% 坐機車、6% 坐安親班車。

#### 上學和放學的情況不一樣

- 早上約 7:30 到校，家長可以順路送去上班，所以上學的距離因素不顯著。
- 下午約 4 點放學，和家長下班時間對不上。很多孩子先去安親班或補習班，安親班常開到晚上 9 點。
- 因此「放學後活動」對回家的交通方式影響很大。

#### 其他發現

- 事故數、犯罪數這類客觀安全指標大多不顯著。作者推測家長「感受到的安全」和官方統計不一定一致，建議未來研究納入**主觀安全指標**。
- 家中有兩個以上學齡孩子時，上學較常開車接送。
- 作者**假設**「學校有接送區，會讓更多家長開車」（引用 Su & Chen 1999）。但三校中兩校都有接送區和志工、一校都沒有，模型沒辦法單獨檢驗這一點，所以**沒有被證實**。

#### 對專題的用法

1. **安親班車**：一台車會接好幾個學生。系統的資料結構要支援「一台車對多個學生」，也要讓安親班業者可以註冊。
2. **下午接送人常常不固定**：臺北市民調中祖父母合計約 16%。一個學生要能綁定多台車、多位接送人。
3. **副作用討論**：接送變方便後，可能有更多家長改成開車。可以寫在報告的「限制」段，並搭配 Tsai 的建議「讓步行學生先放學」。
4. **限制**：資料是 2006 年的，而且只有三所學校。

### Hsu (2018)：Analysis and modeling GPS NLOS effect in highly urbanized area

**研究對象**：在香港九龍高樓區用低價 GPS 接收器（u-blox M8）實測，並用 3D 建築模型判斷每個衛星訊號是否被大樓擋住。

#### 重點數據

- 圖 1：開闊地靜態測試誤差約 5 m；高樓區移動測試（接收器裝在無人機上）時，誤差可達約 **50 m**。
- 24 小時共收集 128,054 筆「被反射的衛星訊號」（NLOS，非直視訊號）：
  - 超過 70% 造成的「虛擬距離（pseudorange）誤差」在 50 m 以內。這是衛星到接收器的距離量測誤差，不是最終的定位誤差。
  - 誤差分布是**長尾**，不是常態分布，所以偶爾會出現很大的跳點。
- **關鍵發現**：誤差大小主要看衛星仰角（仰角越低誤差越大），而不是訊號強度。訊號很強，不代表它沒被大樓反射過。
- 作者提出的誤差模型：γ = α·sec θ·(1 + cos 2θ)
  - α＝接收器到反射牆面的距離
  - θ＝衛星仰角
- 定位誤差比較：

| 方法 | 平均誤差 |
|---|---|
| 不做修正 | 8.67 m |
| 用作者提出的模型 | 6.27 m |
| 用 3D 建築模型模擬（光線追蹤） | 5.05 m |

#### 對專題的用法

1. **半徑設定**：高樓區可能出現 50 m 的誤差，支持「外圈至少 150 m 只發預告，到位確認交給近距離感測器」的設計。
2. **避免誤觸發**：誤差是長尾分布，所以不要用單一一個 GPS 點決定觸發。改用「連續 N 個點都在範圍內」、「停留 X 秒」（Android 的 `DWELL`）或取中位數。
3. **手機的精度值**：手機回報的 accuracy 數值可能過度樂觀。這是根據「訊號強不代表沒被反射」做的**推論**，論文本身沒有測手機。
4. **自己做小實驗**：見[實地量測方案](#實地量測方案)的 B 部分。
5. **限制**：論文用的是專用接收器。手機有 Wi-Fi 和基地台輔助，數值會不一樣，可以和 Merry & Bettinger 測到的 7–13 m 對照。

---

## 對系統設計的建議

| 項目 | 原構想 | 建議修正 | 依據 |
|---|---|---|---|
| 註冊車輛 | 一個學生對一台車 | 一個學生可綁多台車、多位接送人；一台車可接多個學生（安親班） | Lin & Chang 2010；臺北市民調 2015 |
| 車種 | 以汽車為主 | 一定要納入機車；感測器和車牌辨識都要測機車 | 臺北市民調 2015；Laroca 2021 |
| 遠距觸發 | 進入 geofence 就觸發 | 外圈 ≥150 m 只發預告；用連續點或停留時間確認，不用單一 GPS 點 | Shevchenko 2024；Hsu 2018；Android 文件 |
| 到位確認 | 地感線圈、超音波 | 藍牙 beacon（可同時辨識車輛）或往下照的超音波；地感線圈施工難度高 | Chien 2020；Appiah 2020；Bernas 2018 |
| 時段限制 | 放學前後 30 分鐘 | 有文獻支持（管制到達時間）；另外要想辦法避免家長改到外面路邊等 | Tsai 2004 |
| 多區分流 | 引導到較空的接送區 | 可參考「備用停車區＋分批放行」的人工作法，再加上平衡分配演算法 | Tsai 2004；Abdeen 2021 |
| 隱私 | — | 在家長手機上判斷是否進入圍欄，只上傳「已進入」事件和註冊編號；不保存移動軌跡；每日清除 | Shevchenko 2024；de Montjoye 2013；Feal 2020 |
| 資安 | — | 感測器和 Raspberry Pi 改掉預設密碼、關閉不必要的對外連接埠、傳輸加密 | Antonakakis 2017；NIST IR 8259 |
| 成效評估 | — | 照 Tsai 三站法量 T1、T2、T3；上線後由系統自動記錄，做前後對照 | Tsai 2004；Kearns 2021 |
| 報告限制段 | — | 加上「接送變方便，可能讓更多家長選擇開車」 | Lin & Chang 2010 |

---

## 實地量測方案

### A. 接送流程量測（改編自 Tsai et al. 2004）

**人力**：4 人。站 1 在接送區入口、站 2 在上車點、站 3 在離開點，第 4 人記錄違規與行人。

**事前準備**：
- 所有人的手機時鐘對時。
- 沿等候路段每 5 m 做一個記號（粉筆或交通錐），用來讀排隊長度。
- 取得學校同意後，從高處錄影備查。
- **車牌只記末 3 碼或改用編號，報告中不得出現完整車牌。**

**紀錄表範例**：

| 編號 | 車種（汽車／機車／安親班車） | T1 加入排隊 | T2 到達上車點 | T3 離開上車點 | 接走學生數 | 備註（並排、違停、繞道） |
|---|---|---|---|---|---|---|
| 001 | 機車 | 15:52:10 | 16:01:30 | 16:01:55 | 1 | |
| 002 | 汽車 | 15:53:40 | 16:02:05 | 16:03:10 | 2 | 並排 |

**計算指標**：
- 上車停留時間 = T3 − T2
- 總接送時間 = T3 − T1
- 提早到達時間 = 放學鐘響時間 − T1（正值代表提早到）
- 提早到達比例 = 鐘響前就到的車數 ÷ 總車數
- 最大排隊長度（公尺或車數）、溢出到馬路的時間區間

**比較基準**：
- Tsai et al. (2004)：提早到達比例約 60%；總接送時間約 14 分鐘；動態接送時間約 4 分 25 秒。
- TTI 經驗公式：最大排隊車數 ≈（放學人數 − 其他方式回家人數）× 0.20。

### B. 手機 GPS 誤差實驗（參考 Merry & Bettinger 2019、Hsu 2018）

1. 在校門口選兩個點：一個靠高樓或騎樓，一個在開闊處。
2. 用 Google Maps 衛星圖或內政部國土測繪中心圖資，取得兩點的「真實座標」。
3. 每個點放手機記錄 10 分鐘 GPS（可用 GPS Logger 類 App），同時記下手機回報的 accuracy 值。
4. 算出每筆紀錄和真實座標的距離，畫散佈圖和直方圖。
5. 比較兩個點的平均誤差和最大誤差，再比較「實際誤差」和「手機回報的 accuracy」差多少。
6. 用結果決定 geofence 半徑和「連續幾個點才觸發」。

### C. 感測器準確度驗證（參考 Čulík et al. 2023）

1. 感測器運作的同時，用錄影或人工記錄真實的車輛進出。
2. 計算：
   - 漏報率 = 有車但感測器沒偵測到的次數 ÷ 實際車輛數
   - 誤報率 = 沒車但感測器說有車的次數 ÷ 感測器報告次數
3. 特別測試：機車、學生從旁邊走過、下雨天。

### D. 低成本壅塞量測（參考 Shokry et al. 2024）

- 用 Google Maps 查詢（或 Directions API）記錄校門前路段在放學尖峰與平時的旅行時間。
- 旅行時間指數（TTI）= 尖峰旅行時間 ÷ 平時旅行時間。
- 系統上線前後各量 2 週，做對照。

---

## 研究缺口

本專題可能做出原創貢獻的地方：

1. **叫號、通知系統的實測效益**：沒找到同儕審查的前後對照研究，市面上的效益數字都是廠商自述。
2. **台灣學校的接送排隊實測資料**：沒找到量測台灣學校排隊長度或接送時間的公開研究。台灣以機車接送為主，國外的數據不一定適用。
3. **用 SUMO 模擬校園接送**：沒找到相關論文，國外研究多用 VISSIM 或 ARENA。
4. **GPS geofence ＋ 近距離感測的兩段式確認**：各自都有研究，但沒找到套用在學校接送的整合實測。

---

## 付費論文的取得方式

建議依序嘗試：

1. **Google Scholar**：搜標題，點右側的 PDF 連結或「所有 X 個版本」，常常能找到作者自己放的版本。也可以裝 **Unpaywall** 瀏覽器外掛，它會自動找合法的免費版。
2. **arXiv、作者個人網頁、機構典藏**：例如 HAL、DLR elib、各大學的典藏庫。
3. **直接寫信給作者**：大部分研究者都很樂意寄 PDF 給學生。信件範例：

   > Dear Dr. [Name],
   > I am a high school student in Taiwan working on a project about school pick-up congestion. Could you kindly share a copy of your paper "[Title]" ([Journal, Year])? Thank you very much.

4. **圖書館**：
   - 國家圖書館辦閱覽證後，館內可以用部分外文資料庫。
   - 很多大學圖書館也開放校外人士申請閱覽證、在館內使用資料庫。各館規定不同，出發前先上網查。
5. **問學校老師**：有些老師因為在職進修，有大學圖書館帳號。

> **著作權提醒**：付費論文的 PDF 請只在組內自用，不要上傳到公開的 GitHub、雲端或社群。

---

## 延伸搜尋關鍵字

**英文**：

- `school drop-off pick-up` / `school dismissal carpool queue` / `parent pick-up queue length`
- `vehicle detection ultrasonic sensor` / `parking occupancy detection low-cost` / `license plate recognition motorcycle`
- `geofencing false positive` / `geofence accuracy smartphone` / `GNSS NLOS urban canyon smartphone`
- `BLE beacon vehicle identification` / `GPS sensor fusion arrival detection`
- `queueing simulation SUMO parking area` / `VISSIM school zone` / `G/M/N queue parking`
- `location privacy IoT` / `trajectory anonymization` / `children data protection app`
- `parking guidance system allocation algorithm` / `multi-lot parking balancing`

**中文**（給臺灣博碩士論文系統用）：

- 家長接送區、學童接送、上下學接送、校園周邊交通、通學環境
- 停車導引、停車位偵測、車牌辨識 機車
- 地理圍欄、定位誤差、藍牙信標 停車
- 排隊理論 停車場、交通模擬 學校

---

## 參考文獻（APA 格式）

> 標「未核實」的欄位請在定稿前自行確認。

**問題 1**

- Amato, G., Carrara, F., Falchi, F., Gennaro, C., Meghini, C., & Vairo, C. (2017). Deep learning for decentralized parking lot occupancy detection. *Expert Systems with Applications, 72*, 327–334. https://doi.org/10.1016/j.eswa.2016.10.055
- Appiah, O., Quayson, E., & Opoku, E. (2020). Ultrasonic sensor based traffic information acquisition system; a cheaper alternative for ITS application in developing countries. *Scientific African*.（卷期未核實）https://www.sciencedirect.com/science/article/pii/S2468227620302258
- Bernas, M., Płaczek, B., Korski, W., Loska, P., Smyła, J., & Szymała, P. (2018). A survey and comparison of low-cost sensing technologies for road traffic monitoring. *Sensors, 18*(10), 3243. https://doi.org/10.3390/s18103243
- Čulík, K., Štefancová, V., & Hrudkay, K. (2023). Application of wireless magnetic sensors in the urban environment and their accuracy verification. *Sensors, 23*(12), 5740. https://doi.org/10.3390/s23125740
- Jo, Y., & Jung, I. (2014). Analysis of vehicle detection with WSN-based ultrasonic sensors. *Sensors, 14*(8), 14050. https://www.mdpi.com/1424-8220/14/8/14050
- Laroca, R., Zanlorensi, L. A., Gonçalves, G. R., Todt, E., Schwartz, W. R., & Menotti, D. (2021). An efficient and layout-independent automatic license plate recognition system based on the YOLO detector. *IET Intelligent Transport Systems, 15*(4), 483–503.（DOI 未核實；預印本 arXiv:1909.01754）
- Paidi, V., Fleyeh, H., Håkansson, J., & Nyberg, R. G. (2018). Smart parking sensors, technologies and applications for open parking lots: A review. *IET Intelligent Transport Systems, 12*(8), 735–741. https://doi.org/10.1049/iet-its.2017.0406

**問題 2**

- Chien, C.-F., Chen, H.-T., & Lin, C.-Y. (2020). A low-cost on-street parking management system based on Bluetooth beacons. *Sensors, 20*(16), 4559. https://doi.org/10.3390/s20164559
- Google. (n.d.). *Create and monitor geofences*. Android Developers. https://developer.android.com/develop/sensors-and-location/location/geofencing
- Hsu, L.-T. (2018). Analysis and modeling GPS NLOS effect in highly urbanized area. *GPS Solutions, 22*(1), 7. https://doi.org/10.1007/s10291-017-0667-9
- Mackey, A., Spachos, P., & Plataniotis, K. N. (2020). Smart parking system based on Bluetooth low energy beacons with particle filtering. *IEEE Systems Journal, 14*(3). https://doi.org/10.1109/JSYST.2020.2968883
- Merry, K., & Bettinger, P. (2019). Smartphone GPS accuracy study in an urban environment. *PLOS ONE, 14*(7), e0219890. https://doi.org/10.1371/journal.pone.0219890
- Rodriguez Garzon, S., & Deva, B. (2014). Geofencing 2.0: Taking location-based notifications to the next level. In *Proceedings of the 2014 ACM International Joint Conference on Pervasive and Ubiquitous Computing (UbiComp '14)*. https://doi.org/10.1145/2632048.2636093
- Shevchenko, Y., & Reips, U.-D. (2024). Geofencing in location-based behavioral research: Methodology, challenges, and implementation. *Behavior Research Methods, 56*, 6411–6439. https://doi.org/10.3758/s13428-023-02213-2
- van Diggelen, F., & Enge, P. (2015). The world's first GPS MOOC and worldwide laboratory using smartphones. In *Proceedings of ION GNSS+ 2015*.（頁碼未核實）

**問題 3**

- Kearns, B., Davis, J., Geiger, B. C., Coble, D., Klemann, K., Rhoney, M., Baird, C., Carnes, C., Vaughan, C., McCaleb, E., Nicholas, C., Dudley, T., Searcy, S., Findley, D. J., & O'Brien, S. (2021). *School traffic trip generation calculator evaluation and data collection* (Report No. 2019-27). North Carolina Department of Transportation.
- Liu, H., Deng, H., Li, Y., Zhao, Y., & Li, X. (2022). School surrounding region traffic commuting analysis based on simulation. *International Journal of Environmental Research and Public Health, 19*(11), 6566. https://doi.org/10.3390/ijerph19116566
- Lopez, P. A., Behrisch, M., Bieker-Walz, L., Erdmann, J., Flötteröd, Y.-P., Hilbrich, R., Lücken, L., Rummel, J., Wagner, P., & Wießner, E. (2018). Microscopic traffic simulation using SUMO. In *2018 IEEE Intelligent Transportation Systems Conference (ITSC)* (pp. 2575–2582). https://doi.org/10.1109/ITSC.2018.8569938
- Rahman, M. H., Abdel-Aty, M., Lee, J., & Rahman, M. S. (2019). Enhancing traffic safety at school zones by operation and engineering countermeasures: A microscopic simulation approach. *Simulation Modelling Practice and Theory, 94*, 334–348.
- Shokry, S., Alrashidi, A., & Elbany, M. (2024). Analyzing the traffic operational performance of school pick-up and drop-off dynamics in Saudi Arabia. *Sustainability, 16*(12), 5154. https://doi.org/10.3390/su16125154
- Texas Transportation Institute. (2004). *Traffic operations and safety at schools: Recommended guidelines* (Report No. FHWA/TX-04/4286-2).（作者未列）https://static.tti.tamu.edu/tti.tamu.edu/documents/4286-2.pdf
- Tsai, J., Cranford, J., & Lee, J.-J. (2004). Best practices in managing school campus traffic circulation. *Transportation Research Record, 1865*, 41–47. https://doi.org/10.3141/1865-07
- Zhao, Y., Zhou, Z., Pan, Q., & Zhou, T. (2020). G/M/N queuing model-based research on the parking spaces for primary and secondary school. *Discrete Dynamics in Nature and Society, 2020*, 8870862. https://doi.org/10.1155/2020/8870862
- Zheng, H., Yang, Y., Gao, G., Yang, K., & Chen, J. (2023). Traffic stream characteristics analysis for roadway linking to pick-up zone of passenger transportation hub: A fundamental diagram derived from threshold queueing theory. *Applied Sciences, 13*(1), 175. https://doi.org/10.3390/app13010175

**問題 4**

- Ali, S., Elgharabawy, M., Duchaussoy, Q., Mannan, M., & Youssef, A. (2020). Betrayed by the guardian: Security and privacy risks of parental control solutions. In *Annual Computer Security Applications Conference (ACSAC 2020)*. https://doi.org/10.1145/3427228.3427287
- Antonakakis, M., April, T., Bailey, M., et al. (2017). Understanding the Mirai botnet. In *26th USENIX Security Symposium* (pp. 1093–1110).
- de Montjoye, Y.-A., Hidalgo, C. A., Verleysen, M., & Blondel, V. D. (2013). Unique in the crowd: The privacy bounds of human mobility. *Scientific Reports, 3*, 1376. https://doi.org/10.1038/srep01376
- Feal, Á., Calciati, P., Vallina-Rodriguez, N., Troncoso, C., & Gorla, A. (2020). Angel or devil? A privacy study of mobile parental control apps. *Proceedings on Privacy Enhancing Technologies, 2020*(2), 314–335. https://doi.org/10.2478/popets-2020-0029
- National Institute of Standards and Technology. (2020). *Foundational cybersecurity activities for IoT device manufacturers* (NISTIR 8259). https://nvlpubs.nist.gov/nistpubs/ir/2020/NIST.IR.8259.pdf
- Primault, V., Boutet, A., Ben Mokhtar, S., & Brunie, L. (2019). The long road to computational location privacy: A survey. *IEEE Communications Surveys & Tutorials, 21*(3), 2772–2793. https://doi.org/10.1109/COMST.2018.2873950

**延伸方向**

- Abdeen, M. A. R., Nemer, I. A., & Sheltami, T. R. (2021). A balanced algorithm for in-city parking allocation: A case study of Al Madinah City. *Sensors, 21*, 3148.
- Huang, F. Y., & Huang, P.-C. (2024). *Enhancing urban traffic safety: An evaluation of Taipei's neighborhood traffic environment improvement program* (arXiv:2401.16752). arXiv.
- Lin, J.-J., & Chang, H.-T. (2010). Built environment effects on children's school travel in Taipai: Independence and travel mode. *Urban Studies, 47*(4), 867–889. https://doi.org/10.1177/0042098009351938
- Lin, T., Rivano, H., & Le Mouël, F. (2017). A survey of smart parking solutions. *IEEE Transactions on Intelligent Transportation Systems, 18*(12), 3229–3253.
- 臺北市政府交通局（2015）。*104 年第 3 次臺北市交通民意調查報告（改善國小學童上下學交通環境調查）*。臺北市政府。
