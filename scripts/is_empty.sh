#!/bin/bash
query=".nodes | .[] | .nodes |.[] | select(.name == \"$1\") | .nodes | length"
test=$(swaymsg -rt get_tree | jq "$query")
[[ $test == "0" ]]

