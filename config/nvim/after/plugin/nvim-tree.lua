require("nvim-tree").setup({
  sort_by = "name",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
})

function nvimtree_smart_toggle()
  if require'nvim-tree.view'.is_visible() then
    vim.cmd("NvimTreeClose")
  else
    vim.cmd("NvimTreeFindFile")
  end
end

vim.keymap.set("n", "<leader>e", nvimtree_smart_toggle)
