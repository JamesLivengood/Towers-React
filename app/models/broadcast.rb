class Broadcast < ApplicationRecord
    def html_for_contact(contact)
        html = Kramdown::Document.new(markdown_body).to_html
        html = Liquid::Template.parse(html)
        html.render(contact.to_h)
    end
end
