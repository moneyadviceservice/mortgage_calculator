module UI
  module DefaultLocale
    def locale
      "en"
    end

    def url(expansion = {})
      super(expansion.reverse_merge(locale: locale))
    end
  end
end
