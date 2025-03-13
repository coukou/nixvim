{ lib, ... }:
let
  inherit (lib.nixvim) defaultNullOpts mkNullOrOption';
in
lib.nixvim.plugins.mkNeovimPlugin {
  name = "minuet-ai";
  packPathName = "minuet-ai.nvim";
  package = "minuet-ai-nvim";
  moduleName = "minuet";

  maintainers = [ ];

  settingsOptions = { };
  settingsExample = { };
}
