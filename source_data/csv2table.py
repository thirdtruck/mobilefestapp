#!/usr/bin/env python
import sys
import re
import csv

data = sys.stdin.readlines()

c = csv.reader(data, delimiter=",", quotechar='"')

day = ''
location = ''
entries = []

for row in c:
	if not len(row):
		continue
	
	match = re.search('^([A-Z]*).*\((.*)\)', row[0])
	if match and match.group(0):	# We have a time listing
		day = match.group(1)
		location = match.group(2)
		continue
		#print "Day: %s, Location: %s" % (match.group(1), match.group(2))
	line = ', '.join(row).strip()
	print line
	entry = { 'day': day, 'location': location, 'start': row[0], 'end': row[1], 'band': row[2], 'website': row[3] }
	entries.append(entry)

print "# ----------- #"

csvOut = csv.writer(open('output.csv', 'w'), delimiter='|', quotechar='"', quoting=csv.QUOTE_MINIMAL)
rowid = 1
for entry in entries:
	csvOut.writerow([rowid, entry['band'], entry['day'], entry['start']+"-"+entry['end'], entry['location'], '', '', '', entry['start'], entry['end']])
	rowid = rowid+1
