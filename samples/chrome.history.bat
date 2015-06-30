:: Create History.csv  from Chrome history

@ECHO OFF
COPY "%APPDATA%\..\Local\Google\Chrome\User Data\Default\History" tmp.history.json > NUL

ECHO .headers on > chrome_history
ECHO .mode csv >> chrome_history
ECHO .output History.csv >> chrome_history
ECHO SELECT datetime(last_visit_time/1000000-11644473600, 'unixepoch','localtime')as time,* from urls order by last_visit_time desc; >> chrome_history
ECHO .quit >> chrome_history

sqlite3  tmp.history.json < chrome_history

DEL tmp.history.json
DEL chrome_history
