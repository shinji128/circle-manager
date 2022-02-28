# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  [
    { id: 1, name: 'hoge', line_user_id: "hoge" },
    { id: 2, name: '田中', line_user_id: "46cf988b-8d5f" },
    { id: 3, name: '鈴木', line_user_id: "5f6ee1df-b5da" },
    { id: 4, name: '坂本', line_user_id: "a56ebf02-0a6f" },
    { id: 5, name: '斎藤', line_user_id: "5f3152e3-0d32" },
    { id: 6, name: '山田', line_user_id: "f89f3d12-904a" },
    { id: 7, name: '佐々木', line_user_id: "e0393ab8-321d" },
    { id: 8, name: '山下', line_user_id: "a62b4315-fa8e" },
    { id: 9, name: '佐藤', line_user_id: "41c3928f-c54e" },
    { id: 10, name: '高橋', line_user_id: "28e1c1ca-da64" },
    { id: 11, name: '山本', line_user_id: "b528c76a-4b37" }
  ]
)

Circle.create(
  [
    { name: 'バドミントンサークル', introduction: "みんなで楽しくバドミントンをしよう" , user_id: 1, }
  ]
)

Event.create(
  [
    { name: '練習', circle_id: 1, uuid: 'b528c76a-4b37-28e1c1ca-da64'}
  ]
)

Affiliation.create(
  [
    { user_id: 1, circle_id: 1 },
    { user_id: 2, circle_id: 1 },
    { user_id: 3, circle_id: 1 },
    { user_id: 4, circle_id: 1 },
    { user_id: 5, circle_id: 1 },
    { user_id: 6, circle_id: 1 },
    { user_id: 7, circle_id: 1 },
    { user_id: 8, circle_id: 1 },
    { user_id: 9, circle_id: 1 },
    { user_id: 10, circle_id: 1 },
    { user_id: 11, circle_id: 1 }
  ]
)

Attendance.create(
  [
    { user_id: 1, event_id: 1, state: 1 },
    { user_id: 2, event_id: 1, state: 1 },
    { user_id: 3, event_id: 1, state: 1 },
    { user_id: 4, event_id: 1, state: 1 },
    { user_id: 5, event_id: 1, state: 1 },
    { user_id: 6, event_id: 1, state: 1 },
    { user_id: 7, event_id: 1, state: 1 },
    { user_id: 8, event_id: 1, state: 1 },
    { user_id: 9, event_id: 1, state: 1 },
    { user_id: 10, event_id: 1, state: 1 },
    { user_id: 11, event_id: 1, state: 1 }
  ]
)