defmodule ExAttack.Game.Status do
  def print_round_message(%{status: :started} = info) do
    IO.puts("\n===== The game is started! =====\n")
    IO.inspect(info)
    IO.puts("---------------------------")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("\n===== It's #{player} turn =====\n")
    IO.inspect(info)
    IO.puts("---------------------------")
  end

  def print_round_message(%{status: :game_over} = info) do
    IO.puts("\n===== The game this over =====\n")
    IO.inspect(info)
    IO.puts("---------------------------")
  end

  def print_wrong_move_message(move),
    do: IO.puts("\n===== Invalid move: #{move} =====\n")

  def print_move_message(:computer, :attack, damage),
    do: IO.puts("\n===== The player attacked computer dealing #{damage} damage =====\n")

  def print_move_message(:player, :attack, damage),
    do: IO.puts("\n===== The computer attacked player dealing #{damage} damage =====\n")

  def print_move_message(player, :heal, life),
    do: IO.puts("\n===== The #{player} healled itself to #{life} life points =====\n")
end
