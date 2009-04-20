require 'jquery_ui_rails/form_helper'
require 'jquery_ui_rails/jquery_helper'
require 'jquery_ui_rails/application_helper'

ActionView::Base.send :include, JQueryFormHelper
ActionView::Base.send :include, JQueryHelper
ActionView::Base.send :include, JQueryApplicationHelper