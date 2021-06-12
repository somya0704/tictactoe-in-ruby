class Game
WINNING_COMBOS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[6,4,2],
]

  def initialize
    @players = Players.new
  end

  #to check player turn
  def move
    @end = false
    @gameboard = Board.new
    @turn = 1
    while @turn<10
      if @turn % 2 != 0
        player_turn("X", @players.player1)
      elsif @turn % 2 == 0
        player_turn("O", @players.player2)
      end
    end
  end

  #to check move and position
  def player_turn(symbol, player)
    @player_move = gets.chomp.to_i
    if (0..8).include?(@player_move) && @gameboard.board[@player_move] == "-" && @end == false
      @turn += 1
      @gameboard.grid_update(@player_move, symbol)
      win_check
    else
      puts "Invalid Move\n"
    end
  end

  #to check if there is a winner using winning combinations
  def win_check
    WINNING_COMBOS.each do |win_check|
      if (@gameboard.board[win_check[0]] == @gameboard.board[win_check[1]] &&
        @gameboard.board[win_check[1]] == @gameboard.board[win_check[2]]) &&
        @gameboard.board[win_check[0]] != "-"
        if @gameboard.board[win_check[0]] == "X"
          puts "#{@players.player1} won the game"
          @turn = 10
          @end = true
        elsif @gameboard.board[win_check[0]] == "O"
          puts "#{@players.player2} won the game"
          @turn = 10
          @end = true
        end
      end
    end
  end
end

class Players
  attr_reader :player1, :player2

  #to initialize player
  def initialize
    @player1 = gets.chomp
    puts "X #{@player1}"
    @player2 = gets.chomp
    puts "O #{@player2}"
  end
end


class Board
  attr_reader :board

  #to initialize board
  def initialize
    puts "- - -"
    puts "- - -"
    puts "- - -"
    @board = ["-","-","-","-","-","-","-","-","-"]
  end

  #method to update the grid array with "X" or "O"
  def grid_update(position, symbol)
    @board[position] = symbol
    grid_display(@board)
  end

  #to displays the grid after each turn
  def grid_display(board)
    puts "#{board[0]} #{board[1]} #{board[2]}"
    puts "#{board[3]} #{board[4]} #{board[5]}"
    puts "#{board[6]} #{board[7]} #{board[8]}"
  end
end

game = Game.new
game.move