module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
      end
    end
  end

  def display_errors(obj)
    capture_haml do 
      if obj.errors.any?
        haml_tag :div, {id: "error_expanation"} do
          haml_tag :p, "#{pluralize(obj.errors.count, "error")} prohibited this project from being saved"
          haml_tag :ul do 
            obj.errors.full_messages.each do |error|
              haml_tag :li, error
            end
          end
        end
      end
    end
  end
end
