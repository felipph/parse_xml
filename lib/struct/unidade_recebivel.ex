defmodule Struct.UnidadeRecebivel do
  @type t :: %__MODULE__{
          cnpf_cnpf_ufr: String.t(),
          cd_arranjo: String.t(),
          dt_prevt_liq: Date.t(),
          vlr_prevt_liq: Decimal.t(),
          vlr_total: Decimal.t()
        }
  defstruct [:cnpf_cnpf_ufr, :cd_arranjo, :dt_prevt_liq, :vlr_prevt_liq, :vlr_total]
end
