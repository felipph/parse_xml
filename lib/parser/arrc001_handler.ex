defmodule Parser.Arrc001Handler do
  @behaviour Saxy.Handler

  alias Struct.Bcarq
  alias Struct.ParseContext
  alias Struct.UnidadeRecebivel

  def handle_event(:start_document, _prolog, _state), do: {:ok, %ParseContext{}}

  def handle_event(:end_document, _data, %{bcarq: bcarq, records: records}) do
    {:ok, %{bcarq: bcarq, records: records}}
  end

  def handle_event(:start_element, {name, _attributes}, state) when name == "Grupo_ARRC001_UsuFinalRecbdr" do
    state = {:ok, %{state| current_record: %UnidadeRecebivel{}} }
    # IO.inspect(state)
    state
  end

  def handle_event(:start_element, {"CNPJ_CPFUsuFinalRecbdr", _attributes}, %{current_record: %UnidadeRecebivel{}} = state) do
    state = {:ok, %{state| current_tag: "CNPJ_CPFUsuFinalRecbdr"} }
    # IO.inspect(state)
    state
  end
  def handle_event(:characters, chars, %{current_tag: "CNPJ_CPFUsuFinalRecbdr", current_record: %UnidadeRecebivel{}} = state) do
    state = {:ok, %{state | current_record: %{state.current_record | cnpf_cnpf_ufr: chars}}}
    # IO.inspect(state)
    state
  end



  def handle_event(:end_element, "Grupo_ARRC001_UsuFinalRecbdr", state),
  do: {:ok, %{state | records: [state.current_record | state.records], current_record: nil, current_tag: nil}}




  ########## PARSE BCARQ ############


  ##campos
  def handle_event(:start_element, {"NomArq", _attributes}, %{current_record: %Bcarq{}} = state) do
    state = {:ok, %{state| current_tag: "NomArq"} }
    IO.inspect(state)
    state
  end

  def handle_event(:characters, chars, %{current_tag: "NomArq", current_record: %Bcarq{}} = state) do
    state = {:ok, %{state | current_record: %{state.current_record | nm_arq: chars}}}
    IO.inspect(state)
    state
  end

  def handle_event(:start_element, {"BCARQ", _attributes}, state) do
    {:ok, %{state| current_record: %Bcarq{}} }
  end

  def handle_event(:end_element, "BCARQ", %{current_record: %Bcarq{}} = state) do
    {:ok, %{state | bcarq: state.current_record , current_record: nil, current_tag: nil}}
  end

  #### DEFAULTS

  def handle_event(:start_element, {_tag, _attributes}, state) do
    {:ok, state}
  end

  def handle_event(:end_element, _name, state), do: {:ok, %{state | current_tag: nil}}
  def handle_event(:characters, _chars, state),  do: {:ok, state}
end
