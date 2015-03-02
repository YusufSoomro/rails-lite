require 'json'
require 'webrick'

module Phase8
  class Flash

    def initialize(req)
      @cookie = req.cookies.find { |cookie| cookie.name == '_rails_lite_app_flash' }
      @flash_now = (@cookie.nil? ? {} : JSON.parse(@cookie.value))
      @flash_later = {}
    end

    def [](key)
      return @flash_later[key.to_s] if @flash_now.empty?
      @flash_now[key]
    end

    def []=(key, val)
      @flash_later[key] = val
    end

    def now
      @flash_now
    end

    def store_flash(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app_flash', @flash_later.to_json)
    end
  end
end
