# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

topics = Topic.create([{title: 'Comprar iPhone 4', user_id: 1},
                       {title: 'Comprar Galaxy SIII', user_id: 1},
                       {title: 'Comprar Motorola Razr', user_id: 2}])

arguments = Argument.create([{arg: 'Argumento 1, Topico 1, Usuario 1', kind: 1, user_id: 1, topic_id: 1},
                             {arg: 'Argumento 2, Topico 2, Usuario 2', kind: 0, user_id: 2, topic_id: 2},
                             {arg: 'Argumento 3, Topico 3, Usuario 1', kind: 1, user_id: 1, topic_id: 3},
                             {arg: 'Argumento 4, Topico 1, Usuario 2', kind: 0, user_id: 2, topic_id: 1},
                             {arg: 'Argumento 5, Topico 2, Usuario 1', kind: 1, user_id: 1, topic_id: 2}])
                             

