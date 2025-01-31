#!/bin/bash

function getroot() {
	sudo -k
	sudo -v

	while true; do
		sleep 60
		sudo -v
	done &
	SUDOPID=$!
}

function droproot() {
	sudo -k
	kill "$SUDOPID"
	unset SUDOPID
}

function log() {
	echo "[$1]	$2"
}

function StripDebug () {
	sudo rm -rf /usr/lib/debug/.build-id/
}

function cleanup() {
	droproot
	killall sleep
	exit 0
}

function PromptReboot () {
	read -p "$1" answer
	case "$answer" in
		[Yy]* )
			echo "Rebooting..."
			reboot
			;;
		[Nn]* )
			echo "Exiting..."
			cleanup
			;;
		* )
			prompt_reboot
			;;
	esac
}

function cmd() {
	echo "> $1"
	$1
}

getroot

log phase "Starting core upgrade..."
log step "Clearing cache..."
cmd "sudo pacman -Scc --noconfirm"

log step "Rredownloading..."
cmd "sudo pacman -Syy --noconfirm"

log step "Running full system upgrade..."
cmd "sudo pacman -Syu --noconfirm"

# This just prevents some stupid conflics
log step "Removing debug symbols..."
StripDebug

log phase "Starting AUR upgrade"
log step "Clear yay buildcache"
cmd "yay -Scc --noconfirm"

log step "Starting AUR upgrade..."
cmd "yay -Syu --noconfirm"

log step "Starting flatpak upgrade..."
cmd "flatpak upgrade -y"

log phase "Cleanup and finishing touches"

log step "Regenerate initcpio..."
cmd "sudo mkinitcpio -P"

log step "Rerunning reflector..."
cmd "sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist"

log step "Removing orphans..."
cmd "sudo pacman -Rns $(pacman -Qdtq) --noconfirm"

log step "Removing lingering units..."
cmd "sudo systemctl reset-failed"
cmd "sudo systemctl daemon-reload"

log step "Regenerating locale..."
cmd "sudo locale-gen"

log phase "DONE!"
droproot

PromptReboot "Would you like to reboot? (Yn)"
