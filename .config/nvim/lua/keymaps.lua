local map = vim.keymap.set

-- Yank to end of line
map("n", "Y", "y$")

-- Clear search highlight
map("n", "<Esc><Esc>", ":nohl<CR>")

-- Tab operations
map("n", "tc", ":<C-u>tabnew<CR>:tabmove<CR>")
map("n", "tk", ":<C-u>tabclose<CR>")
map("n", "tn", ":<C-u>tabnext<CR>")
map("n", "tp", ":<C-u>tabprevious<CR>")

-- Terminal → normal mode
map("t", "<Esc>", [[<C-\><C-N>]])
map("t", "<C-[>", [[<C-\><C-N>]])
map("n", "<S-t>", ":terminal<CR>")

-- Char movement in insert mode
map("i", "<C-f>", "<Right>", { silent = true })
map("i", "<C-b>", "<Left>", { silent = true })

-- Japanese-aware BOL/EOL and popup-aware Up/Down.
-- The custom functions operate on display columns with Japanese
-- punctuation as separators; preserved verbatim from the old init.vim.
vim.cmd([=[
  function! MyJumptoBol(sep)
    if col('.') == 1
      call cursor(line('.')-1, col('$'))
      call cursor(line('.'), col('$'))
      return ''
    endif
    if matchend(strpart(getline('.'), 0, col('.')), '[[:blank:]]\+') >= col('.')-1
      silent exec 'normal! 0'
      return ''
    endif
    if a:sep != ''
      call search('[^'.a:sep.']\+', 'bW', line("."))
      if col('.') == 1
        silent exec 'normal! ^'
      endif
      return ''
    endif
    exec 'normal! ^'
    return ''
  endfunction

  function! MyJumptoEol(sep)
    if col('.') == col('$')
      silent exec 'normal! w'
      return ''
    endif
    if a:sep != ''
      let prevcol = col('.')
      call search('['.a:sep.']\+[^'.a:sep.']', 'eW', line("."))
      if col('.') != prevcol
        return ''
      endif
    endif
    call cursor(line('.'), col('$'))
    return ''
  endfunction

  function! MyExecExCommand(cmd, ...)
    let saved_ve = &virtualedit
    let index = 1
    while index <= a:0
      if a:{index} == 'onemore'
        silent setlocal virtualedit+=onemore
      endif
      let index = index + 1
    endwhile
    silent exec a:cmd
    if a:0 > 0
      silent exec 'setlocal virtualedit='.saved_ve
    endif
    return ''
  endfunction

  inoremap <silent> <C-a> <C-r>=MyJumptoBol('　。、．，／！？「」')<CR>
  inoremap <silent> <C-e> <C-r>=MyJumptoEol('　。、．，／！？「」')<CR>
  inoremap <silent> <expr> <Up>   pumvisible() ? "\<C-p>" : "<C-r>=MyExecExCommand('normal k')<CR>"
  inoremap <silent> <expr> <Down> pumvisible() ? "\<C-n>" : "<C-r>=MyExecExCommand('normal j')<CR>"
]=])
