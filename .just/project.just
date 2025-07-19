# Build image for OS VM in docker
build OS_NAME VERSION ARCH TAG="latest":
    #!/usr/bin/env bash
    docker build \
        --tag {{OS_NAME}}-{{VERSION}}-{{ARCH}}:{{TAG}} \
        --file ./dockerfiles/Dockerfile.{{OS_NAME}} \
        .

# Install OS
install OS_NAME VERSION ARCH TAG="latest":
    #!/usr/bin/env bash
    docker run -it --rm \
        --name ctx-{{OS_NAME}}-{{VERSION}}-{{ARCH}}-{{TAG}} \
        --device /dev/kvm \
        -p 6080:6080 \
        -v ctx_{{OS_NAME}}_{{VERSION}}_{{ARCH}}_{{TAG}}_data:/data \
        -v $(pwd)/iso/os/{{OS_NAME}}.{{VERSION}}.{{ARCH}}.iso:/iso/os.iso \
        -v $(pwd)/scripts/install/{{OS_NAME}}.sh:/start.sh \
        -e DISK_NAME=disk_{{OS_NAME}}.qcow2 \
        {{OS_NAME}}-{{VERSION}}-{{ARCH}}:{{TAG}}

# Running OS
run OS_NAME VERSION ARCH TAG="latest":
    #!/usr/bin/env bash
    docker run -it --rm \
        --name ctx-{{OS_NAME}}-{{VERSION}}-{{ARCH}}-{{TAG}} \
        --device /dev/kvm \
        -p 6080:6080 \
        -v ctx_{{OS_NAME}}_{{VERSION}}_{{ARCH}}_{{TAG}}_data:/data \
        -v $(pwd)/scripts/run/{{OS_NAME}}.sh:/start.sh \
        -e DISK_NAME=disk_{{OS_NAME}}.qcow2 \
        {{OS_NAME}}-{{VERSION}}-{{ARCH}}:{{TAG}}

# Running OS with cd mounted
run-with-media OS_NAME VERSION ARCH TAG="latest":
    #!/usr/bin/env bash
    docker run -it --rm \
        --name ctx-{{OS_NAME}}-{{VERSION}}-{{ARCH}}-{{TAG}} \
        --device /dev/kvm \
        -p 6080:6080 \
        -v ctx_{{OS_NAME}}_{{VERSION}}_{{ARCH}}_{{TAG}}_data:/data \
        -v $(pwd)/iso/os/{{OS_NAME}}.{{VERSION}}.{{ARCH}}.iso:/iso/os.iso \
        -v $(pwd)/scripts/run/{{OS_NAME}}.sh:/start.sh {{OS_NAME}} \
        -e DISK_NAME=disk_{{OS_NAME}}.qcow2 \
        {{OS_NAME}}-{{VERSION}}-{{ARCH}}:{{TAG}}

# Rename volume
rename-volume OLD_NAME NEW_NAME:
    #!/usr/bin/env bash
    docker volume create {{NEW_NAME}}
    docker run -it --rm \
        -v {{OLD_NAME}}:/from \
        -v {{NEW_NAME}}:/to \
        alpine ash -c 'cd /from ; cp -av . /to'
    docker volume rm {{OLD_NAME}}

[private]
@help:
    echo ".:: Project Help ::."
    just --list --list-heading '' --list-prefix "    ↪ " --justfile {{justfile()}}

[private]
@setup:
    echo ".:: Project Setup ::."
    echo ">>> Nothing to do"
