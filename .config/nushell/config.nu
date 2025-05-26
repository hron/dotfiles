# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# source ./nu-scripts.nu
$env.NU_LIB_DIRS = ($env.NU_LIB_DIRS | default [] | append "/nix/store/8qna10fda99jk2a2vf0fiqzdsfmcf79p-nu_scripts-0-unstable-2025-03-13/share/nu_scripts")
