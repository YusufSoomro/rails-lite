require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      contr_name = self.class.to_s.underscore
      file_to_read = File.read("views/#{contr_name}/#{template_name}.html.erb")
      render_content(ERB.new(file_to_read).result(binding), "text/html")
    end
  end
end
