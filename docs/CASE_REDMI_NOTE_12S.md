# Xiaomi Redmi Note 12S — successful Core USB onboarding with damaged camera

> English companion to [the detailed Spanish field report](CASO_REDMI_NOTE_12S.md). One guided Android 14 / Core 1.29.0 case, not universal Acurast/OEM certification. No raw pairing data, wallet, serial or processor address is published.

**Tested phone:** Redmi Note 12S (`2303ERA42L`), Android 14, HyperOS `V816.0.12.0.UHZMIXM`, locked bootloader and Verified Boot green; camera could not scan QR.

- Official stable Core **1.29.0 (144)** was verified locally (APK file digest, signer, package). Android rejected `adb install` repeatedly with `INSTALL_FAILED_USER_RESTRICTED`; manual installation of that **same verified APK** from Xiaomi File Manager, after security review, succeeded.
- Owner removed setup Google/Xiaomi accounts after preflight; only user 0, no prior owners. The pinned helper/validator matched expected hashes; synthetic and fresh private real-payload `check` passed, without launching Core.
- One authorized `set-device-owner` returned explicit **Success**, confirmed `DeviceOwner,Affiliated`. One `launch` returned `Activity start accepted (0)`, which **by itself** is not pairing.
- **Official Acurast Hub Phones screenshot** supplied by owner showed intended processor with **recent connection and atested status**. Phone UI showed populated Manager, heartbeat and attestation. Initial orange `Executors not installed` turned green/Active after **in-app Settings → Install executor**.
- A later local dashboard screenshot showed the **same previously identified Redmi** with a recent heartbeat, but that private local dashboard is **not the official Hub** and cannot establish Samsung A04 Hub status.

**Limits:** Hub evidence is owner-supplied, not independently audited. A successful scan-free flow **still uses private signed QR data from Hub**. The helper does not authenticate Hub signature. No verified post-lockdown removal of the staged QR file. Do not extrapolate to other Redmi versions or recommend turning off Play Protect.

[Spanish original](CASO_REDMI_NOTE_12S.md) · [AI field decision playbook](FIELD_PLAYBOOK.md) · [Samsung A04 comparison](CASE_SAMSUNG_A04_SM_A045M.md).
