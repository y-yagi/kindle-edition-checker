module BookDecorator
  def has_kindle_edition_icon
    has_kindle_edition ? 'done' : 'clear'
  end
end
