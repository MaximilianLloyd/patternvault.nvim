
<div align="center">

# PatternVault.nvim
##### Persist your favorite patterns, use and manage them with ease.

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
</div>

![PatternVault](patternvault_logo.png)

## ⇁  WIP
This is not fully baked. I've made a minimal version to validate the idea. If you experience any
issues, see some improvement you think would be amazing, or just have some
feedback for me , make an issue!

The format may change later if/when more advanced functionality is added.


## ⇁ The Problem:
You're working on a big codebase and write a clever search and replace pattern, but you change machines or lose track of it somehow. Darn it!


## ⇁ The Solution:
The ability to persist your patterns and access them easily with a human-readable name.


## ⇁ Installation:

* Install using your favorite plugin manager.

### Packer
```lua
use({
    "MaximilianLloyd/patternvault.nvim",
    branch = "main",
    config = function()
        require("patternvault").setup({})
    end,
})
```


### Lazy
```lua
{
    "MaximilianLloyd/patternvault.nvim",
    event = "VeryLazy", -- Customize here as wanted
    config = function() 
        require("patternvault").setup()
    end
},

```

## Default options

PatternVault provides a couple of options to customize the behaviour.

```lua
	{
		yank_register = '+',
		root = vim.fn.stdpath("config"),
		default_history = 'cmd',
		auto_open = true, -- Feeds the pattern to the command line, so you can interact with it.
		should_yank = false, -- Should the pattern be yanked to yank_register.
	}
```

## Usage

add_latest has an optional argument that specifies the history if you want to use another than the default. It defaults to the dir specified in options. I've only considered search and cmd currently. search grabs the latest, for cmnd it searches for the latest %s command.

All of your patterns are stored in a `patternvault.json` file that is stored by default in your neovim config directory.


To get started try running `PaternVault add_latest` and then `PatternVault select`.


### Add latest pattern

Adds the latest pattern from specified `default_history`

```vim
PatternVault add_latest
```


### Select a pattern

Uses `vim.ui.select` to select a stored pattern. This will feed the pattern into the cmdline.

```vim
PatternVault select
```

### Remove a pattern

Removes a pattern from your list.

```vim
PatternVault remove
```

### Edit name

Edits the name.

```vim
PatternVault edit_name
```

### Edit a pattern

Edits the pattern.

```vim
PatternVault edit_patern
```
