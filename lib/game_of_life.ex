defmodule GameOfLife do
  use Application
  @moduledoc """
  Documentation for GameOfLife.
  """

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    init_alive_cells = []

    children = [
      # Define workers and child supervisors to be supervised
      # worker(GameOfLife.Worker, [arg1, arg2, arg3]),
      supervisor(Task.Supervisor, [[name: GameOfLife.TaskSupervisor]]),
      worker(GameOfLife.BoardServer, [init_alive_cells]),

      # We will uncomment this line later
      # worker(GameOfLife.GamePrinter, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GameOfLife.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
