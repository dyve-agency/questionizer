class List < ActiveRecord::Base
  include UniquelyIdentifiable

  has_many :questions
  serialize :emails_to_notify, Array

  attr_accessor :raw_text, :raw_emails

  # TODO: move all this creation logic to a form object / service / lib

  def self.split_into_questions(text)
    splits = split_paragraphs(text)
    splits.map{|body| Question.new(body:body)}
  end

  # https://github.com/rails/rails/blob/9882ec4a50eb64d1024740bbd3ebc4cf31b8e0d3/actionview/lib/action_view/helpers/text_helper.rb#L421
  def self.split_paragraphs(text)
    return [] if text.blank?

    text.to_str.gsub(/\r\n?/, "\n").split(/\n\n+/).map! do |t|
      t.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') || t
    end
  end

  def self.get_emails(text)
    return [] if text.blank?
    text.split(",").map{|e| e.downcase.strip}.select{|e| e =~  Devise.email_regexp }.uniq.compact
  end

  def self.new_from_existing(list)
    self.new(raw_text:list.questions.map{|q| q.body.gsub("<br />", "\n")}.join("\n\n"))
  end

  def save_from_params
    List.transaction do
      self.emails_to_notify = List.get_emails(raw_emails)
      self.save!
      # replacing it directly would raise an ActiveRecord::RecordNotSaved if one question is not valid
      self.questions = []
      self.questions << List.split_into_questions(self.raw_text)
      self.errors.add(:base, "Add at least one question") unless self.questions(true).present?
      raise ActiveRecord::Rollback if self.errors.present?
    end
    self.persisted?
  end
end
