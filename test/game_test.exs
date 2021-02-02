defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Wendell", :chute, :heal, :soco)
      computer = Player.build("Mario", :chute, :heal, :soco)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Wendell", :chute, :heal, :soco)
      computer = Player.build("Mario", :chute, :heal, :soco)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Mario"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Wendell"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Wendell", :chute, :heal, :soco)
      computer = Player.build("Mario", :chute, :heal, :soco)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Mario"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Wendell"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response

      new_state = %{
        computer: %Player{
          life: 90,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Mario"
        },
        player: %Player{
          life: 40,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Wendell"
        },
        status: :continue,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert Game.info() == expected_response
    end
  end

  describe "fetch_player/1" do
    test "returns the player" do
      player = Player.build("Wendell", :chute, :heal, :soco)
      computer = Player.build("Mario", :chute, :heal, :soco)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Mario"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Wendell"
        },
        status: :started,
        turn: :player
      }

      assert Game.fetch_player(:player) == expected_response.player
    end
  end

  describe "turn/0" do
    test "returns the turn" do
      player = Player.build("Wendell", :chute, :heal, :soco)
      computer = Player.build("Mario", :chute, :heal, :soco)

      Game.start(computer, player)

      assert Game.turn() == :player
    end
  end

  describe "player/0" do
    test "returns the player" do
      player = Player.build("Wendell", :chute, :heal, :soco)
      computer = Player.build("Mario", :chute, :heal, :soco)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Mario"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Wendell"
        },
        status: :started,
        turn: :player
      }

      assert Game.player() == expected_response.player
    end
  end
end
