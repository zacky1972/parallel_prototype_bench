defmodule BinaryMergerBench do
  use Benchfella

  @t 4

  @ascending Enum.map(1..(@t * @t * @t), &MergerHelper.element(&1, 0))
  @descending Enum.map((@t * @t * @t)..1, &MergerHelper.element(&1, 0))
  @random 1..(@t * @t * @t) |> Enum.shuffle |> Enum.map(&MergerHelper.element(&1, 0))

  # @as1 Enum.map(1..2, &MergerHelper.element(&1, 0))
  # @des1 Enum.map(2..1, &MergerHelper.element(&1, 0))

  # @as10 Enum.map(1..10, &MergerHelper.element(&1, 0))
  # @des10 Enum.map(10..1, &MergerHelper.element(&1, 0))

  bench "insert in ascending order" do
  	Enum.reduce(@ascending, [], fn x, acc -> BinaryMerger.insert(acc, x) end)
  end

  bench "insert in descending order" do
  	Enum.reduce(@descending, [], fn x, acc -> BinaryMerger.insert(acc, x) end)
  end

  bench "insert in order at random" do
  	Enum.reduce(@random, [], fn x, acc -> BinaryMerger.insert(acc, x) end)
  end

  # bench "@as1" do
  #   Enum.reduce(@as1, [], fn x, acc -> BinaryMerger.insert(acc, x) end)    
  # end

  # bench "@des1" do
  #   Enum.reduce(@des1, [], fn x, acc -> BinaryMerger.insert(acc, x) end)    
  # end

  # bench "@as10" do
  #   Enum.reduce(@as10, [], fn x, acc -> BinaryMerger.insert(acc, x) end)    
  # end

  # bench "@des10" do
  #   Enum.reduce(@des10, [], fn x, acc -> BinaryMerger.insert(acc, x) end)    
  # end

  # bench "BinaryMerger.insert([], i)" do
  #   BinaryMerger.insert([], MergerHelper.element(1))
  # end

  # bench "BinaryMerger.insert(h, i) as" do
  #   BinaryMerger.insert(MergerHelper.element(1), MergerHelper.element(2))
  # end

  # bench "BinaryMerger.insert(h, i) des" do
  #   BinaryMerger.insert(MergerHelper.element(2), MergerHelper.element(1))
  # end

  # bench "spawn" do
  #   spawn(MergerHelper, :echo, [self()])

  #   receive do
  #     :ok -> :ok
  #   after 5000 -> raise("Timeout")
  #   end
  # end

  # bench "single parallel" do
  #   pid = spawn(ParallelBinaryMerger, :receive_insert, [self(), 1..1])
  #   element_1 = MergerHelper.element(1)
  #   send(pid, element_1)
  #   receive do
  #     ^element_1 -> :ok
  #   after 1000 -> :error
  #   end
  # end

  bench "parallel (each #{@t} lists)" do
    1..@t
    |> Enum.map(fn i ->
      {spawn(ParallelBinaryMerger, :receive_insert, [
         self(),
         1..@t |> Enum.map(&(&1 + (i - 1) * @t))
       ]), i}
    end)
    |> Enum.each(fn {pid, i} ->
      send(
        pid,
        1..@t
        |> Enum.map(&MergerHelper.element(&1 + (i - 1) * @t, ((&1 - 1) + (i - 1) * @t) * 1000))
        |> List.flatten()
      )
    end)

    ParallelBinaryMerger.receive_insert(self(), 1..(@t * @t))

    receive do
      _ -> :ok
    after
      1000 -> raise("Timeout")
    end
  end

  bench "parallel (each #{@t} lists) des" do
    @t..1
    |> Enum.map(fn i ->
      {spawn(ParallelBinaryMerger, :receive_insert, [
         self(),
         @t..1 |> Enum.map(&(&1 + (i - 1) * @t))
       ]), i}
    end)
    |> Enum.each(fn {pid, i} ->
      send(
        pid,
        @t..1
        |> Enum.map(&MergerHelper.element(&1 + (i - 1) * @t, ((&1 - 1) + (i - 1) * @t) * 1000))
        |> List.flatten()
      )
    end)

    ParallelBinaryMerger.receive_insert(self(), (@t * @t)..1)

    receive do
      _result -> :ok
    after
      1000 -> raise("Timeout")
    end
  end

end
