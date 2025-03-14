{ lib, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "llama";
  packPathName = "llama-vim.nvim";
  package = "llama-vim";
  moduleName = "llama.vim";

  maintainers = [ ];

  settingsOptions = { };
  settingsExample = { };

  callSetup = false;
}
