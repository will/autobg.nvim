Use github.com/will/bgwinch.nvim instead since neovim 0.7


# autobg.nvim

This plugin syncs the background option in neovim to match the macOS appearance.

![autobg](https://user-images.githubusercontent.com/1973/161821177-bbb7e9cb-554b-4bdc-937b-438ce5f39a5d.gif)

It assumes that if you're on a mac you have `swiftc` installed from xcode commandline tools or something, and compiles a very small program that listens for appearance changes and notifies neovim.

It also depends on [plenary.nvim](https://github.com/nvim-lua/plenary.nvim).

## Packer

```lua
use {
  "will/autobg.nvim",
  config = function()
    require("autobg").setup()
  end,
}
```

### Todo

I couldn't figure out a good way to ensure that the helper program exits in all cases when neovim exists, and opened [an issue](https://github.com/nvim-lua/plenary.nvim/issues/328) about that. In the meantime, the helper program prints to stdout once a minute, and will get killed with SIGPIPE if the parent neovim process is gone.
