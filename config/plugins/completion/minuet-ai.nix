{ helpers, ... }:
{
  plugins.minuet-ai = {
    enable = false;

    settings = {

      virtualtext = {
        auto_trigger_ft = [
          "typescript"
        ];
        keymap = {
          accept = "<A-A>";
          accept_line = "<A-a>";
          accept_n_lines = "<A-z>";
          prev = "<A-[>";
          next = "<A-]>";
          dismiss = "<A-e>";
        };
      };

      provider = "openai_fim_compatible";
      n_completions = 1;

      context_window = 1024;
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM";
          name = "Llama.cpp";
          end_point = "http://localhost:8012/v1/completions";
          model = "Qwen2.5-Coder-3B-Q8_0";
          optional = {
            max_tokens = 128;
            top_p = 0.9;
          };
          template = {
            prompt = helpers.mkRaw ''
              function(context_before_cursor, context_after_cursor)
                  return '<|fim_prefix|>'
                      .. context_before_cursor
                      .. '<|fim_suffix|>'
                      .. context_after_cursor
                      .. '<|fim_middle|>'
              end
            '';
            suffix = false;
          };
        };
      };
    };
  };
}
