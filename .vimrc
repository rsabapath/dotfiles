syntax on
set number
set nowrap " forces style
set autoindent
set copyindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab " makes you go back 2 when you del from tab
set hlsearch " highlight all matches in a file when searching
set incsearch " incrementally highlight your searches
set pastetoggle=<F8>
set nobackup " remove backups from vim
set noswapfile " remove backups from vim
set smartcase " use caps if any caps used in search
set laststatus=2 " forces showing status bar
set encoding=utf-8 " order matters for Windows (encoding+autochdir)
set autochdir
set title " modifies window to have filename as its title
set shell=/bin/bash
set viminfo='10,\"100,:20,%,n~/.viminfo " saves position in files
nnoremap ,, <C-^>
let mapleader=","

cnoremap %g <C-R>=FindParentGit("true")<cr>
cnoremap %G <C-R>=FindParentGit("")<cr>

silent!colorscheme desert

nnoremap ; :
" mappings
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>dw :%s/\v +\n/\r/g<CR> " when substituting, \r is newline
nnoremap / /\v
nnoremap Y 0y$

nnoremap <S-h> gT
nnoremap <S-l> gt
nnoremap <Right> <C-w>l
nnoremap <Left> <C-w>h
nnoremap <Up> <C-w>k
nnoremap <Down> <C-w>j

inoremap jk <esc>
inoremap <esc> <nop>

highlight TrailingWhiteSpace ctermbg=yellow guibg=yellow
match TrailingWhiteSpace /\v +\n/

" Status line settings {{{
set statusline=%.40F " write full path to file, max of 40 chars
set statusline+=%h%m%r " help file, modified, and read only
set statusline+=\ col=%v " column number
set statusline+=\ Buf\=%n " Buffer number
set statusline+=\ %y " Filetype
set statusline+=\ char=\[%b\]
set statusline+=\ %=%l/%L\ (%p%%)\ \  " right align percentages
" }}}

" Command-T
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT $HOME<cr>
map <leader>g :CommandTFlush<cr>\|:CommandT %g<cr>
map <leader>G :CommandTFlush<cr>\|:CommandT %G<cr>

function! FindParentGit(gitIgnore)
  let x = system('find_parent_git')
  let x = substitute(x, '\n$', '', '')

  " if we find no parent git, return .git
  " this is a little silly, but it means Command-T will react properly
  if x == "no parent git found"
    return ".git"
  endif

  " if the root folder contains a gitignore, let's add that to wildignore
  let filename = x . '/.gitignore'
  if filereadable(filename)
      let igstring = ''
      for oline in readfile(filename)
          let line = substitute(oline, '\s|\n|\r', '', "g")
          if line =~ '^#' | con | endif
          if line == '' | con  | endif
          if line =~ '^!' | con  | endif
          if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
          let igstring .= "," . line
      endfor
      if a:gitIgnore == "true"
        let execstring = "set wildignore+=".substitute(igstring, '^,', '', "g")
      else
        " may be problematic in niche cases, for now it'll do
        let execstring = "set wildignore-=".substitute(igstring, '^,', '', "g")
      endif
      execute execstring
  endif

  return x
endfunction

call pathogen#infect()
call pathogen#helptags()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
autocmd FileType javascript nnoremap <leader>j :call JsBeautify()<CR>
