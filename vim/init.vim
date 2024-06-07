" init.vim file for Neovim

" General settings
set wrap
set number

" Plugin management with vim-plug
call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'Heliferepo/VimTek'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'ycm-core/YouCompleteMe'
Plug 'ray-x/lsp_signature.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'ellisonleao/gruvbox.nvim'
call plug#end()

" Key bindings
let mapleader = " "
nnoremap <Leader>. :Files<CR>
nnoremap <Leader>T :NERDTreeToggle<CR>
nnoremap <Leader>F :FloatermToggle<CR>
nnoremap <C-W><Right> <C-W>l
nnoremap <C-W><Left> <C-W>h

" Tab and indentation settings
set tabstop=4       " Number of visual spaces per TAB
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent

" Background setting
set background=dark

" Syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Ack.vim configuration
let g:ackprg = "ag --vimgrep"

" Status line
set laststatus=2
let g:ycm_semantic_triggers = { 'cpp': [ 're!.' ] }
colorscheme gruvbox
nnoremap <F5> :YcmCompleter GetDoc<CR>

lua << EOF
local nvim_lsp = require('lspconfig')
local lsp_signature = require('lsp_signature')
print(lsp_signature)

-- Setup clangd
nvim_lsp.clangd.setup{
  on_attach = function(client, bufnr)
    print("Attaching lsp_signature")
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Setup lsp_signature
    lsp_signature.on_attach({
      bind = true,
      handler_opts = {
        border = "single"
      },
      floating_window = true,
      hint_enable = false,
    }, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  }
}
EOF
