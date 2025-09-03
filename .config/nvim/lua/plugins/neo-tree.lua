-- lua/plugins/neotree.lua
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, for file icons
        "MunifTanjim/nui.nvim",
    },

    config = function()
        -- Keymap to toggle Neo-tree
        vim.api.nvim_set_keymap(
            "n",
            "<C-n>",  -- change this to whatever key you like
            [[:lua require("neo-tree.command").execute({ reveal = true })<CR>]],
            { noremap = true, silent = true }
        )

        -- Neo-tree setup
        require("neo-tree").setup({
            filesystem = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                bind_to_cwd = true,
                use_libuv_file_watcher = true,
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    always_show = { ".gitignored", ".config" },
                },
                window = {
                    mappings = {
                        ["<BS>"] = "navigate_up", -- Alternative key for parent directory
                    },
                },
            },
        })
    end,
}

