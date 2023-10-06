# Usage

### p2pBandwidthLatencyTest

```
cd cuda-samples/Samples/5_Domain_Specific/p2pBandwidthLatencyTest && \
/usr/bin/nvcc p2pBandwidthLatencyTest.cu -o p2pBandwidthLatencyTest -I../../../Common

# run p2pBandwidthLatencyTest for 10 times on a machine with 8 GPUs
# and report the average CPU-GPU performance
./p2pBandwidthLatencyTest_avg.sh 10 8
```

Expecated output on Lambda 8xH100 SXM5 Hyperplane

```
Running test 1
Running test 2
Running test 3
Running test 4
Running test 5
Running test 6
Running test 7
Running test 8
Running test 9
Running test 10
Average CPU-GPU P2P=Enabled Latency Matrix (us) over 10 runs:
 2.05 1.65 1.61 1.61 1.59 1.60 1.62 1.62
 1.68 2.03 1.61 1.61 1.60 1.60 1.61 1.60
 1.69 1.65 2.03 1.63 1.61 1.62 1.62 1.64
 1.66 1.61 1.62 2.02 1.60 1.60 1.61 1.61
 1.82 1.77 1.77 1.78 2.15 1.76 1.79 1.79
 1.86 1.79 1.80 1.81 1.81 2.21 1.81 1.81
 1.81 1.79 1.79 1.79 1.82 1.82 2.15 1.81
 1.85 1.81 1.81 1.83 1.83 1.83 1.84 2.17
Average latency:
1.71
```

### bandwidthTest

```
cd cuda-samples/Samples/1_Utilities/bandwidthTest && \
/usr/bin/nvcc bandwidthTest.cu -o bandwidthTest -I../../../Common

# run bandwidthTest for 10 times
# and report the average performance
./bandwidthTest_avg.sh 10
```

Expecated output on Lambda 8xH100 SXM5 Hyperplane

```
Running test 1
Running test 2
Running test 3
Running test 4
Running test 5
Running test 6
Running test 7
Running test 8
Running test 9
Running test 10
Average Host to Device Bandwidth over 10 runs: 432.31
```
