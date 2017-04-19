csvgrep -c county -m Mrt bigfile.csv >rawmrt.csv
csvgrep -c county -m Stl bigfile.csv >rawstl.csv
csvgrep -c county -m Pal bigfile.csv >rawpal.csv
csvgrep -c county -m Bro bigfile.csv >rawbro.csv
start call pandame.bat rawmrt.csv pandamrt.csv
start call pandame.bat rawstl.csv pandastl.csv
start call pandame.bat rawpal.csv pandapal.csv
start call pandame.bat rawbro.csv pandabro.csv
