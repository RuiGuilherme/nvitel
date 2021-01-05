# nvitel
A fork from [Prime Render Switch and Status](https://store.kde.org/p/1425330/) for [optimus-manager](https://github.com/Askannz/optimus-manager)

This is a very simple widget for KDE Plasma to get status Nvidia GPU, switch using [optimus-manager](https://github.com/Askannz/optimus-manager) and get the processes that are using the gpu.

#### Prerequisites
<ul>
<li>optimus-manager:lasted</li>
<li>zsh:lasted</li>
</ul> 

#### Usage/Install

```bash
$ git clone https://github.com/RuiGuilherme/nvitel.git
$ cd nvitel
$ plasmapkg2 -i .                         
$ cd ..
$ rm -rf nvitel
```

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


now open Widget Menu and search for "Prime".

#### Known issue
For some reason bash don't run script correctly, that a reason zsh is a prerequisite, in the future I will correct this problem.

#### Screenshot
![ToolTip Menu](https://i.imgur.com/tLFrNMb.png)
<br />
![Select Menu](https://i.imgur.com/Pe9Wvb2.png)
<br />
![Process Menu](https://i.imgur.com/paDrdGe.png)

#### Author
###### Rui Guilherme
[GitHub](https://github.com/RuiGuilherme/)
<br />
[Linkedin](https://www.linkedin.com/in/rui-guilherme/)

#### Contributing
Contributions, issues and feature requests are welcome!
