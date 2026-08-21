vim.filetype.add({
  extension = {
    qmd = "quarto",
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Snakefile", "*.smk" },
  callback = function()
    vim.bo.filetype = "snakemake"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".gitconfig", ".git/config" },
  callback = function()
    vim.bo.filetype = "gitconfig"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".gitignore",
  callback = function()
    vim.bo.filetype = "gitignore"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".gitattributes",
  callback = function()
    vim.bo.filetype = "gitattributes"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "git-rebase-todo",
  callback = function()
    vim.bo.filetype = "gitrebase"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "COMMIT_EDITMSG", "MERGE_MSG" },
  callback = function()
    vim.bo.filetype = "gitcommit"
  end,
})
