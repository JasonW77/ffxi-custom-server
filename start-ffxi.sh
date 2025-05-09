#!/bin/bash

#set this to the absolute path of your LandSandBoat server build
SERVER_DIR="/home/jason/server"

#optional: directory to store log files
LOG_DIR="SERVER_DIR/logs"
mkdir -p "$LOG_DIR"

#launch each component
echo "Starting xi_connect..."
"$SERVER_DIR/xi_connect" > "$LOG_DIR/connect.log" 2>&1 &

echo "starting xi_search..."
"$SERVER_DIR/xi_search" > "$LOG_DIR/search.log" 2>&1 &

echo "starting xi_map..."
"$SERVER_DIR/xi_map" > "$LOG_DIR/map.log" 2>&1 &

echo "starting xi_world..."
"$SERVER_DIR/xi_world" > "$LOG_DIR/world.log" 2>&1 &

echo "All servers started. Logs are in $LOG_DIR"

