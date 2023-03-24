if [ -d ~/.config/nvim ]; then
  echo "~/.config/nvim exist already."
  exit 1
else
  SCRIPT=$(readlink -f "$0")
  DIR=$(dirname "$SCRIPT")
  mkdir -p ~/.config
  cd ~/.config
  ln -s $DIR/nvim nvim
fi

sudo pacman -S --needed -y the_silver_searcher ripgrep ccls yarn python-pip go

pip install --upgrade neovim neovim-remote
