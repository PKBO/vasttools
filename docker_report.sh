#!/usr/bin/env bash
set -euo pipefail

# ======= DOCKER DISK USAGE SUMMARY (top) =======
echo "========== DOCKER DISK USAGE SUMMARY =========="
docker system df
echo

# ======= RUNNING CONTAINERS (sorted by SIZE) =======
echo "=== 1) Running containers (sorted by SIZE) ==="
docker ps --size --format "table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Size}}" \
  | tail -n +2 \
  | sort -t$'\t' -k5 -h -r \
  | column -t -s $'\t'
echo

# ======= STOPPED CONTAINERS (sorted by SIZE) =======
echo "=== 2) Stopped containers (sorted by SIZE) ==="
docker ps -a --filter "status=exited" --size --format "table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Size}}" \
  | tail -n +2 \
  | sort -t$'\t' -k5 -h -r \
  | column -t -s $'\t'
echo

# ======= IMAGES (sorted by SIZE) =======
echo "=== 3) Images (sorted by SIZE) ==="
docker images --format "table {{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}\t{{.Size}}" \
  | tail -n +2 \
  | sort -t$'\t' -k4 -h -r \
  | column -t -s $'\t'
echo

# ======= BUILD CACHE (sorted by SIZE) =======
echo "=== 4) Build cache (sorted by SIZE) ==="
if docker system df -v 2>&1 | grep -q "Build cache:"; then
  docker system df -v \
    | awk '/^Build cache:/ {show=1; print "CACHE ID\tCACHE TYPE\tSIZE\tCREATED AT\tLAST USED AT\tUSAGE\tSHAREABLE"; next}
           show && /^[^-]/ && !/^CACHE/ && $0!="" {print}
           /^-/ {show=0}' \
    | awk 'NR==1 {print; next} { sz=$(NF-0); $NF=""; print $0"\t"sz }' \
    | awk 'NR==1 {print; next} { print $0 | "sort -t\"\t\" -k3,3h -r" }' \
    | column -t -s $'\t'
else
  echo "Build cache information not available on this Docker version."
fi
echo

# ======= RAW DETAILS =======
echo "=== 5) RAW docker system df -v output (all details) ==="
docker system df -v
echo

# ======= DOCKER DISK USAGE SUMMARY (bottom) =======
echo "========== DOCKER DISK USAGE SUMMARY =========="
docker system df
