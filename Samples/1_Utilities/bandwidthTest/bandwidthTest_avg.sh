#!/bin/bash

num_runs=${1:-10}

# Initialize sum of Host to Device Bandwidth
total_bandwidth=0

for ((i=1; i<=$num_runs; i++)); do
  echo "Running test $i"
  result=$("./bandwidthTest" "--device=all" | awk '/Host to Device Bandwidth/{getline; getline; getline; print $2}')
  total_bandwidth=$(echo "$total_bandwidth + $result" | bc)
done

# Calculate the average
average_bandwidth=$(echo "scale=2; $total_bandwidth / $num_runs" | bc)

echo "Average Host to Device Bandwidth over $num_runs runs: $average_bandwidth"

