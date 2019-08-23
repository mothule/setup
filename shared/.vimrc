
" 初期設定
runtime! init/*.vim

inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>
hi CursorLine guifg=#E19972

" 各プラグインの設定
if has('nvim') == 0
  runtime! neobundle/install.vim
  runtime! neobundle/plugins/*.vim
else
  " NeoVim
  "
  " プラグインが実際にインストールされるディレクトリ
  let s:dein_dir = expand('~/.cache/dein')
  " dein.vim 本体
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
  " dein.vim がなければ github から落としてくる
  if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
  endif

  "dein Scripts-----------------------------
  if &compatible
    set nocompatible               " Be improved
  endif

  " Required:
  set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

  " Required:
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " Let dein manage dein
    " Required:
    call dein#add(s:dein_repo_dir)

    " Add or remove your plugins here:
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')

    " You can specify revision/branch/tag.
    call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

    " dein.toml, dein_layz.tomlファイルのディレクトリをセット
    let s:toml_dir = expand('~/.config/nvim')

    " 起動時に読み込むプラグイン群
    call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
"    call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})


    " Required:
    call dein#end()
    call dein#save_state()
  endif

  " Required:
  filetype plugin indent on
  syntax enable

  " If you want to install not installed plugins on startup.
  if dein#check_install()
    call dein#install()
  endif

  colorscheme desert

  "End dein Scripts-------------------------
endif
