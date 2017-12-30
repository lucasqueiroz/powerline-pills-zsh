#!/bin/env ruby
# encoding: utf-8

require 'yaml'
require_relative 'git_util'
include GitUtil

config = YAML.load_file('config.yml')

# VARS

username = ENV['USER']
dir = Dir.pwd
size = `tput cols`.to_i
show_username = config['user']['show']
show_folder = config['folder']['show']
show_git = config['git']['show']
show_cmd = config['cmd']['show']

# ICONS

powerline_icon_right = config['base']['powerline_icon_right']
powerline_icon_left = config['base']['powerline_icon_left']
icon_user = config['user']['icon']['char']
icon_folder = config['folder']['icon']['char']
icon_branch = config['git']['icon']['char']
icon_dirty = config['git']['icon']['char_dirty']
icon_bash = config['cmd']['icon']['char']

# COLORS

def fg_color(color)
  "%F{#{color}}"
end

def bg_color(color)
  "%K{#{color}}"
end

arrow_user = fg_color(config['user']['background_color'])
background_user = bg_color(config['user']['background_color'])
foreground_icon_user = fg_color(config['user']['icon']['color'])
foreground_user = fg_color(config['user']['color'])

arrow_folder = fg_color(config['folder']['background_color'])
background_folder = bg_color(config['folder']['background_color'])
foreground_icon_folder = fg_color(config['folder']['icon']['color'])
foreground_folder = fg_color(config['folder']['color'])

arrow_git = fg_color(config['git']['background_color'])
background_git = bg_color(config['git']['background_color'])
foreground_icon_git = fg_color(config['git']['icon']['color'])
foreground_icon_dirty_git = fg_color(config['git']['icon']['color_dirty'])
foreground_git = fg_color(config['git']['color'])

arrow_cmd_failed = fg_color(config['cmd']['background_color_failed'])
background_cmd_failed = bg_color(config['cmd']['background_color_failed'])
foreground_cmd_failed = fg_color(config['cmd']['color_failed'])
arrow_cmd_success = fg_color(config['cmd']['background_color_success'])
background_cmd_success = bg_color(config['cmd']['background_color_success'])
foreground_cmd_success = fg_color(config['cmd']['color_success'])

background_reset = '%f%k'
color = fg_color(config['base']['color'])

# USER

user = ''
user_spaces = 0
if show_username
  user  = background_reset + arrow_user + powerline_icon_left
  user += background_user + foreground_icon_user + " #{icon_user} "
  user += foreground_user + username + ' '
  user += (show_folder ? background_folder : background_reset) + arrow_user + powerline_icon_right
  user_spaces = (show_folder ? 7 : 6) + username.length
end

# FOLDER

folder = ''
folder_spaces = 0
if show_folder
  unless show_username
    folder = arrow_folder + powerline_icon_left + ''
  end
  folder += background_folder + foreground_icon_folder + " #{icon_folder} "
  folder += foreground_folder + dir + ' '
  folder += background_reset + arrow_folder + powerline_icon_right
  folder_spaces = (show_username ? 4 : 6) + dir.length
end

# GIT

git = ''
git_spaces = 0
if git_dir? && show_git
  git_spaces += 6 + git_branch_name.length
  git  = background_reset + arrow_git+ powerline_icon_left
  git += background_git + foreground_icon_git + " #{icon_branch} "
  git += foreground_git + git_branch_name + ' '
  if git_modified?
    git_spaces += 2
    git += foreground_icon_dirty_git + icon_dirty + ' '
  end
  git += background_reset + arrow_git + powerline_icon_right
end

cmd = ''
if show_cmd
  success = ARGV[0] == '0'
  cmd  = background_reset
  cmd += ((success) ? arrow_cmd_success : arrow_cmd_failed) + powerline_icon_left
  cmd += (success) ? background_cmd_success + foreground_cmd_success : background_cmd_failed + foreground_cmd_failed
  cmd += " #{icon_bash} " + background_reset
  cmd += ((success) ? arrow_cmd_success : arrow_cmd_failed) + powerline_icon_right
  cmd += color + ' '
end

spaces = size - (user_spaces + folder_spaces + git_spaces)

puts user + folder + (' ' * spaces) + git + cmd
