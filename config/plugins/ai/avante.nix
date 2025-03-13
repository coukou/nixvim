{
  plugins.avante = {
    enable = true;

    settings = {
      provider = "qwen-llama-cpp";

      vendors = {
        qwen-llama-cpp = {
          __inherited_from = "openai";
          api_key_name = "TERM";
          endpoint = "http://127.0.0.1:1234/v1";
          model = "qwen2.5-coder-7b-instruct";
          disable_tools = true;
        };
      };
    };
  };
}
