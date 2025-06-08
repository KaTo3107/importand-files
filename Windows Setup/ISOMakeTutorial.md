# Create a Bootable Windows ISO with autounattend.xml (BIOS & UEFI Support)

## 🔧 Requirements

- Original Windows ISO (e.g., from Microsoft)
- Answer file: `autounattend.xml`
- Installed Microsoft Windows ADK (for `oscdimg.exe`)
- Extraction tool: 7-Zip, WinRAR, or similar

## 📚 Step-by-Step Guide

### 1. Extract the Windows ISO
Extract the original Windows ISO to a working directory, e.g.:
```
C:\ISO\Modified\
```

### 2. Add autounattend.xml
Copy your `autounattend.xml` file to the root of the extracted ISO content:
```
C:\ISO\Modified\autounattend.xml
```

### 3. Verify Boot Files
Ensure the following boot files exist:
- `C:\ISO\Modified\boot\etfsboot.com` (for BIOS boot)
- `C:\ISO\Modified\efi\microsoft\boot\efisys.bin` (for UEFI boot)

If missing: Extract from an official Windows ISO or get via Windows ADK.

### 4. Create ISO with oscdimg (Hybrid BIOS + UEFI)
Use the following command in Command Prompt (CMD) or PowerShell:
```cmd
oscdimg -m -o -u2 -udfver102 \
  -bootdata:2#p0,e,bC:\ISO\Modified\boot\etfsboot.com#pEF,e,bC:\ISO\Modified\efi\microsoft\boot\efisys.bin \
  C:\ISO\Modified \
  C:\ISO\Windows_Custom.iso
```

### Parameter Explanation:
- `-m` : Allow larger ISO >4GB
- `-o` : Optimize duplicate files
- `-u2` : Use UDF file system version 2.01+
- `-udfver102` : Set compatible UDF version
- `-bootdata:2#...` : Add dual boot support (BIOS + UEFI)

### Result:
The output `Windows_Custom.iso` is now bootable for both BIOS and UEFI and includes your answer file.

## 🚀 Configure Proxmox VM Properly
- **CD/DVD:** Attach ISO as virtual drive
- **Boot Mode:** Match ISO (BIOS or UEFI)
- **Disk Type:** Prefer SATA over VirtIO (avoids missing driver issues)
- **autounattend.xml:** Automatically processed during setup

## 📅 Optional: Test ISO
Test the ISO in VirtualBox or Hyper-V before using on real hardware.

---

## 🔗 Helpful Links
- Windows ADK Download: https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install
- OSCDIMG Tool Info: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/oscdimg-command-line-options

---

Done! Your custom Windows installation ISO is ready to use, complete with automatic setup via `autounattend.xml`.
