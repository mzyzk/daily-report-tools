#!/bin/bash
set -euo pipefail

# 開始日を引数 or 今日に
start_date="${1:-$(date +%Y-%m-%d)}"

# 分解
year=$(date -j -f "%Y-%m-%d" "$start_date" +%Y)
month=$(date -j -f "%Y-%m-%d" "$start_date" +%m)
start_day=$(date -j -f "%Y-%m-%d" "$start_date" +%d)

# 月末日を取得
last_day=$(cal "$month" "$year" | awk 'NF {d=$NF} END {print d}')

# 残り日数を計算
days=$((last_day - 10#$start_day + 1))

template="template.txt"

for ((i=0; i<days; i++)); do
  ymd=$(date -j -v+${i}d -f "%Y-%m-%d" "$start_date" "+%Y%m%d")
  date_line=$(date -j -f "%Y%m%d" "$ymd" "+【日報】%Y/%m/%d")

{
  echo "$date_line"
  echo
  cat template.txt
} > "${ymd}.txt"
done
