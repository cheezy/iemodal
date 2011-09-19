module UrlHelper
  class << self
    def html
      File.expand_path("#{File.dirname(__FILE__)}/../html")
    end

    def files
      "file://#{html}"
    end

    def modal
      "#{files}/modal.html"
    end
  end
end
