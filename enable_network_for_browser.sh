#!/bin/bash
set -e

# -------------------------------
# Usage check
# -------------------------------
if [ $# -lt 1 ]; then
    echo "Usage: $0 <network-trace-name>"
    echo "Example: $0 6mbit-50ms-jitter"
    exit 1
fi

TRACE_NAME="$1"

# -------------------------------
# Mapping from name → script + port
# -------------------------------
case "$TRACE_NAME" in
    unrestricted)
        SCRIPT="unrestricted.sh"
        PORT=9001
        ;;
    6mbit-50ms-jitter)
        SCRIPT="6mbit_50ms_jitter.sh"
        PORT=9002
        ;;
    500kbit-100ms-1min)
        SCRIPT="500kbit_100ms_1min.sh"
        PORT=9003
        ;;
    10mbit-100ms-1min)
        SCRIPT="10mbit_100ms_1min.sh"
        PORT=9004
        ;;
    500kbit-then-unrestricted)
        SCRIPT="500kbit_then_unrestricted.sh"
        PORT=9005
        ;;
    56kbit-100ms-1min)
        SCRIPT="56kbit_100ms_1min.sh"
        PORT=9006
        ;;
    oscillate-1mbit-start)
        SCRIPT="oscillate_1mbit_start.sh"
        PORT=9007
        ;;
    oscillate-5mbit-start)
        SCRIPT="oscillate_5mbit_start.sh"
        PORT=9008
        ;;
    4mbit-then-200kbit)
        SCRIPT="4mbit_then_200kbit.sh"
        PORT=9009
        ;;
    3mbit-100ms-1min)
        SCRIPT="3mbit_100ms_1min.sh"
        PORT=9010
        ;;
    jernbanetorget-ljabru-tram)
        SCRIPT="jernbanetorget_ljabru_tram.sh"
        PORT=9011
        ;;
    snaroya-smestad-car)
        SCRIPT="snaroya_smestad_car.sh"
        PORT=9012
        ;;
    *)
        echo "❌ Unknown trace name: '$TRACE_NAME'"
        echo "Available options:"
        echo "  unrestricted, 6mbit-50ms-jitter, 500kbit-100ms-1min, 10mbit-100ms-1min,"
        echo "  500kbit-then-unrestricted, 56kbit-100ms-1min, oscillate-1mbit-start,"
        echo "  oscillate-5mbit-start, 4mbit-then-200kbit, 3mbit-100ms-1min,"
        echo "  jernbanetorget-ljabru-tram, snaroya-smestad-car"
        exit 1
        ;;
esac

# -------------------------------
# Launch the corresponding script
# -------------------------------
if [ ! -f "./scripts/$SCRIPT" ]; then
    echo "❌ Script '$SCRIPT' not found in scripts/ directory."
    exit 1
fi

echo "🚀 Launching network trace: $TRACE_NAME"
echo "📜 Script: $SCRIPT"
echo "🌐 Please watch the video by entering: http://localhost:${PORT}" on your host browser
echo "-----------------------------------------------"

bash "./scripts/$SCRIPT"
