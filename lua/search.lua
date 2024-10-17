function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

local keymap = vim.keymap.set

keymap('v', '<leader>f', function()
  local text = vim.getVisualSelection()
  vim.fn.feedkeys('/' .. text)
end, { noremap = true, silent = true, desc = 'Search visual selection in current file' })

keymap('v', '<leader>F', function()
  local text = vim.getVisualSelection()
  require('telescope.builtin').live_grep({ default_text = text })
end, { noremap = true, silent = true, desc = 'Search visual selection in global' })
