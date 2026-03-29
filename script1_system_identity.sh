#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Vani | Reg No: 24BCE11269
# Course: Open Source Software | Capstone Project
# Description: Displays a welcome screen with key Linux system
#              information relevant to the Open Source Audit.
# ============================================================

# --- Student & Project Variables ---
STUDENT_NAME="Vani"
REG_NUMBER="24BCE11269"
SOFTWARE_CHOICE="Python"

# --- Gather System Information using command substitution ---
KERNEL=$(uname -r)                          # Kernel release version
DISTRO=$(lsb_release -d 2>/dev/null | cut -f2 || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')
USER_NAME=$(whoami)                         # Currently logged-in user
HOME_DIR=$HOME                              # Home directory of current user
UPTIME=$(uptime -p)                         # Human-readable system uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')        # Day, date, month, year
CURRENT_TIME=$(date '+%H:%M:%S %Z')         # Time with timezone

# --- OS License Information ---
# The Linux kernel is licensed under GPL v2 (GNU General Public License version 2)
OS_LICENSE="GNU General Public License v2 (GPL v2)"

# --- Display the System Identity Report ---
echo "========================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT     "
echo "========================================================"
echo ""
echo "  Student   : $STUDENT_NAME"
echo "  Reg No    : $REG_NUMBER"
echo "  Software  : $SOFTWARE_CHOICE"
echo ""
echo "--------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "--------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  User         : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo ""
echo "--------------------------------------------------------"
echo "  DATE & TIME"
echo "--------------------------------------------------------"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "--------------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "--------------------------------------------------------"
echo "  This operating system is covered under:"
echo "  $OS_LICENSE"
echo ""
echo "  GPL v2 grants you the freedom to run, study, share,"
echo "  and modify this software — the four essential freedoms"
echo "  of Free/Open Source Software (FOSS)."
echo ""
echo "========================================================"
echo "  End of System Identity Report"
echo "========================================================"
