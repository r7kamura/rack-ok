# frozen_string_literal: true

require 'rack/builder'
require 'rack/lint'
require 'rack/ok'
require 'rack/test'

RSpec.describe Rack::Ok do
  include Rack::Test::Methods

  subject do
    get(path)
  end

  let(:app) do
    options = self.options
    Rack::Builder.app do
      use Rack::Lint
      use Rack::Ok, **options
      run lambda { |_env|
        [
          200,
          {
            'Content-Type' => 'text/plain'
          },
          %w[Origin]
        ]
      }
    end
  end

  let(:options) do
    {}
  end

  let(:path) do
    '/health'
  end

  context 'with non health check request' do
    let(:path) do
      '/'
    end

    it 'returns original response' do
      subject
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('Origin')
    end
  end

  context 'with health check request' do
    it 'returns response for health check' do
      subject
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('OK')
    end
  end

  context 'with custom path option' do
    before do
      options[:path] = path
    end

    let(:path) do
      '/ok'
    end

    it 'responds to custom path' do
      subject
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('OK')
    end
  end

  context 'with custom body option' do
    before do
      options[:body] = body
    end

    let(:body) do
      'It works!'
    end

    it 'returns custom body' do
      subject
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(body)
    end
  end
end
