module Ironhide
  class << self
    def enable_helpers
      require 'action_view'
      ActionView::Base.send :include, Ironhide::Helpers::IncluderHelper
    end
  end
end

require 'ironhide/includer'
require 'ironhide/helpers/includer_helper'

Ironhide.enable_helpers
