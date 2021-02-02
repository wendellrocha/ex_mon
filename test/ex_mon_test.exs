defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Wendell"
      }

      assert expected_response == ExMon.create_player("Wendell", :chute, :cura, :soco)
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("Wendell", :chute, :heal, :soco)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "This game is started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Wendell", :chute, :heal, :soco)
      _messages =
        capture_io(fn ->
          ExMon.start_game(player)
        end)

        :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do

      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move"
    end

    test "when the move is invalid, return an error message" do

    end
  end
end
