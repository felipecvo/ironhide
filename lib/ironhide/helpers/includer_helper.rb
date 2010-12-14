module Ironhide
  module Helpers
    module IncluderHelper
      def file_get_contents(url)
        Ironhide::Includer.get(url)
      end
    end
  end
end
