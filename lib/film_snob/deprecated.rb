class FilmSnob
  module Deprecated
    def deprecated_alias(previous, replacement, options)
      define_method(previous) do |*args, &block|
        Kernel.warn "WARNING: ##{previous} is deprecated and " \
                    "will be removed in #{options[:removed_in]}. " \
                    "Please use ##{replacement} instead."
        send(replacement, *args, &block)
      end
    end
  end
end

