#!/usr/bin/env bash

set -e

# Check for KVM support
if [ -e /dev/kvm ]; then
    echo "[INFO] KVM acceleration available"
    KVM_ARG="-enable-kvm"
    CPU_ARG="host"
    MEMORY="16G"
    SMP_CORES=8
else
    echo "[WARNING] KVM not available - using slower emulation mode"
    KVM_ARG=""
    CPU_ARG="qemu64"
    MEMORY="8G"
    SMP_CORES=4
fi

# Windows-specific boot parameters
BOOT_ORDER="-boot order=c,menu=on"
if [ ! -s "/data/$DISK_NAME" ] || [ $(stat -c%s "/data/$DISK_NAME") -lt 1048576 ]; then
  echo "[INFO] Normal boot - starting Windows"
  BOOT_ORDER="-boot order=d,menu=on"
fi

echo "[INFO] Starting VM with ${SMP_CORES} CPU cores and ${MEMORY} RAM"

# Start QEMU with Windows-optimized settings
qemu-system-x86_64 \
  $KVM_ARG \
  -machine q35,accel=kvm:tcg \
  -cpu $CPU_ARG \
  -m $MEMORY \
  -smp $SMP_CORES \
  -vga vmware \
  -usb -device usb-tablet \
  $BOOT_ORDER \
  -drive file=/data/$DISK_NAME,format=qcow2 \
  -netdev user,id=net0,hostfwd=tcp::3389-:3389 \
  -device e1000,netdev=net0 \
  -display vnc=:0 \
  -name "Windows_VM" &

# Start noVNC
sleep 5
websockify --web /novnc 6080 localhost:5900 &

echo "======================================================="
echo "> Connect via VNC: http://localhost:6080"
echo "> Connect via RDP: localhost:3389"
echo "======================================================="

tail -f /dev/null