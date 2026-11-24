# Samsung Galaxy A04 SM-A045M — guided USB Core onboarding with Knox warranty bit 1

> **Field report: November 2026, owner-guided Windows PowerShell / Android session.** A successful Core onboarding screen and executor activation were reported by the device owner. A fresh Hub Phones screenshot / last-seen / attestation confirmation **has not yet been supplied for this specific phone**. This is **not** proof of independent Hub Online status and **not** official Acurast support.

## Device and initial problem

- **Exact model:** Samsung Galaxy A04, `SM-A045M` (**not** the separately documented upstream `SM-A045F`).
- **Android:** 14, SDK 34; ARM64 `arm64-v8a` (also supports 32-bit ARM ABIs); security patch `2026-08-05`.
- **Boot indicators (observed before ownership):** `ro.boot.flash.locked=1`, `ro.boot.verifiedbootstate=green`, `ro.boot.warranty_bit=1`.
- **Initial Core obstacle:** owner recalled that welcome/setup QR enrollment after a factory reset did not enter the expected managed/work-profile setup. **Exact error text and where it failed were not preserved.** Do not infer the Knox fuse caused this failure.
- **Initial current state:** Acurast Lite installed as `com.acurast.attested.executor.sbs.canary`, with work profile `User 11` and its `ProfileOwner/ManagedProfileOwner`. A package-listing command without `--user 0` returned a permission error accessing user 11; this was a **work-profile visibility restriction**, not an attestation finding.
- **Owner decision:** use this personally owned, dedicated device for an explicit Core experiment. No system flashing, bootloader unlock or Knox modification was performed during this session.

## Observed sequence

| Stage | Evidence / action | Result / limitation |
| --- | --- | --- |
| Safely remove Lite | In Acurast Lite settings, owner selected the app's **Uninstall** option. Subsequent `pm list users` showed only user 0; `dpm list-owners` returned **`no owners`**. | Lite profile owner and work profile removed normally. **Do not force-remove profile owners** via ADB. |
| Remove setup accounts | Owner removed remaining Google/Samsung setup accounts through device settings after checking access/backups. No Acurast package remained for user 0. | Device prepared for Core, not evidence of Hub pairing. |
| Verify Android eligibility indicators | Android 14, locked bootloader, Verified Boot green, Knox `1`; ARM64; no extra users or existing owner. | Knox alteration remains; passing boot indicators does **not** prove Core attestation eligibility. |
| Install official APK | Previously verified official Core **1.29.0 / versionCode 144**, package `com.acurast.attested.executor.canary`; `adb install` returned **Success**; package/version confirmed by ADB. | Unlike the Redmi Note 12S case, no manual File Manager APK installation was needed. |
| Check helper source and files | SHA-256 checks for `CoreProvision.java`, `helper.zip`, `check-payload.py` matched pinned references. A new A04-only staging folder held `helper.zip` read-only. | Confirmed local helper integrity. |
| Synthetic `check` | Created a `SYNTHETIC-TEST` JSON with invalid test-only signature; helper `check` reported typed five-field bundle and matching Android launch interface, with no app launch. | **Does not verify Hub pairing signature or device attestation.** Synthetic files were then removed. |
| Private Hub payload | New, phone-specific **Copy QR Data** saved outside repository and Downloads, in a Windows folder with restrictive ACLs. Strict local JSON/time/APK-certificate checks passed. Staged under `/data/local/tmp/acurast-provision-a04/` (directory `700`, helper `444`, payload `600`), with matching transfer hashes confirmed privately. | No payload, account, signature, checksum/hash or wallet details published. Local validity window is not proof of actual Hub expiration. |
| Real payload `check` | On-device helper `check` produced three expected lines (five fields, launch interface, and **check-only / no launch**), and was re-run after Device Owner registration. | Transport compatibility, **not** authenticated signature or completed pairing. |
| Set Device Owner | Authorized single `dpm set-device-owner --user 0` invocation returned explicit **Success**, then `dpm list-owners` confirmed `1 owner` on user 0, `DeviceOwner,Affiliated`. | **First-hand command output**. Knox `1` did not prevent Device Owner registration in this configuration. Do not repeat the command. |
| Launch and enrollment UI | After the authorized launch attempt, owner reported the phone entered **Configuring/Enrolling**. `scrcpy` disconnected when Core entered the dedicated flow. | **Exact launch command stdout was not supplied for the A04**, so do not claim a captured `Activity start accepted (0)` result. `scrcpy` disconnection by itself is not proof of successful enrollment. |
| Finish in Core | Owner reported that Core reached its interface, again showed `Executors not installed`, and that selecting the in-app **Install executor** option completed setup. | **Owner-reported successful enrollment and initial executor installation**. No fresh Hub attestation or last-seen screenshot has yet been provided for this A04. |

## Later evidence clarification

The owner reaffirmed that **both** Redmi Note 12S and Samsung A04 completed their **local Core setup after selecting Install executor**. A later screenshot of a **self-hosted local monitoring dashboard** showed the previously identified **Redmi** processor with recent activity, **not** an independently identified A04 on official **Acurast Hub Phones**. This does not contradict the owner's report that the A04 completed Core setup, but it **cannot establish A04-specific Hub Online/attestation**. A fresh Hub view for this specific phone remains pending. No production data or identifiers are included.

## What the result supports — and what it does not

- The **Knox warranty fuse being tripped (`1`) did not prevent** Core 1.29.0 APK installation, helper `check`, successful Android Device Owner registration, or progression to Core's onboarding UI on this **specific** `SM-A045M`.
- The owner reported that Core onboarding completed and the local **Install executor** step finished. This is a genuine **guided on-device success report**. **Hub connectivity and attestation remain unverified for this case** until explicitly checked.
- The original project's **`SM-A045F`** online report followed a separate stock restore/relock and is a different model/firmware/sequence. We **did not** flash, restore or modify firmware for the `SM-A045M` test. Do not merge those two records.
- The initial factory-reset/QR failure's exact Android error was not preserved; it **cannot be attributed exclusively to Knox**, and USB success does not prove the original QR setup pathway was broken for a specific universal reason.
- This is a single-device observation. It does **not** establish universal compatibility of tripped Knox devices, cryptographically validate the Hub signature in the helper, or guarantee that the device stays connected.

## Important safety lesson: broken touch / scrcpy

This device has erratic touchscreen touches. The owner used `scrcpy --turn-screen-off --stay-awake` to prepare the phone with PC mouse control, and reported that this worked before Core lockdown. **`scrcpy` was lost during dedicated-mode setup.** This was anticipated: scrcpy relies on ADB; the session did **not** establish that an OTG mouse was actually tested. In future trials, test an independent **OTG or Bluetooth pointing device on the phone** before the irreversible Device Owner step, or stop if the owner cannot control/accept consent. **Do not assume OTG works until directly verified.**

## AI troubleshooting rules

1. Split the stages: user/profile cleanup → official APK verified → local helper checks → expressly authorized Device Owner → launch → Core UI/Manager → Hub last-seen/attestation → optional **Install executor** for a missing-executors state.
2. If Lite owns a work profile, use its normal uninstall/de-enrollment route and confirm that user/profile owner disappeared. Treat `pm list packages` access to managed users as permissions, not Knox proof.
3. **Knox `1` is a risk factor, not a universal yes/no compatibility verdict.** Preserve actual bootloader/verified-boot state; never suggest bypassing attestation, rooting, flashing/relocking or wiping to hide it.
4. If Core already reached enrollment but says `Executors not installed`, inspect the phone's **local** Settings → **Install executor** action first; this was reported to resolve the A04 and was independently observed on the Redmi Note 12S guided case.
5. Never claim "Online / Attested in Hub" for this A04 without a fresh, user-confirmed Hub result. No production analytics: this repo covers **USB Core onboarding instead of camera QR scanning**, still using fresh privately stored Hub pairing data.
6. Never publish raw phone screenshot, IMEI, serial, wallet, QR JSON, private QR hash, signatures, email, account or location data. The phone's staged payload cleanup after Core lockdown remains **unverified**.

## References

- [Project scope](ALCANCE.md) · [Registry](../compatibilidad/casos.json) · [Compatibility](COMPATIBILIDAD.md)
- [Samsung notes](samsung.md) · [Preflight and stop conditions](checklist.md) · [USB workflow](usb-onboarding.md)
- [Redmi Note 12S contrasting success](CASO_REDMI_NOTE_12S.md) · [Earlier A52s](CASO_A52S.md)
