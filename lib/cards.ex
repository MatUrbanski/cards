defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of string representing a deck of playing cards.

  ## Examples

      iex> Cards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
       "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
       "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
       "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
       "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
  """

  @spec create_deck :: list
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Shuffles and randomizes passed deck.

  ## Examples
      iex > Cards.shuffle(["Ace of Spades", "Two of Spades"])
  """

  @spec shuffle(list) :: list
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Determines whether a deck contains a given card.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """

  @spec contains?(list, any) :: boolean
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Divides a deck into a hand and the reminder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """

  @spec deal(list, integer) :: list
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Encodes deck to a binary and saves it as a file.

  ## Examples

      iex> Cards.save(["Ace of Spades"], "test_deck")
      :ok

  """

  @spec save(list, String.t) :: atom
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads file, decodes it and returns deck.

  ## Examples

      iex> Cards.save(["Ace of Spades"], "test_deck")
      iex> Cards.load("test_deck")
      ["Ace of Spades"]

  """

  @spec load(String.t) :: list
  def load(filename) do
    case File.read(filename) do
      {:ok, binary}    -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
    Returns shuffled and divided deck.

  ## Examples

      iex> {hand, deck} = Cards.create_hand(2)
      iex> length(hand)
      2
      iex> length(deck)
      18

  """

  @spec create_hand(integer) :: list
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
