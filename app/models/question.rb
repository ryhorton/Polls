class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many :responses, through: :answer_choices, source: :responses

  def results
    answers_with_response_count = self
      .answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS response_count")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .group("answer_choices.id")

    result = Hash.new
    answers_with_response_count.each do |answer|
      result[answer.text] = answer.response_count
    end

    result
  end

  # def results_pseudo_code
    # SELECT
    #   a.*,
    #   COUNT(r.id) AS response_count
    # FROM
    #   answer_choices AS a
    # LEFT OUTER JOIN
    #   responses AS r
    # ON
    #   a.id = r.answer_choice_id
    # WHERE
    #   a.question_id = ?
    # GROUP BY
    #   a.id
  #
  #
  #   result = Hash.new
  #   answers_with_response_count.each do |answer|
  #     result[answer_choice.text] = response_count
  #   end
  #
  #   result
  # end


  def results_better
    choices = answer_choices.includes(:responses)
    results_hash = {}
    choices.each do |answer_choice|
      results_hash[answer_choice.text] = answer_choice.responses.length
    end

    results_hash
  end


  def results_n_plus_1
    results_hash = {}
    answer_choices.each do |answer_choice|
      results_hash[answer_choice.text] = answer_choice.responses.count
    end

    results_hash
  end

end
