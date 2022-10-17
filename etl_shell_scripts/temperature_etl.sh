#get min, max and avg hourly temp on dashboard every minute

#make shell bash
#! /bin/bas

#extract
#extract reading using get_temp_API
#append readings to temp.log
get_temp_API >> temp.log

#buffer last 1 hour reading
tail -60 temp.log >> temp.log

#transform
#call get_stats.py to get stats
python get_stats.py temp.log temp_stats.csv

#load
#load stats using load_stats_API
load_stats_API temp_stats.csv

#make script executable by changing permission
chmod +x temperature_etl.sh


#job scheduling: done on the cronetab editor: crontab -e
#schedule
1 * * * * temperature_etl.sh

# psql --username=postgres --host=localhost