class Post < ActiveRecord::Base
  has_and_belongs_to_many :tags

  validates :author, :title, :body, :tags, presence: true

  def tag_list
    # this is just rubocop optimalization, meaning is the same
    # TODO why self keyword is not neccessary ??
    # self.tags.map { |tag| tag.name }.join(", ")
    tags.map(&:name).join(", ")
  end

  def tag_list=(new_value)
    tag_names = new_value.split(/[\s,]+/)
    self.tags = tag_names.uniq.map { |name| Tag.where('name = ?', name).first || Tag.create(:name => name) }
  end
end
