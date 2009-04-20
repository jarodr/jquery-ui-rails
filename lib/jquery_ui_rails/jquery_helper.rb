module JQueryHelper

  # renders $(document).ready call back
  def render_jquery_document_ready
    @jquery_document_ready = [] unless @jquery_document_ready
    %Q{
      $(document).ready(function() {
        #{@jquery_document_ready.join("\n")}
      })
    }
  end

  # adds string to document ready
  def jquery_document_ready
    @jquery_document_ready = [] unless @jquery_document_ready
    @jquery_document_ready
  end

end