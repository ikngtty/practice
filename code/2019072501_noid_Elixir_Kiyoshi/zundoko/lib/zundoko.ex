defmodule Zundoko do
  @type zundoko :: :zn | :dk
  @type response :: :kys | :ysk
  @type zundoko_bushi :: [zundoko | response]

  # @spec sing_forever :: [zundoko]
  @spec sing_forever :: Enumerable.t()
  def sing_forever, do: Stream.repeatedly(fn -> Enum.random([:zn, :dk]) end)

  @doc ~S"""
  Find a zundoko call pattern, append the corresponding response and finish the song.

  ## Examples

      # less than four zuns are not Kiyoshi
      iex> Zundoko.bushify([:zn, :zn, :zn, :dk, :dk]) |> Enum.to_list()
      [:zn, :zn, :zn, :dk, :dk]

      # just four zuns are Kiyoshi
      iex> Zundoko.bushify([:zn, :zn, :zn, :zn, :dk, :dk, :dk]) |> Enum.to_list()
      [:zn, :zn, :zn, :zn, :dk, :kys]

      # Kiyoshi can be anywhere
      iex> Zundoko.bushify([:dk, :zn, :zn, :zn, :zn, :dk, :dk, :dk]) |> Enum.to_list()
      [:dk, :zn, :zn, :zn, :zn, :dk, :kys]

      # more than four zuns are not Kiyoshi (over-zun pattern)
      iex> Zundoko.bushify([:zn, :zn, :zn, :zn, :zn, :dk, :dk]) |> Enum.to_list()
      [:zn, :zn, :zn, :zn, :zn, :dk, :dk]

      # five dokos are Yoshiki because of Kurenai
      iex> Zundoko.bushify([:dk, :dk, :dk, :dk, :dk, :dk, :dk]) |> Enum.to_list()
      [:dk, :dk, :dk, :dk, :dk, :ysk]

  """
  # @spec bushify([zundoko]) :: zundoko_bushi
  @spec bushify(Enumerable.t()) :: Enumerable.t()
  def bushify(zundoko_list) do
    zundoko_list
    |> Stream.transform([], fn zd, queue ->
      queue = [zd | queue] |> Enum.take(6)

      case queue do
        [:dk | [:zn | [:zn | [:zn | [:zn | tail]]]]] when tail != [:zn] ->
          {[zd, :kys, :halt], queue}

        [:dk | [:dk | [:dk | [:dk | [:dk | _]]]]] ->
          {[zd, :ysk, :halt], queue}

        _ ->
          {[zd], queue}
      end
    end)
    |> Stream.take_while(&(&1 != :halt))
    # just in case
    |> Stream.take(1000)
  end

  @spec to_s(zundoko | response) :: String.t()
  def to_s(word)
  def to_s(:zn), do: "ズン"
  def to_s(:dk), do: "ドコ"
  def to_s(:kys), do: "  キ・ヨ・シ！！！！"
  def to_s(:ysk), do: "  ヨ・シ・キ！！！！"

  def main do
    zundoko_bushi = bushify(sing_forever())

    zundoko_bushi
    |> Enum.each(fn word -> word |> to_s() |> IO.write() end)
  end
end
