return {
    settings = {
        scss = { validate = false },
        editor = {
            quickSuggestions = { strings = true },
            autoClosingQuotes = "always",
        },
        tailwindCSS = {
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
            },
            experimental = {
                classRegex = {
                    "cva\\(([^)]*)\\)",
                    'cn\\("([^\\"]*)"\\)',
                    "cn\\('([^\\']*)'\\)",
                    "ClassName\\('([^\\']*)'\\)",
                },
            },
            includeLanguages = {
                typescript = "javascript",
                typescriptreact = "javascript",
            },
        },
    },
}
