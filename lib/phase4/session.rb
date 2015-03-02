require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @cookie_hash = {}
      
      req.cookies.each do |cookie_obj|
        if cookie_obj.name == '_rails_lite_app'
          @cookie_hash = JSON.parse(cookie_obj.value)
          break
        end
      end
    end

    def [](key)
      @cookie_hash[key]
    end

    def []=(key, val)
      @cookie_hash[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app', @cookie_hash.to_json)
    end
  end
end
