module JQueryFormHelper

  class JQueryFormBuilder < ActionView::Helpers::FormBuilder

    # render jquery submit button
    def submit(string)
      @template.jquery_document_ready << %Q{
        $('button').hover(function() {
          $(this).addClass('ui-state-hover');
        },
        function() {
          $(this).removeClass('ui-state-hover');
        });
        $('#user_submit').remove();
      }
      %Q{
        <div class='ui-dialog-buttonpane ui-widget-content ui-helper-clearfix ui-corner-bottom' style='left: 0; top: #{options[:height]-70}px; position: absolute; width: #{options[:width]-22}px; height: 50px;'>
          <button class='ui-state-default ui-corner-all'>#{string}</button>
        </div>
      }
    end
    
    # render object error messages, jquery style
    def error_messages(options={})
      if @object.errors.length > 0
        errors = %Q{
          <div id='errorExplanation' class='errorExplanation'>
            <div class='ui-state-error ui-corner-all' style='padding: 8px;'>
              <p>
                <span class='ui-icon ui-icon-alert' style='float: left; margin-right: 0.3em;'></span>
                #{@object.errors.length} errors prevented this user from being created
              </p>
              <ul>
        }
        @object.errors.each do |error, message|
          errors << "<li>#{error.humanize.titleize} #{message}</li>\n"
        end
        errors << %Q{
              </ul>
            </div>
          </div>
        }
      end
    end

    # jquery date widget
    def date_field(method)
      @template.jquery_document_ready << "$('##{@object.class.name.tableize.singularize}_#{method}').datepicker({defaultDate: '-10y', changeYear: true, changeMonth: true, yearRange: '1900:2000'});"
      self.text_field method
    end

  end

  # renders a form in jquery widget style
  def jquery_form_for(record_or_name_or_array, *args, &proc)
    options = args
    options = options.extract_options!
    object = record_or_name_or_array
    if object.errors.length > 0 && !flash[:error] # assumes if flash error exists, you will not be displaying object errors
      options[:height] += (22 * object.errors.length) + 90
    elsif(flash[:error])
      options[:height] += 55
    end
    args << args.extract_options!.merge(:height => options[:height])
    concat "<div class='vcentered_content'>\n"
    concat "<div class='ui-widget-shadow ui-corner-all' style='position: absolute; height: #{options[:height]}px; width: #{options[:width]}px;'></div>\n"
    concat "<div class='ui-dialog ui-widget ui-widget-content ui-corner-all' style='height: #{options[:height]-5}px; width: #{options[:width]-2}px; padding: 0px;'>\n"
    form_for(record_or_name_or_array, *(args << options.merge(:builder => JQueryFormBuilder)), &proc)
    concat "</div>\n"
    concat "</div>\n"
   end

  # jquery themed form tag
  def jquery_form_tag(url_for_options = {}, options = {}, *parameters_for_url, &block)
    options[:height] += 55 if flash[:error] || flash[:notice]
    @jquery_form_size = [options[:width], options[:height]]
    concat "<div class='vcentered_content'>\n"
    concat "<div class='ui-widget-shadow ui-corner-all' style='position: absolute; height: #{options[:height]}px; width: #{options[:width]}px;'></div>\n"
    concat "<div class='ui-dialog ui-widget ui-widget-content ui-corner-all' style='height: #{options[:height]-5}px; width: #{options[:width]-2}px; padding: 0px;'>\n"
    form_tag(url_for_options, options, *parameters_for_url, &block)
    concat "</div>\n"
    concat "</div>\n"
  end

  # submit tag, juery ui style
  def jquery_submit_tag(value = "Save changes", options = {})
    jquery_document_ready << %Q{
      $('button').hover(function() {
        $(this).addClass('ui-state-hover');
      },
      function() {
        $(this).removeClass('ui-state-hover');
      });
      $('#user_submit').remove();
    }
    options.merge!(:width => @jquery_form_size[0], :height => @jquery_form_size[1])
    %Q{<div class='ui-dialog-buttonpane ui-widget-content ui-helper-clearfix ui-corner-bottom' style='left: 0; top: #{options[:height]-70}px; position: absolute; width: #{options[:width]-22}px; height: 50px;'>
      <button class='ui-state-default ui-corner-all'>#{value}</button>
    </div>}
  end
  
end