# IndyUDPとTChart

Delphi 11.3  
  
使用しているクラス  
TIdUDPClient  
IdUDPServer  
TThreadedQueue  
TChart  

# 概要
UdpTXは、3チャンネルのサイン波形を送信  
▼  
UdpRXは、受信したデータをTChartに表示  
TChartはスクロール表示  

# 動作
UdpTX  
Timerイベントで1秒に1回データ送信  
3チャンネル  
Int16ビッグエンディアンのバイナリ  
▼  
UdpRX  
IdUDPServer1UDPReadイベントで受信したデータを10分割してQueueに入れる  
▼  
UdpRX  
Timerイベントで100msecに1回Queueからデータを取り出してTChartに表示  
