if v:version > 500
	colorscheme koehler	            " dark colorscheme
endif

syntax enable 			            " pretty codes

set tabstop=8			            " common 8 spaces wide, no expansion
set shiftwidth=8
set softtabstop=8
set noexpandtab

filetype indent on				" load filetype-specific ident files

set showcmd			                " show commands on status line
set cursorline					" underline current line

set number				        " line numbers
set numberwidth=4				" gutter width

set showmatch					" highlight matching parens
set lazyredraw					" only redraw on demand/when needed
set incsearch					" enable incremental searches
set hlsearch					" enable search result highlighting

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

set foldenable			" enable folding
set foldlevelstart=4		" fold levels 5 and beyond on startup
set foldnestmax=8		" limit folding to 8 levels of code

set foldmethod=indent		" base folding on indentation	

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShapre=0\x7"
endif

" overrides language-specific styles/settings for file types/extensions
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.tzt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()

    autocmd FileType go setlocal noexpandtab
    autocmd FileType go setlocal tabstop=4
    autocmd FileType go setlocal shiftwidth=4 
    autocmd FileType go setlocal softtabstop=4
    autocmd FileType go setlocal signcolumn=yes

    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4

    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4

    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s

    autocmd FileType python setlocal expandtab
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType python setlocal signcolumn=yes
    autocmd FileType python setlocal commentstring=#\ %s

    autocmd FileType vim setlocal expandtab
    autocmd FileType vim setlocal tabstop=4
    autocmd FileType vim setlocal shiftwidth=4
    autocmd FileType vim setlocal softtabstop=4
    autocmd FileType vim setlocal signcolumn=yes

    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

" transient editor state file management
set backup
set backupdir=$HOME/vimfiles/back//
set directory^=$HOME/vimfiles/swap//
set undodir=$HOME/vimfiles/undo//
set writebackup

" custom function to trim whitespace (used in augroup)
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" enable signcolumn
set signcolumn=yes

" disable menubar in gvim
set guioptions-=m

" disable toolbar in gvim
set guioptions-=T

" disable right scrollbar in gvim
set guioptions-=r

