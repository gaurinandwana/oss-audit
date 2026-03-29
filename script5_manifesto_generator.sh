#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: Vani | Reg No: 24BCE11269
# Course: Open Source Software | Capstone Project
# Description: Asks the user three interactive questions and
#              composes a personalised open source philosophy
#              statement, then saves it to a .txt file.
# ============================================================

# --- Alias concept demonstrated via comment ---
# In a real shell session you could define:
#   alias manifesto='bash script5_manifesto_generator.sh'
# This makes the script callable by a short, memorable name —
# a classic UNIX philosophy: small tools with simple interfaces.

# --- Welcome Banner ---
echo "========================================================"
echo "    OPEN SOURCE MANIFESTO GENERATOR"
echo "    For: Vani | 24BCE11269 | Python Audit"
echo "========================================================"
echo ""
echo "  Answer three questions to generate your personal"
echo "  open source philosophy statement."
echo ""
echo "--------------------------------------------------------"
echo ""

# --- Collect user input using read ---
# -p flag prints the prompt before reading input
read -rp "  1. Name one open-source tool you use every day: " TOOL
echo ""
read -rp "  2. In one word, what does 'freedom' mean to you? " FREEDOM
echo ""
read -rp "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Validate inputs: make sure none are empty ---
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  ERROR: All three questions must be answered."
    echo "  Please run the script again and provide all inputs."
    exit 1
fi

# --- Get current date and define output filename ---
DATE=$(date '+%d %B %Y')
OUTPUT="manifesto_$(whoami).txt"   # Unique filename per user

# --- String concatenation: build the manifesto paragraph ---
# Using echo with >> to append each line to the output file
# Using > to create/overwrite the file with the header first

# Build the manifesto content (write to file using > and >>)
{
echo "========================================================"
echo "  MY OPEN SOURCE MANIFESTO"
echo "  Generated on: $DATE"
echo "  By: $(whoami)"
echo "========================================================"
echo ""
echo "  Every day, I rely on $TOOL — a piece of software that"
echo "  someone built, documented, and shared with the world at"
echo "  no cost and with no conditions other than the expectation"
echo "  of the same openness in return. That act of sharing is"
echo "  not naivety. It is a statement."
echo ""
echo "  To me, freedom means $FREEDOM. In the context of software,"
echo "  freedom is not just the absence of a price tag. It is the"
echo "  right to understand the tools I use, to improve them, to"
echo "  fix them when they break, and to pass them on to others."
echo "  Without source code, there is no freedom — only dependence."
echo ""
echo "  One day, I want to build $BUILD and share it freely. Not"
echo "  because I expect nothing in return, but because I understand"
echo "  that the ecosystem I benefit from every day was built by"
echo "  people who made exactly that choice before me. Open source"
echo "  is not charity. It is civilisation applied to software."
echo ""
echo "  I believe that knowledge shared is knowledge multiplied."
echo "  I believe that transparency builds trust. I believe that"
echo "  the best software in the world was written in the open,"
echo "  tested by strangers, and improved by communities who never"
echo "  met. That is worth protecting — and worth contributing to."
echo ""
echo "  -- $TOOL | $FREEDOM | $BUILD --"
echo "  -- $(whoami) | $DATE --"
echo ""
echo "========================================================"
} > "$OUTPUT"   # Redirect entire block to file (creates or overwrites)

echo ""
echo "--------------------------------------------------------"
echo "  Your manifesto has been saved to: $OUTPUT"
echo "--------------------------------------------------------"
echo ""

# --- Display the saved manifesto ---
cat "$OUTPUT"

echo ""
echo "========================================================"
echo "  End of Manifesto Generator"
echo "========================================================"
