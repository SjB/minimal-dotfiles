return {
    name = "CMake Create",
    builder = function()
        return {
            cmd = { "cmake" },
            args = { "-B", "build", "-S", "." },
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