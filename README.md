# Firadisk
Firadisk - File System Driver [ x86 / x64 ]

Changelog:

v0.0.1.30
- Added: boot option indicates that the virtual drive is required for booting.
- Sector-mapped virtual drive is not supported.

v0.0.1.28
- Added: Read options from GRUB4DOS RAM drive.

v0.0.1.26
  - Fixed: CD-ROM emulation in Windows 7.
  - Fixed: BSOD when unloaded.
  - Added: Allow disabling detection of GRUB4DOS and Memdisk by settings in registry.
  - File-backed virtual drive "cdrom,file=..." does not work in Windows XP-2003 text-mode setup. But "cdrom,vmem=..." works.

v0.0.1.24
  - Find disk image file without knowing drive letter of backing drive. ( use find:\ instead of <drive letter>:\ )
  
v0.0.1.22
  - It is possible to boot Windows XP in disk image file.

v0.0.1.20
  - Detect MEMDISK (v3.86) RAM drive.
  - Test SSE2 memory copy code.

v0.0.1.16
  - Fix: Slow transfer speed of RAM drive.
  - Bug: Cannot boot Windows XP setup from RAM CD-ROM.

v0.0.1.12
  - Fix: Windows Server 2003 compatibility.
  - Fix: Can read hexadecimal number (0x12345678) in boot option parameters.

v0.0.1.10
  - Virtual floppy disk drive.
  - New "physicalmemory" boot option keyword.
  - Bug: Cannot read hexadecimal number in boot option parameters.

v0.0.1.8
  - File-based drives can be created using /firadisk boot.ini option.
  - Fix: Detection of GRUB4DOS' RAM CD-ROM.

v0.0.1.6
  - Bug: Incorrect detection of size and address of GRUB4DOS' RAM CD-ROM.

v0.0.1.4
  - Support multiple virtual drive.
  - Support CD-ROM ISO loaded with GRUB4DOS.
  - No floppy drive emulation. Floppy disk image mapped to (fdx) will appear to be removable disk.

v0.0.1.0
  - Support one virtual hard drive that has been loaded with GRUB4DOS's map --mem command.
  - Windows XP can run from virtual hard drive in RAM.

