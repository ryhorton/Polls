# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(user_name: "User One")
u2 = User.create!(user_name: "User Two")
u3 = User.create!(user_name: "User Three")
u4 = User.create!(user_name: "User Four")
u5 = User.create!(user_name: "User Five")


p1 = Poll.create!(author_id: u1.id, title: "Poll 1 (u1)")
p2 = Poll.create!(author_id: u2.id, title: "Poll 2 (u2)")
p3 = Poll.create!(author_id: u1.id, title: "Poll 3 (u1)")

p1q1 = Question.create!(poll_id: p1.id, text: "Poll one question one?")
p1q2 = Question.create!(poll_id: p1.id, text: "Poll one question two?")

p2q1 = Question.create!(poll_id: p2.id, text: "Poll two question one?")
p2q2 = Question.create!(poll_id: p2.id, text: "Poll two question two?")

p3q1 = Question.create!(poll_id: p3.id, text: "Poll three question one?")

#poll 1
p1q1ac1 = AnswerChoice.create!(question_id: p1q1.id, text: "p1q1ac1")
p1q1ac2 = AnswerChoice.create!(question_id: p1q1.id, text: "p1q1ac2")

p1q2ac1 = AnswerChoice.create!(question_id: p1q2.id, text: "p1q2ac1")
p1q2ac2 = AnswerChoice.create!(question_id: p1q2.id, text: "p1q2ac2")

#Poll 2
p2q1ac1 = AnswerChoice.create!(question_id: p2q1.id, text: "p2q1ac1")
p2q1ac2 = AnswerChoice.create!(question_id: p2q1.id, text: "p2q1ac2")

p2q2ac1 = AnswerChoice.create!(question_id: p2q2.id, text: "p2q2ac1")
p2q2ac2 = AnswerChoice.create!(question_id: p2q2.id, text: "p2q2ac2")

#Poll 3
p3q1ac1 = AnswerChoice.create!(question_id: p3q1.id, text: "p3q1ac1")
p3q1ac2 = AnswerChoice.create!(question_id: p3q1.id, text: "p3q1ac2")
p3q2ac3 = AnswerChoice.create!(question_id: p3q1.id, text: "p3q1ac3")

#poll 1
p1q1r1 = Response.create!(answer_choice_id: p1q1ac1.id, user_id: u1.id)
p1q1r2 = Response.create!(answer_choice_id: p1q1ac2.id, user_id: u2.id)
p1q1r3 = Response.create!(answer_choice_id: p1q1ac2.id, user_id: u3.id)

p1q2r1 = Response.create!(answer_choice_id: p1q2ac1.id, user_id: u1.id)
p1q2r2 = Response.create!(answer_choice_id: p1q2ac1.id, user_id: u2.id)
p1q2r3 = Response.create!(answer_choice_id: p1q2ac2.id, user_id: u3.id)

#poll 2
p2q1r1 = Response.create!(answer_choice_id: p2q1ac1.id, user_id: u3.id)
p2q1r2 = Response.create!(answer_choice_id: p2q1ac2.id, user_id: u4.id)
p2q1r3 = Response.create!(answer_choice_id: p2q1ac2.id, user_id: u5.id)

p2q2r1 = Response.create!(answer_choice_id: p2q2ac1.id, user_id: u3.id)
p2q2r2 = Response.create!(answer_choice_id: p2q2ac1.id, user_id: u4.id)
p2q2r3 = Response.create!(answer_choice_id: p2q2ac1.id, user_id: u5.id)

#poll 3
p3q1r1 = Response.create!(answer_choice_id: p3q1ac3.id, user_id: u2.id)
