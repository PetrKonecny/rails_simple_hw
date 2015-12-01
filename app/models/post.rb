class Post < ActiveRecord::Base
  validates :author, :title, :body, :tags_string, presence: true
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  after_destroy :delete_empty_tags

  def tags_string=(string)
    string.split(/[\s, ]/).uniq.each do |name|
      sync_tag(name)
    end
    remove_tags(string)
  end

  def sync_tag(name)
    tag = Tag.where(name: name).first
    if tag.nil?
      tags << Tag.new(name: name)
    elsif tags.select { |item| item.name.eql?(name) }.blank?
      tags << tag
    end
  end

  def remove_tags(string)
    tags.each do |item|
      unless string.split(/[\s, ]/).include?(item.name)
        tags.destroy(item)
      end
    end
  end

  def tags_string
    tags.map(&:name).join(",")
  end

  def delete_empty_tags
    Tag.where(posts_count: 0).delete_all
  end
end
