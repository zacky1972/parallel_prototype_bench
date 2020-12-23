defmodule BinaryMergerBench do
  use Benchfella

  @ascending Enum.map(1..100, &BinaryMergerHelper.element(&1))
  @descending Enum.map(100..1, &BinaryMergerHelper.element(&1))
  @random 1..100 |> Enum.shuffle |> Enum.map(&BinaryMergerHelper.element(&1))

  @as1 Enum.map(1..2, &BinaryMergerHelper.element(&1))
  @des1 Enum.map(2..1, &BinaryMergerHelper.element(&1))

  @as10 Enum.map(1..10, &BinaryMergerHelper.element(&1))
  @des10 Enum.map(10..1, &BinaryMergerHelper.element(&1))

  bench "insert in ascending order" do
  	Enum.reduce(@ascending, [], fn x, acc -> BinaryMerger.insert(acc, x) end)
  end

  bench "insert in descending order" do
  	Enum.reduce(@descending, [], fn x, acc -> BinaryMerger.insert(acc, x) end)
  end

  bench "insert in order at random" do
  	Enum.reduce(@random, [], fn x, acc -> BinaryMerger.insert(acc, x) end)
  end

  bench "@as1" do
    Enum.reduce(@as1, [], fn x, acc -> BinaryMerger.insert(acc, x) end)    
  end

  bench "@des1" do
    Enum.reduce(@des1, [], fn x, acc -> BinaryMerger.insert(acc, x) end)    
  end

  bench "@as10" do
    Enum.reduce(@as10, [], fn x, acc -> BinaryMerger.insert(acc, x) end)    
  end

  bench "@des10" do
    Enum.reduce(@des10, [], fn x, acc -> BinaryMerger.insert(acc, x) end)    
  end

  bench "BinaryMerger.insert([], i)" do
    BinaryMerger.insert([], BinaryMergerHelper.element(1))
  end

  bench "BinaryMerger.insert(h, i) as" do
    BinaryMerger.insert(BinaryMergerHelper.element(1), BinaryMergerHelper.element(2))
  end

  bench "BinaryMerger.insert(h, i) des" do
    BinaryMerger.insert(BinaryMergerHelper.element(2), BinaryMergerHelper.element(1))
  end

  bench "spawn" do
    spawn(BinaryMergerHelper, :echo, [self()])

    receive do
      :ok -> :ok
    after 5000 -> raise("Timeout")
    end
  end
end