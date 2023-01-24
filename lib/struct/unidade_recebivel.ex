defmodule Struct.UnidadeRecebivel do
  @type t :: %__MODULE__{
          cd_arranjo: String.t(),
          cnpf_cnpf_ufr: number(),
          dt_prevt_liq: Date.t(),
          vlr_prevt_liq: Decimal.t(),
          vlr_total: Decimal.t()
        }
  defstruct [:cnpf_cnpf_ufr, :cd_arranjo,
  :dt_prevt_liq, :vlr_prevt_liq, :vlr_total]
end
