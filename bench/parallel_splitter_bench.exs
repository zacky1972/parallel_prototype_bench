defmodule ParallelSplitterBench do
  use Benchfella

  @list_10000 Enum.to_list(1..10000)

  bench "ParallelSplitter(@list_10000, 1000)" do
  	ParallelSplitter.split({SplitterHelper, :count}, self(), @list_10000, 1000, [:monitor])  	
  	:ok
  end
end