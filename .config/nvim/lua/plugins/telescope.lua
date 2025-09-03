-- lua/plugins/telescope.lua
return {
	{
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6", -- or branch = "master" if you prefer latest
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "node_modules", ".git/" },
            },
            pickers = {
                find_files = {
                    hidden = true, -- show hidden files
                },
                live_grep = {
                    additional_args = function(_)
                        return { "--hidden" } -- grep hidden files
                    end,
                },
            },
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<C-p>", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    end,
	},

	{
		'nvim-telescope/telescope-ui-select.nvim',
		config = function()
			require("telescope").setup {
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown{}
					}
				}
			}
			require("telescope").load_extension("ui-select")
		end
	}
}

