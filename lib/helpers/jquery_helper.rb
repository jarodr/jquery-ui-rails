module ActionView
  module Helpers #:nodoc:
    module JqueryHelper
  
      # renders $(document).ready call back
      def jquery_document_ready
        @jquery_document_ready = [] unless @jquery_document_ready
        %Q{
          $(document).ready(function() {
            #{@jquery_document_ready.join("\n")}
          })
        }
      end
  
      # adds string to document ready
      def add_to_document_ready(string)
        if @jquery_document_ready
          @jquery_document_ready << string
        else
          @jquery_document_ready = []
          @jquery_document_ready << string
        end
      end
  
    end
  end
end