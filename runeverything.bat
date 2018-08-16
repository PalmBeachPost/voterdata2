rem All voter extract data should be in folder VoterExtract
rem All voter history data should be in folder VoterHistory

rem start c:\pypy\pypy voterhistory.py
rem start c:\python36\python voterhistory.py
start c:\pypy\pypy3 voterhistory.py

rem c:\pypy\pypy voters.py
rem c:\python36\python voters.py
c:\pypy\pypy3 voters.py

rem call pandame.bat
csvgrep -c county -m Mrt bigfile.csv >rawmrt.csv
csvgrep -c county -m Stl bigfile.csv >rawstl.csv
csvgrep -c county -m Pal bigfile.csv >rawpal.csv
csvgrep -c county -m Bro bigfile.csv >rawbro.csv
call pandame.bat rawmrt.csv pandamrt.csv
call pandame.bat rawstl.csv pandastl.csv
call pandame.bat rawpal.csv pandapal.csv
call pandame.bat rawbro.csv pandabro.csv
