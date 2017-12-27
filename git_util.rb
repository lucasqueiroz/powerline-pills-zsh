# Takes care of all the git related stuff
module GitUtil
  def git_dir?
    system('git rev-parse --short HEAD >/dev/null 2>&1')
  end

  def git_branch_name
    `git branch | grep \\* | cut -d ' ' -f2`.delete("\n")
  end

  def git_modified?
    !`git status --porcelain`.empty?
  end
end
