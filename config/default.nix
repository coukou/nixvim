{
  imports = [
    ./autocommands.nix
    ./keys.nix
    ./settings.nix

    ./plugins/completion/blink.nix
    ./plugins/git/gitsigns.nix
    ./plugins/lsp/conform.nix
    ./plugins/lsp/lsp.nix
    ./plugins/mini
    ./plugins/snacks
    ./plugins/treesitter
    ./plugins/ui/lualine.nix
    ./plugins/utils/comment.nix
    ./plugins/utils/telescope.nix
    ./plugins/utils/whichkey.nix
    ./plugins/utils/oil.nix
    ./plugins/utils/yazi.nix
    ./plugins/utils/diffview.nix
  ];

  options = { };

  config = { };
}
