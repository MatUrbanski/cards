defmodule CardsTest do
  use ExUnit.Case, async: true
  doctest Cards

  setup do
    on_exit fn ->
      File.rm("test_deck")
    end
  end

  describe "create_deck/0" do
    test "returns list of cards" do
      cards = [
        "Ace of Spades", "Two of Spades", "Three of Spades",
        "Four of Spades", "Five of Spades", "Ace of Clubs", "Two of Clubs",
        "Three of Clubs", "Four of Clubs", "Five of Clubs",
        "Ace of Hearts", "Two of Hearts", "Three of Hearts",
        "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
        "Two of Diamonds", "Three of Diamonds", "Four of Diamonds",
        "Five of Diamonds"
      ]

      assert Cards.create_deck == cards
    end
  end

  describe "shuffle/1" do
    test "shuffles a deck and randomizes it" do
      deck = Cards.create_deck

      refute deck == Cards.shuffle(deck)
    end
  end

  describe "contains?/1" do
    test "returns true when deck contains card" do
      deck = ["Ace of Spades"]

      assert Cards.contains?(deck, "Ace of Spades") == true
    end

    test "returns false when deck contains card" do
      deck = ["Ace of Spades"]

      assert Cards.contains?(deck, "Two of Spades") == false
    end
  end

  describe "deal/2" do
    test "divides deck by a provided size" do
      deck = ["Ace of Spades", "Two of Spades", "Three of Spades"]

      assert Cards.deal(deck, 2) == {["Ace of Spades", "Two of Spades"], ["Three of Spades"]}
    end
  end

  describe "save/2" do
    test "saves file with binary data" do
      Cards.save(["Ace of Spades"], "test_deck")

      assert File.exists?("test_deck") == true
    end

    test "returns :ok" do
      assert Cards.save(["Ace of Spades"], "test_deck") == :ok
    end
  end

  describe "load/1" do
    test "returns decoded binary when file exists" do
      Cards.save(["Ace of Spades"], "test_deck")

      assert Cards.load("test_deck") == ["Ace of Spades"]
    end

    test "returns error message when file does not exists" do
      assert Cards.load("wrong_deck") == "That file does not exist"
    end
  end

  describe "create_hand/1" do
    test 'it returns shuffled and divided deck' do
      {hand, deck} = Cards.create_hand(2)

      assert length(hand) == 2
      assert length(deck) == 18
    end
  end
end
