# nvitel
A fork from [Prime Render Switch and Status](https://store.kde.org/p/1425330/) for [optimus-manager](https://github.com/Askannz/optimus-manager)

This is a very simple widget for KDE Plasma to get status Nvidia GPU, switch using [optimus-manager](https://github.com/Askannz/optimus-manager) and get the processes that are using the gpu.

#### Prerequisites
<ul>
<li>optimus-manager:lasted - https://github.com/Askannz/optimus-manager</li>
<li>zenity:lasted - https://gitlab.gnome.org/GNOME/zenity</li>
</ul> 

#### Usage/Install

```bash
$ git clone https://github.com/RuiGuilherme/nvitel.git
$ cd nvitel
$ plasmapkg2 -i .                         
$ cd ..
$ rm -rf nvitel
```
now open Widget Menu and search for "Prime".

#### Update/Reinstall

```bash
$ cd ~
$ rm -rf .local/share/plasma/plasmoids/org.kde.plasma.nvitel
$ git clone https://github.com/RuiGuilherme/nvitel.git
$ cd nvitel
$ plasmapkg2 -i .                         
$ cd ..
$ rm -rf nvitel

(optional)
$ kquitapp5 plasmashell && kstart5 plasmashell
```
#### Changelog
1.0 - Initial Release
<br />
1.1 - Minor Changes 
<br />
1.2 - Get list process
<br />
1.3 - Restart and Closed the process using GPU
<br />
1.3.1 - Fix compatibility on bash (zsh is not more a dependencies)

#### Known issue
you tell

#### Screenshot
![ToolTip Menu](https://i.imgur.com/tLFrNMb.png)
<br />
![Select Menu](https://i.imgur.com/Pe9Wvb2.png)
<br />
![Process Menu](https://i.imgur.com/cx9f80c.png)
<br />
![Close/Restart Menu](https://i.imgur.com/dSYDhKq.png)

#### Author
###### Rui Guilherme
[GitHub](https://github.com/RuiGuilherme/)
<br />
[Linkedin](https://www.linkedin.com/in/rui-guilherme/)

#### Contributing
Contributions, issues and feature requests are welcome!
