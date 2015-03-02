require 'uri'

module Phase5
  class Params
    def initialize(req, route_params = {})
      @params = {}
      parse_www_encoded_form(req.query_string) if req.query_string
      parse_www_encoded_form(req.body()) if req.body()
      @params.merge!(route_params)
    end

    def [](key)
      @params["#{key}"]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    
    def parse_www_encoded_form(www_encoded_form)
      URI.decode_www_form(www_encoded_form).each do |key, val|
        if key.scan(/\[/).empty?
          @params[key] = val
        else
          params_string = "@params"

          parse_key(key).each do |key|
            params_string += "['#{key}']"
            eval("#{params_string} = {}") if eval(params_string).nil?
          end

          eval("#{params_string} = '#{val}'")
        end
      end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
