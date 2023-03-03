
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
You're working on a codebase and write an clever search and replace pattern, but you loose it and now have to try and piece together how you did it


## ⇁ The Solution:
The ability to persist your search patterns and access them easily.


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
    event = "VeryLazy" -- Customize here as wanted,
    config = function() 
        require("patternvault").setup()
    end
},

```

## Default options

PatternVault provides a couple of options to customize the behaviour.

```lua
	local defaults = {
		yank_register = '+',
		root = vim.fn.stdpath("config"),
		default_history = 'cmd',
		auto_open = true, -- Feeds the pattern to the command line, so you can interact with it.
		should_yank = false, -- Should the pattern be yanked to yank_register.
	}
```

## Usage

add_latest has an optional argument that specifies the history if you want to use another than the default. It defaults to the one defined in default options. I've only considered search and cmd currently. search grabs the latest, for cmnd it searches for the latest %s command.

All of your patterns are stored in a `patternvault.json` file that is stored by default in your neovim config directory.


### Add latest pattern
```vim
PatternVault add_latest
```

### Add latest %s pattern
```vim
PatternVault add_latest search 
```


### Select a pattern

Uses `vim.ui.select` to select a stored pattern. With default options this will feed the pattern into the cmdline.

```vim
PatternVault select
```

### Remove a pattern

Removes a pattern from your list

```vim
PatternVault remove
```

### Edit name

Edits the name.

```vim
PatternVault edit_name
```
