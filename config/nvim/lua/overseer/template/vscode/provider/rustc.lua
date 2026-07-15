local M = {}

M.problem_patterns = {
    ["$rustc"] = {
        {
            regexp = "^(error|warning)(\\[E\\d+\\])*:(.*)$",
            message = 3
        },
        {
            regexp = "^\\s+-+>\\s*([^:]*):(\\d+):(\\d+)$",
            kind = "location",
            file = 1,
            line = 2,
            column = 3
        },
        {
            regexp = "^(\\s|\\d)+(\\||=).*$"
        },
        { 
            regexp = "^$"
        }
    }
}

M.problem_matchers = {
    ["$rustc"] = {
        fileLocation = { "relative", "${cwd}" },
        pattern = "$rustc",


    }
}
return M
  