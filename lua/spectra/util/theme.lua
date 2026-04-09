local M = {}

local function copy(value)
  if value == nil then
    return nil
  end

  return vim.deepcopy(value)
end

function M.role(roles, names)
  for _, name in ipairs(names or {}) do
    local role = roles[name]
    if role then
      return copy(role)
    end
  end

  return nil
end

function M.highlight(roles, names, fallback, extra)
  local base = M.role(roles, names) or copy(fallback) or {}

  if extra then
    base = vim.tbl_extend("force", base, extra)
  end

  return base
end

function M.merge(base, extra)
  return vim.tbl_extend("force", copy(base) or {}, extra or {})
end

return M
