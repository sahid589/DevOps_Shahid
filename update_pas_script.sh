#!/usr/bin/env bash
app_id="105e6ec7-6a56-448a-a0aa-ee4a5607f5f0"
read -r -d '' QUERY <<-'EOF'
requests
| where name contains "Contact/Post"
| project timestamp, url, customDimensions
EOF

for day in 06; do
for hour in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23; do
m1=15
m2=30
m3=45
m4=60
az monitor app-insights query \
    --analytics-query "$QUERY" \
    --apps "$app_id" \
    --start-time 2023-08-$day $hour:00:00 +01:00 \
    --end-time 2023-08-$day $hour:15:00 +01:00 \
    --output json \
    --verbose > pas-coop-no-contact-logs_202308$day$hour$m1.json
	
az monitor app-insights query \
    --analytics-query "$QUERY" \
    --apps "$app_id" \
    --start-time 2023-08-$day $hour:15:00 +01:00 \
    --end-time 2023-08-$day $hour:30:00 +01:00 \
    --output json \
    --verbose > pas-coop-no-contact-logs_202308$day$hour$m2.json
	
az monitor app-insights query \
    --analytics-query "$QUERY" \
    --apps "$app_id" \
    --start-time 2023-08-$day $hour:30:00 +01:00 \
    --end-time 2023-08-$day $hour:45:00 +01:00 \
    --output json \
    --verbose > pas-coop-no-contact-logs_202308$day$hour$m3.json
	
az monitor app-insights query \
    --analytics-query "$QUERY" \
    --apps "$app_id" \
    --start-time 2023-08-$day $hour:45:00 +01:00 \
    --end-time 2023-08-$day $hour:59:59 +01:00 \
    --output json \
    --verbose > pas-coop-no-contact-logs_202308$day$hour$m4.json

done
#Compress files
zip coop_pas_data_export_contact_202308$day.zip ./pas-coop-no-contact-logs*
rm pas-coop-no-contact-logs*.json

done
	


