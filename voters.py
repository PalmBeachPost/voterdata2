#!c:/python36/python
# #!/python27/python

import csv
import os
# import titlecase
import sys
import time
# import datetime
from string import capwords

buffersize = 20000            # Default is 8192
counter = 0
starttime = time.clock()
print("2,000 voters are marked with .")

with open('bigfile.csv', 'wb', buffersize) as outputfile:
    c = csv.writer(outputfile)
    c.writerow(["county", "id", "last_name", "name_suffix", "first_name", "middle_name", "res_address_suppress", "res_address_line1", "res_address_line2", "res_city", "res_state", "res_zip", "mail_address_line1", "mail_address_line2", "mail_address_line3", "mail_city", "mail_state", "mail_zip", "mail_country", "gender", "race", "birth_date", "reg_date", "party", "precinct", "precinct_group", "precinct_Split", "precinct_Suffix", "status", "congressional_District", "house_District", "senate_District", "county_district", "school_District", "area_Code", "phone_Number", "dummy", "email"])
    filelist = os.listdir("VoterExtract/")
    for inputfile in filelist:
        with open("VoterExtract/" + inputfile, 'rb', buffersize) as inputcsv:
            rows = csv.reader(inputcsv, delimiter='\t')
            for row in rows:
                for i, item in enumerate(row):
                    # row[i]=titlecase.titlecase(row[i])                    #set up proper casing
                    row[i] = capwords(row[i])
                    row[i] = row[i].replace("\\", "").replace('"', '').replace("  ", " ").replace("  ", " ").strip()

                race = row[20]
                if race == "1":
                    race = "Native"
                elif race == "2":
                    race = "Asian"
                elif race == "3":
                    race = "black"
                elif race == "4":
                    race = "Hisp."
                elif race == "5":
                    race = "white"
                elif race == "6":
                    race = "other"
                elif race == "7":
                    race = "multi"
                else:
                    race = "Unk."
                row[20] = race
#               if len(row[21])>5:
#                   row[21]=datetime.datetime.strptime(row[21], "%m/%d/%Y").strftime("%Y-%m-%d")
#               if len(row[22])>5:
#                   row[22]=datetime.datetime.strptime(row[22], "%m/%d/%Y").strftime("%Y-%m-%d")
                # Above failed with a voter with a reported date of 1897. So let's go the ugly way.
                if row[21].count("/") == 2:
                    mydate = row[21].split("/")
                    row[21] = mydate[2] + "-" + mydate[0] + "-" + mydate[1]
                elif len(row[21]) == 0:
                    row[21] = "0000-00-00"

                if row[22].count("/") == 2:
                    mydate = row[22].split("/")
                    row[22] = mydate[2] + "-" + mydate[0] + "-" + mydate[1]
                elif len(row[22]) == 0:
                    row[22] = "0000-00-00"

                c.writerow(row)
                counter += 1
                if counter % 100000 == 0:
                    sys.stdout.write('!' + '\r\n')
                    endtime = time.clock()
                    print(str("{:,}".format(counter)) + " voters in " + str(endtime-starttime) + " seconds.")
                elif counter % 2000 == 0:
                    sys.stdout.write('.')
                else:
                    pass
print("")
endtime = time.clock()
print("Processed " + str("{:,}".format(counter)) + " records in " + str(endtime-starttime) + " seconds (" + str((endtime-starttime)/60) + " minutes.)")
print(str(counter / (endtime-starttime)) + " records per second.")

# 12,900,000 voters in 3117.28396701 seconds.
