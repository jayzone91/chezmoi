return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = {
        "folke/trouble.nvim",
    },
    config = true,
    keys = {
        { "<leader>xt", "<cmd>TodoTrouble<cr>",   desc = "Todo (Trouble)" },
        {
            "<leader>xT",
            "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
            desc = "Todo/Fix/Fixme (Trouble)",
        },
        { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
        {
            "<leader>sT",
            "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
            desc = "Todo/Fix/Fixme",
        },
    },
}
