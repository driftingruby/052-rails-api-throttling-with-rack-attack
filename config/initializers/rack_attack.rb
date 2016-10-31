class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new 

  throttle('api/ip', limit: 3, period: 10) do |req|
    req.ip if req.subdomain == 'api'
  end

  class Request < ::Rack::Request
    def subdomain
      host.split('.').first
    end
  end
end