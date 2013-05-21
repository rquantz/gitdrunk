module SpiritsHelper
  def nested_spirits(spirits)
    spirits.map do |spirit, child_spirits|
      if spirit.is_brand?
        class_name = "nested-spirits children-of-spirit-#{spirit.id} brand-spirit" 
      else
        class_name = "nested-spirits children-of-spirit-#{spirit.id}"
      end
      render(partial: 'spirits/nested_spirit', locals: { spirit: spirit }) + content_tag(:ul, nested_spirits(child_spirits), class: class_name, 'data-parent-id' => spirit.id)
    end.join.html_safe
  end
end
