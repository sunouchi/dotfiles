# Homebrew packages.
#
# Install with:  brew bundle install --file=Brewfile
#
# Language runtimes (node / python / ruby) are managed via mise, not here.

tap "rcmdnk/file"

# -- Language runtime manager (replaces nvm / rbenv / pyenv) --
brew "mise"

# -- Python package manager (fast pip replacement) --
brew "uv"

# -- GitHub CLI --
brew "gh"

# -- Container runtime (CLI) --
brew "docker"

# -- Git --
brew "git"
brew "git-lfs"

# -- Terminal workflow --
brew "neovim"
brew "tmux"
brew "tree"
brew "htop"
brew "fzf"
brew "glow"                # Markdown preview in terminal
brew "direnv"
brew "coreutils"
brew "reattach-to-user-namespace"
brew "tree-sitter"
brew "rsync"               # macOS 標準の openrsync は iCloud ファイルの mmap 読みで失敗する（akebia intake が使用）

# -- Build toolchain --
brew "cmake"
brew "autoconf"
brew "automake"
brew "pkgconf"
brew "m4"
brew "libtool"

# -- Web dev (WordPress etc.) --
brew "php"
brew "mysql"

# -- Crypto / network essentials --
brew "openssl@3"
brew "ca-certificates"
brew "curl"
brew "wget"

# -- Storage / compression --
brew "sqlite"
brew "readline"
brew "xz"
brew "zstd"
brew "brotli"
brew "lz4"

# -- Image/font base libs (explicit to guarantee a minimal toolchain) --
brew "jpeg"
brew "jpeg-turbo"
brew "libpng"
brew "libtiff"
brew "webp"
brew "freetype"

# -- Text layout engine (required by WeasyPrint to render PDFs) --
# NOTE: WeasyPrint dlopen()s these, so the Python interpreter must match the
# library architecture (arm64). The x86_64 Python from mise cannot load them.
brew "pango"

# -- Brewfile management (so this file itself is maintainable) --
brew "rcmdnk/file/brew-file"

# -- GCP --
cask "gcloud-cli"

# -- GUI apps --
# Claude Code (CLI) は cask ではなく公式インストーラで入れる。README 参照。
cask "google-chrome"
cask "claude"              # Claude Desktop
cask "bettertouchtool"
cask "speedtest"           # Speedtest by Ookla
cask "visual-studio-code"
