return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
    keys = { { "<leader>gn", "<cmd>Neogit<CR>", desc = "Open Neogit" } },
    opts = {
      kind = "auto",
      ignored_settings = {
        "NeogitPushPopup--force-with-lease",
        "NeogitPushPopup--force",
        "NeogitPullPopup--rebase",
        "NeogitCommitPopup--allow-empty",
        "NeogitCommitPopup--reset-author",
        "NeogitRevertPopup--no-edit",
      },
    },
  },
}
