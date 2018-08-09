# Powerline Pills Theme for ZSH

Custom ZSH theme created in Ruby, using powerline characters to simulate pills with useful information.

## Installation

⚠️ WARNING: If you installed this theme before January 2nd, 2018, you will need to install it again! ⚠️

Ruby (tested with 1.9.3), ZSH and Oh-my-zsh are required for this theme.

This requires a powerline patched font to work properly. I recommend using one of the [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts).

<details>
<summary>Steps to install (automatic)</summary>

1. Clone this repository:  
  `git clone git@github.com:lucasqueiroz/powerline-pills-zsh.git`
2. Cd into the folder that you cloned, then into the `install` folder
3. Run the following command to install the theme (Warning: it will change your current zsh theme!)  
  `./install.zsh`
4. Reload your terminal (or open a new tab)

</details>

<details>
<summary>Steps to install (manual)</summary>

1. Clone this repository:  
  `git clone https://github.com/lucasqueiroz/powerline-pills-zsh.git`
2. Cd into the folder that you cloned
3. Copy the `powerline-pills.zsh-theme` file to your oh-my-zsh's `custom` folder (Usually found in `~/.oh-my-zsh/custom`)
4. Edit the `~/.zshrc` file and set `powerline-pills` as the current theme
5. Add this to the end of the `~/.zshrc` file:  
```bash
# Powerline Pills Theme
export POWERLINE_PILLS="<powerline-pills folder>"
```
Replacing `<powerline-pills folder>` with the folder that you cloned this repository into.

</details>

## Configuration
The configuration file (`config.yml`) has options for you to customize this theme.
The `left_top`, `right_top` and `left_bottom` configurations under `base` let you configure which pills you want on each part.

## Screenshots

<details>
<summary>Click to view the screenshots</summary>

### Default config (Non-git folder)

![Screenshot 1](https://github.com/lucasqueiroz/powerline-pills-zsh/blob/master/screenshots/screenshot_1.png?raw=true)

### Without date (Git folder)

![Screenshot 2](https://github.com/lucasqueiroz/powerline-pills-zsh/blob/master/screenshots/screenshot_2.png?raw=true)

### Command output

![Screenshot 3](https://github.com/lucasqueiroz/powerline-pills-zsh/blob/master/screenshots/screenshot_3.png?raw=true)

</details>
