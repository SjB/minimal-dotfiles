return {
    name = "CMake Build",
    builder = function()
        return {
            cmd = { "cmake" },
            args = { "--build", "build", "--target", "all" },
            components = {
                { "on_output_quickfix", set_diagnostics = true },
                "on_result_diagnostics",
                "default",
            },
        }
    end,
    condition = {
        filetype = { "cpp", "c" },
    },
}