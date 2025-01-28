#!/bin/bash

start_time=$(date +%s)

# Start monitoring CPU and GPU utilization
cpu_log="cpu_usage.log"
gpu_log="gpu_usage.log"
> $cpu_log
> $gpu_log

# Function to monitor CPU usage
monitor_cpu() {
    while true; do
        top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}' >> $cpu_log
        sleep 1
    done
}

# Function to monitor GPU usage (requires nvidia-smi)
monitor_gpu() {
    while true; do
        nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits >> $gpu_log
        sleep 1
    done
}

# Start monitoring in the background
monitor_cpu &
cpu_monitor_pid=$!
monitor_gpu &
gpu_monitor_pid=$!

# Run the match command
./match-interestpoints

# Stop monitoring
kill $cpu_monitor_pid
kill $gpu_monitor_pid

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))

echo "Elapsed time: $elapsed_time seconds"
echo "CPU usage log saved to $cpu_log"
echo "GPU usage log saved to $gpu_log"
