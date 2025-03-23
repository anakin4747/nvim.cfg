
local function resize_by_dir(direction, amount)

    local current_win = vim.api.nvim_get_current_win()
    local row, col    = unpack(vim.api.nvim_win_get_position(current_win))
    local height      = vim.api.nvim_win_get_height(current_win)
    local width       = vim.api.nvim_win_get_width(current_win)
    local columns     = vim.api.nvim_get_option_value('columns', {})
    local lines       = vim.api.nvim_get_option_value('lines', {})

    local function is_top_win() return row == 0 end
    local function is_left_win() return col == 0 end
    local function is_bottom_win() return lines - (row + height) < 3 end
    local function is_right_win() return col + width == columns end

    local cmd = ""

    if direction == "up" then
        if is_top_win() then
            cmd = "resize -"
        elseif is_bottom_win() then
            cmd = "resize +"
        end
    elseif direction == "down" then
        if is_top_win() then
            cmd = "resize +"
        elseif is_bottom_win() then
            cmd = "resize -"
        end
    elseif direction == "left" then
        if is_left_win() then
            cmd = "vertical resize -"
        elseif is_right_win() then
            cmd = "vertical resize +"
        end
    elseif direction == "right" then
        if is_left_win() then
            cmd = "vertical resize +"
        elseif is_right_win() then
            cmd = "vertical resize -"
        end
    else
        print("Invalid direction")
        return
    end

    vim.cmd(cmd .. amount)
end

local is_resize_mode = true

vim.g.resize_value = 4

local function toggle_resize_mode()

    if is_resize_mode then

        if #vim.api.nvim_list_wins() == 1 then
            print("resize: only one window")
            return
        end

        vim.keymap.set("n", "h", function () resize_by_dir("left", vim.g.resize_value) end)
        vim.keymap.set("n", "j", function () resize_by_dir("down", vim.g.resize_value) end)
        vim.keymap.set("n", "k", function () resize_by_dir("up", vim.g.resize_value) end)
        vim.keymap.set("n", "l", function () resize_by_dir("right", vim.g.resize_value) end)
        vim.keymap.set("n", "=", function () vim.g.resize_value = vim.g.resize_value + 1 end)
        vim.keymap.set("n", "-", function () vim.g.resize_value = vim.g.resize_value - 1 end)
        vim.keymap.set("n", "<esc>", toggle_resize_mode)
        is_resize_mode = false
    else
        vim.cmd("silent unmap h")
        vim.cmd("silent unmap j")
        vim.cmd("silent unmap k")
        vim.cmd("silent unmap l")
        vim.cmd("silent unmap =")
        vim.cmd("silent unmap -")
        vim.cmd("silent unmap <esc>")
        is_resize_mode = true
    end
end

vim.keymap.set(
    'n', '<leader>rs', toggle_resize_mode, {
        noremap = true, silent = true, desc = "Toggle resize mode"
    }
)
