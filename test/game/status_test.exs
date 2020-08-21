defmodule ExAttack.Game.StatusTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExAttack.{Game, Player}
  alias ExAttack.Game.Status

  describe "print_round_message/1" do
    setup do
      player = Player.build("murilo", :kick, :punch, :heal)

      capture_io(fn ->
        ExAttack.start_game(player)
      end)

      :ok
    end

    test "when status is started, return message game start" do
      messages =
        capture_io(fn ->
          Status.print_round_message(Game.info())
        end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
    end

    test "when status is game_over, return message game finish" do
      new_state = %{
        computer: %Player{
          life: 0,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :puch},
          name: "boss"
        },
        player: %Player{
          life: 32,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :puch},
          name: "murilo"
        },
        status: :game_over,
        turn: :player
      }

      messages =
        capture_io(fn ->
          ExAttack.Game.update(new_state)
          ExAttack.make_move(:kick)
          Status.print_round_message(Game.info())
        end)

      assert messages =~ "The game this over"
      assert messages =~ "status: :game_over"
    end
  end

  describe "print_round_message/3" do
    test "when status is continue, return message turn player" do
      player = Player.build("murilo", :kick, :punch, :heal)

      messages =
        capture_io(fn ->
          ExAttack.start_game(player)
          ExAttack.make_move(:kick)
          Status.print_round_message(Game.info())
        end)

      assert messages =~ "The player attacked computer"
      assert messages =~ "status: :continue"
    end
  end

  describe "print_wrong_move_message/1" do
    test "when move not exists, return error message" do
      messages = capture_io(fn -> Status.print_wrong_move_message(:punch) end)

      assert messages =~ " Invalid move: punch"
    end
  end
end
