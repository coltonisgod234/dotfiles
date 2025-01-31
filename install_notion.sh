echo "This script was meant for Arch Linux"
echo "you will need to manually install these on other distros"
echo "ENSURE YOU ARE RUNNING THIS SCRIPT AS ROOT"
read -n 1 -s -r -p "Press any key to install..."

function do_logout () {
	current_session_id=$(loginctl show-session $XDG_SESSION_ID -p Id --value)

	if [[ -n "$current_session_id" ]]; then
		echo "You are running a systemd system, terminating with loginctl..."
		loginctl terminate-session "$current_session_id"
	else
		echo "Unable to determine the active session ID!"
		echo "LAST RESORT: Attempting to kill Xorg server..."
		echo "IF YOUR WINDOW MANAGER FREEZES, GO TO A DIFFRENT TTY AND REBOOT"
		killall Xorg -9
	fi
	exit 0
}

function requirement () {
	if pacman -Q $1 ; then
		echo "OK"
		return 0
	else
		echo "Required package $1 isn't installed!"
		#read -n 1 -s -r -p "Press any key to install it."
		sudo pacman -S $1 --no-confirm
		return 0
	fi
}

function AURrequirement () {
	if yay -Q $1 ; then
		echo "OK"
		return 0
	else
		echo "Required package $1(AUR) isn't installed!"
		yay -S $1 --no-confirm
		return 0
	fi
}

function installed_check () {
	if test -d "$2"; then
		echo "The $1 dotfiles are already installed"
		echo "Did you mean to update them?"
		echo "Run \`install.sh upgrade\` if so"
		exit 1
	fi
	return 0
}

function notion_install () {
	echo "Checking requirements..."
	requirement "notion"
	requirement

	echo "Creating config directory..."
	mkdir -p ~/.notion/

	echo "Copying dotfiles..."
	cp notionwm/* ~/.notion

	echo "Creating notion.desktop xsession..."
	cp notion.desktop /usr/share/xsessions/notion.desktop

	echo "Copying this script..."
	cp install_notion.sh ~/.notion
	echo "(probably) Success!"
}

function notion_uninstall () {
	echo "Uninstalling Notion dotfiles..."
	echo "Uninstalling Notion..."
	pacman -Rns notion --no-confirm

	echo "Removing dotfiles..."
	rm -r ~/.notion/
	rmdir ~/.notion

	echo "Deleting notion.desktop xsession..."
	rm /usr/share/xsessions/notion.desktop
	echo "(hopefully) Success!"
}

function notion_upgrade () {
	echo "Upgrading Notion dotfiles..."
	echo "Pulling git repo"
	git pull
	echo "Removing dotfiles..."
	notion_uninstall
	echo "Reinstalling dotfiles..."
	notion_install
}

function logoff_prompt () {
	echo "Done! You must log off to apply the changes"
	read -n 1 -s -r -p "Press any key to log off..."
	do_logout
}

if test "$1" == "install" ; then
	installed_check "Notion" "~/.notion/"
	notion_install
	logoff_prompt
elif test "$1" == "uninstall" ; then
	notion_uninstall
	logoff_prompt
elif test "$1" == "upgrade" ; then
	notion_upgrade
	logoff_prompt
else
	echo -e "\n\n"
	echo "Usage: install.sh [subcommand]"
	echo "Subcommands:"
	echo "  install: install the dotfiles"
	echo "  uninstall: remove the dotfiles"
	echo "  upgrade: upgrade the dotfiles to a new version"
fi

