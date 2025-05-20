#!/usr/bin/env bash
set -euo pipefail

# Helper to convert Docker size string (e.g. "3.28GB") to bytes for sorting
to_bytes() {
  awk '
    function unit_mult(u) {
      if (u == "B") return 1;
      if (u == "kB") return 1024;
      if (u == "MB") return 1024*1024;
      if (u == "GB") return 1024*1024*1024;
      if (u == "TB") return 1024*1024*1024*1024;
      return 1;
    }
    {
      match($0, /([0-9.]+)([A-Za-z]+)/, arr);
      printf "%.0f\n", arr[1]*unit_mult(arr[2])
    }'
}

echo "=== 1) Images (sorted by SIZE) ==="
docker system df -v \
| awk '/^Images:/ {show=1; print "REPOSITORY:TAG\tIMAGE ID\tSIZE"} show && /^[^-]/ && !/^REPOSITORY/ && $0!="" {print} /^-/ {show=0}' \
| awk 'NR==1 {print; next} { sz=$(NF-0); $NF=""; print $0"\t"sz }' \
| awk 'NR==1 {print; next} { print $0 | "sort -t\"\t\" -k4,4h -r" }' \
| column -t -s $'\t'

echo
echo "=== 2) Containers (sorted by SIZE) ==="
docker system df -v \
| awk '/^Containers:/ {show=1; print "CONTAINER ID\tIMAGE\tCOMMAND\tLOCAL VOLUMES\tSIZE\tCREATED AT\tSTATUS\tNAMES"} show && /^[^-]/ && !/^CONTAINER/ && $0!="" {print} /^-/ {show=0}' \
| awk 'NR==1 {print; next} { sz=$(NF-0); $NF=""; print $0"\t"sz }' \
| awk 'NR==1 {print; next} { print $0 | "sort -t\"\t\" -k5,5h -r" }' \
| column -t -s $'\t'

echo
echo "=== 3) Build cache (sorted by SIZE) ==="
docker system df -v \
| awk '/^Build cache:/ {show=1; print "CACHE ID\tCACHE TYPE\tSIZE\tCREATED AT\tLAST USED AT\tUSAGE\tSHAREABLE"} show && /^[^-]/ && !/^CACHE/ && $0!="" {print} /^-/ {show=0}' \
| awk 'NR==1 {print; next} { sz=$(NF-0); $NF=""; print $0"\t"sz }' \
| awk 'NR==1 {print; next} { print $0 | "sort -t\"\t\" -k3,3h -r" }' \
| column -t -s $'\t'

echo
echo "=== 4) Docker disk usage summary ==="
docker system df
