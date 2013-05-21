module SpiritsHelper
  def nested_spirits(spirits)
    spirits.map do |spirit, child_spirits|
      render(partial: 'spirits/nested_spirit', locals: { spirit: spirit }) + content_tag(:ul, nested_spirits(child_spirits), class: 'nested_spirits')
    end.join.html_safe
  end
end
