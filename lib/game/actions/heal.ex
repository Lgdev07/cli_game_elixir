defmodule ExMon.Game.Actions.Heal do
  alias ExMon.Game
  alias ExMon.Game.Status

  @move_heal_power 18..25

  def heal_life(player) do
    healing = calculate_healing()

    player
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life(healing)
    |> update_life(player, healing)
  end

  defp calculate_healing, do: Enum.random(@move_heal_power)

  defp calculate_total_life(life, healing) when life + healing > 100, do: 100
  defp calculate_total_life(life, healing), do: life + healing

  defp update_life(life, player, healing) do
    player
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(player, healing)
  end

  defp update_game(struct, player, healing) do
    Game.info()
    |> Map.put(player, struct)
    |> Game.update()

    Status.print_move_message(player, :heal, healing)
  end
end
