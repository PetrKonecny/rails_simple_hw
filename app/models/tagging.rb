class Tagging < ActiveRecord::Base
  belongs_to :post
  belongs_to :tag, counter_cache: :posts_count
  after_destroy :delete_empty_tags

  def delete_empty_tags
    Tag.where(posts_count: 0).delete_all
  end
end
