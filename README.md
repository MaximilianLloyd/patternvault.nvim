
<div align="center">

# Regexstore.nvim
##### Don't loose your favorite regexes.

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
</div>

## ⇁  WIP
This is not fully baked. I've made a minimal MVP to validate the idea. If you experience any
issues, see some improvement you think would be amazing, or just have some
feedback for me , make an issue!

The format may change later if/when more advanced functionality is added.


## ⇁ The Problem:
You're working on a codebase and write an clever search and replace regex, but you loose it and now have to try and piece together how you did it


## ⇁ The Solution:
The ability to persist your search patterns and access them easily for later use.


## ⇁ Installation:

* Install using your favorite plugin manager.

### Packer
```lua
use({
    "MaximilianLloyd/regexstore.nvim",
    branch = "main",
    config = function()
        require("regexstore").setup({})
    end,
})
```


### Lazy
```lua
{
    "MaximilianLloyd/regexstore.nvim",
    event = "VeryLazy" -- Customize here as wanted,
    config = function() 
        require("regexstore").setup()
    end
},

```

## Default options

Regexstore provides a couple of.

```lua
{
	yank_register = '"',
	root = vim.fn.stdpath("config"), -- where to storethe regexstore.json file in your neovim config directory, for easy portability.
}

```

## Usage

Basic usage.


### Add latest search pattern
```
Regexstore add
```

### Select a regex

Uses `vim.ui.select` to select a regex. It will show the name you stored it under and the regex. Selecting will copy to your specified register.

```
Regexstore select
```


### Remove a regex

Removes a regex from your list

```
Regexstore remove
```

### Edit name

Edits the name.

```
Regexstore edit_name
```

## Todo 
- [ ] Edit regexes

