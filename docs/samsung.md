# Samsung steps

Read this page in GitHub; no guide download is needed. For blocked setup, use [AI-assisted help](ai-assisted.md) or the [USB procedure](usb-onboarding.md). Computer tools are a separate setup requirement.

## If setup is blocked at the welcome screen

If QR setup stops before you can reach ordinary Settings, write down the exact warning and the last step that worked. Open [AI-assisted help](ai-assisted.md) and include your phone model, Android version if known, and that Settings is unavailable. Keep the QR and account details private.

The switches below require access to Settings; they are not steps you can follow from the welcome screen. Your assistant should identify the blocker and check whether a supported next step is available using the documented tools. If it cannot establish one, stop there rather than reset repeatedly or try an unexplained command.

## If Settings is accessible and Samsung blocks the app or USB

If ordinary Settings is accessible, open **Settings → Security and privacy → Auto Blocker**. Inspect the master switch and any Maximum restrictions. If it blocks the intended verified Acurast setup, turn the master control off after reading its confirmation. Some older models lack this feature.

**Do not disable Play Protect as a default fix.** An older upstream preparation mentioned reducing these protections, but this increases risk and was **not needed** to install official Core 1.29.0 by ADB on the SM-A045M. Verify source and Android signer, inspect the real vendor error and stop on malware warnings instead of bypassing them.

Resetting may restore defaults. A blocker disabled at the home screen is not a guarantee it will remain disabled after another reset. If QR setup still fails, give your [local AI assistant](ai-assisted.md) the exact error; it must follow the USB prerequisites and phone checks.

## If using the community USB procedure

Confirm the installed Core version is **1.27.1 or newer** before registering the device owner. The version named in the Hub QR's advanced field may be older. On our Android 17 test an older build accepted the provisioning intent and discarded the pairing with no error shown anywhere; this is a single-device observation, not a claim about every Samsung. See [version notes](downloads.md) and work through the [preflight, gates and stop conditions](checklist.md).

Settings → About phone → Software information → tap **Build number seven times** → enter PIN if asked → return to Settings → Developer options → **USB debugging on**. Accept the trusted computer's authorization prompt on the unlocked phone.

Before device-owner registration, remove setup accounts normally: Settings → Accounts and backup → Manage accounts → account → Remove account. Preserve unsynced data first; this removes the account from the phone, not the cloud account itself.

## A04 SM-A045M with Knox warranty bit 1: a separate guided fork case

In November 2026, the owner of a **Galaxy A04 SM-A045M / Android 14** reported successful Core 1.29.0 USB enrollment **without flashing firmware**, despite `ro.boot.warranty_bit=1`. ADB showed a locked bootloader and Verified Boot green; Acurast Lite's managed user 11 was uninstalled through its own UI; Device Owner registration returned **Success**; helper `check` passed; the owner subsequently reported the Core onboarding screen and resolved `Executors not installed` through the in-app **Install executor** action. **Hub Online and attestation for this SM-A045M are still unverified.** The session also involved ghost touches and the loss of scrcpy as Core entered dedicated mode. See [anonymized field record](CASE_SAMSUNG_A04_SM_A045M.md).

**Do not extrapolate** to other Samsung Knox tripped phones. Do not recommend a flash, relock, Knox bypass or account/profile bypass from this anecdote; users must prepare a reliable physical input method before potentially irreversible device ownership.

**Evidence note:** a later private self-hosted processor dashboard screenshot matched the previously identified **Redmi**. It is not an A04-specific attestation result from official Hub Phones. In the A04 trial scrcpy worked for preflight but disconnected during Core configuring; test independent physical input in advance. [Cross-model decision playbook](FIELD_PLAYBOOK.md).

## Stock firmware

Our SM-A045F needed separate stock restoration/relock first, and its Knox bit stayed tripped. That is not a standard onboarding step. No generic flash or relock recipe is provided. [Recovery boundaries](recovery.md).

Optional reference: [Samsung Auto Blocker documentation](https://www.samsung.com/us/support/answer/ANS10003636/).
