defmodule MergerHelper do
  def element(id, offset), do: [{id..id, 1000, Enum.to_list((1 + offset)..(1000 + offset))}]

  def echo(pid) do
  	send(pid, :ok)
  end
end