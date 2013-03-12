# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderTreeHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        if !(node.level >= 1)
          result = "
            <li>
              <div class='btn-group'>
                <div class='item btn'>
                  #{ show_link }
                </div>
          "
          if !node.children.blank? 
            result = result + "
                <button class='btn dropdown-toggle' data-toggle='dropdown'>
                  <span class='caret'>
                  </span>
                </button>
                #{ children }
              </div>
            </li>
            "
          else 
            result = result +"
                <button class='btn dropdown-toggle' data-toggle='dropdown' disabled='disabled'>
                  <span class='caret'></span>
                </button>
              </div>
            </li>
            "
          end
          return result
        else 
          "
            <li>
              #{ show_link }
            </li>
         "
        end
      end

      def show_link
        node = options[:node]
        ns   = options[:namespace]
        url  = h.url_for(ns + [node])
        title_field = options[:title]

        "#{ h.link_to(node.send(title_field), url) }"
      end

      def children
        unless options[:children].blank?
          "<ul class='dropdown-menu'>#{ options[:children] }</ul>"
        end
      end

    end
  end
end
