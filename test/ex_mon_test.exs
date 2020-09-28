defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns the created player" do
      expected_result = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Luan"
      }

      assert ExMon.create_player("Luan", :chute, :soco, :cura) == expected_result
    end
  end

  describe "start_game/1" do
    test "returns the created player" do
      player = ExMon.create_player("Luan", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "===== The game started ====="
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      capture_io(fn ->
        ExMon.create_player("Luan", :chute, :soco, :cura)
        |> ExMon.start_game()
      end)

      :ok
    end

    test "makes a valid move" do
      messages =
        capture_io(fn ->
          assert ExMon.make_move(:chute) == :ok
        end)

      assert messages =~ "The Player attacked Computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "makes a invalid move" do
      messages =
        capture_io(fn ->
          assert ExMon.make_move(:invalid) == :ok
        end)

      assert messages =~ "Invalid Move: invalid"
    end
  end

  # def make_move(move) do
  #   Game.info()
  #   |> Map.get(:status)
  #   |> handle_status(move)
  # end
end
