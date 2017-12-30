home = ENV['HOME']
zshrc = home + '/.zshrc'
text = File.read(zshrc)
new_content = text.gsub(/^ZSH_THEME=\".+\"$/, 'ZSH_THEME="powerline-pills"')
File.open(zshrc, 'w') { |file|
  file.puts(new_content)
}