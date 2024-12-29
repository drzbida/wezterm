---@diagnostic disable: undefined-field

local wt = require "wezterm"

local M = {}

local current_program = nil

wt.on("user-var-changed", function(_, _, name, value)
  if name == "PROG" then
    current_program = value ~= "" and value or nil
  end
end)

function M.get_process_osc1337()
  return current_program
end

return M
