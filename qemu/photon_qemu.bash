# [Downloading Photon OS](https://vmware.github.io/photon/docs-v5/installation-guide/downloading-photon/)
# [Building Photon OS 5.0 Iso from source on Ubuntu 22.04 1519](https://github.com/vmware/photon/issues/1519)
#
cd $(dirname "${BASH_SOURCE[0]}")
QEMU_DIR=$(pwd)
RELEASE=5.0
ISO=photon-5.0-dde71ec57.x86_64.iso
BOOT_DISK=photon-${RELEASE}.qcow2
MEMORY=4G

function photon::create_boot_disk {
    qemu-img create -f qcow2 ${BOOT_DISK} 16G
}

function photon::download {
    wget https://packages.vmware.com/photon/${RELEASE}/GA/iso/${ISO}
}

function photon::install {
    qemu-system-x86_64 -drive id=disk,file=${BOOT_DISK} -drive id=cdrom,file=${ISO},media=cdrom,if=none,read-only=on -device ahci,id=ahci -device ide-hd,drive=disk,bus=ahci.0 -device ide-cd,drive=cdrom,bus=ahci.1 -m ${MEMORY}
}

function photon::boot {
    qemu-system-x86_64 -drive id=disk,file=${BOOT_DISK},if=none -device ahci,id=ahci -device ide-hd,drive=disk,bus=ahci.0 -m ${MEMORY}
}

echo $QEMU_DIR

