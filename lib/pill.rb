# Class that holds information about a pill
class Pill
  attr_accessor :background, :foreground, :foreground_icon,
                :icon, :foreground_text, :text

  def initialize(background, foreground_icon, icon, foreground_text = '',
                 text = '')
    @background = background
    @foreground = background.tr('K', 'F')
    @foreground_icon = foreground_icon
    @icon = icon
    @foreground_text = foreground_text
    @text = text
  end

  def build(icon_left, first)
    str = ''
    str = @foreground + icon_left if first
    str += @background + ' ' + @foreground_icon + @icon + ' '
    return str + @foreground_text + @text + ' ' unless @text.empty?
    str
  end

  def join(icon_left, icon_right, pill = nil, first = false)
    str = build(icon_left, first)
    return str + pill.background + @foreground + icon_right unless pill.nil?
    str + '%k' + @foreground + icon_right
  end
end
