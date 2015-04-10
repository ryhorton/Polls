class User < ActiveRecord::Base

  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )


  # def completed_polls
  #   sqlquery = <<-SQL
  #
  #   SELECT
  #     polls.*
  #     -- COUNT(questions.id) AS total_questions_count,
  #     -- COUNT(user_responses.q_id) AS user_answers_count
  #   FROM
  #     polls
  #   JOIN
  #     questions
  #   ON
  #     polls.id = questions.poll_id
  #   LEFT OUTER JOIN
  #     (
  #       SELECT
  #         ac.question_id AS q_id
  #       FROM
  #         responses AS r
  #       JOIN
  #         users AS u
  #       ON
  #         u.id = r.user_id
  #       JOIN
  #         answer_choices AS ac
  #       ON
  #         ac.id = r.answer_choice_id
  #       WHERE
  #         u.id = ?
  #     ) AS user_responses
  #   ON
  #     user_responses.q_id = questions.id
  #   GROUP BY
  #     polls.id
  #   HAVING
  #     COUNT(questions.id) > COUNT(user_responses.q_id)
  #       AND COUNT(user_responses.q_id) > 0
  #   SQL
  #
  #   Poll.find_by_sql([sqlquery, id])
  # end

  def completed_polls
    sqlquery_without_having = <<-SQL

    SELECT
      polls.*
      -- COUNT(questions.id) AS total_questions_count,
      -- COUNT(user_responses.q_id) AS user_answers_count
    FROM
      polls
    JOIN
      questions
    ON
      polls.id = questions.poll_id
    LEFT OUTER JOIN
      (
        SELECT
          ac.question_id AS q_id
        FROM
          responses AS r
        JOIN
          users AS u
        ON
          u.id = r.user_id
        JOIN
          answer_choices AS ac
        ON
          ac.id = r.answer_choice_id
        WHERE
          u.id = ?
      ) AS user_responses
    ON
      user_responses.q_id = questions.id
    GROUP BY
      polls.id
    SQL

    incomplete_having = <<-SQL
    HAVING
      COUNT(questions.id) > COUNT(user_responses.q_id)
        AND COUNT(user_responses.q_id) > 0
    SQL

    complete_having = <<-SQL
    HAVING
      COUNT(questions.id) = COUNT(user_responses.q_id)
    SQL


    Poll.find_by_sql([sqlquery_without_having + complete_having, id])
    #have to use real string addition because we DON'T want to santize inputs

  end
end
