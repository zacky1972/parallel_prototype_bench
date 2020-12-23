defmodule BinaryMergerHelper do
  @list_1000 Enum.to_list(1..1000)
  def element(id), do: [{id..id, 1000, @list_1000}]

  def echo(pid) do
  	send(pid, :ok)
  end
end