return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.api.nvim_set_keymap("n", "<C-n>", ":Neotree toggle<CR>", { noremap = true, silent = true })
		require("neo-tree").setup({
			close_if_last_window = true,
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
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
						["<esc>"] = "close_window",
						["h"] = "navigate_up",
						["l"] = function(state)
							local node = state.tree:get_node()
							if node.type == "directory" then
								require("neo-tree.sources.filesystem.commands").set_root(state)
							else
								require("neo-tree.sources.filesystem.commands").open(state)
							end
						end,
					},
				},
			},
		})
	end,
}
