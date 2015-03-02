require_relative '../phase5/controller_base'

module Phase6
  class ControllerBase < Phase5::ControllerBase
    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(name)
      send(name)
      return if already_built_response?
      render_content(action_name, "text/html")
    end
  end
end
