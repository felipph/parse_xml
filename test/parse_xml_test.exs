defmodule ParseXmlTest do
  use ExUnit.Case
  doctest ParseXml
  alias Struct.Bcarq

  test "Parse ARRC001" do
    ParseXml.parse_xml()
    |> IO.inspect
  end

  test "TypeCheck" do
    struc = %Bcarq{nm_arq: "Teste"}
    %type{} = struc
    IO.inspect(struc)
    IO.inspect(type)
    assert type == Struct.Bcarq
  end
end
