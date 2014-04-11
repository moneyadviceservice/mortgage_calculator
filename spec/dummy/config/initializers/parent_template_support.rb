require 'mas/templating'
MAS::Templating::ControllerConcerns::ParentTemplateSupport.configure do |c|
  c.add_templates({
    embedded: 'layouts/embedded_tool'
  })
end
