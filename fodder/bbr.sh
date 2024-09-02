#!/usr/bin/env bash
#
# Auto install latest kernel for TCP BBR
#
# System Required:  Debian8+, Ubuntu16+
#
# Copyright (C) 2016-2021 Teddysun <i@teddysun.com>
#
# URL: https://teddysun.com/489.html
#

print_color() {
    local color_code="$1"
    local message="$2"
    printf "\033[1;${color_code}m%b\033[0m\n" "$message"
}

_info() {
    print_color "32" "[Info] $1"
}

_warn() {
    print_color "33" "[Warning] $1"
}

_error() {
    print_color "31" "[Error] $1"
    exit 1
}

_exists() {
    command -v "$1" >/dev/null 2>&1
}

_os() {
    [ -f "/etc/os-release" ] && source /etc/os-release && echo "${ID}"
}

_os_full() {
    [ -f /etc/os-release ] && awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release
}

_os_ver() {
    local main_ver="$(echo $(_os_full) | grep -oE "[0-9.]+")"
    echo "${main_ver%%.*}"
}

_error_detect() {
    _info "$1"
    eval "$1"
    [ $? -ne 0 ] && _error "Execution command ($1) failed, please check it and try again."
}

_is_64bit() {
    [ "$(getconf LONG_BIT)" = "64" ]
}

_version_ge() {
    test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"
}

get_latest_version() {
    latest_version=($(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/ | awk -F'\"v' '/v[4-9]./{print $2}' | cut -d/ -f1 | grep -v - | sort -V))
    [ ${#latest_version[@]} -eq 0 ] && _error "Get latest kernel version failed."
    kernel_arr=()
    for i in ${latest_version[@]}; do
        _version_ge $i 5.15 && kernel_arr+=($i)
    done
    kernel=${kernel_arr[-1]}
    if _is_64bit; then
        deb_name=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/ | grep "linux-image" | grep "generic" | awk -F'\">' '/amd64.deb/{print $2}' | cut -d'<' -f1 | head -1)
        deb_kernel_url="https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/${deb_name}"
        deb_kernel_name="linux-image-${kernel}-amd64.deb"
        modules_deb_name=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/ | grep "linux-modules" | grep "generic" | awk -F'\">' '/amd64.deb/{print $2}' | cut -d'<' -f1 | head -1)
        deb_kernel_modules_url="https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/${modules_deb_name}"
        deb_kernel_modules_name="linux-modules-${kernel}-amd64.deb"
    else
        deb_name=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/ | grep "linux-image" | grep "generic" | awk -F'\">' '/i386.deb/{print $2}' | cut -d'<' -f1 | head -1)
        deb_kernel_url="https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/${deb_name}"
        deb_kernel_name="linux-image-${kernel}-i386.deb"
        modules_deb_name=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/ | grep "linux-modules" | grep "generic" | awk -F'\">' '/i386.deb/{print $2}' | cut -d'<' -f1 | head -1)
        deb_kernel_modules_url="https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/${modules_deb_name}"
        deb_kernel_modules_name="linux-modules-${kernel}-i386.deb"
    fi
    [ -z "${deb_name}" ] && _error "Getting Linux kernel binary package name failed, maybe kernel build failed. Please choose other one and try again."
}

check_bbr_status() {
    [ "$(sysctl net.ipv4.tcp_congestion_control | awk '{print $3}')" == "bbr" ]
}

check_kernel_version() {
    _version_ge "$(uname -r | cut -d- -f1)" 4.9
}

check_os() {
    local os=$(_os)
    [ -z "$os" ] && _error "Not supported OS"
    case "$os" in
        ubuntu) [ "$(_os_ver)" -lt 16 ] && _error "Not supported OS, please change to Ubuntu 16+ and try again." ;;
        debian) [ "$(_os_ver)" -lt 8 ] && _error "Not supported OS, please change to Debian 8+ and try again." ;;
        *) _error "Not supported OS" ;;
    esac
}

sysctl_config() {
    sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
    sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
    echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
    sysctl -p >/dev/null 2>&1
}

install_kernel() {
    case "$(_os)" in
        ubuntu|debian)
            _info "Getting latest kernel version..."
            get_latest_version
            [ -n "${modules_deb_name}" ] && _error_detect "wget -c -t3 -T60 -O ${deb_kernel_modules_name} ${deb_kernel_modules_url}"
            _error_detect "wget -c -t3 -T60 -O ${deb_kernel_name} ${deb_kernel_url}"
            _error_detect "dpkg -i ${deb_kernel_modules_name} ${deb_kernel_name}"
            rm -f ${deb_kernel_modules_name} ${deb_kernel_name}
            _error_detect "/usr/sbin/update-grub"
            ;;
    esac
}


install_bbr() {
    check_bbr_status && _info "TCP BBR has already been enabled. nothing to do..."
    check_kernel_version && _info "The kernel version is greater than 4.9, directly setting TCP BBR..." && sysctl_config && _info "Setting TCP BBR completed..."
    check_os
    install_kernel
    sysctl_config
}

[[ $EUID -ne 0 ]] && _error "This script must be run as root"
opsy=$(_os_full)
arch=$(uname -m)
lbit=$(getconf LONG_BIT)
kern=$(uname -r)

echo "---------- System Information ----------"
echo " OS      : $opsy"
echo " Arch    : $arch ($lbit Bit)"
echo " Kernel  : $kern"
echo "----------------------------------------"
echo " Automatically enable TCP BBR script"
echo
echo " URL: https://teddysun.com/489.html"
echo "----------------------------------------"
echo

install_bbr 2>&1 | tee /etc/xray/install_bbr.log
