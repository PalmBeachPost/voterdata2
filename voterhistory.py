#!c:/python36/python
# #!/python27/python

import csv
import os

# import titlecase
from string import capwords
import sys
import time
# import datetime

buffersize = 20000            # Default is 8192
counter = 0
starttime = time.clock()
print("2,000 records are marked with .")

with open('fullhistory.csv', 'w', buffersize) as outputfile:
    c = csv.writer(outputfile)
    c.writerow(["county", "id", "electiondate", "historycode"])
    filelist = os.listdir("VoterHistory/")
    for inputfile in filelist:
        with open("VoterHistory/" + inputfile, 'r', buffersize) as inputcsv:
            rows = csv.reader(inputcsv, delimiter='\t')
            for row in rows:
                row[0] = capwords(row[0])
                if row[2].count("/") == 2:
                    mydate = row[2].split("/")
                    row[2] = mydate[2] + "-" + mydate[0] + "-" + mydate[1]
                elif len(row[2]) == 0:
                    row[2] = "0000-00-00"
                c.writerow(row)
                counter += 1
                if counter % 100000 == 0:
                    sys.stdout.write('!' + '\r\n')
                    endtime = time.clock()
                    print(str("{:,}".format(counter)) + " records in " + str(endtime-starttime) + " seconds.")
                elif counter % 2000 == 0:
                    sys.stdout.write('.')
                else:
                    pass
print("")
endtime = time.clock()
print("Processed " + str("{:,}".format(counter)) + " records in " + str(endtime-starttime) + " seconds (" + str((endtime-starttime)/60) + " minutes.)")
print(str(counter / (endtime-starttime)) + " records per second.")
