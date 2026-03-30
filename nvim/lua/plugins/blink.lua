return {
	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = {
					-- 优先级：blink 补全菜单 > Copilot 建议 > snippet 跳转 > 正常 Tab
					"select_and_accept",
					function(cmp)
						local ok, copilot = pcall(require, "copilot.suggestion")
						if ok and copilot.is_visible() then
							copilot.accept()
							return true
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
		},
	},
}
