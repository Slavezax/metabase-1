#!/bin/bash
# Script to stop the current Metabase development instance

echo "=== Stopping Current Metabase Instance ==="
echo ""

# Find Metabase processes
METABASE_PIDS=$(ps aux | grep -i metabase | grep java | grep -v grep | awk '{print $2}')

if [ -z "$METABASE_PIDS" ]; then
    echo "ℹ️  No Metabase processes found running."
    exit 0
fi

echo "📋 Found Metabase process(es): $METABASE_PIDS"

# Ask for confirmation
read -p "🤔 Stop these Metabase process(es)? (y/N): " -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Cancelled."
    exit 0
fi

# Stop the processes
echo "🛑 Stopping Metabase processes..."
for PID in $METABASE_PIDS; do
    echo "  Stopping process $PID..."
    kill "$PID"
done

# Wait a moment and check if they stopped
sleep 3

STILL_RUNNING=$(ps aux | grep -i metabase | grep java | grep -v grep | wc -l | tr -d ' ')
if [ "$STILL_RUNNING" -gt 0 ]; then
    echo "⚠️  Some processes still running. Forcing termination..."
    pkill -9 -f metabase
    sleep 2
fi

# Final check
FINAL_CHECK=$(ps aux | grep -i metabase | grep java | grep -v grep | wc -l | tr -d ' ')
if [ "$FINAL_CHECK" -eq 0 ]; then
    echo "✅ All Metabase processes stopped successfully!"
    echo ""
    echo "💡 You can now start the migrated version with:"
    echo "   ./metabase-config.sh"
else
    echo "❌ Some processes may still be running. Please check manually:"
    echo "   ps aux | grep metabase"
fi

