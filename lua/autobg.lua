local Job = require "plenary.job"
local Path = require "plenary.path"

local M = {}

M.callback = function(mode)
  vim.cmd("set bg=" .. mode)
end

M.exe_path = vim.fn.stdpath "data" .. "/appearance_watch"

M.ensure_compiled = function()
  if not Path:new(M.exe_path):exists() then
    vim.notify "Compiling autobg helper…"
    local script_dir = debug.getinfo(2, "S").source:sub(2):match "(.*/)"
    local j = Job:new {
      command = "swiftc",
      args = { script_dir .. "../appearance_watch.swift", "-o", M.exe_path },
    }
    j:sync()
    vim.notify "…done"
  end
end

M.start = function()
  if M.job then
    return
  end

  M.job = Job:new {
    command = M.exe_path,
    on_stdout = function(_, msg)
      if not (msg == "dark" or msg == "light") then
        return
      end

      vim.schedule(function()
        M.callback(msg)
      end)
    end,
  }

  M.job:start()
end

M.setup = function(opts)
  if not opts then
    opts = {}
  end

  if opts.callback then
    M.callback = opts.callback
  end

  M.ensure_compiled()
  M.start()
end

M.setup {}

return M
