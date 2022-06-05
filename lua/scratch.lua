local f = vim.fn
local api = vim.api
local cmd = vim.cmd
local last_ext = nil
local function open_split(direction)
  _G.assert((nil ~= direction), "Missing argument direction on fnl/scratch.fnl:7")
  local bufheight = f.floor((f.winheight(0) / 5))
  vim.cmd((direction .. " " .. bufheight .. "split"))
  local bufnr = api.nvim_create_buf(true, false)
  api.nvim_set_current_buf(bufnr)
  return bufnr
end
local function open_scratchpad_with_ext(ext)
  _G.assert((nil ~= ext), "Missing argument ext on fnl/scratch.fnl:15")
  local cwd = vim.fn.getcwd()
  local bufnr = open_split("aboveleft")
  return cmd(("edit .scratch." .. ext))
end
local function open_scratchpad()
  last_ext = f.input("Scratchpad extension> ")
  return open_scratchpad_with_ext(last_ext)
end
local function open_last_scratchpad()
  if (last_ext == nil) then
    last_ext = vim.fn.expand("%:e")
  else
  end
  return open_scratchpad_with_ext(last_ext)
end
local function open_current_scratchpad()
  last_ext = vim.fn.expand("%:e")
  return open_scratchpad_with_ext(last_ext)
end
return {["open-scratchpad"] = open_scratchpad, ["open-last-scratchpad"] = open_last_scratchpad, ["open-current-scratchpad"] = open_current_scratchpad}
