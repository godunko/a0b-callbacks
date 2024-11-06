--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package body A0B.Callbacks.Generic_Discrete is

   procedure Emitter (Closure : System.Address);

   function Create_Callback (Value : Discrete_Type) return Callback is
     (Emitter => Emitter'Access,
      Closure => System.Storage_Elements.To_Address
        (Discrete_Type'Pos (Value)));

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : System.Address) is
      Argument : constant Discrete_Type :=
        Discrete_Type'Val
          (System.Storage_Elements.To_Integer (Closure));
   begin
      Subprogram (Argument);
   end Emitter;

end A0B.Callbacks.Generic_Discrete;
