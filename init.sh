#!/bin/bash

# detects the OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unsupported OS: $OSTYPE"
        exit 1
    fi
}

os=$(detect_os)
if [[ "$os" == "macOS" ]]; then
    cd macos
    bash ./mac_init.sh
elif [[ "$os" == "linux" ]]; then
    cd linux
    bash ./linux_init.sh
fi
