defmodule ExAttackTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExAttack.Player

  describe "create_player/4" do
    test "returns a player" do
      expected = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "murilo"
      }

      assert expected == ExAttack.create_player("murilo", :kick, :punch, :heal)
    end
  end

  describe "start_game/1" do
    test "returns the message game" do
      player = Player.build("murilo", :kick, :punch, :heal)

      messages = capture_io(fn -> assert ExAttack.start_game(player) == :ok end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("murilo", :kick, :punch, :heal)
      capture_io(fn -> ExAttack.start_game(player) end)

      :ok
    end

    test "when the move exists, returns round message" do
      messages = capture_io(fn -> ExAttack.make_move(:kick) end)

      assert messages =~ "The player attacked computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns error message" do
      messages = capture_io(fn -> ExAttack.make_move(:jump) end)

      assert messages =~ "Invalid move: jump"
    end

    test "when the game is over, return finish message" do
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
        end)

      assert messages =~ "The game this over"
      assert messages =~ "status: :game_over"
    end
  end
end
