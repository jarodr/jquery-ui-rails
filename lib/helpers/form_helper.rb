module ActionView
  module Helpers #:nodoc:
    module FormHelper
  
      class JqueryFormBuilder < ActionView::Helpers::FormBuilder
    
        # render jquery submit button
        def submit(string)
          %Q{
            <div class='ui-dialog-buttonpane ui-widget-content ui-helper-clearfix ui-corner-bottom' style='left: 0; top: #{options[:height]-70}px; position: absolute; width: #{options[:width]-22}px; height: 50px;'>
              <button class='ui-state-default ui-corner-all'>#{string}</button>
            </div>
          }
        end
    
        # render object error messages, jquery style
        def error_messages(options={})
          if @object.errors.length > 0
            @template.render(:layout => "theme/error_messages", :locals => {:object => @object})
          end
        end
    
        # jquery date widget
        def date_field(method)
          @template.add_to_ready_script "$('##{@object.class.name.tableize.singularize}_#{method}').datepicker({defaultDate: '-10y', changeYear: true, changeMonth: true, yearRange: '1900:2000'});"
          self.text_field method
        end
    
      end
  
      def jquery_form_for(record_or_name_or_array, *args, &proc)
        flash[:ready_scripts] << %Q{
          $('button').hover(function() {
            $(this).addClass('ui-state-hover');
          },
          function() {
            $(this).removeClass('ui-state-hover');
          });
          $('#user_submit').remove();
        }
        options = args
        options = options.extract_options!
        object = record_or_name_or_array
        if object.errors.length > 0
          options[:height] += (22 * object.errors.length) + 90
        end
        args << args.extract_options!.merge(:height => options[:height])
        concat "<div class='vcentered_content'>\n"
        concat "<div class='ui-widget-shadow ui-corner-all' style='position: absolute; height: #{options[:height]}px; width: #{options[:width]}px;'></div>\n"
        concat "<div class='ui-dialog ui-widget ui-widget-content ui-corner-all' style='height: #{options[:height]-5}px; width: #{options[:width]-2}px; padding: 0px;'>\n"
        form_for(record_or_name_or_array, *(args << options.merge(:builder => JqueryFormBuilder)), &proc)
        concat "</div>\n"
        concat "</div>\n"
       end
  
      # jquery themed form tag
      def jquery_form_tag(url_for_options = {}, options = {}, *parameters_for_url, &block)
        @shadow_boxed_form_size = [options[:width], options[:height]]
        concat "<div class='vcentered_content'>\n"
        concat "<div class='ui-widget-shadow ui-corner-all' style='position: absolute; height: #{options[:height]}px; width: #{options[:width]}px;'></div>\n"
        concat "<div class='ui-dialog ui-widget ui-widget-content ui-corner-all' style='height: #{options[:height]-5}px; width: #{options[:width]-2}px; padding: 0px;'>\n"
        form_tag(url_for_options, options, *parameters_for_url, &block)
        concat "</div>\n"
        concat "</div>\n"
      end
  
      def submit_tag(value = "Save changes", options = {})
        flash[:ready_scripts] << %Q{
          $('button').hover(function() {
            $(this).addClass('ui-state-hover');
          },
          function() {
            $(this).removeClass('ui-state-hover');
          });
          $('#user_submit').remove();
        }
        options.merge!(:width => @shadow_boxed_form_size[0], :height => @shadow_boxed_form_size[1])
        %Q{<div class='ui-dialog-buttonpane ui-widget-content ui-helper-clearfix ui-corner-bottom' style='left: 0; top: #{options[:height]-70}px; position: absolute; width: #{options[:width]-22}px; height: 50px;'>
          <button class='ui-state-default ui-corner-all'>#{value}</button>
        </div>}
      end
  
      def shadow_box(selector='main-shadow', dialog_selector='main-content', width="100%;")
        flash[:ready_scripts] << %Q{
          $('##{selector}').css("height", $('##{dialog_selector}').height() + 8);
        }
        render :partial => 'shared/shadow_box', :locals => {:selector => selector, :width => width}
      end
      
    end
  end
  
  
end