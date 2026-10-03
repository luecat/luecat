#!/usr/bin/env bash
# Orange Pi 3B 診斷腳本：只讀取資訊，不修改系統。
# 用法：sudo bash diag.sh
# 輸出：目前目錄下的 diag-<時間>.txt

OUT="diag-$(date +%Y%m%d-%H%M%S).txt"

section() {
	printf '\n==================== %s ====================\n' "$1"
}

# 執行指令並印出指令本身；失敗也繼續
run() {
	printf '\n$ %s\n' "$*"
	bash -c "$*" 2>&1
}

# 印出檔案內容；不存在就略過
show() {
	local f
	for f in "$@"; do
		[ -r "$f" ] || continue
		printf '%s: ' "$f"
		tr -d '\0' < "$f"
		echo
	done
}

collect() {
	section "基本資訊"
	run "date"
	[ "$(id -u)" -eq 0 ] || echo "注意：沒有用 sudo 執行，部分資訊（dmesg、時脈）會讀不到"
	show /proc/device-tree/model /proc/device-tree/compatible
	run "uname -a"
	run "cat /etc/os-release"
	run "cat /etc/armbian-release"
	run "grep -E 'fdtfile|overlays|extraargs' /boot/armbianEnv.txt"
	run "cat /proc/cmdline"
	run "free -h"

	section "儲存裝置和開機"
	run "lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS"
	run "findmnt /"
	run "cat /proc/mtd"

	section "顯示"
	local c
	for c in /sys/class/drm/card*-*; do
		[ -d "$c" ] || continue
		echo
		echo "--- $(basename "$c") ---"
		show "$c/status" "$c/enabled"
		[ -r "$c/modes" ] && { echo "modes:"; cat "$c/modes"; }
	done
	run "dmesg | grep -iE 'drm|vop|hdmi|underflow|post_buf_empty|edid' | tail -n 80"
	if [ -r /sys/kernel/debug/clk/clk_summary ]; then
		run "grep -iE 'dclk|hdmi|vpll|hpll|gpll|cpll' /sys/kernel/debug/clk/clk_summary"
	else
		echo "讀不到時脈資訊（需要 sudo，且 debugfs 要掛載在 /sys/kernel/debug）"
	fi

	section "桌面工作階段"
	run "loginctl list-sessions --no-legend"
	local s
	for s in $(loginctl list-sessions --no-legend 2>/dev/null | awk '{print $1}'); do
		run "loginctl show-session $s -p Type -p Desktop -p Name -p State"
	done

	section "devfreq（DDR、GPU、NPU 調頻）"
	local d
	for d in /sys/class/devfreq/*; do
		[ -d "$d" ] || continue
		echo
		echo "--- $(basename "$d") ---"
		show "$d/name" "$d/governor" "$d/cur_freq" "$d/available_frequencies" "$d/min_freq" "$d/max_freq"
	done

	section "GPU"
	run "lsmod | grep -iE 'panfrost|mali|bifrost|kbase'"
	run "ls -l /dev/dri /dev/mali* 2>/dev/null"
	run "dmesg | grep -iE 'panfrost|mali' | tail -n 30"

	section "NPU"
	run "lsmod | grep -iE 'rknpu|rocket'"
	run "ls -l /dev/accel 2>/dev/null"
	show /sys/kernel/debug/rknpu/version /sys/kernel/debug/rknpu/load
	run "dmesg | grep -iE 'rknpu|rocket|npu' | tail -n 30"

	section "網路"
	run "ip -br link"
	run "ip -br addr"
	run "lsmod | grep -iE 'brcmfmac|bcmdhd|sprd|uwe|bluetooth'"
	run "dmesg | grep -iE 'brcmfmac|bcmdhd|sprd|uwe|stmmac|dwmac|yt8531' | tail -n 30"

	section "溫度"
	local z
	for z in /sys/class/thermal/thermal_zone*; do
		[ -r "$z/temp" ] || continue
		echo "$(cat "$z/type"): $(( $(cat "$z/temp") / 1000 ))°C"
	done

	section "最近的核心錯誤"
	run "dmesg --level=err,warn | tail -n 60"
}

collect | tee "$OUT"
echo
echo "已存到 $OUT，把整個檔案內容貼給 Claude。"
