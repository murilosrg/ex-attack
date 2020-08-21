defmodule ExAttack.PlayerTest do
  use ExUnit.Case

  alias ExAttack.Player

  describe "build/4" do
    test "return a player" do
      expected = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "murilo"
      }

      assert expected == Player.build("murilo", :kick, :punch, :heal)
    end
  end
end
