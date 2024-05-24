-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Cmake keymap
keymap.set("n", "<leader>cr", ":CompileAndRun<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>gc", ":GenerateCMake<CR>", { noremap = true, silent = true })

-- Debugger keybindings
keymap.set("n", "<F5>", function()
  require("dap").continue()
end, { desc = "DAP Continue" })
keymap.set("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "DAP Step Over" })
keymap.set("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "DAP Step Into" })
keymap.set("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "DAP Step Out" })
keymap.set("n", "<Leader>b", function()
  require("dap").toggle_breakpoint()
end, { desc = "DAP Toggle Breakpoint" })
keymap.set("n", "<Leader>B", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP Set Conditional Breakpoint" })
keymap.set("n", "<Leader>lp", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "DAP Set Log Point" })
keymap.set("n", "<Leader>dr", function()
  require("dap").repl.open()
end, { desc = "DAP Open REPL" })
keymap.set("n", "<Leader>dl", function()
  require("dap").run_last()
end, { desc = "DAP Run Last" })
keymap.set("n", "<Leader>dq", function()
  require("dap").terminate()
end, { desc = "DAP Terminate" })
