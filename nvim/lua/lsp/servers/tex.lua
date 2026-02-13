local M = {}

function M.setup()
	-- LaTeX Language Server with detailed build configuration
	vim.lsp.config('texlab', {
		cmd = { 'texlab' },
		filetypes = { 'tex', 'plaintex', 'bib' },
		root_markers = { '.latexmkrc', '.git' },
		settings = {
			texlab = {
				bibtexFormatter = "texlab",
				build = {
					args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
					executable = "latexmk",
					forwardSearchAfter = false,
					onSave = true
				},
				chktex = {
					onEdit = false,
					onOpenAndSave = false
				},
				diagnosticsDelay = 300,
				formatterLineLength = 80,
				forwardSearch = {
					args = {}
				},
				latexFormatter = "latexindent",
				latexindent = {
					modifyLineBreaks = false
				}
			}
		},
		capabilities = {
			textDocument = {
				formatting = {
					dynamicRegistration = false
				}
			}
		}
	})

	-- Enable the server
	vim.lsp.enable('texlab')
end

return M
