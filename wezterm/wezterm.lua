local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
config.set_environment_variables = {
    EDITOR = 'nvim',
    PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
}
config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 }
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.font_size = 14
config.color_scheme = 'rose-pine-moon'
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
        inactive_tab = {
            bg_color = 'rgba(0,0,0,0)',
            fg_color = '#e0def4'
        },
        active_tab = {
            bg_color = '#ea9a97',
            fg_color = '#393552'
        }
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

wezterm.on(
    'format-tab-title',
    function(tab)
        return {
            { Text = ' ' .. tab.tab_index + 1 .. ' ' },
        }
    end
)

wezterm.on('user-var-changed', function(window, pane, name, value)
    if name == 'switch-workspace' then
        local cmd_context = wezterm.json_parse(value)
        window:perform_action(
            act.SwitchToWorkspace {
                name = cmd_context.workspace,
                spawn = {
                    cwd = cmd_context.cwd,
                },
            },
            pane
        )
    end
end)


return config
