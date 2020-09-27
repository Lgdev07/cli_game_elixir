defmodule ExMon.Game.Status do
  def print_game_status(%{status: :started} = info) do
    IO.puts("\n===== The game started =====\n")
    IO.inspect(info)
    IO.puts("------------------------------")
  end

  def print_game_status(%{status: :continue, turn: player} = info) do
    IO.puts("\n===== It's #{player} turn. =====\n")
    IO.inspect(info)
    IO.puts("------------------------------")
  end

  def print_game_status(%{status: :game_over} = info) do
    IO.puts("\n===== Game Over =====\n")
    IO.inspect(info)
    IO.puts("------------------------------")
  end

  def print_wrong_move_message(move) do
    IO.puts("\n===== Invalid Move: #{move} =====\n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n===== The Player attacked Computer dealing #{damage} damage =====\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n===== The Computer attacked Player dealing #{damage} damage =====\n")
  end

  def print_move_message(player, :heal, healing) do
    IO.puts("\n===== The #{player} healed #{healing} =====\n")
  end
end
