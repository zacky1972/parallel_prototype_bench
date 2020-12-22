defmodule BasicListBench do
  use Benchfella

  @list_1 [1]
  @list_1000 Enum.to_list(1..1000)
  @list_10000 Enum.to_list(1..10000)

  
end