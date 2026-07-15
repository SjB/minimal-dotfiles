vim.keymap.set("i", "<C-.>", function()
    if not vim.lsp.inline_completion.get() then
        return "<C-.>"
    end
end, { expr = true, desc = "Accept the current inline completion" })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local function client_supports_method(client, method, bufnr)
            return client:supports_method(method, bufnr)
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, event.buf) then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end
    end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    } or {},
    virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
})


require('mason').setup()
-- require('mason-lspconfig').setup()

local servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                completion = {
                    callSnippet = "Replace",
                },
                diagnostics = {
                    disable = { 'missing-fields' },
                    globals = { 'vim', 'require' },
                },

            },
        }
    },
    gopls = {
        settings = {
            gopls = {
                experimentalPostfixCompletions = true,
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
                hints = {
                    enabled = true,
                    rangeVariableTypes = true,
                    prameterNames = true,
                    functionTypeParameters = true,
                    constantValues = true,
                    compositeLiteralTypes = true,
                    compositeLiteralFields = true,
                    assignVariableTypes = true,
                },
            },
        },
    },
    harper_ls = {
        settings = {
            ["harper-ls"] = {
                linters = {
                    SentenceCapitalization = true,
                    SpellCheck = true
                },
                dialect = "Canadian"
            }
        }
    },
    -- csharp_ls = {},
    pyright = {
        settings = {
            pyright = {
                disableOrganizeImports = true,
                disableTaggedHints = true,
            },
            python = {
                analysis = {
                    diagnosticSeverityOverrides = {
                        reportUndefinedVariable = "none",
                        reportUnusedExpression = "none",
                    },
                },
            },
        },
    },
    clangd = {
        settings = {
            ["clang"] = {
                cmd = { "clangd", "--background-index", "--compile-commands-dir=" .. vim.loop.cwd() .. "/build" },
            }
        }
    },
    ruff = {},
    rust_analyzer = {
        settings = {
            ['rust-analyzer'] = {
                cargo = {
                    allFeatures = true,
                },
                checkOnSave = true,
                check = {
                    command = "clippy",
                },
                procMacro = {
                    enable = true,
                },
                lens = {
                    debug = { enable = true },
                    enable = true,
                    implementations = { enable = true },
                    references = {
                        adt = { enable = true },
                        enumVariant = { enable = true },
                        method = { enable = true },
                        trait = { enable = true },
                    },
                    run = { enable = true },
                    updateTest = { enable = true },
                },
            },
        }
    },
    ts_ls = {},
    html = {},
    eslint = {},
    jsonls = {},
    jdtls = {},
    zls = {},
    copilot = {
        --     settings = {
        --         ['copilot'] = {
        --             cmd = { "copilot-language-server", "--stdio" },
        --             init_options = {
        --                 name = "Neovim",
        --                 version = tostring(vim.version()),
        --             },
        --             editorPluginInfo = {
        --                 name =  "Neovim",
        --                 version = tostring(vim.version()),
        --             },
        --         },
        --     },
    },
    omnisharp = {
        settings = {
            ["omnisharp"] = {
                useModernNet = true,
                organizeImportsOnFormat = true,
                enableImportCompletion = true,
                cmd = { "omnisharp" },
                root_dir = require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git"),
            }
        }
    },
}

local ensure_installed = vim.tbl_keys(servers or {})
require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
capabilities = vim.tbl_deep_extend('force', capabilities, {
    general = {
        -- dynamicRegistration = false,
        positionEncodings = { "utf-16" },
    },
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
})

for server, cfg in pairs(servers) do
    cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})
    vim.lsp.config(server, cfg)
    vim.lsp.enable(server)
end
vim.lsp.inline_completion.enable();
-- vim.lsp.enable("rust-analyzer", false)


require('mason-nvim-dap').setup({
    handlers = {
        function(config)
            -- all sources with no handler get passed here
            -- Keep original functionality
            require('mason-nvim-dap').default_setup(config)
        end,
    },
})
