rem All voter extract data should be in folder VoterExtract

start c:\pypy\pypy voterhistory.py

c:\pypy\pypy voters.py

rem call pandame.bat
start csvgrep -c county -m Pal bigfile.csv >rawpal.csv && call pandame.bat rawpal.csv pandapal.csv
start csvgrep -c county -m Bro bigfile.csv >rawbro.csv && call pandame.bat rawbro.csv pandabro.csv
start csvgrep -c county -m Mrt bigfile.csv >rawmrt.csv && call pandame.bat rawmrt.csv pandamrt.csv

csvgrep -c county -m Stl bigfile.csv >rawstl.csv && call pandame.bat rawstl.csv pandastl.csv

