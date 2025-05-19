FILE=~/Pictures/Screenshots/screenshot_$(date +%s).png
grim -g "$(slurp)" "$FILE" && wl-copy < "$FILE"
notify-send "Took a screenshot and copied to clipboard!" -i "$FILE" "$FILE"
