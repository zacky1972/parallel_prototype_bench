defmodule ParallelPrototypeBBench do
  use Benchfella

  @range_0x10000 Enum.to_list(1..0x10000)

  setup_all do
    LogisticMap.logistic_map_10_pelemay(@range_0x10000)
    {:ok, nil}
  end

  # bench "Enum.map(@range_0x10000, & &1 * 2)" do
  # 	Enum.map(@range_0x10000, & &1 * 2)
  # end

  # bench "ParallelPrototype.pmap(@range_0x10000, & &1 * 2)" do
  # 	ParallelPrototype.pmap(@range_0x10000, & &1 * 2)
  # end

  bench "Enum.map(@range_0x10000, logistic_map_10)" do
  	Enum.map(@range_0x10000, &LogisticMap.logistic_map_10(&1))
  end

  bench "ParallelPrototype.pmap(@range_0x10000, logistic_map_10)" do
  	ParallelPrototype.pmap(@range_0x10000, &LogisticMap.logistic_map_10(&1), 12000)
  end

  bench "ParallelPrototype.pmap_chunk(@range_0x10000, pelemay_logistic_map_10)" do
    ParallelPrototype.pmap_chunk(@range_0x10000, &LogisticMap.logistic_map_10(&1), &LogisticMap.logistic_map_10_pelemay(&1), 8000)
  end
end
