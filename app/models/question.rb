class Question < ActiveRecord::Base
  belongs_to :list

  validates :body, presence: true

  def answered?
    self.reply.present?
  end
end
