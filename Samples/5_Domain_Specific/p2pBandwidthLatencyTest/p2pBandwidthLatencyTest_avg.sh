#!/bin/bash

num_runs=${1:-10}   
num_gpu=${2:-8}  


# Initialize arrays to store the matrix values
declare -A matrix_sum
declare -A matrix_count

for ((i=1; i<=$num_runs; i++)); do
  echo "Running test $i"
  output="$("./p2pBandwidthLatencyTest")"

  # Extract the latency matrix
  matrix=$(echo "$output" | awk -v n="$num_gpu" '/P2P=Enabled Latency \(P2P Writes\) Matrix \(us\)/ { for (i = 1; i <= n+3; i++) getline; for (i = 1; i <= n; i++) { getline; print } }')

  # Accumulate the matrix values element-wise
  row=0
  while read -r line; do
    col=0
    for value in $line; do
      matrix_sum[$row,$col]=$(awk "BEGIN {printf \"%.2f\", ${matrix_sum[$row,$col]} + $value; exit}")
      matrix_count[$row,$col]=$((matrix_count[$row,$col] + 1))
      col=$((col + 1))
    done
    row=$((row + 1))
  done <<< "$matrix"
done

# Calculate the average matrix
average_matrix=""
for ((i=0; i<$num_gpu; i++)); do
  for ((j=0; j<$(($num_gpu + 1)); j++)); do
    average_matrix+="$(awk "BEGIN {printf \"%.2f\", ${matrix_sum[$i,$j]} / ${matrix_count[$i,$j]}; exit}")\t"
  done
  average_matrix+="\n"
done

# Remove the first column from the average matrix
average_matrix_no_first_col=$(echo -e "$average_matrix" | awk '{$1=""; print $0}')

echo "Average CPU-GPU P2P=Enabled Latency Matrix (us) over $num_runs runs:"
echo -e "$average_matrix_no_first_col"

# Remove the diagonal entries from the remaining matrix
remaining_matrix=$(echo -e "$average_matrix_no_first_col" | awk '{for (i=1; i<=NF; i++) if (i != NR) printf "%.2f\t", $i; print ""}')

# Calculate the average of the remaining entries
remaining_entries_avg=$(echo -e "$remaining_matrix" | awk '{ for (i = 1; i <= NF; i++) sum+=$i; } END { printf "%.2f", sum / (NF * NR); }')

echo "Average latency:"
echo "$remaining_entries_avg"