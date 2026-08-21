#!/usr/bin/env bash

#// Check if wlogout is already running

if pgrep -x "wlogout" >/dev/null; then
    pkill -x "wlogout"
    exit 0
fi

#// set file variables

scrDir=$(dirname "$(realpath "$0")")
# shellcheck disable=SC1091
source "$scrDir/globalcontrol.sh"
[ -n "${1}" ] && wlogoutStyle="${1}"
wlogoutStyle=${wlogoutStyle:-$WLOGOUT_STYLE}
confDir="${confDir:-$HOME/.config}"
wLayout="${confDir}/wlogout/layout_${wlogoutStyle}"
wlTmplt="${confDir}/wlogout/style_${wlogoutStyle}.css"
echo "wlogoutStyle: ${wlogoutStyle}"
echo "wLayout: ${wLayout}"
echo "wlTmplt: ${wlTmplt}"

if [ ! -f "${wLayout}" ] || [ ! -f "${wlTmplt}" ]; then
    echo "ERROR: Config ${wlogoutStyle} not found..."
    wlogoutStyle=1
    wLayout="${confDir}/wlogout/layout_${wlogoutStyle}"
    wlTmplt="${confDir}/wlogout/style_${wlogoutStyle}.css"
fi

#// detect monitor res

# supports Hyprland and niri; falls back to a sane default
if [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ] && command -v hyprctl >/dev/null; then
    read -r x_mon y_mon hypr_scale < <(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | "\(.width) \(.height) \(.scale * 100 | round)"')
elif [ -n "${NIRI_SOCKET}" ] && command -v niri >/dev/null; then
    read -r x_mon y_mon hypr_scale < <(niri msg -j focused-output | jq -r '.logical | "\(.width) \(.height) \(.scale * 100 | round)"')
elif command -v wlr-randr >/dev/null; then
    read -r x_mon y_mon < <(wlr-randr --json | jq -r '[.[] | select(.enabled==true)][0] | (.modes[] | select(.current==true)) | "\(.width) \(.height)"')
    hypr_scale=100
fi

x_mon=${x_mon:-1920}
y_mon=${y_mon:-1080}
hypr_scale=${hypr_scale:-100}
[ "${hypr_scale}" -gt 0 ] 2>/dev/null || hypr_scale=100
#// scale config layout and style

case "${wlogoutStyle}" in
1)
    wlColms=6
    export mgn=$((y_mon * 28 / hypr_scale))
    export hvr=$((y_mon * 23 / hypr_scale))
    ;;
2)
    wlColms=2
    export x_mgn=$((x_mon * 35 / hypr_scale))
    export y_mgn=$((y_mon * 25 / hypr_scale))
    export x_hvr=$((x_mon * 32 / hypr_scale))
    export y_hvr=$((y_mon * 20 / hypr_scale))
    ;;
esac

#// scale font size

export fntSize=$((y_mon * 2 / 100))

#// detect wallpaper brightness

cacheDir="${HYDE_CACHE_HOME}"
dcol_mode="${dcol_mode:-dark}"
# shellcheck disable=SC1091
[ -f "${cacheDir}/wall.dcol" ] && source "${cacheDir}/wall.dcol"

#  Theme mode: detects the color-scheme set in hypr.theme and falls back if nothing is parsed.
enableWallDcol="${enableWallDcol:-1}"
if [ "${enableWallDcol}" -eq 0 ]; then
    HYDE_THEME_DIR="${HYDE_THEME_DIR:-$confDir/hyde/themes/$HYDE_THEME}"
    dcol_mode=$(get_hyprConf "COLOR_SCHEME")
    dcol_mode=${dcol_mode#prefer-}
    # shellcheck disable=SC1091
    [ -f "${HYDE_THEME_DIR}/theme.dcol" ] && source "${HYDE_THEME_DIR}/theme.dcol"
fi
{ [ "${dcol_mode}" == "dark" ] && export BtnCol="white"; } || export BtnCol="black"

#// eval hypr border radius

hypr_border="${hypr_border:-10}"
export active_rad=$((hypr_border * 5))
export button_rad=$((hypr_border * 8))

#// eval config files

wlStyle="$(envsubst <"${wlTmplt}")"

#// launch wlogout

wlogout -b "${wlColms}" -c 0 -r 0 -m 0 --layout "${wLayout}" --css <(echo "${wlStyle}") --protocol layer-shell
