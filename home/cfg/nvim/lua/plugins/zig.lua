return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "zig" })
      else
        opts.ensure_installed = { "zig" }
      end
    end,
  },
  {
    "ziglang/zig.vim",
    ft = "zig",
    init = function()
      vim.g.zig_fmt_autosave = 0
    end,
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "zls", "codelldb" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        zls = {
          settings = {
            semantic_tokens = "full",
          },
        },
      },
    },
  },
}
