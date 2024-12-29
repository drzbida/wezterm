local fs = require "utils.fs"
local wt = require "wezterm"
local get_process_osc1337 = require("events.user-var-changed").get_process_osc1337

wt.on("format-window-title", function(tab, pane, tabs, pane_title, _)
  local zoomed = ""
  if tab.active_pane.is_zoomed then
    zoomed = "[Z] "
  end

  local index = ""
  if #tabs > 1 then
    index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
  end

  local proc = get_process_osc1337(pane) or pane.foreground_process_name

  local title = fs.basename(pane.title):gsub("%.exe%s?$", "")

  if proc:find "nvim" then
    proc = proc:sub(proc:find "nvim")
  end

  if proc == "nvim" or title == "cmd" then
    local cwd = fs.basename(pane.current_working_dir.file_path)
    title = string.format("Neovim (dir: %s)", cwd)
  end

  return zoomed .. index .. title
end)
