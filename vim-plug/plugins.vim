" Plugins will be downloaded under the specified directory.
call plug#begin('C:\Users\User\AppData\Local\nvim\autoload\plugged')

" Declare the list of plugins.
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Alternate lsp: (Use 'CocInstall coc-json coc-csharp-ls' to install csharp language server)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

"I cannot get this to work :c"
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
