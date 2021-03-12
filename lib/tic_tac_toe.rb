board=[" "," "," "," "," "," "," "," "," "]

WIN_COMBINATIONS=[
  [0,1,2], [3,4,5], [6,7,8], 
  [0,3,6], [1,4,7], [2,5,8], 
  [0,4,8], [2,4,6]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index]=value
end

def position_taken?(board, index)
  (board[index]!=" " && board[index]!="" && board[index]!=nil)
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  turns=0
  board.each do |space|
    if space=="X" || space=="O"
      turns+=1
    end
  end
  turns
end

def current_player(board)
  turns=turn_count(board)
  if turns==0 || turns%2==0
    return value="X"
  elsif turns>0 && turns%2!=0
    return value="O"
  else
    nil
  end
end

def turn(board)
  value=current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, value)
    display_board(board)
  elsif !valid_move?(board, index) && !over?(board)
    turn(board)
  end
end
  
def won?(board)
  WIN_COMBINATIONS.detect do |winning_spots|
    if winning_spots.all? {|index| board[index]=="X"}
      winning_spots
    elsif winning_spots.all? {|index| board[index]=="O"}
      winning_spots
    else
      nil
    end
  end
end

def full?(board)
  board.all? do |index|
    index=="X" || index=="O"
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    if won?(board).detect {|index| board[index]=="X"}
      return "X"
    else
      return "O"
    end
  else
    nil
  end
end

def play(board)
  counter=0
  while !over?(board) && counter<9
    turn(board)
    counter+=1
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end