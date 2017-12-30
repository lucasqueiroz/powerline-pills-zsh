#!/bin/env ruby
# encoding: utf-8

require 'yaml'
require_relative 'util'
include Util

# VARS

username = ENV['USER']
dir = Dir.pwd
size = `tput cols`.to_i
path = ENV['POWERLINE_PILLS']

config = YAML.load_file(path + '/config.yml')
show_os = config['os']['show']
show_username = config['user']['show']
show_folder = config['folder']['show']
show_git = config['git']['show']
show_date = config['date']['show']
show_cmd = config['cmd']['show']

date_format = config['date']['format']
cur_date = `date +#{date_format}`.to_s.chomp

# ICONS

powerline_icon_right = config['base']['powerline_icon_right']
powerline_icon_left = config['base']['powerline_icon_left']
icon_linux = config['os']['icon_linux']
icon_darwin = config['os']['icon_darwin']
icon_user = config['user']['icon']['char']
icon_folder = config['folder']['icon']['char']
icon_branch = config['git']['icon']['char']
icon_dirty = config['git']['icon']['char_dirty']
icon_date = config['date']['icon']['char']
icon_bash = config['cmd']['icon']['char']

# COLORS

def fg_color(color)
  "%F{#{color}}"
end

def bg_color(color)
  "%K{#{color}}"
end

arrow_os = fg_color(config['os']['background_color'])
background_os = bg_color(config['os']['background_color'])
foreground_os = fg_color(config['os']['color'])

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

arrow_date = fg_color(config['date']['background_color'])
background_date = bg_color(config['date']['background_color'])
foreground_icon_date = fg_color(config['date']['icon']['color'])
foreground_date = fg_color(config['date']['color'])

arrow_cmd_failed = fg_color(config['cmd']['background_color_failed'])
background_cmd_failed = bg_color(config['cmd']['background_color_failed'])
foreground_cmd_failed = fg_color(config['cmd']['color_failed'])
arrow_cmd_success = fg_color(config['cmd']['background_color_success'])
background_cmd_success = bg_color(config['cmd']['background_color_success'])
foreground_cmd_success = fg_color(config['cmd']['color_success'])

background_reset = '%f%k'
color = fg_color(config['base']['color'])

# OS

os = ''
if show_os && (darwin? || linux?)
  os  = background_reset + arrow_os + powerline_icon_left
  os += background_os + ' ' + foreground_os + (darwin? ? icon_darwin : icon_linux) + ' '
  os += (show_username ? background_user : (show_folder ? background_folder : background_reset)) + arrow_os + powerline_icon_right
end
os_spaces = clean_str(os).size

# USER

user = ''
if show_username
  user = arrow_user + powerline_icon_left unless show_os  
  user += background_user + foreground_icon_user + " #{icon_user} "
  user += foreground_user + username + ' '
  user += (show_folder ? background_folder : background_reset) + arrow_user + powerline_icon_right
end
user_spaces = clean_str(user).size

# FOLDER

# so os n
# so user n
# user + os s
# s

folder = ''
if show_folder
  folder = arrow_folder + powerline_icon_left unless show_os && show_username  
  space_before_icon = (show_os && show_username ? true : (show_os || show_username ? false : true))
  folder += background_folder + foreground_icon_folder + (space_before_icon ? ' ' : '') + "#{icon_folder} "
  folder += foreground_folder + dir + ' '
  folder += background_reset + arrow_folder + powerline_icon_right
end
folder_spaces = clean_str(folder).size

# GIT

git = ''
if git_dir? && show_git
  git  = background_reset + arrow_git+ powerline_icon_left
  git += background_git + foreground_icon_git + " #{icon_branch} "
  git += foreground_git + git_branch_name + ' '
  git += foreground_icon_dirty_git + icon_dirty + ' ' if git_modified?
  git += (show_date ? background_date : background_reset) + arrow_git + powerline_icon_right
end
git_spaces = clean_str(git).size

# DATE

date = ''
if show_date
  date += arrow_date + powerline_icon_left unless git_dir? && show_git
  date += background_date + foreground_icon_date + " #{icon_date} "
  date += foreground_date + cur_date + ' '
  date += background_reset + arrow_date + powerline_icon_right
end
date_spaces = clean_str(date).size

# CMD

cmd = "\n"
if show_cmd
  success = ARGV[0] == '0'
  cmd += background_reset
  cmd += ((success) ? arrow_cmd_success : arrow_cmd_failed) + powerline_icon_left
  cmd += (success) ? background_cmd_success + foreground_cmd_success : background_cmd_failed + foreground_cmd_failed
  cmd += " #{icon_bash} " + background_reset
  cmd += ((success) ? arrow_cmd_success : arrow_cmd_failed) + powerline_icon_right
  cmd += color + ' '
end

spaces = size - (os_spaces + user_spaces + folder_spaces + git_spaces + date_spaces)

puts os + user + folder + (' ' * spaces) + git + date + cmd
