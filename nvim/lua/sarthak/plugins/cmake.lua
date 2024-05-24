return {
  "Civitasv/cmake-tools.nvim",
  config = function()
    require("cmake-tools").setup({
      cmake_command = "cmake",
      cmake_build_directory = "build",
      cmake_build_directory_prefix = "", -- CMake will append the project name
      cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = {},
      cmake_console_size = 10, -- Height of the CMake console window
      cmake_show_console = "always", -- "always", "only_on_error"
      cmake_dap_configuration = {
        name = "cpp",
        type = "lldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
      },
      cmake_variants_message = {
        short = { show = true },
        long = { show = true, max_length = 40 },
      },
    })
  end,
}
