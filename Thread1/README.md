# Thread1

Delphi 11.3  
  
使用しているクラス  
TThread  
TThreadedQueue  
IFMXCursorService  

# 概要
スレッドはFormCreate時生成、FormDestroy時終了

# 動作
■フォーム生成  
	FormCreate  
	▼  
	スレッド生成  
  
■ボタン押す  
	ボタン押す  
	▼  
	カーソル変更  
	▼  
	スレッドで処理、スレッド終了待ち  
	▼  
	カーソル元に戻す  
  
■ フォーム破棄  
	スレッド停止
