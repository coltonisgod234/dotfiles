#!/usr/bin/zsh
set -x

#wallpaper_folder="$HOME/"
wallpaper_folder="$HOME/.config/colton-dfiles/wallpapers"
temp_file="/tmp/desktop_background_modulated"

# Execute if you want random wallpaper (not default)
function random_wall () {
	rm "$temp_file"
	random_image=$(find "$wallpaper_folder" -type f \( -iname \*.jpg -o -iname \*.png \) | shuf -n 1)
	echo "$random_image"
	convert "$random_image" \
		-colorspace RGB \
		-modulate 100,130,90 \
		-normalize \
		"$temp_file"

	wal -i "$temp_file" --backend haishouku --contrast 1.5 -n
	$HOME/.config/hypr/scripts/reload_dunst_cols.sh  # Reload dunst
	pkill -USR1 -x kitty  # Reload kitty

	hyprctl hyprpaper reload ,"$random_image"
}

function main_wall () {
	random_image="$wallpaper_folder/main.jpg"
	echo "$random_image"
	magick "$random_image" \
		-colorspace RGB \
		-modulate 100,130,90 \
		-normalize \
		"$temp_file"

	wal -i "$temp_file" --backend haishouku --contrast 1.5 -n
	$HOME/.config/hypr/scripts/reload_dunst_cols.sh  # Reload dunst
	pkill -USR1 -x kitty  # Reload kitty

	echo "This command will fail if you're installing the dotfiles"
	hyprctl hyprpaper reload ,"$random_image"
}

# Removed for dotfile install
# Wait until Hyprpaper is fully up
#while ! pidof hyprpaper; do
#    sleep 0.1
#done
main_wall

