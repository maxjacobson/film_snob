class FilmSnob
  # all FilmSnob errors can be rescued in one go by rescuing this one
  class FilmSnobError < StandardError; end

  class NotSupportedURLError < FilmSnobError; end
  class NotEmbeddableError < FilmSnobError; end
end
