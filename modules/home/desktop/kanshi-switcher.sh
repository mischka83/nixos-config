#!/usr/bin/env bash
# Kanshi profile switcher menu for fuzzel/wofi.

KANSHICTL_BIN="$(command -v kanshictl 2>/dev/null || true)"
if [ -z "$KANSHICTL_BIN" ] && [ -x "/etc/profiles/per-user/$USER/bin/kanshictl" ]; then
  KANSHICTL_BIN="/etc/profiles/per-user/$USER/bin/kanshictl"
fi

FUZZEL_BIN="$(command -v fuzzel 2>/dev/null || true)"
if [ -z "$FUZZEL_BIN" ] && [ -x "/run/current-system/sw/bin/fuzzel" ]; then
  FUZZEL_BIN="/run/current-system/sw/bin/fuzzel"
fi

if [ -z "$KANSHICTL_BIN" ] || [ -z "$FUZZEL_BIN" ]; then
  exit 1
fi

status=$("$KANSHICTL_BIN" status 2>/dev/null)
current=$(printf '%s\n' "$status" | sed -n 's/.*"current_profile":"\([^"]*\)".*/\1/p')

# Get list of profiles from config
profiles=$(sed -n 's/^profile \([^ ]\+\) {$/\1/p' ~/.config/kanshi/config 2>/dev/null)

if [ -z "$profiles" ]; then
  echo "No profiles found in ~/.config/kanshi/config"
  exit 1
fi

# Show menu with fuzzel, mark current profile
selected=$(printf '%s\n' "$profiles" | while read -r profile; do
  if [ "$profile" = "$current" ]; then
    echo "✓ $profile"
  else
    echo "$profile"
  fi
done | "$FUZZEL_BIN" --dmenu)

if [ $? -ne 0 ]; then
  exit 0
fi

if [ -n "$selected" ]; then
  # Remove the checkmark if present
  profile=$(echo "$selected" | sed 's/^✓ //')
  "$KANSHICTL_BIN" switch "$profile"
fi
