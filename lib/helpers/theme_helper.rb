module ActionView
  module Helpers #:nodoc:
    module ThemeHelper
  
      # require jquery theme
      def jquery_theme(string)
        stylesheet_link_tag "/themes/#{string}/theme"
      end

    end
  end
end