{ delib, pkgs, ... }:
delib.module {
  name = "programs.vim";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      ((vim-full.override {  }).customize{
        name = "vim";
        vimrcConfig.customRC = ''
            set mouse=a
            set encoding=utf-8
            syntax on
            filetype plugin indent on

            set relativenumber
            set number

            set wrap
            set tabstop=4        " Number of spaces that a <Tab> in the file counts for
            set softtabstop=4    " Number of spaces that a <Tab> counts when editing
            set shiftwidth=4      " Number of spaces used for each step of (auto)indent
            set expandtab

            set ignorecase        " Ignore case when searching
            set smartcase         " Override ignorecase if search term contains uppercase letters
            set hlsearch          " Highlight search results
            set incsearch         " Show matches as you type

            set clipboard=unnamedplus
          '';
      }
    )];
  };
}
