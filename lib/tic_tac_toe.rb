def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  turn_count = 0
  until turn_count == 9 || over?(board) || draw?(board)
    turn_count += 1
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  else
    winning_player = winner(board)
    puts "Congratulations #{winning_player}!"
  end

end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [6,4,2],
  [0,4,8]
]
def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn_count(board)
  total = 0
  board.each do |entry|
    if !(entry == "   " || entry == " ")
      total += 1
    end
  end
  total
end

def current_player(board)
  player = turn_count(board) % 2 == 0 ? "X" : "O"
  return player
end

def won?(board)

  WIN_COMBINATIONS.each do |win_combo|
    pos_1 = board[win_combo[0]]
    pos_2 = board[win_combo[1]]
    pos_3 = board[win_combo[2]]

    x_wins = pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
    y_wins = pos_1 == "O" && pos_2 == "O" && pos_3 == "O"

    if x_wins || y_wins
      return win_combo
    else
      false
    end
  end

  return nil
end

def full?(board)
  board.none? {|i| i == "   " || i == " " || i == "" || i == nil}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  #no need to call draw? method here- it would be redundant
  won?(board) || full?(board)
end

def winner(board)
  if board.empty?
    return nil
  end

  winning_combo = won?(board)
  if winning_combo != nil
    return board[winning_combo[0]]
  else
    return nil
  end
end
