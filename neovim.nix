# /etc/nixos/neovim.nix
{ config, pkgs, ... }:

let
  # 创建带配置的 neovim
  myNeovim = pkgs.neovim.override {
    viAlias = true;
    vimAlias = true;
    
    configure = {
      customRC = ''
        " 基础设置
        set number              " 显示行号
        set relativenumber      " 相对行号
        set tabstop=4           " Tab宽度
        set shiftwidth=4        " 缩进宽度
        set expandtab           " Tab转空格
        syntax on               " 语法高亮
        filetype plugin indent on " 文件类型检测
        
        " 搜索设置
        set ignorecase          " 搜索忽略大小写
        set smartcase           " 智能大小写
        set hlsearch            " 高亮搜索结果
        
        " 界面
        set mouse=a             " 启用鼠标
        set termguicolors       " 真彩色支持
        
        " 快捷键
        nnoremap <leader>w :w<CR>    " 保存
        nnoremap <leader>q :q<CR>    " 退出
        nnoremap <leader>Q :q!<CR>   " 强制退出
        inoremap jk <Esc>
        " 主题（使用默认主题）
      '';
      
      packages.myVimPackages = with pkgs.vimPlugins; {
        start = [
          vim-nix      # Nix 语法高亮
          vim-fugitive # Git 支持
        ];
      };
    };
  };
in
{
  environment.systemPackages = [
    myNeovim
  ] ++ (with pkgs; [
    # 基本工具
    nil          # Nix LSP
    ripgrep      # 搜索
    fd           # 文件查找
    nixpkgs-fmt  # Nix 格式化
  ]);
  
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
