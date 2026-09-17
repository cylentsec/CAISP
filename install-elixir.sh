#!/usr/bin/env bash
#!/bin/bash

# Update apt and ensure the locales package is installed
apt-get update
apt-get install -y locales

#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# 1. Update and install locales without sudo
apt-get update
apt-get install -y locales

# 2. Uncomment en_US.UTF-8 in the configuration file
sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen

# 3. Generate the uncommented locale
locale-gen

# 4. Set the system-wide locale (applies to standard users/services)
update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# 5. Force the locale for the root user's environment
echo 'export LANG=en_US.UTF-8' >> /root/.bashrc
echo 'export LC_ALL=en_US.UTF-8' >> /root/.bashrc
source /root/.bashrc

# Install and configure Elixir
curl -fsSO https://elixir-lang.org/install.sh
sh install.sh elixir@1.20.4 otp@28.4
cat >> ~/.bashrc <<'EOF'
installs_dir=$HOME/.elixir-install/installs
export PATH=$installs_dir/otp/28.4/bin:$PATH
export PATH=$installs_dir/elixir/1.20.4-otp-28/bin:$PATH
EOF
