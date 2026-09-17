# CAISP
CAISP scripts

Install Elixir:

```
curl -fsSO https://elixir-lang.org/install.sh
sh install.sh elixir@1.20.4 otp@28.4
cat > ~/.bashrc <<'EOF'
installs_dir=$HOME/.elixir-install/installs
export PATH=$installs_dir/otp/28.4/bin:$PATH
export PATH=$installs_dir/elixir/1.20.4-otp-28/bin:$PATH
EOF
```

