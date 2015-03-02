require_relative '../phase6/controller_base.rb'
require_relative 'flash.rb'

module Phase8
  class ControllerBase < Phase6::ControllerBase
    def redirect_to(url)
      super
      self.flash.store_flash(res)
    end

    def render_content(content, type)
      super
      self.flash.store_flash(res)
    end

    # method exposing a `flash` object
    def flash
      @flash ||= Flash.new(req)
    end
  end
end
