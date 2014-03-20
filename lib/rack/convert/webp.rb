require "rack/convert/webp/version"
require 'rack/accept_media_types'
require 'webp-ffi'
require 'tempfile'

module Rack
  module Convert
    class Webp
      ACCEPT_CONTENT_TYPES = %w(
        image/jpeg
        image/jpg
        image/png
        image/tiff
      )
      DEFAULT_OPTIONS = {quality: 75}

      def initialize(app, options = {})
        @app = app
        @encode_options = DEFAULT_OPTIONS.merge options
      end

      def call(env)
        status, headers, response = @app.call(env)
        request = Rack::Request.new(env)
        media_types = request.accept_media_types

        if response.kind_of?(Rack::File) &&
             media_types.include?("image/webp") &&
             ACCEPT_CONTENT_TYPES.include?(headers["Content-Type"]) &&
             !request.params['original']
          begin
            webp_file = Tempfile.new('webp')
            now = Time.now
            ::WebP.encode(response.path, webp_file.path, @encode_options.merge(encoding_params request.params))
            original_size = ::File.size(response.path)
            webp_size = ::File.size(webp_file.path)
            headers['X-Encoding-Time'] = "#{((Time.now - now).to_f * 1000).to_i}ms"
            response = [webp_file.read]
            headers['X-Compress'] = "#{((webp_size.to_f / original_size) * 100).to_i}% - original: #{original_size} webp: #{webp_size}"
            headers['Content-Length'] = webp_size.to_s
            headers['Content-Type'] = "image/webp"
          ensure
            webp_file.close
            webp_file.unlink
          end
        end

        [status, headers, response]
      end

      private
      def encoding_params(params)
        result = {}
        params.each do |key, value|
          result[key.to_sym] = value.to_i
        end
        result
      end
    end
  end
end
