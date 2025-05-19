#!/usr/bin/env bash
address=$(hyprctl -j clients | jq -r 'sort_by(.focusHistoryID) | .[] | select(.workspace.id >= 0) | "\(.address)\ton \(.workspace.id)    \(.title)"' |
	      fzf --color prompt:green,pointer:green,current-bg:-1,current-fg:green,gutter:-1,border:bright-black,current-hl:red,hl:red \
		  --cycle \
		  --sync \
		  --bind tab:down,shift-tab:up,start:down,double-click:ignore \
		  --wrap \
		  --delimiter=$'\t' \
		  --with-nth=2 \
		  --layout=reverse |
	      awk -F"\t" '{print $1}')

if [ -n "$address" ] ; then
    hyprctl -q dispatch focuswindow address:$address
fi

hyprctl -q dispatch submap reset
