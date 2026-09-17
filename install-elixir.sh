#!/usr/bin/env bash
#!/bin/bash

# Update apt and ensure the locales package is installed
apt-get update
apt-get install -y locales

# Generate the specific UTF-8 locale
locale-gen en_US.UTF-8
# Set the locale system-wide in /etc/default/locale
update-locale LANG=en_US.UTF-8

# Install and configure Elixir
curl -fsSO https://elixir-lang.org/install.sh
sh install.sh elixir@1.20.4 otp@28.4
cat >> ~/.bashrc <<'EOF'
installs_dir=$HOME/.elixir-install/installs
export PATH=$installs_dir/otp/28.4/bin:$PATH
export PATH=$installs_dir/elixir/1.20.4-otp-28/bin:$PATH
EOF
