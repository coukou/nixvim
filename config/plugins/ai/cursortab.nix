{ pkgs
, ...
}:
let
  pname = "cursortab.nvim";
  version = "778a80aeee1b24304ce03dd9ae849d64173ab6ec";

  src = pkgs.fetchFromGitHub {
    owner = "leonardcser";
    repo = pname;
    rev = version;
    hash = "sha256-L/rqUyleUZFSmKIq0b5O018+kQG21rkENuwS2tJpkn4=";
  };

  # 1. Build the Go Server component
  cursortab-server = pkgs.buildGoModule {
    inherit pname version;
    src = "${src}/server";
    vendorHash = "sha256-IvJw+89eZ5Ghppjt0KT9IRL8XPyU6XbiAYL3axQO6u4=";
    postInstall = ''
      mv $out/bin/server $out/bin/cursortab-server || true
    '';
  };

in
{
  extraPlugins = [
    (
      pkgs.vimUtils.buildVimPlugin {
        inherit pname version src;

        postInstall = ''
          mkdir -p $out/server
          ln -s ${cursortab-server}/bin/cursortab $out/server/cursortab
        '';

        meta = with pkgs.lib; {
          description = "Smarter tab behavior for Neovim with a Go backend";
          homepage = "https://github.com/leonardcser/cursortab.nvim";
          license = licenses.mit;
        };
      }
    )
  ];

  extraConfigLua = ''
    require("cursortab").setup({
      enabled = true,
      log_level = "info",  -- "trace", "debug", "info", "warn", "error"
      state_dir = vim.fn.stdpath("state") .. "/cursortab",  -- Directory for runtime files (log, socket, pid)

      keymaps = {
        accept = "<Tab>",           -- Keymap to accept completion, or false to disable
        partial_accept = "<S-Tab>", -- Keymap to partially accept, or false to disable
        trigger = false,            -- Keymap to manually trigger completion, or false to disable
      },

      ui = {
        completions = {
          addition_style = "dimmed",  -- "dimmed" or "highlight"
          fg_opacity = 0.6,           -- opacity for completion overlays (0=invisible, 1=fully visible)
        },
        jump = {
          symbol = "",              -- Symbol shown for jump points
          text = " TAB ",            -- Text displayed after jump symbol
          show_distance = true,      -- Show line distance for off-screen jumps
        },
      },

      behavior = {
        idle_completion_delay = 50,  -- Delay in ms after idle to trigger completion (-1 to disable)
        text_change_debounce = 50,   -- Debounce in ms after text change to trigger completion (-1 to disable)
        max_visible_lines = 12,      -- Max visible lines per completion (0 to disable)
        enabled_modes = { "insert", "normal" },  -- Modes where completions are active
        cursor_prediction = {
          enabled = true,            -- Show jump indicators after completions
          auto_advance = true,       -- When no changes, show cursor jump to last line
          proximity_threshold = 2,   -- Min lines apart to show cursor jump (0 to disable)
        },
        ignore_paths = {             -- Glob patterns for files to skip completions
          "*.min.js",
          "*.min.css",
          "*.map",
          "*-lock.json",
          "*.lock",
          "*.sum",
          "*.csv",
          "*.tsv",
          "*.parquet",
          "*.zip",
          "*.tar",
          "*.gz",
          "*.pem",
          "*.key",
          ".env",
          ".env.*",
          "*.log",
        },
        ignore_gitignored = true,    -- Skip files matched by .gitignore
      },

      provider = {
        type = "sweep",
        url = "http://localhost:10001",
        model = "sweep/next-edit-1.5",
        completion_path = "/v1/completions",
        privacy_mode = true,                
      },

      blink = {
        enabled = false,    -- Enable blink source
        ghost_text = true,  -- Show native ghost text alongside blink menu
      },

      debug = {
        immediate_shutdown = false,  -- Shutdown daemon immediately when no clients
      },
    })
  '';

  autoCmd = [
    {
      event = [ "BufEnter" ];
      pattern = "*";
      callback = {
        __raw = ''
          function(args)
            local daemon = require("cursortab.daemon")
            if not daemon then return end

            if vim.bo.filetype == "oil" then
              daemon.set_enabled(false)
            else
              daemon.set_enabled(true)
            end
          end
        '';
      };
    }
  ];

}
