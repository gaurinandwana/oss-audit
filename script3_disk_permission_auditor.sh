#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: Vani | Reg No: 24BCE11269
# Course: Open Source Software | Capstone Project
# Description: Loops through key Linux system directories and
#              reports their permissions, ownership, and disk
#              usage. Also checks Python's config directories.
# ============================================================

# --- List of important system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/var/cache")

echo "========================================================"
echo "        DISK AND PERMISSION AUDITOR"
echo "========================================================"
echo ""
echo "  Auditing key Linux system directories..."
echo ""
printf "  %-20s %-30s %-10s\n" "DIRECTORY" "PERMISSIONS  OWNER  GROUP" "SIZE"
echo "  --------------------------------------------------------------------"

# --- For loop: iterate over each directory in the array ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, and group using awk on ls -ld output
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')
        # Get human-readable size using du, suppress permission error messages
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "  %-20s %-12s %-8s %-8s %-10s\n" "$DIR" "$PERMS" "$OWNER" "$GROUP" "${SIZE:-N/A}"
    else
        # Directory does not exist on this system
        printf "  %-20s %s\n" "$DIR" "[does not exist on this system]"
    fi
done

echo ""
echo "--------------------------------------------------------"
echo "  PYTHON-SPECIFIC DIRECTORY AUDIT"
echo "--------------------------------------------------------"
echo ""
echo "  Checking Python installation directories..."
echo ""

# --- Python-specific directories to inspect ---
PYTHON_DIRS=(
    "/usr/lib/python3"
    "/usr/lib/python3.11"
    "/usr/lib/python3.12"
    "/usr/local/lib/python3"
    "/usr/local/bin"
    "/etc/python3"
    "/usr/share/doc/python3"
)

FOUND=0   # Counter to track if we found any Python directories

for PDIR in "${PYTHON_DIRS[@]}"; do
    if [ -d "$PDIR" ]; then
        FOUND=$((FOUND + 1))
        PERMS=$(ls -ld "$PDIR" | awk '{print $1}')
        OWNER=$(ls -ld "$PDIR" | awk '{print $3}')
        GROUP=$(ls -ld "$PDIR" | awk '{print $4}')
        SIZE=$(du -sh "$PDIR" 2>/dev/null | cut -f1)
        echo "  Directory : $PDIR"
        echo "  Permission: $PERMS | Owner: $OWNER | Group: $GROUP | Size: ${SIZE:-N/A}"
        echo ""
    fi
done

# --- Check if Python config directory exists (may vary by version) ---
PYTHON_CONFIG=$(python3 -c "import sysconfig; print(sysconfig.get_config_var('prefix'))" 2>/dev/null)
if [ -n "$PYTHON_CONFIG" ]; then
    echo "  Python prefix (install root): $PYTHON_CONFIG"
    FOUND=$((FOUND + 1))
fi

# If no Python directories were found, print a helpful message
if [ "$FOUND" -eq 0 ]; then
    echo "  No standard Python directories found."
    echo "  Python may not be installed, or is in a non-standard location."
    echo "  Try: which python3 | python3 --version"
fi

echo ""
echo "--------------------------------------------------------"
echo "  SECURITY NOTE"
echo "--------------------------------------------------------"
echo ""
echo "  Linux permission model (rwxrwxrwx) controls who can"
echo "  read, write, or execute files — owner, group, or others."
echo "  Python runs as the invoking user, following least-privilege."
echo "  System-wide packages in /usr/lib are owned by root to"
echo "  prevent unauthorised modification."
echo ""
echo "========================================================"
echo "  End of Disk and Permission Auditor"
echo "========================================================"
