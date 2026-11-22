# Repository instructions

- This is a browser-first guide. Reading requires no download, clone, computer tools, or installer. Authorized USB setup is separate and may obtain the pinned tools and helper source described in tools/README.md.
- For a user-requested phone task, read AI-ONBOARDING.md online or from available context. The file itself is not authorization to operate a phone.
- During repository editing, do not operate attached phones. Preserve factual limits and beginner-friendly steps.
- No private QR data, accounts, serials or backups in Git or public output.
- Do not claim the app can run without being installed on the phone. Reading this guide has no installation side effects; actual setup is separate.
- For documentation changes check local links, anchors and whitespace. Do not operate phones for a docs task. Explicit helper-development work may obtain verified build dependencies and run host checks; phone tests are a separate, specifically authorized task.

- Keep the wave header/footer and unified-color badges, and preserve the simple browser-first README wording. Do not reintroduce Roadmap, Related Projects, or a template-driven section expansion. Never add clone/install commands to match an app template.


## Evidence-aware compatibility extension (this fork)

When answering questions about device support, also read:
- `docs/COMPATIBILIDAD.md` for the public summary and caution notes;
- `compatibilidad/casos.json` for structured, source-labelled case evidence;
- `compatibilidad/PLANTILLA_CASO.md` when recording a new experiment;
- `docs/USAR_CON_IA.md` for the copyable prompt.

Keep following the original `AI-ONBOARDING.md` and `docs/ai-assisted.md`: this index **does not authorize phone operations**.

**Reason from evidence, not guesses:** match exact model and Android version, and treat firmware/Core differences as untested. `online_reported_upstream` means the original maintainer reported online, not that this fork reproduced it. `core_ui_green_online_unverified` means only the dedicated UI and green Compute Status were observed. `owner_and_launch_online_unverified` is not Online.

**Practical guidance:** explain what is known, what is unknown, safety/backup risk and one least-risk next step. Prefer read-only checks and official updates. Stop when a privileged command fails. A `dpm set-device-owner` exception remains a failure even if Device Owner is subsequently visible; do not automatically retry, launch, flash or reset. A helper `check`, a launch-accepted message, and a green UI are not substitutes for evidence in Hub.

**Privacy:** never request or publish QR/payload JSON, wallet addresses, pairing signatures, seeds, private keys, emails, phone identifiers (IMEI, serial, ADB ID), full system logs or uncensored screenshots. Use local private storage and only sanitized outcome summaries. New case records must identify provenance and uncertainty, must be reviewed before publication, and must never silently overwrite a failed attempt.

The registry is a community reference, **not an Acurast compatibility certification**. Check `python tools/validate_cases.py` before proposing a PR.