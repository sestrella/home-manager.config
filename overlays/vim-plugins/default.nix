final: prev: {
  vimPlugins = prev.vimPlugins // {
    auto-dark-mode-nvim = prev.vimUtils.buildVimPlugin {
      name = "auto-dark-mode.nvim";
      src = prev.fetchFromGitHub {
        owner = "f-person";
        repo = "auto-dark-mode.nvim";
        rev = "97a86c9402c784a254e5465ca2c51481eea310e3";
        hash = "sha256-zedwqG5PeJiSAZCl3GeyHwKDH/QjTz2OqDsFRTMTH/A=";
      };
    };
  };
}
