return {
  --     <leader>a in normal mode: function under the cursor
  --     <leader>a in visual mode, or :'<,'>Asm: selected lines
  --     In the window: +/- change -O level, R reruns, q closes
  --
  -- Needs cc/c++ or rustc/cargo on PATH. Uses compile_commands.json if it finds one.
  "0xdeadf1sh/AssemblyForNeovim",
  config = function()
    require("asm").setup()
  end,
}
