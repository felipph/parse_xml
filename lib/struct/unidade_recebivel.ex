defmodule Struct.UnidadeRecebivel do
  @type t :: %__MODULE__{
          cnpf_cnpf_ufr: number(),
          dt_prevt_liq: Date.t(),
          vlr_prevt_liq: String.t(),
          dt_ref: Date.t(),
          cd_arranjo: String.t()
        }

  defstruct [:cnpf_cnpf_ufr, :cd_arranjo, :dt_prevt_liq, :vlr_prevt_liq, :dt_ref]
end
