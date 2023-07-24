local wezterm = require "wezterm"
local act = wezterm.action
local module = {}

local keybindings = {
  -- Tabs management.
  {
    key = "T",
    mods = "CTRL|SHIFT",
    action = act.SpawnCommandInNewTab {
      domain = "CurrentPaneDomain",
    },
  },
  {
    key = "F2",
    action = act.SpawnCommandInNewTab {
      domain = "DefaultDomain",
    },
  },
  {
    key = "F3",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "Tab",
    mods = "CTRL|SHIFT",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "LeftArrow",
    mods = "CTRL|SHIFT",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "F4",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "Tab",
    mods = "CTRL",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "RightArrow",
    mods = "CTRL|SHIFT",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "<",
    mods = "CTRL|SHIFT",
    action = act.MoveTabRelative(-1),
  },
  {
    key = ">",
    mods = "CTRL|SHIFT",
    action = act.MoveTabRelative(1),
  },
  {
    key = "F8",
    action = act.PromptInputLine {
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  {
    key = "Q",
    mods = "CTRL|SHIFT",
    action = act.CloseCurrentTab { confirm = true },
  },
  -- Panes managment.
  {
    key = "F6",
    mods = "CTRL",
    action = act.CloseCurrentPane { confirm = true },
  },
  {
    key = "W",
    mods = "CTRL|SHIFT",
    action = act.CloseCurrentPane { confirm = true },
  },
  {
    key = "F2",
    mods = "SHIFT",
    action = act.SplitPane {
      command = { domain = "DefaultDomain" },
      direction = "Down",
    },
  },
  {
    key = "Enter",
    mods = "CTRL|SHIFT",
    action = act.SplitPane {
      command = { domain = "CurrentPaneDomain" },
      direction = "Down",
    },
  },
  {
    key = "F2",
    mods = "CTRL",
    action = act.SplitPane {
      command = { domain = "DefaultDomain" },
      direction = "Right",
    },
  },
  {
    key = "|",
    mods = "CTRL|SHIFT",
    action = act.SplitPane {
      command = { domain = "CurrentPaneDomain" },
      direction = "Right",
    },
  },
  {
    key = "UpArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize { "Up", 1 },
  },
  {
    key = "RightArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize { "Right", 1 },
  },
  {
    key = "DownArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize { "Down", 1 },
  },
  {
    key = "LeftArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize { "Left", 1 },
  },
  {
    key = "UpArrow",
    mods = "SHIFT",
    action = act.ActivatePaneDirection "Up",
  },
  {
    key = "K",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection "Up",
  },
  {
    key = "RightArrow",
    mods = "SHIFT",
    action = act.ActivatePaneDirection "Right",
  },
  {
    key = "L",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection "Right",
  },
  {
    key = "DownArrow",
    mods = "SHIFT",
    action = act.ActivatePaneDirection "Down",
  },
  {
    key = "J",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection "Down",
  },
  {
    key = "LeftArrow",
    mods = "SHIFT",
    action = act.ActivatePaneDirection "Left",
  },
  {
    key = "H",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection "Left",
  },
  {
    key = "F7",
    mods = "CTRL|SHIFT",
    action = act.PaneSelect {
      alphabet = "abcdefghijklmnopqrstuvwxyz",
    },
  },
  {
    key = "F8",
    mods = "CTRL|SHIFT",
    action = act.PaneSelect {
      mode = "SwapWithActive",
    },
  },
  {
    key = "Z",
    mods = "CTRL|SHIFT",
    action = act.TogglePaneZoomState,
  },
  {
    key = "N",
    mods = "CTRL|SHIFT",
    action = act.ShowLauncher,
  },
  -- Scrollback.
  {
    key = "Y",
    mods = "CTRL|SHIFT",
    action = act.ScrollByLine(-1),
  },
  {
    key = "UpArrow",
    mods = "CTRL|SHIFT",
    action = act.ScrollByLine(-1),
  },
  {
    key = "E",
    mods = "CTRL|SHIFT",
    action = act.ScrollByLine(1),
  },
  {
    key = "DownArrow",
    mods = "CTRL|SHIFT",
    action = act.ScrollByLine(1),
  },
  {
    key = "U",
    mods = "CTRL|SHIFT",
    action = act.ScrollByPage(-0.5),
  },
  {
    key = "D",
    mods = "CTRL|SHIFT",
    action = act.ScrollByPage(0.5),
  },
  {
    key = "PageUp",
    mods = "SHIFT",
    action = act.ScrollByPage(-1),
  },
  {
    key = "PageDown",
    mods = "SHIFT",
    action = act.ScrollByPage(1),
  },
  {
    key = "Home",
    mods = "SHIFT",
    action = act.ScrollToTop,
  },
  {
    key = "End",
    mods = "SHIFT",
    action = act.ScrollToBottom,
  },
  {
    key = "UpArrow",
    mods = "CTRL",
    action = act.ScrollToPrompt(-1),
  },
  {
    key = "DownArrow",
    mods = "CTRL",
    action = act.ScrollToPrompt(1),
  },
}

-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
function module.apply_to_config(config)
  config.keys = keybindings
end

-- return our module table
return module
