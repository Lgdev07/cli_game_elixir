defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.{Heal, Attack}

  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> Enum.find_value({:error, move}, fn {k, v} ->
      if v == move, do: {:ok, k}
    end)
  end

  def attack(move) do
    case Game.turn() do
      :computer -> Attack.attack_opponent(:player, move)
      :player -> Attack.attack_opponent(:computer, move)
    end
  end

  def heal() do
    case Game.turn() do
      :computer -> Heal.heal_life(:computer)
      :player -> Heal.heal_life(:player)
    end
  end
end
