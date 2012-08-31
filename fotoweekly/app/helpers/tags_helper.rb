module TagsHelper

  def tag_cloud(tags)
    classes = 5
    max = 0

    tags.each do |tag|
      max = tag.count if (tag.count > max)
    end

    tags_array = []
    divisor = (max / classes ) + 1
    tags.each do |tag|
      tag_hash = {
        'name'  => tag.name,
        'count' => tag.count,
        'class' => (tag.count/divisor.to_f).ceil,
      }
      tags_array << tag_hash
    end
    return tags_array
  end

end

