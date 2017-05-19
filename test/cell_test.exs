defmodule GameOfLife.CellTest do
  use ExUnit.Case, async: true
  ###  ALIVE CELL
  # CELL DIES
  test "alive cell with no neighbours dies" do
    alive_cell = { 1, 1 }
    alive_cells = [alive_cell]
    refute GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with one neighbor dies" do
    alive_cell = { 1, 1 }
    alive_cells = [alive_cell, { 0, 0 }]
    refute GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with more than 3 neighbours dies" do
    alive_cell = { 1, 1 }
    alive_cells = [alive_cell, { 0, 0 }, { 1, 0 }, { 2, 0 }, { 2, 1 }]
    refute GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  # CELL LIVES
  test "alive cell with 2 neighbours lives" do
    alive_cell = { 1, 1 }
    alive_cells = [alive_cell, { 0, 0 }, { 1, 0 }]
    assert GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with 3 neighbours lives" do
    alive_cell = { 1, 1 }
    alive_cells = [alive_cell, { 0, 0 }, { 1, 0 }, { 2, 1 }]
    assert GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  ###  DEAD CELL
  test "dead cell with 3 neighbours becomes alive" do
    dead_cell = { 1, 1 }
    alive_cells = [{ 0, 0 }, { 1, 0 }, { 2, 1 }]
    assert GameOfLife.Cell.become_alive?(alive_cells, dead_cell)
  end

  test "dead cell with 2 neighbours remains dead" do
    dead_cell = { 1, 1 }
    alive_cells = [{ 0, 0 }, { 1, 0 }]
    refute GameOfLife.Cell.become_alive?(alive_cells, dead_cell)
  end

  test "find dead cells (neighbours of alive cell)" do
    alive_cells = [{ 1, 1 }]
    dead_neighbours = GameOfLife.Cell.dead_neighbours(alive_cells) |> Enum.sort
    expected_dead_neighbours = [
      {0, 0}, {1, 0}, {2, 0},
      {0, 1},         {2, 1},
      {0, 2}, {1, 2}, {2, 2}
    ] |> Enum.sort
    assert dead_neighbours == expected_dead_neighbours
  end

  test "find dead cells (neighbours of alive cells)" do
    alive_cells = [{ 1, 1 }, {2, 1}]
    dead_neighbours = GameOfLife.Cell.dead_neighbours(alive_cells) |> Enum.sort
    expected_dead_neighbours  = [
      {0, 0}, {1, 0}, {2, 0}, {3, 0},
      {0, 1},                 {3, 1},
      {0, 2}, {1, 2}, {2, 2}, {3, 2}
    ] |> Enum.sort
    assert dead_neighbours == expected_dead_neighbours
  end
end
