#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: Vani | Reg No: 24BCE11269
# Course: Open Source Software | Capstone Project
# Description: Reads a log file line by line, counts keyword
#              occurrences (default: "error"), and prints a
#              summary with the last 5 matching lines.
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# ============================================================

# --- Command-line arguments ---
LOGFILE=$1              # First argument: path to the log file
KEYWORD=${2:-"error"}   # Second argument: keyword to search (defaults to "error")

# --- Counter for keyword matches ---
COUNT=0

echo "========================================================"
echo "        LOG FILE ANALYZER"
echo "========================================================"
echo ""
echo "  Log file : ${LOGFILE:-[not specified]}"
echo "  Keyword  : $KEYWORD"
echo ""
echo "--------------------------------------------------------"

# --- Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    exit 1
fi

# --- Retry loop: if the file is empty, offer to try another file ---
# This demonstrates a do-while style loop using while with a flag
RETRY=true
ATTEMPT=0
MAX_ATTEMPTS=3

while $RETRY; do
    ATTEMPT=$((ATTEMPT + 1))

    # Check if the specified file exists
    if [ ! -f "$LOGFILE" ]; then
        echo "  ERROR: File '$LOGFILE' not found."

        # After 3 failed attempts, exit gracefully
        if [ "$ATTEMPT" -ge "$MAX_ATTEMPTS" ]; then
            echo "  Maximum attempts ($MAX_ATTEMPTS) reached. Exiting."
            exit 1
        fi

        # Prompt user to try an alternative log file
        echo "  Attempt $ATTEMPT of $MAX_ATTEMPTS."
        read -rp "  Enter another log file path (or press Enter to exit): " NEW_FILE

        # Exit if user presses Enter without input
        if [ -z "$NEW_FILE" ]; then
            echo "  No file provided. Exiting."
            exit 1
        fi

        LOGFILE="$NEW_FILE"   # Update the file path and retry
        continue
    fi

    # Check if the file is empty
    if [ ! -s "$LOGFILE" ]; then
        echo "  WARNING: File '$LOGFILE' exists but is empty."

        if [ "$ATTEMPT" -ge "$MAX_ATTEMPTS" ]; then
            echo "  Maximum attempts reached. Exiting."
            exit 1
        fi

        read -rp "  Try another log file path (or press Enter to exit): " NEW_FILE
        if [ -z "$NEW_FILE" ]; then
            echo "  Exiting."
            exit 1
        fi
        LOGFILE="$NEW_FILE"
        continue
    fi

    # File exists and is not empty — exit the retry loop
    RETRY=false
done

echo "  Scanning '$LOGFILE' for keyword: '$KEYWORD'"
echo ""

# --- While-read loop: read file line by line ---
# IFS= preserves leading/trailing whitespace; -r prevents backslash interpretation
while IFS= read -r LINE; do
    # If the line contains the keyword (case-insensitive), increment counter
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
    fi
done < "$LOGFILE"

# --- Print summary ---
echo "  SCAN COMPLETE"
echo "  ------------------------------------------------------------"
echo "  Keyword '$KEYWORD' found $COUNT time(s) in: $LOGFILE"
echo ""

# --- Print last 5 matching lines ---
if [ "$COUNT" -gt 0 ]; then
    echo "  Last 5 lines containing '$KEYWORD':"
    echo "  ------------------------------------------------------------"
    # Use grep to find matching lines, tail to get last 5
    grep -i "$KEYWORD" "$LOGFILE" | tail -5 | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
else
    echo "  No lines containing '$KEYWORD' were found in the log file."
fi

echo ""
echo "========================================================"
echo "  End of Log File Analyzer"
echo "========================================================"
