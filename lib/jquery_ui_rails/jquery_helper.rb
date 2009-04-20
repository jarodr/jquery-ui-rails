module JQueryHelper

  # renders $(document).ready call back
  def render_jquery_document_ready
    %Q{
      $(document).ready(function() {
        #{flash.delete(:jquery_document_ready).join("\n")}
      })
    }
  end

  # adds string to document ready
  def jquery_document_ready
    flash[:jquery_document_ready] = [] unless flash[:jquery_document_ready]
    flash[:jquery_document_ready]
  end

end