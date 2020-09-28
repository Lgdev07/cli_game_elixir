defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Player, Game}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Luan", :chute, :soco, :cura)
      computer = Player.build("Computer", :kick, :punch, :heal)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Luan", :chute, :soco, :cura)
      computer = Player.build("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_result = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Computer"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Luan"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_result
    end
  end

  describe "update/1" do
    test "update the game state with the given state" do
      player = Player.build("Luan", :chute, :soco, :cura)
      computer = Player.build("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_result = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Computer"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Luan"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_result

      new_state = %{expected_result | computer: %{expected_result.computer | life: 85}}

      Game.update(new_state)

      expected_result = %{new_state | status: :continue, turn: :computer}

      assert Game.info() == expected_result
    end
  end

  describe "player/0" do
    test "get the player" do
      player = Player.build("Luan", :chute, :soco, :cura)
      computer = Player.build("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_result = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Luan"
      }

      assert Game.player() == expected_result
    end
  end

  describe "turn/0" do
    test "get the turn" do
      player = Player.build("Luan", :chute, :soco, :cura)
      computer = Player.build("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      assert Game.turn() == :player
    end
  end

  describe "fetch_player/1" do
    test "returns the player struct" do
      player = Player.build("Luan", :chute, :soco, :cura)
      computer = Player.build("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_result = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Luan"
      }

      assert Game.fetch_player(:player) == expected_result
    end

    test "returns the computer struct" do
      player = Player.build("Luan", :chute, :soco, :cura)
      computer = Player.build("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_result = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Computer"
      }

      assert Game.fetch_player(:computer) == expected_result
    end
  end
end
