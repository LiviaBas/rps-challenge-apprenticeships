require 'sinatra/base'

def pick_rps(choice=nil) # rock: 0, paper: 1, scissors: 2
  img_paths = ["rock.jpg", "paper.jpg", "scissors.jpg"]
  if choice
    # player choice
    return img_paths[choice]
  else
    # opponent choice
    return img_paths[rand(3)]
  end
end

def pick_winner(player_choice, opponent_choice)
  img_paths = ["rock.jpg", "paper.jpg", "scissors.jpg"]
  player_choice = img_paths.index player_choice
  opponent_choice = img_paths.index opponent_choice
  if player_choice == 0
    if opponent_choice == 0
      return "tie!"
    elsif opponent_choice == 1
      return "player loses!"
    elsif opponent_choice == 2
      return "player wins!"
    end
  elsif player_choice == 1
    if opponent_choice == 0
      return "player wins!"
    elsif opponent_choice == 1
      return "tie!"
    elsif opponent_choice == 2
      return "player loses!"
    end
  elsif player_choice == 2
    if opponent_choice == 0
      return "player loses!"
    elsif opponent_choice == 1
      return "player wins!"
    elsif opponent_choice == 2
      return "tie!"
    end
  end
end

class RockPaperScissors < Sinatra::Base
  enable :sessions

  get '/test' do
    'test page'
  end

  get '/names' do
    erb(:names)
  end

  get '/rock' do
    session['choice'] = 0
    redirect to("/play")
  end

  get '/paper' do
    session['choice'] = 1
    redirect to("/play")
  end

  get '/scissors' do
    session['choice'] = 2
    redirect to("/play")
  end

  get '/choose' do
    erb(:choose)
  end

  post '/setup' do
    session['name'] = params[:name]
    redirect to("/choose")
  end

  get '/play' do
    @player = session['name']
    @player_choice = pick_rps(session['choice'])
    @opponent_choice = pick_rps()
    @end_message = pick_winner(@player_choice, @opponent_choice)
    erb(:game_loop)
  end

  run! if app_file == $0
end
