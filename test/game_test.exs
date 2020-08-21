defmodule ExAttack.GameTest do
  use ExUnit.Case

  alias ExAttack.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("murilo", :puch, :kick, :heal)
      computer = Player.build("boss", :puch, :kick, :heal)

      assert {:ok, _} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("murilo", :puch, :kick, :heal)
      computer = Player.build("boss", :puch, :kick, :heal)

      Game.start(computer, player)

      expected = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :puch},
          name: "boss"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :puch},
          name: "murilo"
        },
        status: :started,
        turn: :player
      }

      assert expected == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("murilo", :puch, :kick, :heal)
      computer = Player.build("boss", :puch, :kick, :heal)

      Game.start(computer, player)

      expected = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :puch},
          name: "boss"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :puch},
          name: "murilo"
        },
        status: :started,
        turn: :player
      }

      assert expected == Game.info()

      new_state = %{
        computer: %Player{
          life: 12,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :puch},
          name: "boss"
        },
        player: %Player{
          life: 32,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :puch},
          name: "murilo"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected = %{new_state | turn: :computer, status: :continue}

      assert expected == Game.info()
    end
  end

  describe "player/0" do
    test "returns the current player turn" do
      player = Player.build("murilo", :puch, :kick, :heal)
      computer = Player.build("boss", :puch, :kick, :heal)

      Game.start(computer, player)

      assert player == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the current game turn" do
      player = Player.build("murilo", :puch, :kick, :heal)
      computer = Player.build("boss", :puch, :kick, :heal)

      Game.start(computer, player)

      assert :player == Game.turn()
    end
  end
end
