local M = {}

function M.setup(opts)
  opts = vim.tbl_deep_extend("force", { theme = "dracula-colorful" }, opts or {})
  return require("spectra").setup(opts)
end

function M.get_groups()
  return require("spectra").get_groups("dracula-colorful")
end

function M.load()
  return require("spectra").load("dracula-colorful")
end

return M
