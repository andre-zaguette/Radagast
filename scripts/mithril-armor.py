#!/usr/bin/env python3
import os, re

# Mithril Armor (Radagast): Python Security Scanner
SHADOW_PATTERNS = [
    (r'(?i)api_key.*=.*[\'"][a-zA-Z0-9]{20,}[\'"]', "Secret: API key hardcoded"),
    (r'(?i)password.*=.*[\'"][a-zA-Z0-9]{8,}[\'"]', "Secret: password hardcoded"),
    (r'(?i)secret.*=.*[\'"][a-zA-Z0-9]{20,}[\'"]', "Secret: secret value hardcoded"),
    (r'\beval\(', "Injection risk: eval() detected"),
    (r'\bexec\(', "Injection risk: exec() detected"),
    (r'subprocess\..*shell\s*=\s*True', "Shell injection risk: shell=True in subprocess"),
    (r'cursor\.execute\(.*%.*\)', "SQL injection risk: string formatting in SQL"),
    (r'from typing import Any\b|:\s*Any\b', "Type discipline: Any type detected"),
    (r'\.\.\.', "Incomplete stub: ... (ellipsis) in implementation"),
]

def scan(directory="."):
    print("🛡️ Mithril Armor (Radagast): Scanning Python shadows...")
    issues = 0
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".py") and '.git' not in root:
                path = os.path.join(root, file)
                try:
                    content = open(path, errors='ignore').read()
                    for pattern, label in SHADOW_PATTERNS:
                        if re.search(pattern, content):
                            print(f"🔥 {label} in {path}")
                            issues += 1
                except:
                    pass
    if issues:
        print(f"\n❌ {issues} shadow(s) found. Fix before signaling Boromir.")
        return False
    print("✨ No shadows. Python code is shielded.")
    return True

if __name__ == "__main__":
    import sys
    if not scan():
        sys.exit(1)
