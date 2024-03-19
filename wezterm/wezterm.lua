local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
config.set_environment_variables = {
    EDITOR = 'nvim',
    PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
}
config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 }
config.font = wezterm.font 'CaskaydiaCove Nerd Font'
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.font_size = 17
config.color_scheme = 'rose-pine'
config.window_background_image = '/Users/ponanna/Pictures/rose_pine_contourline.png'
config.window_background_image_hsb = {
    brightness = 0.02
}
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.show_new_tab_button_in_tab_bar = false
config.colors = {
    tab_bar = {
        background = 'rgba(0,0,0,0)',
        active_tab = {
            bg_color = '#9ccfd8',
            fg_color = '#1f1d2e',
        },
        inactive_tab = {
            bg_color = '#1f1d2e',
            fg_color = '#9ccfd8',
        },
    },
}
config.keys = {
    { key = 'l', mods = 'LEADER', action = wezterm.action.ShowLauncher },
    { key = 'h', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'v', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'w', mods = 'LEADER', action = wezterm.action.PaneSelect },
    { key = 's', mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
    {
        key = 'e',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, pane)
            local workspaces = DirLookup("~/Workspace")

            window:perform_action(
                act.InputSelector {
                    action = wezterm.action_callback(
                        function(inner_window, inner_pane, id, label)
                            if not id and not label then
                                wezterm.log_info 'cancelled'
                            else
                                wezterm.log_info('id = ' .. id)
                                wezterm.log_info('label = ' .. label)
                                inner_window:perform_action(
                                    act.SwitchToWorkspace {
                                        name = label,
                                        spawn = {
                                            label = label,
                                            cwd = id,
                                            args = { "nvim", "." }
                                        },
                                    },
                                    inner_pane
                                )
                            end
                        end
                    ),
                    title = 'Choose Workspace',
                    choices = workspaces,
                    fuzzy = true,
                    fuzzy_description = 'Choose workspace: ',
                },
                pane
            )
        end),
    },
}

function DirLookup(dir)
    local cmd = 'find ' .. dir .. ' -maxdepth 1 -type d'
    local p = io.popen(cmd)
    if not p then
        return {}
    end
    local i, t = 0, {}
    for file in p:lines() do
        wezterm.log_info(file)
        i = i + 1
        local label = file:match(".*/([^/]+)")
        t[i] = { id = file, label = label }
    end
    p:close()
    return t
end

return config
