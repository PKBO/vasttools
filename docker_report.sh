#!/usr/bin/env bash
set -euo pipefail

# docker_report.sh
# Quick report of Docker container/image/cache usage, sorted by size.
# Author: https://github.com/PKBO

echo "=== 1) Running containers (sorted by SIZE) ==="
docker ps \
  --format 'table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.CreatedAt}}\t{{.RunningFor}}\t{{.Size}}' \
  | tail -n +2 \
  | sort -t$'\t' -k6 -h -r

echo
echo "=== 2) Stopped containers (sorted by SIZE) ==="
docker ps -a --filter "status=exited" \
  --format 'table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.CreatedAt}}\tExited {{.RunningFor}}\t{{.Size}}' \
  | tail -n +2 \
  | sort -t$'\t' -k6 -h -r

echo
echo "=== 3) Images (sorted by SIZE) ==="
docker images \
  --format 'table {{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}\t{{.Size}}' \
  | tail -n +2 \
  | sort -t$'\t' -k4 -h -r

echo
echo "=== 4) Total build cache size ==="
if docker builder df &>/dev/null; then
  docker builder df 2>/dev/null | awk '/^Total build cache usage:/ { print $5, $6 }' \
    || echo "Could not determine total build cache size."
else
  echo "Build cache info not available (use Docker 19.03+)."
fi

echo
echo "=== 5) Build cache entries (sorted by SIZE) ==="
if docker builder df -v &>/dev/null; then
  echo -e "SIZE\tCACHE ID"
  docker builder df -v 2>/dev/null \
    | awk '
      /^Cache ID/ { id=$3 }
      /^\s+[0-9]/ { print $1 "\t" id }
    ' \
    | sort -h -r
else
  echo "Detailed build cache info not available (use Docker 19.03+)."
fi

echo
echo "=== End of report ==="
echo "Tip: Run as user with Docker access (in docker group or via sudo) for best results."
