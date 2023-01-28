defmodule Parser.Arrc001Handler do
  @behaviour Saxy.Handler

  alias Struct.Bcarq
  alias Struct.ParseContext
  alias Struct.UnidadeRecebivel

  def handle_event(:start_document, _prolog, _state), do: {:ok, %ParseContext{}}

  def handle_event(:end_document, _data, %{bcarq: bcarq, records: records}) do
    {:ok, %{bcarq: bcarq, records: records}}
  end

  #Records
  def handle_event(:start_element, {"Grupo_ARRC001_UsuFinalRecbdr", _attributes}, state) do
    {:ok, %{state| current_record: %UnidadeRecebivel{}} }
  end

  def handle_event(:end_element, "Grupo_ARRC001_DomclBanc", %{current_record: %UnidadeRecebivel{}} = state) do

    base_record = %UnidadeRecebivel{
      cnpf_cnpf_ufr: state.current_record.cnpf_cnpf_ufr,
      cd_arranjo: state.current_record.cd_arranjo,
      vlr_total: state.current_record.vlr_total,
      dt_prevt_liq: state.current_record.dt_prevt_liq
    }
    {:ok, %{state | records: [state.current_record | state.records], current_record: base_record}}
    # {:ok, %{state |  current_record: base_record}}
  end

  def handle_event(:end_element, "Grupo_ARRC001_UniddRecbvl", state) do
    base_record = %UnidadeRecebivel{
      cnpf_cnpf_ufr: state.current_record.cnpf_cnpf_ufr,
      cd_arranjo: state.current_record.cd_arranjo
    }
    {:ok, %{state | current_record: base_record}}
  end

  # def handle_event(:end_element, "Grupo_ARRC001_UniddRecbvl", state) do
  #   {:ok, %{state | records: [state.current_record | state.records], current_record: nil}}
  # end

  ##Inícios de tags de tipos conhecidos
  def handle_event(:start_element, {name, _attributes}, %{current_record: %Bcarq{}} = state) do
    {:ok, %{state| current_tag: name} }
  end

  def handle_event(:start_element, {name, _attributes}, %{current_record: %UnidadeRecebivel{}} = state) do
    {:ok, %{state| current_tag: name} }
  end


  def handle_event(:characters, chars, %{current_record: %UnidadeRecebivel{}} = state) do
    case state.current_tag do
      "CNPJ_CPFUsuFinalRecbdr"  -> {:ok, %{state | current_record: %{state.current_record | cnpf_cnpf_ufr: chars}}}
      "CodInstitdrArrajPgto"    -> {:ok, %{state | current_record: %{state.current_record | cd_arranjo: chars}}}
      "DtPrevtLiquid"           -> {:ok, %{state | current_record: %{state.current_record | dt_prevt_liq: Date.from_iso8601(chars)}}}
      "VlrTot"                  -> {:ok, %{state | current_record: %{state.current_record | vlr_total: Decimal.round(Decimal.new(chars),2,:half_even)}}}
      "VlrPreContrd"            -> {:ok, %{state | current_record: %{state.current_record | vlr_pre_contr: Decimal.new(chars)}}}
      "CNPJ_CPFTitlarCt"        -> {:ok, %{state | current_record: %{state.current_record | cnpf_cnpf_tit_ct: chars}}}
      "ISPBBcoRecbdr"           -> {:ok, %{state | current_record: %{state.current_record | ispb_bco_recb: String.to_integer(chars)}}}
      "TpCt"                    -> {:ok, %{state | current_record: %{state.current_record | tp_ct: chars}}}
      "Ag"                      -> {:ok, %{state | current_record: %{state.current_record | ag: chars}}}
      "Ct"                      -> {:ok, %{state | current_record: %{state.current_record | ct: chars}}}
      "CtPgto"                  -> {:ok, %{state | current_record: %{state.current_record | ct_pgto: chars}}}
      "VlrPrevtLiquid"          -> {:ok, %{state | current_record: %{state.current_record | vlr_prevt_liq: Decimal.round(Decimal.new(chars),2,:half_even)}}}
      "DtEftLiquid"             -> {:ok, %{state | current_record: %{state.current_record | dt_eft_liq: Date.from_iso8601(chars)}}}
      "VlrEftLiquid"            -> {:ok, %{state | current_record: %{state.current_record | vlr_eft_liq: Decimal.round(Decimal.new(chars),2,:half_even)}}}
      "IdentdOp"                -> {:ok, %{state | current_record: %{state.current_record | id_op: Decimal.new(chars)}}}
      _ -> {:ok, state}
    end
  end



  ########## PARSE BCARQ ############

  ##BCARQ
  def handle_event(:start_element, {"BCARQ", _attributes}, state) do
    {:ok, %{state| current_record: %Bcarq{}} }
  end

  def handle_event(:end_element, "BCARQ", %{current_record: %Bcarq{}} = state) do
    {:ok, %{state | bcarq: state.current_record , current_record: nil, current_tag: nil}}
  end

  #CAMPOS
  def handle_event(:characters, chars, %{current_record: %Bcarq{}} = state) do
    # IO.inspect(state.current_tag)
    case state.current_tag do
      "NomArq"            -> {:ok, %{state | current_record: %{state.current_record | nm_arq: chars}}}
      "NumCtrlEmis"       -> {:ok, %{state | current_record: %{state.current_record | num_ctrl_emissor: chars}}}
      "ISPBEmissor"       -> {:ok, %{state | current_record: %{state.current_record | ispb_emissor: chars}}}
      "ISPBDestinatario"  -> {:ok, %{state | current_record: %{state.current_record | ispb_dest: chars}}}
      "DtHrArq"           -> {:ok, %{state | current_record: %{state.current_record | dh_arq: chars}}}
      "DtRef"             -> {:ok, %{state | current_record: %{state.current_record | dt_ref: chars}}}
      _ -> {:ok, state}
    end
  end

  #### DEFAULTS

  def handle_event(:start_element, {_tag, _attributes}, state), do: {:ok, state}
  def handle_event(:end_element, _name, state), do: {:ok, %{state | current_tag: nil}}
  def handle_event(:characters, _chars, state),  do: {:ok, state}
end
