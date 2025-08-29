-- vim.api.nvim_set_keymap('n','q','<cmd>wincmd q<cr>',{desc="Close help window"})
	local opts = {
		noremap = true,
	}
	vim.api.nvim_buf_set_keymap(0, "", "q", "<cmd>wincmd q<cr>", opts)
