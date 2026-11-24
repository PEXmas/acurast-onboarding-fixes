#!/usr/bin/env python3
"""Validate the public, anonymized Acurast case registry (Python stdlib only).

This is a schema/privacy *lint*, NOT a security audit and NOT QR-signature verification.
"""
import json
import re
import sys
from pathlib import Path

FILE = Path(__file__).resolve().parents[1] / "compatibilidad" / "casos.json"
REQUIRED = {
    "id": str, "device": str, "android": str, "core_initial": (str, type(None)),
    "core_final": (str, type(None)), "method": str, "source_type": str,
    "source": str, "result": str, "online_verified": bool,
    "evidence": list, "issues": list, "risk_notes": list, "last_observed": str,
}
ALLOWED_RESULTS = {
    "core_ui_green_online_unverified",
    "online_reported_upstream",
    "owner_and_launch_online_unverified",
    "hub_online_user_reported",
}
ALLOWED_SOURCES = {"guided_observation", "upstream_community_report", "user_report"}
PRIVATE_PATTERNS = [
    (re.compile(r"[\w.+-]+@[\w.-]+\.[A-Za-z]{2,}"), "email"),
    (re.compile(r"(?<!\d)\d{15}(?!\d)"), "possible IMEI"),
    (re.compile(r"0x[0-9a-fA-F]{96,}"), "possible signature"),
    (re.compile(r"android\.app\.extra\.PROVISIONING_ADMIN_EXTRAS_BUNDLE"), "raw QR field"),
    (re.compile(r"-----BEGIN (?:RSA |EC )?PRIVATE KEY-----"), "private key"),
]
errors = []
try:
    registry = json.loads(FILE.read_text(encoding="utf-8"))
    assert registry.get("schema_version") == 1
    entries = registry["entries"]
    assert isinstance(entries, list) and entries
except (OSError, ValueError, KeyError, AssertionError, TypeError) as exc:
    print("FAIL: registry missing or invalid:", exc)
    sys.exit(1)

ids = set()
for index, row in enumerate(entries):
    prefix = f"entries[{index}]"
    if not isinstance(row, dict):
        errors.append(f"{prefix}: not an object")
        continue
    for key, expected in REQUIRED.items():
        if key not in row or not isinstance(row[key], expected):
            errors.append(f"{prefix}: invalid or missing {key}")
    code = row.get("id")
    if not isinstance(code, str) or not re.fullmatch(r"[a-z0-9][a-z0-9-]{5,100}", code):
        errors.append(f"{prefix}: invalid id format")
    if code in ids:
        errors.append(f"{prefix}: duplicate id")
    ids.add(code)
    if row.get("result") not in ALLOWED_RESULTS:
        errors.append(f"{prefix}: unsupported result")
    if row.get("source_type") not in ALLOWED_SOURCES:
        errors.append(f"{prefix}: unsupported source_type")
    if row.get("online_verified") is True:
        errors.append(f"{prefix}: online_verified must stay false unless a documented, independent verification process is added")
    if row.get("result") == "online_reported_upstream" and row.get("source_type") != "upstream_community_report":
        errors.append(f"{prefix}: upstream status missing upstream source")
    if row.get("source_type") == "upstream_community_report" and not str(row.get("source","")).startswith("https://github.com/"):
        errors.append(f"{prefix}: upstream report must cite public source")
    if not row.get("evidence") or not all(isinstance(v, str) and v for v in row["evidence"]):
        errors.append(f"{prefix}: evidence must be nonempty text list")
    if not isinstance(row.get("risk_notes"), list) or not all(isinstance(v, str) for v in row["risk_notes"]):
        errors.append(f"{prefix}: risk_notes must be text list")
    if not isinstance(row.get("issues"), list):
        errors.append(f"{prefix}: issues must be a list")
    else:
        for j, issue in enumerate(row["issues"]):
            if not isinstance(issue, dict) or any(not isinstance(issue.get(k), str) or not issue[k] for k in ("code", "symptom", "observed_action", "outcome")):
                errors.append(f"{prefix}: invalid issue #{j+1}")

# Scan only the public data file. This is a heuristic, not a guarantee.
raw = FILE.read_text(encoding="utf-8")
for pattern, name in PRIVATE_PATTERNS:
    if pattern.search(raw):
        errors.append(f"Possible sensitive value: {name}; review locally. Do not paste it in chats or issues.")
if errors:
    print("FAIL: " + str(len(errors)) + " issue(s):")
    for err in errors:
        print(" - " + err)
    sys.exit(1)
print(f"PASS: {len(entries)} anonymized cases validated (structure and basic privacy lint)")
