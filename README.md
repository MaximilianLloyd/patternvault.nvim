
<div align="center">

# PatternVault.nvim
##### Don't loose your favorite search patterns.

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
</div>

## ⇁  WIP
This is not fully baked. I've made a minimal MVP to validate the idea. If you experience any
issues, see some improvement you think would be amazing, or just have some
feedback for me , make an issue!

The format may change later if/when more advanced functionality is added.


## ⇁ The Problem:
You're working on a codebase and write an clever search and replace pattern, but you loose it and now have to try and piece together how you did it


## ⇁ The Solution:
The ability to persist your search patterns and access them easily for later use.


## ⇁ Installation:

* Install using your favorite plugin manager.

### Packer
```lua
use({
    "MaximilianLloyd/PatternVault.nvim",
    branch = "main",
    config = function()
        require("PatternVault").setup({})
    end,
})
```


### Lazy
```lua
{
    "MaximilianLloyd/PatternVault.nvim",
    event = "VeryLazy" -- Customize here as wanted,
    config = function() 
        require("PatternVault").setup()
    end
},

```

## Default options

PatternVault provides a couple of.

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

Basic usage.

add_latest has an optional argument that specifies the history. It defaults to the one defined in default options. I've only considered search and cmd currently. search grabs the latest, for cmnd it searches for the latest %s command.


### Add latest pattern
```
PatternVault add_latest
```

### Add latest %s pattern
```
PatternVault add_latest search
```



### Select a pattern

Uses `vim.ui.select` to select a stored pattern. Selecting will copy to your specified register.

```
PatternVault select
```


### Remove a pattern

Removes a pattern from your list

```
PatternVault remove
```

### Edit name

Edits the name.

```
PatternVault edit_name
```

-- 

## Todo
- [ ] Add an option to automatically open a select pattern


