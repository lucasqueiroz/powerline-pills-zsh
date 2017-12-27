require_relative 'git_util'
include GitUtil

icon_arrow_left = ''
icon_arrow_right = ''
icon_user = ''
icon_folder = ''
icon_branch = ''
icon_dirty = ''
icon_bash = ''

foreground = '%F{7}'
background_user = '%K{2}'
foreground_user = '%F{2}'
background_folder = '%K{8}'
foreground_folder = '%F{8}'
background_git = '%K{9}'
foreground_git = '%F{9}'
foreground_git_dirty = '%F{11}'
background_cmd_success = '%K{4}'
foreground_cmd_success = '%F{4}'
background_cmd_fail = '%K{1}'
foreground_cmd_fail = '%F{1}'
background_reset = '%f%k'

username = ENV['USER']
dir = Dir.pwd

size = `tput cols`.to_i

user = background_reset + foreground_user + icon_arrow_left + background_user + foreground + " #{icon_user} #{username} " + background_folder + foreground_user + icon_arrow_right
user_spaces = 7 + username.length
folder = background_folder + foreground + " #{icon_folder} #{dir} " + background_reset + foreground_folder + icon_arrow_right
folder_spaces = 4 + dir.length

git = ''
git_spaces = 0
if git_dir?
  git_spaces += 6 + git_branch_name.length
  git = background_reset + foreground_git + icon_arrow_left + background_git + foreground + " #{icon_branch} #{git_branch_name} "
  if git_modified?
    git_spaces += 2
    git += foreground_git_dirty + icon_dirty + ' '
  end
  git += background_reset + foreground_git + icon_arrow_right
end

spaces = size - (user_spaces + folder_spaces + git_spaces)

cmd = (ARGV[0] == '0') ? background_reset + foreground_cmd_success + icon_arrow_left + background_cmd_success : background_reset + foreground_cmd_fail + icon_arrow_left + background_cmd_fail
cmd += foreground + " #{icon_bash}  " + background_reset
cmd += (ARGV[0] == '0') ? foreground_cmd_success : foreground_cmd_fail
cmd += icon_arrow_right + foreground + ' '

puts user + folder + (' ' * spaces) + git + cmd
