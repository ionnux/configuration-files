call plug#begin('~/.nvim/plugged')
Plug 'easymotion/vim-easymotion'
"Plug 'frazrepo/vim-rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'udalov/kotlin-vim'
"syntax highlighter for javascript
"Plug 'yuezk/vim-js'
Plug 'simnalamburt/vim-mundo'
" Plug 'mbbill/undotree'
Plug 'ryanoasis/vim-devicons'
"Plug 'justinmk/vim-sneak'
Plug 'preservim/nerdtree'
Plug 'preservim/vimux'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'nvim-telescope/telescope.nvim'
" Plug 'kassio/neoterm'
" Plug 'jalvesaq/vimcmdline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'gruvbox-community/gruvbox'
" Plug 'dracula/vim',{'name':'dracula'}
" Plug 'joshdick/onedark.vim'
Plug 'mhinz/vim-startify'
" Plug 'roman/golden-ratio'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" Plug 'christoomey/vim-tmux-navigator'
call plug#end()

"nvim settings

"gruvbox settings
"set gruvbox contrast to hard. put this before the colorscheme setting
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
" let g:gruvbox_italic = 1

colorscheme gruvbox
" colorscheme dracula

"highlight settings for cusorline
function ColorSettings()

    if g:colors_name ==# "gruvbox"
        hi CocHighlightText guibg=#504945
        hi CocFloating guibg=#3c3836
        hi CocErrorFloat guifg=#ebdbb2
        hi CocErrorLine guibg=#282828
        hi CursorLine guibg=None
        hi CursorLineNr guifg=#fabd2f
        hi CursorLineNr guibg=None
        hi Pmenu guibg=#a89984
        hi Pmenu guifg=#282828
        hi PmenuSel guibg=#3c3836
        hi PmenuSel guifg=#fabd2f
        hi PmenuSbar guibg=#bdae93
        hi PmenuThumb guibg=#504945
        let g:airline_theme = 'base16_gruvbox_dark_hard'
    elseif g:colors_name ==# "dracula"
        hi CursorLine guibg=None
        hi CursorLineNr guifg=#f1fa8c
        hi CursorLineNr guibg=None
        "hi CocFloating guibg=#282828
        hi CocHighlightText guibg=#44475a
        " hi CocHighlightText guifg=#282a36
        hi CocErrorSign guifg=#ff79c6
    endif

endfunction
augroup Color
    autocmd!
    autocmd ColorScheme * :call ColorSettings()
augroup END



"show line number
set number

"show relative number
set relativenumber
"settings for when to show relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * set norelativenumber
augroup END



"set number of lines to keep above and below when scrolling
set scrolloff=8

"increase nvim command timeout from 1000 to 2000
"set timeoutlen=2000

"hide insert display in insert mode
set noshowmode

"set tab to have 4 spaces
set tabstop=4

"i'm setting this because of vi mundo
set undodir=~/.nvim/undo
set undofile

"expand tabs into spaces
set expandtab

"when using << or >> commands, indent line by 4 spaces
set shiftwidth=4
set completeopt=menuone,noinsert,noselect

"set sign column to always on
" set signcolumn=yes

"force nvim to use 256 color
set termguicolors

"open horizontal splits below the current window
set splitbelow

"do not highlight search
set nohlsearch

"open vertical splits to the right of the current window
set splitright

"highlight cursorline
set cursorline

"nvim mappings

"use space key as leader
nnoremap <SPACE> <Nop>
let mapleader=" "

"map <leader>ev to edit my vimrc file
nnoremap <silent><leader>ev :call EditVimrc()<cr>
function EditVimrc()
    if winwidth('.') > 110
        :vs $MYVIMRC
    else
        :e $MYVIMRC
    endif
endfunction

"map <leader>; to add delimiter to end of line.
nnoremap <leader>; :call Delimiter()<cr>
function Delimiter()
    let cursr_pos = getpos(".")
    if &filetype ==# "javascript"
        if getline(".")[-1:] != ";"
            execute "normal! A;\<esc>"
            call setpos(".", cursor_pos)
        else
            execute "normal! $x"
            call setpos(".", cursor_pos)
        endif
    elseif &filetype ==# "json"
        if getline(".")[-1:] != ","
            execute "normal! A,\<esc>"
            call setpos(".", cursor_pos)
        else
            execute "normal! $x"
            call setpos(".", cursor_pos)
        endif
    endif
endfunction

"map <leader>sv to source my vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

" map <leader>st to startify
nnoremap <leader>st :Startify<cr>

"press ctrl l to go to the end of line in insert mode
inoremap <c-l> <c-o>A

"use <leader>ww to write files
nnoremap <silent><leader>ww :w<cr>
nnoremap <silent><leader>wq :x<cr>


"use jk to go to normal mode from insert mode
inoremap jk <Esc>

syntax on

"let me use escape key to go to normal mode from terminal mode
if has('nvim')
    "tnoremap <ESC> <C-\><C-n>
    "tnoremap <C-v><ESC> <ESC>
    tnoremap jk <C-\><C-n>
    tnoremap <C-h> <backspace>
endif

autocmd TermEnter * set timeoutlen=500
autocmd TermLeave * set timeoutlen=1000



"easymotion settings
let g:EasyMotion_verbose = 0
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
let g:EasyMotion_smartcase = 1

"two character search
"nmap s <Plug>(easymotion-s2)
"nmap t <Plug>(easymotion-t2)

"n character search
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)



"ultisnips settings
let g:UltiSnipsExpandTrigger = '<nop>'

"vim-rainbow settings
"let g:rainbow_active = 1


"nerdtree settings
"nnoremap <leader>nn :NERDTree<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nt :NERDTreeFocus<CR>
nnoremap <leader>nn :NERDTreeToggle<CR>



"neoterm settings
"map <leader>ii to toggling neoterm
nnoremap <silent> <leader>ii :<c-u>exec v:count.'Ttoggle'<cr>

"map <leader>id to deleting neoterm buffer
nnoremap <silent><leader>id :Tclose!<cr>

"map <leader>if to send current file to REPL
nnoremap <silent> <leader>if :TREPLSendFile<cr>

"map <leader>il to send current line to REPL
nnoremap <silent> <leader>il :TREPLSendLine<cr>

"map <leader>is to send current selection to REPL
vnoremap <silent> <leader>is :TREPLSendSelection<cr>

"Open the neoterm in a vertical split if current window width is bigger than 100, otherwise use a horizontal split.
let g:neoterm_callbacks = {}
function! g:neoterm_callbacks.before_new()
  if winwidth('.') > 110
    let g:neoterm_default_mod = 'botright vertical'
  else
    let g:neoterm_default_mod = 'botright'
  end
endfunction

"let g:neoterm_bracketed_paste = 1
"use bracketed paste for python
autocmd filetype python let g:neoterm_bracketed_paste = 1

"don't use bracketed paste for python
autocmd filetype javascript let g:neoterm_bracketed_paste = 0

"let g:neoterm_autojump = 1
let g:neoterm_autoscroll = 1
let g:neoterm_repl_python = 'ipython'


"autopairs settings
let g:AutoPairsFlyMode = 1



"airline settings
"this setting automatically populate the g:airline_symbols dictionary with the powerline symbols.
let g:airline_powerline_fonts = 1

"enable/disable bufferline integration >
"let g:airline#extensions#bufferline#enabled = 1

"determine whether bufferline will overwrite customization variables >
"let g:airline#extensions#bufferline#overwrite_variables = 1

"enable tabline
let g:airline#extensions#tabline#enabled = 1

"show buffer number in tabline
let g:airline#extensions#tabline#buffer_nr_show = 1

"tabline formatter
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"startify settings
"startify bookmark setting
let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'}]
"startify indices setting
let g:startify_custom_indices = ['g', 'f', 'd', 's', 'a']
"automatically set airline theme to gruvbox whenever startify starts


"coc settings
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
"set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qq <Plug>(coc-codelens-action)

" Format the current buffer
nmap <leader>f <Plug>(coc-format)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')



"<CR> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

"use <Tab> to navigate to the next completio"n
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

"use <S-Tab> to navigate to the previous completion
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

"Map <c-space> to trigger completion: >
inoremap <silent><expr> <c-space> coc#refresh()


"Python
"Run python code
autocmd filetype python nnoremap <silent><leader>rr :w \| sp \| set nonumber \| terminal python <C-r>\%<Cr>

"Debug python code
autocmd filetype python nnoremap <silent><leader>dd :w \| sp \| set nonumber \| terminal ipdb3 <C-r>\%<Cr>

"coc-yank settings
"autocmd filetype python nnoremap <silent> <Leader>y  :<C-u>CocList -A --normal yank<cr>

"javascript
"Run javascript code
autocmd filetype javascript nnoremap <silent><leader>rr :w \| sp \| set nonumber \| terminal node <C-r>\%<Cr>



"indentline settings
let g:indentLine_char = '┊'



"vim-maximizer settings
nnoremap <silent><leader>m :MaximizerToggle!<CR>
vnoremap <silent><leader>m :MaximizerToggle!<CR>gv



"fzf settings
nnoremap <silent><leader>ff :Files<cr>
nnoremap <silent><leader>fif :Rg<cr>
nnoremap <silent><leader>fb :Buffers<cr>
nnoremap <silent><leader>fbl :BLines<cr>
nnoremap <silent><leader>fh :History<cr>
nnoremap <silent><leader>fc :Commands<cr>
nnoremap <silent><leader>fch :History:<cr>
nnoremap <silent><leader>fsh :History/<cr>
nnoremap <silent><leader>fcs :Colors<cr>



"vim mundo settings
nnoremap <silent><leader>vm :MundoToggle<cr>

"undotree settings
nnoremap <silent><leader>ut :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
"let g:mundo_inline_undo = 1

" autocmd BufReadPost *.kt setlocal filetype=kotlin

" compile and run kotlin code
" autocmd filetype kotlin nnoremap <silent><leader>rr :w \| sp \| set nonumber \| terminal kotlinc <C-r>\% -include-runtime -d <C-r>\%.jar && java -jar <C-r>\%.jar<Cr>
autocmd filetype kotlin nnoremap <silent><leader>rr :call VimuxRunCommand("kotlinc <c-r>\%.jar && java -jar <c-r>\%.jar")


let maplocalleader = "\\"
" vimcmdline settings
" let cmdline_map_source_fun = '<LocalLeader>vf'
" let cmdline_map_source_start = '<LocalLeader>vs'


"vim split window settings
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>
nnoremap <silent><leader>\| <c-w>v
nnoremap <silent><leader>- <c-w>s

" vimux settings
" Prompt for a command to run
map <leader>vp :VimuxPromptCommand<cr>
" Run last command executed by VimuxRunCommand
map <leader>vl :VimuxRunLastCommand<cr>
