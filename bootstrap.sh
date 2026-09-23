#!/usr/bin/env bash
set -euo pipefail

SETUP_REPO="Egiss-IT-as-expected/egiss-dev-setup"
SETUP_DIR="$HOME/projects/egiss-dev-setup"

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools, accept the dialog and wait for it to finish"
  xcode-select --install
  until xcode-select -p >/dev/null 2>&1; do sleep 5; done
fi

BREW=/opt/homebrew/bin/brew
[ "$(uname -m)" = "x86_64" ] && BREW=/usr/local/bin/brew
if [ ! -x "$BREW" ]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$("$BREW" shellenv)"
touch "$HOME/.zprofile"
grep -q 'brew shellenv' "$HOME/.zprofile" || echo "eval \"\$($BREW shellenv)\"" >> "$HOME/.zprofile"

for t in gh ansible; do command -v "$t" >/dev/null || brew install "$t"; done

if ! gh auth status >/dev/null 2>&1; then
  echo "Logging in to GitHub, you need access to the $SETUP_REPO repository"
  gh auth login --hostname github.com --git-protocol https --web --scopes user:email
fi
gh auth setup-git

if [ ! -d "$SETUP_DIR/.git" ]; then
  mkdir -p "$(dirname "$SETUP_DIR")"
  gh repo clone "$SETUP_REPO" "$SETUP_DIR"
fi

cd "$SETUP_DIR"
exec ansible-playbook setup.yml --ask-become-pass
