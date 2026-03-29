# oss-audit-24bce11269

**The Open Source Audit — Python**
A Capstone Project for the Open Source Software (NGMC) Course at VIT

| | |
|---|---|
| **Student** | Gauri |
| **Registration Number** | 24BCE10245 |
| **Course** | Open Source Software |
| **Audited Software** | Python (CPython) |
| **Licence Audited** | Python Software Foundation Licence v2 (PSF-2.0) |

---

## About This Project

This repository contains the complete submission for the Open Source Audit capstone project. The project audits **Python** — one of the most widely used open-source programming languages in the world — across five areas:

- Origin story and the problem Python was created to solve
- Licence analysis (PSF licence) and the four freedoms of free software
- Ethical reflection on open-source development
- Python's footprint on a Linux system
- Python's place in the broader FOSS ecosystem

---

## Repository Contents

```
oss-audit-24bce11269/
├── README.md                            ← This file
├── script1_system_identity.sh           ← System Identity Report
├── script2_package_inspector.sh         ← FOSS Package Inspector
├── script3_disk_permission_auditor.sh   ← Disk and Permission Auditor
├── script4_log_analyzer.sh              ← Log File Analyzer
└── script5_manifesto_generator.sh       ← Open Source Manifesto Generator
```

The project report PDF is submitted separately via the VITyarthi portal.

---

## Script Descriptions

### Script 1 — System Identity Report (`script1_system_identity.sh`)

Displays a formatted welcome screen showing the Linux distribution, kernel version, logged-in user, home directory, system uptime, current date and time, and the open-source licence that covers the operating system.

**Concepts demonstrated:** Variables, `echo`, command substitution `$()`, `uname`, `lsb_release`, `whoami`, `uptime`, `date`, basic output formatting.

---

### Script 2 — FOSS Package Inspector (`script2_package_inspector.sh`)

Checks whether Python (or any specified FOSS package) is installed on the system. Detects whether the system uses RPM or DEB packaging, retrieves version and licence details, and uses a `case` statement to print a one-line philosophy note about each known FOSS package.

**Concepts demonstrated:** `if-then-else`, `case` statement, `rpm -qi`, `dpkg -l`, `apt-cache show`, pipe with `grep`, `command -v` for binary detection.

---

### Script 3 — Disk and Permission Auditor (`script3_disk_permission_auditor.sh`)

Iterates over a list of important Linux system directories using a `for` loop and reports the permissions, owner, group, and disk usage of each. Also checks Python-specific installation directories and reports their status and permissions.

**Concepts demonstrated:** `for` loop, arrays `${DIRS[@]}`, `ls -ld`, `awk` to extract fields, `du -sh`, `cut`, directory existence check with `[ -d ]`.

---

### Script 4 — Log File Analyzer (`script4_log_analyzer.sh`)

Reads a log file line by line and counts how many lines contain a specified keyword (default: `error`). Includes a retry loop for handling missing or empty files. Prints a summary and the last five matching lines.

**Concepts demonstrated:** Command-line arguments `$1 $2`, `while IFS= read -r` loop, `if-then` inside loop, counter with `$(( ))`, `grep -i`, `tail`, do-while style retry logic, input validation.

**Usage:**
```bash
./script4_log_analyzer.sh /var/log/syslog error
./script4_log_analyzer.sh /var/log/auth.log WARNING
```

---

### Script 5 — Open Source Manifesto Generator (`script5_manifesto_generator.sh`)

Asks the user three interactive questions using `read`, then composes a personalised open-source philosophy statement from their answers and saves it to a uniquely named `.txt` file. Demonstrates the alias concept via an explanatory comment.

**Concepts demonstrated:** `read -rp` for interactive input, string concatenation, writing to file with `>` and `>>`, `date` command, `$(whoami)` for dynamic filename, alias concept (demonstrated in comments).

---

## How to Run the Scripts on Linux

### Step 1 — Clone the Repository

```bash
git clone https://github.com/<your-username>/oss-audit-24bce11269.git
cd oss-audit-24bce11269
```

### Step 2 — Make Scripts Executable

```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_permission_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

### Step 3 — Run Each Script

```bash
# Script 1: System Identity Report
./script1_system_identity.sh

# Script 2: FOSS Package Inspector
./script2_package_inspector.sh

# Script 3: Disk and Permission Auditor
./script3_disk_permission_auditor.sh

# Script 4: Log File Analyzer (requires a log file argument)
./script4_log_analyzer.sh /var/log/syslog error
# Or with a different keyword:
./script4_log_analyzer.sh /var/log/auth.log failed

# Script 5: Open Source Manifesto Generator (interactive)
./script5_manifesto_generator.sh
```

---

## Dependencies

All scripts use standard Linux utilities available on any modern distribution. No additional packages need to be installed.

| Utility | Purpose | Available on |
|---------|---------|-------------|
| `bash` | Script interpreter | All Linux distros |
| `uname` | Kernel version | All Linux distros |
| `lsb_release` | Distro name | Ubuntu, Debian, Fedora |
| `whoami`, `uptime`, `date` | System info | All Linux distros |
| `rpm` | Package info (RPM systems) | Fedora, RHEL, CentOS |
| `dpkg`, `apt-cache` | Package info (DEB systems) | Ubuntu, Debian |
| `du`, `ls`, `awk`, `cut` | Filesystem info | All Linux distros |
| `grep`, `tail` | Text processing | All Linux distros |

For Script 2, the system must have either `rpm` (Fedora/RHEL) or `dpkg` (Ubuntu/Debian) available for full package inspection. The script handles both gracefully.

---

## Tested On

- Ubuntu 22.04 LTS
- Fedora 39
- Debian 12 (Bookworm)

---

## Licence

This project submission is for academic purposes under the VITyarthi Open Source Software course. The shell scripts are released under the [MIT Licence](https://opensource.org/licenses/MIT).
