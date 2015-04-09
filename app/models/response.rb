class Response < ActiveRecord::Base
  # plural 'validates' for column validations
  validates :answer_choice_id, :user_id, presence: true

  # singular 'validate' for custom validations
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll


  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    question.responses.where("? IS NULL OR responses.id <> ?", id, id)
  end


  private
  def respondent_has_not_already_answered_question
    if sibling_responses
      .where(user_id: user_id)
      .exists?
      errors[:user_id] << "already answered this question"
    end
  end

  # def author_cannot_respond_to_own_poll
  #   if user_id == poll_author.id
  #     errors[:user_id] << "cannot respond to own poll"
  #   end
  # end

  def author_cannot_respond_to_own_poll
    if question
      .poll
      .author
      .id == user_id
      errors[:user_id] << "cannot respond to own poll"
    end

  end


end
  #
  # has_one :poll, through: :question, source: :poll
  # has_one :poll_author, through: :poll, source: :author


  # def self.exclude_response(id)
  #   if id
  #     where("responses.id <> ?", id)
  #   else
  #     all
  #   end
  # end
  #
  #
  # def sibling_responses
  #   question.responses.exclude_response(id)
  # end
