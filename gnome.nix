{ config, pkgs, lib, ...}:
{
services.displayManager.gdm.enable = true;
services.desktopManager.gnome.enable = true;
  
## 以上配置即可启用 gnome 桌面
## 以下配置按需选择定制：

  # 精简不想要的服务
  services.packagekit.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    # 精简不想安装的包
    gnome-photos
    gnome-tour
    yelp
    geary
    totem
    gnome-music
    gnome-software
  ];

  environment.systemPackages = with pkgs; [
    gthumb
    notejot
    lollypop

    refine
    dconf-editor
    gnome-power-manager
  ] ++ (with gnomeExtensions; [
    appindicator
    dash-to-dock
    night-theme-switcher
    clipboard-history
    caffeine
  ]);

  # 可以和 kde-connect 协议连接的 gnome 软件
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

}
