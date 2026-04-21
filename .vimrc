let mapleader = " "
set relativenumber
set hidden
syntax on
set ignorecase smartcase
set path+=/Users/mac221/workspace/g1103/game/**
set wildignore+=*/node_modules/*,*/.git/*,*.tmp,*.swp
set ruler

"python3
"map <leader>j :%!python3 -m json.tool<CR>

" ===== Ripgrep 搜索配置 =====
" 使用 ripgrep 搜索当前目录
command! -nargs=+ -complete=file Rg execute 'grep! <args>' | copen

" 快捷键：\rg 搜索光标下的单词
nnoremap \rg :execute "grep! " . expand("<cword>")<CR>
nnoremap \rG :grep!<Space>

" 搜索结果自动打开 quickfix 窗口
autocmd QuickFixCmdPost [^l]* cwindow
autocmd QuickFixCmdPost l* lwindow

" 设置使用 ripgrep 作为 grep 程序
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m

augroup highlightYankedText
  autocmd!
  autocmd TextYankPost * call FlashYankedText()
augroup END

function! FlashYankedText()
  " 使用 IncSearch 样式高亮被 yank 的区域
  let id = matchadd('IncSearch', "\\%>'\\[\\_.*\\%<']..")
  call timer_start(300, {-> matchdelete(id)})
endfunction
