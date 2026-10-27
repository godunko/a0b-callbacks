--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Callbacks.Generic_Parameterless
  with SPARK_Mode => Off
is

   procedure Emitter (Closure : System.Storage_Elements.Integer_Address)
     with SPARK_Mode => Off;

   ---------------------
   -- Create_Callback --
   ---------------------

   function Create_Callback return Callback
   is
     (Emitter => Emitter'Access,
      Closure => Null_Address);

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : System.Storage_Elements.Integer_Address)
     with SPARK_Mode => Off
   is
      use type System.Storage_Elements.Integer_Address;

      pragma Assert (Closure = Null_Address);

   begin
      Subprogram;
   end Emitter;

end A0B.Callbacks.Generic_Parameterless;
