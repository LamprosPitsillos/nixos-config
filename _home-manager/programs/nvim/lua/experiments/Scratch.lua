require('attempt').setup{
  -- dir = (unix and '/tmp/' or vim.fn.expand '$TEMP\\') .. 'attempt.nvim' .. path_separator,
  autosave = false,
  list_buffers = false,     -- This will make them show on other pickers (like :Telescope buffers)
  -- initial_content = {
  --   py = initial_content_fn, -- Either string or function that returns the initial content
  --   c = initial_content_fn,
  --   cpp = initial_content_fn,
  --   java = initial_content_fn,
  --   rs = initial_content_fn,
  --   go = initial_content_fn,
  --   sh = initial_content_fn
  -- },
  ext_options = { 'lua', 'js', 'py', 'cpp', 'c', '' },  -- Options to choose from
  format_opts = { [''] = '[None]' },                    -- How they'll look
  run = {
    -- py = 'w !python',       -- Either strings or lua functions
    -- js = 'w !node',
    -- lua = 'w | luafile %',
    -- sh = 'w !bash',
    -- pl = 'w !perl',
  }
}
local attempt = require('attempt')

local function map(mode, l, r, opts)
    opts = opts or {}
    opts = vim.tbl_extend('force', { silent=true }, opts)
    vim.keymap.set(mode, l, r, opts)
end

map('n', '<leader>an', attempt.new_select)        -- new attempt, selecting extension
map('n', '<leader>ai', attempt.new_input_ext)     -- new attempt, inputing extension
map('n', '<leader>ar', attempt.run)               -- run attempt
map('n', '<leader>ad', attempt.delete_buf)        -- delete attempt from current buffer
map('n', '<leader>ac', attempt.rename_buf)        -- rename attempt from current buffer
-- map('n', '<leader>al', "Telescope attempt")       -- search through attempts
map('n', '<leader>al', attempt.open_select) -- use ui.select instead of telescope
