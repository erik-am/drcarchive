include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::XMLSitemap
# include Nanoc3::Helpers::Breadcrumbs

def breadcrumbs_trail
  trail = []
  current_identifier = @item.identifier

  loop do
    item = @items.find { |i| i.identifier == current_identifier }
    trail.unshift(item)
    break if current_identifier == '/'
    current_identifier = current_identifier.sub(/[^\/]+\/$/, '')
  end

  trail
end
