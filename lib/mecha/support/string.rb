class String
  # Underscore a string, replacing dashes and spaces using underscores.
  #
  # @example Convert a camel case String to snake case
  #   'Snake  -  Case'.snakecase #=> 'snake_case'
  #
  # @return [String] the object converted to underscore format.
  def underscore
    tr('-', '_')
      .gsub(/\s/, '_')
      .gsub(/__+/, '_')
      .downcase
  end

  alias snakecase underscore
end
