defmodule BasicListBench do
  use Benchfella

  @list_1 [1]
  @list_1000 Enum.to_list(1..1000)
  @list_10000 Enum.to_list(1..10000)

  # bench "@list_1 ++ @list_1000" do
  # 	@list_1 ++ @list_1000
  # end

  # bench "@list_1000 ++ @list_1" do
  # 	@list_1000 ++ @list_1
  # end

  bench "@list_1 ++ @list_10000" do
  	@list_1 ++ @list_10000
  end

  bench "@list_10000 ++ @list_1" do
  	@list_10000 ++ @list_1
  end

  bench "@list_1000 ++ @list_10000" do
  	@list_1000 ++ @list_10000
  end

  bench "@list_10000 ++ @list_1000" do
  	@list_10000 ++ @list_1000
  end

  # bench "@list_10000 ++ @list_10000" do
  # 	@list_10000 ++ @list_10000
  # end

  bench "Enum.count(@list_1000)" do
  	Enum.count(@list_1000)
  end

  bench "Enum.count(@list_10000)" do
  	Enum.count(@list_10000)
  end

  bench "Enum.reverse(@list_1000)" do
  	Enum.reverse(@list_1000)
  end

  bench "Enum.reverse(@list_10000)" do
  	Enum.reverse(@list_10000)
  end
end
