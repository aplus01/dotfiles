#!/bin/bash

# Get list of available audio sinks with descriptions
sinks_list=$(pactl list sinks | awk '
    /Name:/ {name=$2}
    /Description:/ {
        desc=$0
        sub(/.*Description: /, "", desc)
        if (name && desc) {
            print name "|" desc
            name=""
            desc=""
        }
    }
')

# Get current default sink
current_sink=$(pactl get-default-sink)

# Build menu entries
menu_entries=""
while IFS='|' read -r sink_name sink_desc; do
  if [ "$sink_name" = "$current_sink" ]; then
    menu_entries="${menu_entries}● ${sink_desc}\n"
  else
    menu_entries="${menu_entries}  ${sink_desc}\n"
  fi
done <<<"$sinks_list"

# Remove trailing newline
menu_entries=$(echo -e "$menu_entries" | sed '$d')

# Use rofi to select
selected=$(echo -e "$menu_entries" | rofi -dmenu -i -p "Audio Output")

# Exit if no selection made
if [ -z "$selected" ]; then
  exit 0
fi

# Remove the bullet point and leading spaces
selected=$(echo "$selected" | sed 's/^[ ●]*//')

# Find the sink name that matches the selected description
selected_sink=""
while IFS='|' read -r sink_name sink_desc; do
  if [ "$sink_desc" = "$selected" ]; then
    selected_sink="$sink_name"
    break
  fi
done <<<"$sinks_list"

# Set the new default sink
if [ -n "$selected_sink" ]; then
  pactl set-default-sink "$selected_sink"

  # Move all currently playing streams to the new sink
  pactl list short sink-inputs | awk '{print $1}' | while read stream; do
    pactl move-sink-input "$stream" "$selected_sink"
  done

  # Send notification
  if command -v notify-send &>/dev/null; then
    notify-send "Audio Output Switched" "$selected" -i audio-speakers -t 2000
  fi
fi
