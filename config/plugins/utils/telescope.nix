{ pkgs, ... }:
{
  extraPackages = [ pkgs.ripgrep ];
  plugins.telescope = {
    enable = true;

    settings = { };

    keymaps = {
      "<leader>fd" = {
        action = "diagnostics";
        options.desc = "[Find] Diagnostics";
      };
      "<leader>ff" = {
        action = "find_files";
        options.desc = "[Find] Files";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "[Find] Buffers";
      };
      "<leader>fw" = {
        action = "live_grep";
        options.desc = "[Find] Live Grep";
      };
      "<leader>fgb" = {
        action = "git_branches";
        options.desc = "[Find] Git Branches";
      };
      "<leader>fgc" = {
        action = "git_commits";
        options.desc = "[Find] Git Commits";
      };
      "<leader>fgs" = {
        action = "git_status";
        options.desc = "[Find] Git Status";
      };
      "<leader>fs" = {
        action = "lsp_document_symbols";
        options.desc = "[Find] LSP Symbols";
      };
      "<leader>fS" = {
        action = "lsp_workspace_symbols";
        options.desc = "[Find] LSP workspace symbols";
      };
    };
  };
}
