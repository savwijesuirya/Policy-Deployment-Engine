#!/usr/bin/env python3
import os
import re
import sys
import json
import argparse
from urllib.request import urlopen, Request

# Terraform Registry API URL for hashicorp/google provider versions
REGISTRY_URL = "https://registry.terraform.io/v1/providers/hashicorp/google/versions"

def get_latest_google_version():
    """Fetch the latest hashicorp/google provider version from Terraform Registry."""
    try:
        req = Request(REGISTRY_URL, headers={"User-Agent": "python-urllib"})
        with urlopen(req, timeout=10) as resp:
            data = json.load(resp)
    except Exception as e:
        sys.exit(f" Failed to fetch registry data: {e}")
    latest = data["versions"][0]["version"]
    print(f"→ Latest hashicorp/google provider version: {latest}")
    return latest

def update_file(path, latest_version):
    """
    Replace any 'version = "old"' with the new latest_version in the given file.
    Returns True if the file was changed.
    """
    pattern = re.compile(r'(version\s*=\s*")[^"]+(")')
    changed = False

    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    new_lines = []
    for line in lines:
        def repl(m):
            return f"{m.group(1)}{latest_version}{m.group(2)}"
        new_line = pattern.sub(repl, line)
        if new_line != line:
            changed = True
        new_lines.append(new_line)

    if changed:
        with open(path, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        print(f" Updated {path}")
    return changed

def walk_and_update(root, latest_version):
    """Walk through root directory, updating any .tf files found."""
    total = 0
    for dirpath, _, filenames in os.walk(root):
        for fn in filenames:
            if fn.endswith('.tf'):
                full = os.path.join(dirpath, fn)
                if update_file(full, latest_version):
                    total += 1
    print(f"\n Completed: updated {total} file(s).")

def main():
    parser = argparse.ArgumentParser(
        description="Update Terraform provider versions in all .tf files to the latest hashicorp/google provider."
    )
    parser.add_argument(
        "--root",
        default=".",
        help="Root directory to begin searching (default: entire repo)."
    )
    args = parser.parse_args()

    latest = get_latest_google_version()
    walk_and_update(args.root, latest)

if __name__ == "__main__":
    main()
