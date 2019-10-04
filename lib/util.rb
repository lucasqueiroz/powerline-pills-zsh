# Utilities that helps with the theme
module Util
  def git_dir?
    system('git rev-parse --short HEAD >/dev/null 2>&1')
  end

  def git_branch_name
    `git branch | grep \\* | cut -d ' ' -f2`.delete("\n")
  end

  def git_modified?
    !`git status --porcelain`.empty?
  end

  def current_os
    `uname -s`
  end

  def darwin?
    current_os.chomp == 'Darwin'
  end

  def linux?
    current_os.chomp == 'Linux'
  end

  def clean_str(str)
    str.gsub(/\%f|%k|%F{\d+}|%K{\d+}/, '')
  end

  def ruby_version
    ruby_project? ? RUBY_VERSION : ''
  end

  private

  def ruby_project?
    Dir.glob('*.rb').size > 0 || Dir.entries('.').include?('Gemfile')
  end
end
