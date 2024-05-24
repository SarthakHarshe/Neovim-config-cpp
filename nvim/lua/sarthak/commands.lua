vim.api.nvim_create_user_command("CompileAndRun", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local project_name = vim.fn.fnamemodify(filename, ":t:r") -- Get the base name without extension

  -- Create the build directory and run CMake and Make asynchronously
  local build_cmd = "mkdir -p build && cd build && cmake .. && make"
  vim.fn.jobstart(build_cmd, {
    on_exit = function(job_id, exit_code, event)
      if exit_code == 0 then
        -- Build succeeded, determine the full path to the executable
        local executable = "./build/" .. project_name

        -- Run the executable in a vertical split pane
        vim.cmd("vsplit term://" .. executable)
        vim.cmd("startinsert") -- Start terminal in insert mode
      else
        -- Build failed, show the build output
        vim.cmd("botright split term://" .. build_cmd)
      end
    end,
    on_stdout = function(job_id, data, event)
      -- Handle standard output if needed
    end,
    on_stderr = function(job_id, data, event)
      -- Handle standard error if needed
    end,
  })
end, {})

vim.api.nvim_create_user_command("GenerateCMake", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local project_name = vim.fn.fnamemodify(filename, ":t:r") -- Get the base name without extension

  local cmakelists_content = [[
cmake_minimum_required(VERSION 3.10)
project(%s)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g") 

include_directories("~/custom_headers")

add_executable(%s %s)
]]

  -- Format the content with the project name and filename
  cmakelists_content = string.format(cmakelists_content, project_name, project_name, filename)

  -- Write the content to CMakeLists.txt
  local cmakelists_path = vim.fn.fnamemodify(filename, ":h") .. "/CMakeLists.txt"
  local cmakelists_file = io.open(cmakelists_path, "w")
  if cmakelists_file then
    cmakelists_file:write(cmakelists_content)
    cmakelists_file:close()
    print("CMakeLists.txt generated successfully")
  else
    print("Error: Unable to write CMakeLists.txt")
  end
end, {})
