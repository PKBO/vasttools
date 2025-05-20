#!/usr/bin/env bash
set -euo pipefail

echo "========== DOCKER DISK USAGE SUMMARY (top) =========="
docker system df
echo

echo "=== 1) Running containers (sorted by SIZE) ==="
docker ps --size --format "table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Size}}" \
  | tail -n +2 \
  | sort -t$'\t' -k5 -h -r \
  | column -t -s $'\t'
echo

echo "=== 2) Stopped containers (sorted by SIZE) ==="
docker ps -a --filter "status=exited" --size --format "table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Size}}" \
  | tail -n +2 \
  | sort -t$'\t' -k5 -h -r \
  | column -t -s $'\t'
echo

echo "=== 3) Images (sorted by SIZE) ==="
docker images --format "table {{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}\t{{.Size}}" \
  | tail -n +2 \
  | sort -t$'\t' -k4 -h -r \
  | column -t -s $'\t'
echo

echo "=== 4) Build cache details ==="
docker system df -v | awk '/^Build cache:/ {show=1; print ""; print $0; next} show && /^[^-]/ {print} /^-/ {show=0}'
echo

echo "=== 5) RAW docker system df -v output (all details) ==="
docker system df -v
echo

echo "========== DOCKER DISK USAGE SUMMARY (bottom) =========="
docker system df
