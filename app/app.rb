require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'

require_relative 'models/leaderboard'

get '/leaderboards' do
  username = params[:username]
  level = params[:level]
  order_by = params[:order_by]

  where_clause = {}
  where_clause['username'] = username if username
  where_clause['level'] = level if level

  order_clause = {}
  order_clause['duration'] = :asc if (order_by == 'duration')

  json Leaderboard.where(where_clause).order(order_clause)
end

get '/leaderboards/:id' do
  leaderboard = Leaderboard.find_by_id(params[:id])

  if leaderboard
    halt 200, json(leaderboard)
  else
    halt 404, json(message: 'leaderboard not found')
  end
end

post '/leaderboards' do
  json_leaderboard = JSON.parse(request.body.read)
  leaderboard = Leaderboard.create!(json_leaderboard)
  json leaderboard
rescue ActiveRecord::RecordInvalid => e
  halt 403, json(message: e.message)
rescue StandardError => e
  halt 500, json(message: 'internal server error')
end

patch '/leaderboards/:id' do
  leaderboard = Leaderboard.find_by_id(params[:id])

  halt(404, json(message: 'leaderboard not found')) unless leaderboard

  json_leaderboard = JSON.parse(request.body.read)
  leaderboard.update!(json_leaderboard)
  json leaderboard
rescue ActiveRecord::RecordInvalid => e
  halt 403, json(message: e.message)
rescue StandardError => e
  halt 500, json(message: 'internal server error')
end

delete '/leaderboards/:id' do
  leaderboard = Leaderboard.find_by_id(params[:id])

  if leaderboard
    leaderboard.destroy
  else
    halt 404
  end
end
