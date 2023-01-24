defmodule Struct.Bcarq do
  @type t :: %__MODULE__{
          nm_arq: String.t(),
          num_ctrl_emissor: number(),
          ispb_emissor: integer(),
          ispb_dest: String.t(),
          dh_arq: DateTime.t(),
          dt_ref: Date.t()
        }

  defstruct [:nm_arq, :num_ctrl_emissor, :ispb_emissor, :ispb_dest, :dh_arq, :dt_ref]
end
