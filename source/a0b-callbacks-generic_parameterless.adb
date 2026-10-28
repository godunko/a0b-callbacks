--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Callbacks.Generic_Parameterless
  with SPARK_Mode => Off
is

   procedure Emitter (Closure : A0B.Storage.Address)
     with SPARK_Mode => Off;

   ------------
   -- Create --
   ------------

   function Create return Callback
   is
     (Emitter => Emitter'Access,
      Closure => <>);

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : A0B.Storage.Address)
     with SPARK_Mode => Off
   is
      use type A0B.Storage.Address;

      pragma Assert (Closure = A0B.Storage.Null_Address);

   begin
      Subprogram;
   end Emitter;

end A0B.Callbacks.Generic_Parameterless;
