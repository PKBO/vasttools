#!/usr/bin/env bash
set -euo pipefail

echo "========== DOCKER DISK USAGE SUMMARY (top) =========="
docker system df
echo

# --- RUNNING CONTAINERS ---

echo "=== 1) Running containers (sorted by SIZE) ==="
docker ps --size --format "{{.Names}}|{{.ID}}|{{.Image}}|{{.Status}}|{{.Size}}" \
| awk -F'|' '
  function tobytes(s,  n, u) {
    match(s, /([0-9.]+)([kMGTP]?B)/, arr)
    n=arr[1]
    u=arr[2]
    if(u=="B")      return n
    if(u=="kB")     return n*1024
    if(u=="MB")     return n*1024*1024
    if(u=="GB")     return n*1024*1024*1024
    if(u=="TB")     return n*1024*1024*1024*1024
    return 0
  }
  {
    split($5, sz, " ")
    print tobytes(sz[1]) "|" $0
  }
' \
| sort -n -r \
| cut -d'|' -f2- \
| awk -F'|' 'BEGIN{print "NAME\tID\tIMAGE\tSTATUS\tSIZE"} {OFS="\t"; print $1,$2,$3,$4,$5}' \
| column -t -s $'\t'
echo

# --- STOPPED CONTAINERS ---

echo "=== 2) Stopped containers (sorted by SIZE) ==="
docker ps -a --filter "status=exited" --size --format "{{.Names}}|{{.ID}}|{{.Image}}|{{.Status}}|{{.Size}}" \
| awk -F'|' '
  function tobytes(s,  n, u) {
    match(s, /([0-9.]+)([kMGTP]?B)/, arr)
    n=arr[1]
    u=arr[2]
    if(u=="B")      return n
    if(u=="kB")     return n*1024
    if(u=="MB")     return n*1024*1024
    if(u=="GB")     return n*1024*1024*1024
    if(u=="TB")     return n*1024*1024*1024*1024
    return 0
  }
  {
    split($5, sz, " ")
    print tobytes(sz[1]) "|" $0
  }
' \
| sort -n -r \
| cut -d'|' -f2- \
| awk -F'|' 'BEGIN{print "NAME\tID\tIMAGE\tSTATUS\tSIZE"} {OFS="\t"; print $1,$2,$3,$4,$5}' \
| column -t -s $'\t'
echo

# --- IMAGES ---

echo "=== 3) Images (sorted by SIZE) ==="
docker images --format "{{.Repository}}:{{.Tag}}|{{.ID}}|{{.CreatedSince}}|{{.Size}}" \
| awk -F'|' '
  function tobytes(s,  n, u) {
    match(s, /([0-9.]+)([kMGTP]?B)/, arr)
    n=arr[1]
    u=arr[2]
    if(u=="B")      return n
    if(u=="kB")     return n*1024
    if(u=="MB")     return n*1024*1024
    if(u=="GB")     return n*1024*1024*1024
    if(u=="TB")     return n*1024*1024*1024*1024
    return 0
  }
  {
    print tobytes($4) "|" $0
  }
' \
| sort -n -r \
| cut -d'|' -f2- \
| awk -F'|' 'BEGIN{print "REPOSITORY:TAG\tID\tCREATED\tSIZE"} {OFS="\t"; print $1,$2,$3,$4}' \
| column -t -s $'\t'
echo

# --- BUILD CACHE (netřídím, není to zásadní, summary je jinde) ---

echo "=== 4) Build cache details ==="
docker system df -v | awk '/^Build cache:/ {show=1; print ""; print $0; next} show && /^[^-]/ {print} /^-/ {show=0}'
echo

echo "=== 5) RAW docker system df -v output (all details) ==="
docker system df -v
echo

echo "========== DOCKER DISK USAGE SUMMARY (bottom) =========="
docker system df
