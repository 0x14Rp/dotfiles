#!/usr/bin/env bash

# Compositor-agnostic session actions. wlogout runs its "action" through sh -c,
# so this script is invoked by absolute path from the layouts.

scrDir="$(dirname "$(realpath "$0")")"

lock() {
    # HyDE defines LOCKSCREEN in its runtime; honour it when available.
    if [ -r "${HYDE_RUNTIME_DIR:-$XDG_RUNTIME_DIR/hyde}/environment" ]; then
        exec "${scrDir}/lockscreen.sh" "${@}"
    fi
    for locker in hyprlock swaylock; do
        command -v "${locker}" >/dev/null && exec "${locker}"
    done
    exec loginctl lock-session
}

logout() {
    if [ -n "${NIRI_SOCKET}" ] && command -v niri >/dev/null; then
        exec niri msg action quit --skip-confirmation
    fi
    if [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ] && command -v hyprctl >/dev/null; then
        exec hyprctl dispatch exit 0
    fi
    exec loginctl terminate-session "${XDG_SESSION_ID:-self}"
}

case "${1}" in
lock) shift && lock "${@}" ;;
logout) logout ;;
suspend)
    lock &
    disown
    sleep 1
    exec systemctl suspend
    ;;
*)
    echo "usage: $(basename "$0") {lock|logout|suspend}" >&2
    exit 1
    ;;
esac
