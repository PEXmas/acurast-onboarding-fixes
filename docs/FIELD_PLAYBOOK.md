# AI field playbook: Acurast Core onboarding without QR camera scanning

> Community, owner-authorized guide updated November 2026. USB/ADB replaces **scanning** a QR with the phone camera, **not** the signed **Copy QR Data** issued by Acurast Hub. Keep pairing data on the owner's device, out of Git, chats and cloud sync. This project covers enrollment only, never ACU production, rewards, profitability or farm analytics.

## Compare the two owner-guided Android 14 / Core 1.29.0 cases

| Step | Redmi Note 12S, broken camera | Samsung Galaxy A04 **SM-A045M**, Knox bit 1 |
| --- | --- | --- |
| Initial issue | Camera cannot scan Hub QR | Owner recalls failed managed setup after scanning QR following a factory reset; exact error not preserved |
| Prior Lite setup | No installed Lite on evaluated Redmi | Lite owned managed profile user 11; owner removed it through **Lite's own Uninstall** UI, then verified just user 0 and `no owners` |
| Official APK | ADB `INSTALL_FAILED_USER_RESTRICTED`; **verified** APK installed via Xiaomi File Manager with security review | `adb install` **Success**, official Core version 1.29.0 / 144 verified |
| Helper | Synthetic and real private-payload `check` succeeded | Synthetic and real private-payload `check` succeeded |
| Owner | Explicit `set-device-owner` **Success** and `dpm list-owners` confirmation | Explicit **Success** and `DeviceOwner,Affiliated` confirmation |
| Pairing launch | Captured `Activity start accepted (0)` | Owner reported entering Configuring/Enrolling; **exact launch stdout not supplied**, scrcpy disconnected |
| Runtime preparation | Orange `Executors not installed` then in-app **Settings → Install executor**, green/Active | Owner reported same missing-executor step and successful local completion |
| Evidence in official Hub | Owner provided **Hub Phones screenshot**, recent connection and attested status; phone screenshot with Manager | **Owner-reported Core UI success**, but **no A04-specific Hub Phones last-seen/attestation confirmation yet** |

A later screenshot from a **self-hosted processor dashboard** showed the **previously identified Redmi processor**, not the Samsung. Its recent heartbeat cannot be reused to certify the A04 in official Acurast Hub. The A04 **SM-A045M** is also different from the upstream **SM-A045F**, which had separate firmware restoration: no firmware flash was performed in this A045M trial.

**What Knox bit 1 proves:** the warranty fuse was altered. It did **not** stop Core APK installation, helper checks, Android Device Owner registration or entering Core on this **one** locked/green SM-A045M. It neither guarantees nor universally prevents Hub attestation on other phones.

## Decision tree for an AI assistant

1. **Establish consent and device identity.** Confirm owner, intended single phone, exact model, Android/Core versions, data backup and whether it is dedicated. A reset performed in the past does **not** mean another reset is always needed.
2. **Read-only preflight:** current Android user 0, `pm list users`, `dpm list-owners`, installed Acurast packages, locked bootloader, Verified Boot, root status and OEM properties. A package-listing `Shell does not have permission to access user 11` can be a managed-profile visibility restriction: query `--user 0`. `dpm` reporting `Calling identity is not authorized` **does not** mean `no owners`.
3. **Existing Lite:** protect the owner's credentials/pairing, then use **Lite's own Uninstall/de-enrollment** only with explicit approval. Verify its user/profile owner is absent; never force-remove an unrelated administrator. In the A04 test, profile/account cleanup prepared the device **without another factory reset**.
4. **Firmware is a separate gate:** a locked bootloader and Verified Boot green are favorable, not proof of Hub attestation. A tripped Knox bit is a risk, not a universal no-go; a blank property is unknown. Never flash, root, unlock/relock, spoof integrity or disable malware scanning to imitate a successful case.
5. **APK:** select **official** Core, verify SHA-256, signer, package and version; install only after the owner agrees. ADB install restrictions (Xiaomi) do not mean the APK is malicious. The Samsung A04 accepted ADB directly; the Redmi needed File Manager installation of the **same verified** APK after security review.
6. **Helper and synthetic preflight:** match pinned source/ZIP/validator checksums. `CoreProvision ... check` may verify a typed five-string PersistableBundle and matching Android interface **without launching the app**. Synthetic data **must never be launched**. Check success is **not** Hub-signature authentication, ownership, or pairing.
7. **Private Hub QR:** obtain fresh **Copy QR Data** for intended Hub wallet/phone; save as UTF-8 JSON in a private folder **outside Downloads, Git and sync** with user-only directory **and file** permissions. Validate JSON/time and APK certificate checksum locally, and actual Hub expiry separately. Stage in a shell-owned folder (directory 700, helper 444, payload 600) and compare host/device SHA-256 **without showing the hashes**; run real-data `check`. Never paste QR, JSON, private hash, signature, account or wallet into chat.
8. **Gate A — irreversible:** recheck only user 0, no accounts/work profiles/owners, Core installed but stopped, QR still valid, payload byte identity, consent and possible factory-reset recovery. With ghost touches, test an **independent OTG/Bluetooth input** before Device Owner; scrcpy depends on ADB and can disconnect.
9. **Owner and launch:** register Device Owner **once** and require explicit `Success` plus read-only `dpm list-owners`. On any exception, **stop**; a partial state is not success. After the owner is confirmed and the QR remains fresh, one specifically approved `launch` may be attempted. `Activity start accepted (0)` means only Android accepted the start.
10. **Gate B — phone:** inspect actual Core UI, Manager, disclaimer and setup completion. `Manager: not set` is incomplete pairing; a Processor row or a lost scrcpy session is not enough.
11. **Gate C — official Hub:** check **the intended exact phone** in **Acurast Hub → Phones** for recent last-seen and attestation. Label evidence carefully: phone UI, owner statement, **local dashboard**, official Hub screenshot or independent check are **not interchangeable**.
12. **Executor readiness:** if `Executors not installed` is orange after reaching Core, first inspect **app Settings → Install executor**, when available. Both 2026 experiments used this local action. Do not automatically reinstall, re-pair, or update an entire farm. Verify its result separately.
13. **Close safely:** remove synthetic files and staged QR copies **only if accessible**, verify removal where possible, and note unconfirmed payload copies if Core locked down ADB. Do not reset the phone solely for cleanup.

## Error → one safe next action

| Observation | Next check | Do not conclude |
| --- | --- | --- |
| `INSTALL_FAILED_USER_RESTRICTED` | Vendor USB restrictions, verified APK, local installer prompts | Invalid APK signature or need to disable protection |
| Shell cannot query user 11 | Lite work profile; read-only user 0 query | Knox incompatibility |
| `dpm list-owners` permission denied | Authorized permissions; state **unknown** | No Device Owner |
| Helper `check` passed | Preflight only | Pairing, cryptographic signature or Hub Online |
| `set-device-owner` exception | Stop and inspect read-only | Safe to retry |
| `Activity start accepted (0)` | Core Manager and official Hub | Pairing complete |
| scrcpy disconnects | Phone and independently tested physical input | Proof of success/failure |
| Orange missing executors | Core-local **Install executor** | Need to repeat owner/upgrade all phones |
| Green Core or active local dashboard | Correct device in official Hub | Hub attestation of another phone |

**Assistant output:** exact model and software, last gate passed, evidence type, one unresolved risk, and **one smallest safe next step**. No QR, IMEI, wallet, serials, phone IP, full logs or uncensored screenshots.

[English Redmi case](CASE_REDMI_NOTE_12S.md) · [Spanish source case](CASO_REDMI_NOTE_12S.md) · [Samsung A04 case](CASE_SAMSUNG_A04_SM_A045M.md) · [Registry](../compatibilidad/casos.json) · [Gates](checklist.md).
