#!/usr/bin/env bash
set -euo pipefail

echo "=== 1) Running containers (sorted by current SIZE) ==="
docker ps --format 'table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.CreatedAt}}\t{{.RunningFor}}\t{{.Size}}' \
  | tail -n +2 \
  | sort -k6 -h -r

echo
echo "=== 2) Stopped containers (sorted by SIZE) ==="
docker ps -a --filter "status=exited" \
  --format 'table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.CreatedAt}}\tExited {{.RunningFor}}\t{{.Size}}' \
  | tail -n +2 \
  | sort -k6 -h -r

echo
echo "=== 3) Images (sorted by SIZE) ==="
docker images --format 'table {{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}\t{{.Size}}' \
  | tail -n +2 \
  | sort -k4 -h -r

echo
echo "=== 4) Total build cache size ==="
docker builder df --format '{{.Size}}' \
  | grep -E '[0-9]' \
  | awk '
    function conv(val, unit) {
      if (unit=="kB") return val*1024;
      if (unit=="MB") return val*1024*1024;
      if (unit=="GB") return val*1024*1024*1024;
      return val;
    }
    {
      match($0,/([0-9.]+)([kMG]B)/,a);
      total += conv(a[1],a[2]);
    }
    END { printf "Total build cache: %.2f MB\n", total/1024/1024 }
'

echo
echo "=== 5) Build cache entries (sorted by SIZE) ==="
docker builder df --format '{{.Size}}\t{{.CacheID}}' \
  | tail -n +2 \
  | sort -hr
