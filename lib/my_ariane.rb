# -*- encoding : utf-8 -*-
# Customize ariane(breadcrumb)
class MyAriane < Ariane::Render::HTMLList
  def list(crumbs)
    content_tag(:ul, class: nil) do
      raw items(crumbs)
    end
  end
end
