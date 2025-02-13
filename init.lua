--  Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.nofsync = true

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

IsVSCode = (vim.g.vscode ~= nil)

StartupColorTheme = 'everforest'

function IsStartupColorTheme(name)
    return StartupColorTheme == name
end

function MakeColorTheme(repo, alias, config, enabled)
    if enabled == nil then
        enabled = not IsVSCode
    end
    return {
        repo,
        name = alias,
        -- lazy = not IsStartupColorTheme(alias),
        priority = 1000,
        config = config,
        enabled = enabled
    }
end

function CT(color)
    color = color or StartupColorTheme
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function Rpad(str, amount)
    for _ = 1, (amount - string.len(str)), 1 do
        str = str .. ' '
    end
    return str
end

function CTlist()
    local pad = 0
    for _, theme in pairs(ColorThemes) do
        pad = math.max(string.len(theme[1]), pad)
    end
    for _, theme in pairs(ColorThemes) do
        local link = theme[1]
        local abbrev = theme["name"]
        print(Rpad(link, pad + 3) .. abbrev)
    end
end

ColorThemes = {
    MakeColorTheme('rose-pine/neovim', 'rose-pine',
        function()
            require('rose-pine').setup({
                --- @usage 'auto'|'main'|'moon'|'dawn'
                variant = 'auto',
                --- @usage 'main'|'moon'|'dawn'
                dark_variant = 'main',
                bold_vert_split = false,
                dim_nc_background = false,
                disable_background = true,
                disable_float_background = true,
                disable_italics = false,

                --- @usage string hex value or named color from rosepinetheme.com/palette
                groups = {
                    background = 'base',
                    background_nc = '_experimental_nc',
                    panel = 'surface',
                    panel_nc = 'base',
                    border = 'highlight_med',
                    comment = 'muted',
                    link = 'iris',
                    punctuation = 'subtle',

                    error = 'love',
                    hint = 'iris',
                    info = 'foam',
                    warn = 'gold',

                    headings = {
                        h1 = 'iris',
                        h2 = 'foam',
                        h3 = 'rose',
                        h4 = 'gold',
                        h5 = 'pine',
                        h6 = 'foam',
                    }
                    -- or set all headings at once
                    -- headings = 'subtle'
                },

                -- Change specific vim highlight groups
                -- https://github.com/rose-pine/neovim/wiki/Recipes
                highlight_groups = {
                    ColorColumn = { bg = 'rose' },

                    -- Blend colours against the "base" background
                    CursorLine = { bg = 'foam', blend = 10 },
                    StatusLine = { fg = 'love', bg = 'love', blend = 10 },
                }
            })
        end
    ),
    MakeColorTheme('ntk148v/komau.vim', 'komau'),
    MakeColorTheme('Mofiqul/vscode.nvim', 'vscode',
        function()
            local c = require('vscode.colors').get_colors()
            require('vscode').setup({
                -- Alternatively set style in setup
                -- style = 'light'

                -- Enable transparent background
                transparent = true,

                -- Enable italic comment
                italic_comments = true,

                -- Underline `@markup.link.*` variants
                underline_links = true,

                -- Disable nvim-tree background color
                disable_nvimtree_bg = true,

                -- Override colors (see ./lua/vscode/colors.lua)
                color_overrides = {
                    vscLineNumber = '#646978',
                },

                -- Override highlight groups (see ./lua/vscode/theme.lua)
                group_overrides = {
                    -- this supports the same val table as vim.api.nvim_set_hl
                    -- use colors from this colorscheme by requiring vscode.colors!
                    Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
                }
            })
            require('vscode').load('dark')
        end),
    MakeColorTheme('davidosomething/vim-colors-meh', 'meh'),
    MakeColorTheme('andreypopp/vim-colors-plain', 'vc-plain'),
    MakeColorTheme('karoliskoncevicius/distilled-vim', 'distilled'),
    MakeColorTheme('zekzekus/menguless', 'menguless'),
    MakeColorTheme('fxn/vim-monochrome', 'monochrome'),
    MakeColorTheme('lurst/austere.vim', 'austere'),
    MakeColorTheme('widatama/vim-phoenix', 'phoenix'),
    MakeColorTheme('axvr/photon.vim', 'photon'),
    MakeColorTheme('stefanvanburen/rams.vim', 'rams'),
    MakeColorTheme('kadekillary/skull-vim', 'skull'),
    MakeColorTheme('kvrohit/rasmus.nvim', 'rasmus'),
    MakeColorTheme('navarasu/onedark.nvim', 'onedark',
        function()
            require('onedark').setup {
                -- Set a style preset. 'dark' is default.
                style = 'dark', -- dark, darker, cool, deep, warm, warmer, light
            }
            require('onedark').load()
        end
    ),
    MakeColorTheme('neanias/everforest-nvim', 'everforest',
        function()
            require('everforest').setup({
                ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
                ---Default is "medium".
                background = "medium",
                ---How much of the background should be transparent. 2 will have more UI
                ---components be transparent (e.g. status line background)
                transparent_background_level = 1,
                ---Whether italics should be used for keywords and more.
                italics = true,
                ---Disable italic fonts for comments. Comments are in italics by default, set
                ---this to `true` to make them _not_ italic!
                disable_italic_comments = false,
                ---By default, the colour of the sign column background is the same as the as normal text
                ---background, but you can use a grey background by setting this to `"grey"`.
                sign_column_background = "none",
                ---The contrast of line numbers, indent lines, etc. Options are `"high"` or
                ---`"low"` (default).
                ui_contrast = "high",
                ---Dim inactive windows. Only works in Neovim. Can look a bit weird with Telescope.
                ---
                ---When this option is used in conjunction with show_eob set to `false`, the
                ---end of the buffer will only be hidden inside the active window. Inside
                ---inactive windows, the end of buffer filler characters will be visible in
                ---dimmed symbols. This is due to the way Vim and Neovim handle `EndOfBuffer`.
                dim_inactive_windows = false,
                ---Some plugins support highlighting error/warning/info/hint texts, by
                ---default these texts are only underlined, but you can use this option to
                ---also highlight the background of them.
                diagnostic_text_highlight = false,
                ---Which colour the diagnostic text should be. Options are `"grey"` or `"coloured"` (default)
                diagnostic_virtual_text = "coloured",
                ---Some plugins support highlighting error/warning/info/hint lines, but this
                ---feature is disabled by default in this colour scheme.
                diagnostic_line_highlight = (vim.g.vscode ~= true),
                ---By default, this color scheme won't colour the foreground of |spell|, instead
                ---colored under curls will be used. If you also want to colour the foreground,
                ---set this option to `true`.
                spell_foreground = false,
                ---Whether to show the EndOfBuffer highlight.
                show_eob = true,
                ---Style used to make floating windows stand out from other windows. `"bright"`
                ---makes the background of these windows lighter than |hl-Normal|, whereas
                ---`"dim"` makes it darker.
                ---
                ---Floating windows include for instance diagnostic pop-ups, scrollable
                ---documentation windows from completion engines, overlay windows from
                ---installers, etc.
                ---
                ---NB: This is only significant for dark backgrounds as the light palettes
                ---have the same colour for both values in the switch.
                float_style = "dim",
                ---Inlay hints are special markers that are displayed inline with the code to
                ---provide you with additional information. You can use this option to customize
                ---the background color of inlay hints.
                ---
                ---Options are `"none"` or `"dimmed"`.
                inlay_hints_background = "none",
                ---You can override specific highlights to use other groups or a hex colour.
                ---This function will be called with the highlights and colour palette tables.
                on_highlights = function(highlight_groups, palette) end,
                ---You can override colours in the palette to use different hex colours.
                ---This function will be called once the base and background colours have
                ---been mixed on the palette.
                colours_override = function(palette) end,
            })
        end
    )
};


-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
    -- NOTE: First, some plugins that don't require any configuration

    'neovim/nvim-lspconfig',

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Plugin development
    {
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },

        -- `vim.uv` typings
        {
            "Bilal2453/luvit-meta",
            lazy = true,
        },

        -- completion source for require statements and module annotations
        {
            "hrsh7th/nvim-cmp",
            opts = function(_, opts)
                opts.sources = opts.sources or {}
                table.insert(opts.sources, {
                    name = "lazydev",
                    group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                })
            end,
        },
    },

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- Colors

    {
        'xiyaowong/transparent.nvim',
        lazy = false,
        enabled = not IsVSCode,
        config = function()
            require("transparent").setup({
                -- table: default groups
                groups = {
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                    'EndOfBuffer',
                },
                -- table: additional groups that should be cleared
                extra_groups = { 'NormalSB' },
                -- table: groups you don't want to clear
                exclude_groups = {},
            })
        end
    },

    ColorThemes,

    -- LSP
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       opts = {} },
        },
    },

    -- Obsidan

    {
        --url='0qln/NvimObsidianFinial',
        -- dir='D:\\Programmmieren\\Projects\\NvimObsidianFinial',
        -- name='NvimObsidianFinial',
    },

    {
        -- dir="D:\\Programmmieren\\Projects\\obsidian.nvim",
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        enabled = not IsVSCode,
        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --     "BufReadPre path/to/my-vault/**.md",
        --     "BufNewFile path/to/my-vault/**.md",
        -- },

        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },

        opts = {
            workspaces = {
                {
                    name = "buf-parent",
                    path = function()
                        return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
                    end,
                },
            },

            ---@param title string|?
            ---@return string
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
                -- In this case a note with the title 'My new note' will be given an ID that looks
                -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.time()) .. "-" .. suffix
            end,

            ---@param spec { id: string, dir: obsidian.Path, title: string|? }
            ---@return string|obsidian.Path The full path to the new note.
            note_path_func = function(spec)
                -- This is equivalent to the default behavior.
                local path = spec.dir / tostring(spec.id)
                return path:with_suffix(".md")
            end,

            completion = {
                nvim_cmp = true,
                min_chars = 3
            },

            mappings = {
                -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
            },

            new_notes_location = "current_dir",
        },
    },

    {
        'Exafunction/codeium.vim',
        event = 'BufEnter',
        enabled = not IsVSCode,
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    -- Build Step is needed for regex support in snippets
                    -- This step is not supported in many windows environments
                    -- Remove the below condition to re-enable on windows
                    if vim.fn.has 'win32' == 1 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
            },
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup({})
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete {},
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['J'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['K'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                },
            })
        end,
        enabled = not IsVSCode,
    },

    -- Useful plugin to show you pending keybinds.
    -- { 'folke/which-key.nvim',                opts = {} },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map({ 'n', 'v' }, ']c', function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Jump to next hunk' })

                map({ 'n', 'v' }, '[c', function()
                    if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Jump to previous hunk' })

                -- Actions
                -- visual mode
                map('v', '<leader>hs', function()
                    gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'stage git hunk' })
                map('v', '<leader>hr', function()
                    gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'reset git hunk' })
                -- normal mode
                map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
                map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
                map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
                map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
                map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
                map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
                map('n', '<leader>hb', function()
                    gs.blame_line { full = false }
                end, { desc = 'git blame line' })
                map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
                map('n', '<leader>hD', function()
                    gs.diffthis '~'
                end, { desc = 'git diff against last commit' })

                -- Toggles
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
                map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
            end,
        },
    },

    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
        },
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        enabled = not IsVSCode,
        lazy = true,
    },

    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {
            enabled = false
        },
    },

    -- "gc" to comment visual regions/lines
    {
        'numToStr/Comment.nvim', opts = {}
    },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        -- enabled = not IsVSCode,
        -- lazy = false,
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
            },
        },
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

    {
        lazy = true, -- This plugin spikes the loading times.
        "iabdelkareem/csharp.nvim",
        dependencies = {
            "williamboman/mason.nvim", -- Required, automatically installs omnisharp
            "mfussenegger/nvim-dap",
            "Tastyep/structlog.nvim",  -- Optional, but highly recommended for debugging
        },
        config = function()
            require("mason").setup() -- Mason setup must run before csharp

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers

            -- TODO: remove the copy pasing
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            --

            require('csharp').setup({
                lsp = {
                    -- When set to false, csharp.nvim won't launch omnisharp automatically.
                    enable = true,
                    -- When set, csharp.nvim won't install omnisharp automatically. Instead, the omnisharp instance in the cmd_path will be used.
                    cmd_path = "C:\\Program Files\\OmniSharp\\OmniSharp.dll",
                    -- The default timeout when communicating with omnisharp
                    default_timeout = 1000,
                    -- Settings that'll be passed to the omnisharp server
                    enable_editor_config_support = true,
                    organize_imports = true,
                    load_projects_on_demand = false,
                    enable_analyzers_support = true,
                    enable_import_completion = true,
                    include_prerelease_sdks = true,
                    analyze_open_documents_only = false,
                    enable_package_auto_restore = true,
                    -- Launches omnisharp in debug mode
                    debug = false,
                    -- The capabilities to pass to the omnisharp server
                    capabilities = capabilities,
                    -- on_attach function that'll be called when the LSP is attached to a buffer
                    on_attach = nil --[[ on_attach ]]
                },
                logging = {
                    -- The minimum log level.
                    level = "INFO",
                },
                dap = {
                    -- When set, csharp.nvim won't launch install and debugger automatically. Instead, it'll use the debug adapter specified.
                    --- @type string?
                    adapter_name = nil,
                }
            })
        end
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        lazy = false,
        -- enabled = not IsVSCode,
    },

    {
        "gelguy/wilder.nvim",
        enabled = not IsVSCode,
        config = function()
            require('wilder').setup({
                modes = { ':', '/', '?' }
            })
        end
    },

    -- TODO
    -- {
    --     'nvimdev/lspsaga.nvim',
    --     dependencies = {
    --         'nvim-treesitter/nvim-treesitter', -- optional
    --         'nvim-tree/nvim-web-devicons'      -- optional
    --     }
    -- },

    {
        'timtro/glslView-nvim',
        ft = 'glsl',
        lazy = true,
    },

    {
        'mrcjkb/haskell-tools.nvim',
        version = '^3', -- Recommended
        lazy = false,   -- This plugin is already lazy

        enabled = false
    },

    {
        "jiaoshijie/undotree",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        keys = { -- load the plugin only when using it's keybinding:
            { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
        },
    },

    {
        "Eandrju/cellular-automaton.nvim",
        lazy = true
    },

}, {})

-- Set highlight on search
vim.o.hlsearch = false
vim.opt.incsearch = true

-- Fat cursor in insert mode
vim.o.guicursor = ""

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Mouse mode
vim.o.mouse = ''

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Scrolloff
vim.opt.scrolloff = 8

vim.o.wrap = false
-- only activate line wrapping for markdown files
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.md" },
    callback = function()
        vim.opt.wrap = true
        -- require("Codeium").Disable()
    end
})
vim.api.nvim_create_autocmd({ "BufLeave" }, {
    pattern = { "*.md" },
    callback = function()
        vim.opt.wrap = false
    end
})

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 50

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Conceal level (Needed for obsidian highlightings)
vim.o.conceallevel = 1


-- [[ Keymaps ]]

-- Obsidian
vim.keymap.set('n', '<leader>oc', 'mzI- [ ] <Esc>`z')

vim.keymap.set('n', '<leader>b', '<C-^>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<C-K>', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set("n", "<C-j>", "nzzzv")
vim.keymap.set("n", "<C-k>", "Nzzzv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv")

vim.keymap.set("n", "<Enter>", "mzo<Esc>`z")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Lsp
vim.keymap.set('n', '<leader>fd', function()
    vim.lsp.buf.hover()
end)

-- Debugging
vim.keymap.set('n', '<leader>db', function()
    local current_file = vim.api.nvim_buf_get_name(0)
    -- C#
    if string.gmatch(current_file, '.cs$')() == '.cs' then
        require 'csharp'.debug_project()
    end
end)

-- Running
vim.keymap.set('n', '<leader>go', function()
    local current_file = vim.api.nvim_buf_get_name(0)
    -- C#
    if string.gmatch(current_file, '.cs$')() == '.cs' then
        require 'csharp'.run_project()
    end
end)

-- Fix imports
vim.keymap.set('n', '<leader>fi', function()
    local current_file = vim.api.nvim_buf_get_name(0)
    -- C#
    if string.gmatch(current_file, '.cs$')() == '.cs' then
        require 'csharp'.fix_usings()
    end
end)

-- Fix all
vim.keymap.set('n', '<leader>fa', function()
    local current_file = vim.api.nvim_buf_get_name(0)
    -- C#
    if string.gmatch(current_file, '.cs$')() == '.cs' then
        require 'csharp'.fix_all()
    end
end)

-- shenanigans
vim.keymap.set('n', '<leader>mr', '<cmd>CellularAutomaton make_it_rain<CR>')

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
    -- Use the current buffer's path as the starting point for the git search
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    -- If the buffer is not associated with a file, return nil
    if current_file == '' then
        current_dir = cwd
    else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
    end

    -- Find the Git root directory from the current file's path
    local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
    if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
    end
    return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        require('telescope.builtin').live_grep {
            search_dirs = { git_root },
        }
    end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
    require('telescope.builtin').live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    }
end
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', function()
    -- Interpolate between obsidian search and telescope search
    local current_file = vim.api.nvim_buf_get_name(0)
    local is_md = string.gmatch(current_file, '.md$')() == '.md'
    if is_md then
        vim.cmd('ObsidianSearch')
    else
        require('telescope.builtin').find_files()
    end
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
    require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
            'markdown',
            'markdown_inline',
            'c',
            'cpp',
            'java',
            'go',
            'lua',
            'python',
            'rust',
            'tsx',
            'javascript',
            'typescript',
            'php',
            'phpdoc',
            'php_only',
            'html',
            'vimdoc',
            'vim',
            'bash',
            'glsl',
            'hlsl'
        },

        -- Autoinstall languages that are not installed. Defaults to false
        auto_install = true,
        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- List of parsers to ignore installing
        ignore_install = {},
        -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
        modules = {},
        highlight = { enable = not IsVSCode },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<c-space>',
                node_incremental = '<c-space>',
                scope_incremental = '<c-s>',
                node_decremental = '<M-space>',
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ['<leader>a'] = '@parameter.inner',
                },
                swap_previous = {
                    ['<leader>A'] = '@parameter.inner',
                },
            },
        },
    }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca',
        function() vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } } end,
        '[C]ode [A]ction')
    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    nmap('<leader>si', function() vim.lsp.buf.hover() end, '[S]how [I]nformation')
    -- See `:help K` for why this keymap

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    nmap('<leader>ff', vim.lsp.buf.format, '[F]ix [F]ormat')
end

-- document existing key chains
-- require('which-key').register {
--     ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--     ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--     ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
--     ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
--     ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--     ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--     ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
--     ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
-- }
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
-- require('which-key').register({
--     ['<leader>'] = { name = 'VISUAL <leader>' },
--     ['<leader>h'] = { 'Git [H]unk' },
-- }, { mode = 'v' })

if not IsVSCode then
    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require('mason').setup()
    require('mason-lspconfig').setup()

    local servers = {
        clangd = {},
        -- gopls = {},
        pyright = {},
        rust_analyzer = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true
                },
            }
        },

        -- tsserver = {},
        html = { filetypes = { 'html', 'twig', 'hbs' } },

        lua_ls = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                -- diagnostics = { disable = { 'missing-fields' } },
            },
        },

        -- omnisharp = {
        --     cmd = { "dotnet", "D:\\Programmmieren\\Omnisharp\\omnisharp-win-x86-net6.0\\OmniSharp.dll" },
        --
        --     settings = {
        --       FormattingOptions = {
        --         -- Enables support for reading code style, naming convention and analyzer
        --         -- settings from .editorconfig.
        --         EnableEditorConfigSupport = true,
        --         -- Specifies whether 'using' directives should be grouped and sorted during
        --         -- document formatting.
        --         OrganizeImports = nil,
        --       },
        --       MsBuild = {
        --         -- If true, MSBuild project system will only load projects for files that
        --         -- were opened in the editor. This setting is useful for big C# codebases
        --         -- and allows for faster initialization of code navigation features only
        --         -- for projects that are relevant to code that is being edited. With this
        --         -- setting enabled OmniSharp may load fewer projects and may thus display
        --         -- incomplete reference lists for symbols.
        --         LoadProjectsOnDemand = nil,
        --       },
        --       RoslynExtensionsOptions = {
        --         -- Enables support for roslyn analyzers, code fixes and rulesets.
        --         EnableAnalyzersSupport = true,
        --         -- Enables support for showing unimported types and unimported extension
        --         -- methods in completion lists. When committed, the appropriate using
        --         -- directive will be added at the top of the current file. This option can
        --         -- have a negative impact on initial completion responsiveness,
        --         -- particularly for the first few completion sessions after opening a
        --         -- solution.
        --         EnableImportCompletion = true,
        --         -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        --         -- true
        --         AnalyzeOpenDocumentsOnly = nil,
        --       },
        --       Sdk = {
        --         -- Specifies whether to include preview versions of the .NET SDK when
        --         -- determining which version to use for project loading.
        --         IncludePrereleases = true,
        --       },
        --     },
        -- },

        csharp_ls = {
            init_options = { AutomaticWorkspaceInit = true }
        },

        -- https://phpactor.readthedocs.io/en/master/lsp/vim.html
        -- phpactor = {
        --   init_options = {
        --     ["language_server_phpstan.enabled"] = false,
        --     ["language_server_psalm.enabled"] = true,
        --   }
        -- },

        intelephense = {

            -- See https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#initialisation-options
            init_options = {
                storagePath = …, -- Optional absolute path to storage dir. Defaults to os.tmpdir().
                globalStoragePath = …, -- Optional absolute path to a global storage dir. Defaults to os.homedir().
                licenceKey = …, -- Optional licence key or absolute path to a text file containing the licence key.
                clearCache = …, -- Optional flag to clear server state. State can also be cleared by deleting {storagePath}/intelephense
            },
            -- See https://github.com/bmewburn/intelephense-docs
            settings = {
                intelephense = {
                    files = {
                        maxSize = 1000000,
                    },
                },
            }
        }
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
        function(server_name)
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
                filetypes = (servers[server_name] or {}).filetypes,
            }
        end,
    }

    CT(StartupColorTheme)
end
