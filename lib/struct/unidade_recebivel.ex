defmodule Struct.UnidadeRecebivel do
  @type t :: %__MODULE__{
          cnpf_cnpf_tit: String.t(),
          cnpf_cnpf_ufr: String.t(),
          cd_arranjo: String.t(),
          dt_prevt_liq: Date.t(),
          vlr_total: Decimal.t(),
          vlr_pre_contr: Decimal.t(),
          vlr_prevt_liq: Decimal.t(),
          dt_eft_liq: Date.t(),
          vlr_eft_liq: Decimal.t(),
          id_op: Decimal.t(),
          cnpf_cnpf_tit_ct: String.t(),
          ispb_bco_recb: integer,
          tp_ct: String.t(),
          ag: String.t(),
          ct: String.t(),
          ct_pgto: String.t()
        }
  defstruct [:cnpf_cnpf_tit, :cnpf_cnpf_ufr, :cd_arranjo, :dt_prevt_liq, :vlr_prevt_liq,
  :vlr_total, :vlr_pre_contr, :dt_eft_liq, :vlr_eft_liq,
  :cnpf_cnpf_tit_ct, :ispb_bco_recb, :tp_ct, :ag, :ct, :ct_pgto, id_op: Decimal.new("0")]
end
