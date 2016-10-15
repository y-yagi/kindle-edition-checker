module BookDecorator
  def has_kindle_edition_icon
    has_kindle_edition ? 'check circle' : 'clear'
  end
end
