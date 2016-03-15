rem All voter extract data should be in folder VoterExtract
c:\pypy\pypy voters.py


rem call pandame.bat
csvgrep -c county -m Pal bigfile.csv >rawpal.csv
call pandame.bat rawpal.csv pandapal.csv
csvgrep -c county -m Bro bigfile.csv >rawbro.csv
call pandame.bat rawbro.csv pandabro.csv
csvgrep -c county -m Mrt bigfile.csv >rawmrt.csv
call pandame.bat rawmrt.csv pandamrt.csv
csvgrep -c county -m Stl bigfile.csv >rawstl.csv
call pandame.bat rawstl.csv pandastl.csv

c:\pypy\pypy voterhistory.py