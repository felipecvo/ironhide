require 'httpclient'

module Ironhide
  class Includer

    module ClassMethods
      attr_writer :default_timeout

      def default_timeout
        @default_timeout ||= 600
      end

      def get(url, timeout = default_timeout)
        cached = cache_read(url)
        return cached unless cached.nil?

        response = HTTPClient.get(url)
        if response.status_code == 200
          content = response.body.content
          cache_write(url, content, timeout)
          content
        else
          nil
        end
      end
      
      def cache_read(url)
        return nil unless defined? Rails
        Rails.cache.read(cache_key(url))
      end
      
      def cache_write(url, value, timeout)
        return unless defined? Rails
        Rails.cache.write(cache_key(url), value, :expires_in => timeout)
      end
      
      def cache_key(url)
        "Ironhide::Includer::#{Digest::MD5.hexdigest(url)}"
      end
    end

    extend ClassMethods
  end
end
