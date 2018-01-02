#!/bin/env ruby
# encoding: utf-8

require 'yaml'
require_relative 'util'
require_relative 'pill'
include Util

# VARS
last_exit = ARGV[0] == '0'
username = ENV['USER']
dir = Dir.pwd
size = `tput cols`.to_i
path = ENV['POWERLINE_PILLS']

config = YAML.load_file(path + '/config.yml')

date_format = config['date']['format']
cur_date = `date +#{date_format}`.to_s.chomp
config_left_top = config['base']['left_top']
config_right_top = config['base']['right_top']
config_left_bottom = config['base']['left_bottom']

# ICONS
powerline_icon_right = config['base']['powerline_icon_right']
powerline_icon_left = config['base']['powerline_icon_left']
icon_linux = config['os']['icon_linux']
icon_darwin = config['os']['icon_darwin']
icon_os = linux? ? icon_linux : icon_darwin
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

background_os = bg_color(config['os']['background_color'])
foreground_os = fg_color(config['os']['color'])

background_user = bg_color(config['user']['background_color'])
foreground_icon_user = fg_color(config['user']['icon']['color'])
foreground_user = fg_color(config['user']['color'])

background_folder = bg_color(config['folder']['background_color'])
foreground_icon_folder = fg_color(config['folder']['icon']['color'])
foreground_folder = fg_color(config['folder']['color'])

background_git = bg_color(config['git']['background_color'])
foreground_icon_git = fg_color(config['git']['icon']['color'])
foreground_icon_dirty_git = fg_color(config['git']['icon']['color_dirty'])
foreground_git = fg_color(config['git']['color'])

background_date = bg_color(config['date']['background_color'])
foreground_icon_date = fg_color(config['date']['icon']['color'])
foreground_date = fg_color(config['date']['color'])

background_cmd_failed = bg_color(config['cmd']['background_color_failed'])
foreground_cmd_failed = fg_color(config['cmd']['color_failed'])
background_cmd_success = bg_color(config['cmd']['background_color_success'])
foreground_cmd_success = fg_color(config['cmd']['color_success'])

background_reset = '%f%k'
color = fg_color(config['base']['color'])

# PILLS
os_pill = Pill.new(background_os, foreground_os, icon_os)

user_pill = Pill.new(background_user, foreground_icon_user, icon_user,
                     foreground_user, username)

folder_pill = Pill.new(background_folder, foreground_icon_folder, icon_folder,
                       foreground_folder, dir)

git_text = nil
if git_dir?
  git_text = foreground_git + git_branch_name
  git_text += ' ' + foreground_icon_dirty_git + icon_dirty if git_modified?
end
git_pill = Pill.new(background_git, foreground_icon_git, icon_branch,
                    foreground_git, git_text)

date_pill = Pill.new(background_date, foreground_icon_date, icon_date,
                     foreground_date, cur_date)

background_cmd = last_exit ? background_cmd_success : background_cmd_failed
foreground_cmd = last_exit ? foreground_cmd_success : foreground_cmd_failed
cmd_pill = Pill.new(background_cmd, foreground_cmd, icon_bash)

pill_names = { os: os_pill, user: user_pill, folder: folder_pill,
               git: git_pill, date: date_pill, cmd: cmd_pill }

left_top = []
right_top = []
left_bottom = []

config_left_top.each do |clt|
  left_top.push(pill_names[clt.to_sym]) unless pill_names[clt.to_sym].nil?
end

config_right_top.each do |crt|
  right_top.push(pill_names[crt.to_sym]) unless pill_names[crt.to_sym].nil?
end

config_left_bottom.each do |clb|
  left_bottom.push(pill_names[clb.to_sym]) unless pill_names[clb.to_sym].nil?
end

# LEFT (TOP)
left_top.delete(git_pill) if git_text.nil?
str_left_top = ''
left_top[0...-1].each_with_index do |l, i|
  str_left_top += l.join(powerline_icon_left, powerline_icon_right,
                         left_top[i + 1], i.zero?)
end
str_left_top += left_top[-1].join(powerline_icon_left, powerline_icon_right,
                                  nil, left_top.size == 1)

# RIGHT (TOP)
right_top.delete(git_pill) if git_text.nil?
str_right_top = ''
right_top[0...-1].each_with_index do |r, i|
  str_right_top += r.join(powerline_icon_left, powerline_icon_right,
                          right_top[i + 1], i.zero?)
end
str_right_top += right_top[-1].join(powerline_icon_left, powerline_icon_right,
                                    nil, right_top.size == 1)

# LEFT (BOTTOM)
left_bottom.delete(git_pill) if git_text.nil?
str_left_bottom = ''
left_bottom[0...-1].each_with_index do |l, i|
  str_left_bottom += l.join(powerline_icon_left, powerline_icon_right,
                            left_bottom[i + 1], i.zero?)
end
str_left_bottom += left_bottom[-1].join(powerline_icon_left,
                                        powerline_icon_right, nil,
                                        left_bottom.size == 1)

spaces = size - (clean_str(str_left_top).size + clean_str(str_right_top).size)
puts str_left_top + (' ' * spaces) + str_right_top + str_left_bottom + ' ' +
     background_reset + color
