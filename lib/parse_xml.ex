defmodule ParseXml do
  def parse_xml do
    xml_file = "./arrc001/ARRC001_01027058_20200110_00001.xml"
    case File.stream!(xml_file)
        |> Stream.filter(&(&1 != "\n "))
        |>Saxy.parse_stream(Parser.Arrc001Handler, nil) do
      {:ok, state} -> {:ok, state}
      {:error, err} -> {:error, err}
    end
  end

  def parse_xml_with_validation do
    xml_file = "./arrc001/ARRC001_01027058_20200110_00001.xml"
    xsd = "./arrc001/ARRC001.xsd"
    #validação do XSD
    case :erlsom.compile_xsd_file(xsd, include_dirs: ["arrc001"]) do
      {:error, error_desc} -> throw(error_desc)
      {:ok, model} -> validade(xml_file, model)
    end

    parse_xml()
  end

  def validade(xml_file, model) do
    case :erlsom.scan_file(xml_file, model) do
      {:ok, _data, _linebreak} -> :ok
      {:error, error_data} -> {:error, error_data}
    end
  end

end
