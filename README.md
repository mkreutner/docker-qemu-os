# Docker Qemu OS

A Docker container solution for running differents OS with KVM acceleration, providing VNC.

## Getting Started

### Prerequisites

- :green_circle: Docker installed
- :green_circle: KVM enabled system
- :green_circle: Administrative privileges
- :green_circle: Just. Just is a handy way to save and run project-specific commands [GitHub Repository](git@github.com:casey/just.git)

### Features

- :green_circle: Run OS inside a Docker container
- :green_circle: Secure with isolated environment
- :green_circle: Access via noVNC (web browser)
- :green_circle: Fast virtualisation using KVM (requires host support)
- :green_circle: Persistent storage using Docker volumes

### Requirements

- :green_circle: Linux  host with:
    - :green_circle: KVM enabled (/dev/kvm should exist)
    - :green_circle: Docker installed
- :green_circle: ISO of desired OS to install (for initial installation)
- :green_circle: Modern web browser (for noVNC access)

## Installation

1. Clone the repository

```bash
git clone git@github.com:mkreutner/docker-qemu-os.git

cd docker-qemu-os

# Build Docker image for OS_NAME-VERSION-ARCH
just build <OS_NAME> <VERSION> <ARCH>

# Start installation of OS_NAME-VERSION-ARCH
just install <OS_NAME> <VERSION> <ARCH>

# Run OS_NAME-VERSION-ARCH
just run <OS_NAME> <VERSION> <ARCH>

# Run OS_NAME-VERSION-ARCH with CD Mounting
# By default mount install iso CD
just run-with-media <OS_NAME> <VERSION> <ARCH> [CD_ISO_NAME=./iso/os/OS_NAME.VERSION.ARCH.iso] 
```

## ISO naming convention

| Type | Directory | Naming convention |
|:-----|:----------|:------------------|
| Install | `./iso/os/` | `OS_NAME.VERSION.ARCH.iso` |
| Softwares | `./iso/software/` | `TOOL_NAME.VERSION.ARCH.iso` |

### Examples

| OS_NAME | VERSION | ARCH | File name | 
|:--------|:--------|:-----|:----------|
| Windows | 11      | x64  | windows.11.x64.iso |
| Windows | 11 24H2 | x64  | windows.11_24h2.x64.iso |
| Debian  | 13      | x64  | debian.13.x64.iso |
| Haiku   | R1 Beta5 | x86_64  | haiku.r1_beta5.x86_64.iso |
| MS SQL Server | 2019 | x64 | ms_sql_server.2019.x64.iso |

## Daily use

A little sample with 
* OS: `Haiku` 
* Version: `r1_beta5` 
* Arch: `x86_64`
* ISO: `./iso/os/haiku.r1_beta5.x86_64.iso`

```bash
# Build
just build haiku r1_beta5 x86_64
# Install mode
just install haiku r1_beta5 x86_64
# Run mode (without extra CD/Media)
just run haiku r1_beta5 x86_64
```

## Tested ISOs

* :green_circle: Windows 11 24H2 EN INT x64 (windows.11_24h4_en_int.x64.iso)
* :green_circle: Haiku R1 Beta5 x86_64 (haiku.r1_beta5.x86_64.iso)
* :red_circle:   BeOS 5 Personal Edition x86 (beos.5.personal_edition.x86): Unbootable CD (WIP)

## Usefull links

- [ArchiveOS](https://archiveos.org/)

