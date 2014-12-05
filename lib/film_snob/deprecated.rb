module Deprecated
  def deprecated_alias(previous, replacement, warning = nil)
    define_method(previous) do |*args, &block|
      if warning
        warn "WARNING: #{warning.strip} " \
             "Please use ##{replacement} instead."
      else
        warn "WARNING: ##{previous} is deprecated. " \
             "Please use ##{replacement} instead."
      end
      send replacement, *args, &block
    end
  end
end

