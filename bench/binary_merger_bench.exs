defmodule BinaryMergerBench do
  use Benchfella

  @ascending Enum.map(1..100, &BinaryMergerHelper.element(&1))
  @descending Enum.map(100..1, &BinaryMergerHelper.element(&1))
  @random 1..100 |> Enum.shuffle |> Enum.map(&BinaryMergerHelper.element(&1))

  bench "insert in ascending order" do
  	Enum.reduce(@ascending, [], fn x, acc -> BinaryMerger.insert(acc, x) end)
  end

  bench "insert in descending order" do
  	Enum.reduce(@descending, [], fn x, acc -> BinaryMerger.insert(acc, x) end)
  end

  bench "insert in order at random" do
  	Enum.reduce(@random, [], fn x, acc -> BinaryMerger.insert(acc, x) end)
  end
end