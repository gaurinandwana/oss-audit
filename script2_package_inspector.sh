#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: Vani | Reg No: 24BCE11269
# Course: Open Source Software | Capstone Project
# Description: Checks if a FOSS package is installed, retrieves
#              its version and license, and prints a philosophy
#              note about each package using a case statement.
# ============================================================

# --- Target package for this audit ---
PACKAGE="python3"   # Main audited software

# --- Function to check installation on both RPM and DEB systems ---
check_package() {
    local pkg=$1

    # Try RPM-based systems first (Fedora, RHEL, CentOS)
    if command -v rpm &>/dev/null && rpm -q "$pkg" &>/dev/null; then
        echo "[INSTALLED — RPM system]"
        rpm -qi "$pkg" | grep -E 'Version|License|Summary'
        return 0
    fi

    # Try DEB-based systems (Ubuntu, Debian)
    if command -v dpkg &>/dev/null && dpkg -l "$pkg" 2>/dev/null | grep -q "^ii"; then
        echo "[INSTALLED — DEB system]"
        dpkg -l "$pkg" | grep "^ii" | awk '{print "Version: "$3}'
        # Get more info from apt-cache if available
        if command -v apt-cache &>/dev/null; then
            apt-cache show "$pkg" 2>/dev/null | grep -E 'Version|License|Description' | head -5
        fi
        return 0
    fi

    # Try checking if the binary is simply available in PATH
    if command -v "$pkg" &>/dev/null; then
        echo "[AVAILABLE in PATH — binary found]"
        "$pkg" --version 2>/dev/null || echo "(version flag not supported)"
        return 0
    fi

    return 1   # Not found
}

echo "========================================================"
echo "        FOSS PACKAGE INSPECTOR"
echo "========================================================"
echo ""
echo "  Checking package: $PACKAGE"
echo "--------------------------------------------------------"

# --- Check installation status ---
if check_package "$PACKAGE"; then
    echo ""
    echo "  Package '$PACKAGE' is present on this system."
else
    echo "  Package '$PACKAGE' is NOT installed on this system."
    echo "  To install on Ubuntu/Debian : sudo apt install python3"
    echo "  To install on Fedora/RHEL   : sudo dnf install python3"
fi

echo ""
echo "--------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTES"
echo "--------------------------------------------------------"

# --- Case statement: print philosophy note per package ---
# This demonstrates use of case for multi-branch decision logic
case $PACKAGE in
    python3|python)
        echo "  Python: Born from Guido van Rossum's desire for a"
        echo "  language that is readable and accessible to all."
        echo "  The PSF license ensures Python remains free forever,"
        echo "  and its community-driven development is a model for"
        echo "  how open source can shape an entire industry."
        ;;
    httpd|apache2)
        echo "  Apache: The web server that built the open internet."
        echo "  Its permissive Apache 2.0 license allows companies"
        echo "  to use and modify it freely — a cornerstone of FOSS."
        ;;
    mysql|mariadb)
        echo "  MySQL: Open source at the heart of millions of apps."
        echo "  Its dual GPL/Commercial license model sparked major"
        echo "  debate about how companies monetize open-source tools."
        ;;
    firefox)
        echo "  Firefox: A nonprofit browser fighting for an open web."
        echo "  Mozilla's MPL 2.0 license balances openness with the"
        echo "  ability for companies to build proprietary extensions."
        ;;
    vlc)
        echo "  VLC: Built by students at École Centrale Paris who"
        echo "  needed a free, flexible media player. Its LGPL/GPL"
        echo "  license means anyone can adapt it for any platform."
        ;;
    git)
        echo "  Git: Linus Torvalds built Git in 2 weeks when BitKeeper"
        echo "  (a proprietary tool) was no longer free to use. A"
        echo "  perfect example of open source born from frustration."
        ;;
    libreoffice)
        echo "  LibreOffice: A community fork of OpenOffice, born when"
        echo "  Oracle acquired Sun Microsystems. Demonstrates how FOSS"
        echo "  communities can rescue a project from corporate control."
        ;;
    *)
        echo "  '$PACKAGE': A member of the vast FOSS ecosystem."
        echo "  Open source software empowers users with the freedom"
        echo "  to run, study, modify, and share software freely."
        ;;
esac

echo ""
echo "========================================================"
echo "  End of FOSS Package Inspector"
echo "========================================================"
