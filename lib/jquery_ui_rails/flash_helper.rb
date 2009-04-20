module JQueryFlashHelper
  
  def flash_error
    if flash[:error]
      %Q{
        <div class='ui-state-error ui-corner-all' style='padding: 8px;'>
          <span class='ui-icon ui-icon-alert' style='float: left; margin-right: 0.3em;'></span>
          #{flash[:error]}
        </div>
        }
    end
  end
  
  # render flash notice message
  def flash_notice
    %Q{
      <div class='ui-state-error ui-corner-all' style='padding: 8px;'>
        <span class='ui-icon ui-icon-info' style='float: left; margin-right: 0.3em;'></span>
        #{flash[:notice]}
      </div>
    }
  end
  
end