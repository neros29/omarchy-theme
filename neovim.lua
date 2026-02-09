-- TokyoNight with transparent background + pink accents (no orange)
-- lazy.nvim only (NOT LazyVim)

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'night', -- try "moon" later if you want more purple
      transparent = true,
      terminal_colors = true,

      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },

      -- 1️⃣ Override TokyoNight base colors
      on_colors = function(c)
        c.orange = '#FF7AE6' -- 🔥 replace orange with pink
      end,

      -- 2️⃣ Fix highlights & force transparency
      on_highlights = function(hl, c)
        local none = 'NONE'
        local pink = '#FF7AE6'

        -- Core transparency
        hl.Normal = { bg = none }
        hl.NormalNC = { bg = none }
        hl.SignColumn = { bg = none }
        hl.LineNr = { bg = none }
        hl.CursorLineNr = { bg = none }

        hl.VertSplit = { bg = none }
        hl.WinSeparator = { bg = none }

        hl.StatusLine = { bg = none }
        hl.StatusLineNC = { bg = none }
        hl.TabLine = { bg = none }
        hl.TabLineFill = { bg = none }
        hl.TabLineSel = { bg = none }

        -- Cursor / selection
        hl.CursorLine = { bg = c.bg_highlight }
        hl.Visual = { bg = c.bg_visual }

        -- Menus (glass look)
        hl.Pmenu = { bg = c.bg_dark }
        hl.PmenuSel = { bg = c.bg_highlight }

        -- Floating windows
        hl.NormalFloat = { bg = none }
        hl.FloatBorder = { bg = none }
        hl.FloatTitle = { bg = none }

        -- Telescope (transparent)
        hl.TelescopeNormal = { bg = none }
        hl.TelescopeBorder = { bg = none }
        hl.TelescopePromptNormal = { bg = none }
        hl.TelescopePromptBorder = { bg = none }
        hl.TelescopeResultsNormal = { bg = none }
        hl.TelescopeResultsBorder = { bg = none }
        hl.TelescopePreviewNormal = { bg = none }
        hl.TelescopePreviewBorder = { bg = none }

        -- Diagnostics: replace orange/yellow accents with pink where appropriate
        hl.DiagnosticWarn = { fg = pink }
        hl.DiagnosticUnderlineWarn = { undercurl = true, sp = pink }

        -- Treesitter / syntax tweaks that still reference orange internally
        hl['@number'] = { fg = pink }
        hl['@constant'] = { fg = pink }
        hl['@punctuation.special'] = { fg = pink }

        -- Lazy UI (if you open :Lazy)
        hl.LazyNormal = { bg = none }
      end,
    },

    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme 'tokyonight'

      -- Safety net: re-force transparency if anything resets it
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
        end,
      })
    end,
  },
}
