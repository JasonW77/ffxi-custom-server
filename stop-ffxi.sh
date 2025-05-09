#!/bin/bash
echo "Gracefully stopping FFXI server processes..."
pkill -f xi_

sleep 3

echo "Force killing any remaining FFXI server processes..."
for proc in xi_map xi_world xi_search xi_connect; do
    pids=$(pgrep -f $proc)
    if [ -n "$pids" ]; then
        echo "Force killing $proc..."
        kill -9 $pids
    fi
done

echo "Done. Remaining processes:"
pgrep -af xi_ || echo "All processes stopped."#!/bin/bash
echo "Stopping all FFXI server processes..."
pkill -f xi_connect
pkill -f xi_search
pkill -f xi_map
pkill -f xi_world
echo "Done."
