defmodule ParseXmlTest do
  use ExUnit.Case
  doctest ParseXml
  alias Struct.Bcarq

  alias Elixir.Benchee




  # setup do
  #  :observer.start()
  # end

  test "Parse ARRC001" do

    {time, {:ok, state}} = :timer.tc(&ParseXml.parse_xml/0)

    {:ok, state} = ParseXml.parse_xml()
    IO.inspect(state)
    IO.inspect(time/1000)
    assert(length(state.records) == 24400)
  end

  test "TypeCheck" do
    struc = %Bcarq{nm_arq: "Teste"}
    %type{} = struc
    IO.inspect(struc)
    IO.inspect(type)
    assert type == Struct.Bcarq
  end

  # test "Bench" do
  #   Benchee.run(%{ "somente parse" => fn -> ParseXml.parse_xml() end,"parse e validacao" => fn -> ParseXml.parse_xml_with_validation() end}, time: 10, memory_time: 2)
  # end
end
