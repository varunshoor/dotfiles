-- Display references, definitions and implementations of document symbols
-- See: https://github.com/Wansmer/symbol-usage.nvim

local function text_format(symbol)
  local res = {}

  if symbol.references then
    table.insert(res, { "󰌹 " .. tostring(symbol.references), "Comment" })
  end

  if symbol.definition then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, { "󰳽 " .. tostring(symbol.definition), "Comment" })
  end

  if symbol.implementation then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, { "󰡱 " .. tostring(symbol.implementation), "Comment" })
  end

  return res
end
return {
  "Wansmer/symbol-usage.nvim",
  lazy = true,
  event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
  config = function()
    require("symbol-usage").setup({
      vt_position = "end_of_line",
      text_format = text_format,
    })
  end,
}
