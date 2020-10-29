# frozen_string_literal: true

require 'rack/health_check/version'

module Rack
  class HealthCheck
    DEFAULT_REQUEST_PATH = '/health'

    DEFAULT_RESPONSE_BODY = 'OK'

    # @param [#call] app
    # @param [String] body
    # @param [String] path
    def initialize(
      app,
      body: DEFAULT_RESPONSE_BODY,
      path: DEFAULT_REQUEST_PATH
    )
      @app = app
      @body = body
      @path = path
    end

    # @param [Hash] env Rack env.
    # @return [Array] Rack response.
    def call(env)
      if env['PATH_INFO'] == @path
        [
          '200',
          {
            'Content-Length' => @body.bytesize.to_s,
            'Content-Type' => 'text/plain'
          },
          [@body]
        ]
      else
        @app.call(env)
      end
    end
  end
end
