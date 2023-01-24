defmodule ParseXml do
  def parse_xml do
    xml_file = "./arrc001/ARRC001_01027058_20200110_00002.xml"
    xsd = "./arrc001/ARRC001.xsd"

    case :erlsom.compile_xsd_file(xsd, include_dirs: ["arrc001"]) do
      {:error, error_desc} -> IO.inspect(error_desc)
      {:ok, model} -> validade(xml_file, model)
    end

    # ok, agora parse para registros:

    stream =
      File.stream!(xml_file)
      |> Stream.filter(&(&1 != "\n "))

    {:ok, state} = Saxy.parse_stream(stream, Parser.Arrc001Handler, nil)
    IO.inspect(state)
  end

  def validade(xml_file, model) do
    case :erlsom.scan_file(xml_file, model) do
      {:ok, _data, _linebreak} -> :ok
      {:error, error_data} -> {:error, error_data}
    end
  end

  def time_of(function, args) do
    :timer.tc(function, args)
  end

  def do_parse do
    {time, result} = ParseXml.time_of(&parse_xml/0, [])
    IO.puts("Time: #{time / 1000}ms")
    result
  end
end
