#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

sketchybar --set $NAME

if [ "$SELECTED" = "true" ]; then
  sketchybar -m --set $NAME icon.highlight=on background.drawing=on
else
  sketchybar -m --set $NAME icon.highlight=off background.drawing=off
fi
