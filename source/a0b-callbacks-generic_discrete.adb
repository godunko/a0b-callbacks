--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package body A0B.Callbacks.Generic_Discrete is

   procedure Emitter (Closure : System.Storage_Elements.Integer_Address);

   function Create_Callback (Value : Discrete_Type) return Callback is
     (Emitter => Emitter'Access,
      Closure => Discrete_Type'Pos (Value));

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : System.Storage_Elements.Integer_Address) is
   begin
      Subprogram (Discrete_Type'Val (Closure));
   end Emitter;

end A0B.Callbacks.Generic_Discrete;
