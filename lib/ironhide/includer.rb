require 'httpclient'
require 'rails'

module Ironhide
  class Includer

    module ClassMethods
      attr_writer :default_timeout

      def default_timeout
        @default_timeout ||= 10.minutes
      end

      def get(url, timeout = default_timeout)
        key = "Ironhide::Includer::#{Digest::MD5.hexdigest(url)}"
        cached = Rails.cache.read(key)
        return cached unless cached.nil?

        response = HTTPClient.get(url)
        if response.status_code == 200
          content = response.body.content
          Rails.cache.write(key, content, :expires_in => timeout)
          content
        else
          nil
        end
      end
    end

    extend ClassMethods
  end
end
