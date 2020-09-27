defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Robotnik"

  def create_player(name, move_rnd, move_avg, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Game.info()
    |> Status.print_game_status()
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _move), do: Status.print_game_status(Game.info())

  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    Game.info()
    |> computer_move()
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move =
      {:ok,
       ExMon.Game.info()
       |> Map.get(:computer)
       |> Map.get(:moves)
       |> Map.keys()
       |> Enum.random()}

    do_move(move)
  end

  defp computer_move(_), do: :ok

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Game.info()
    |> Status.print_game_status()
  end
end
