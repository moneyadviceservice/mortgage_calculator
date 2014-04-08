module UI
  module DefaultLocale
    def locale
      @locale || "en"
    end

    def locale=(value)
      @locale = value
    end

    def url(expansion = {})
      super(expansion.reverse_merge(locale: locale))
    end
  end
end
