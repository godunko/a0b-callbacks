--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Callbacks.Generic_Parameterless is

   procedure Emitter (Closure : System.Address);

   ---------------------
   -- Create_Callback --
   ---------------------

   function Create_Callback return Callback is
   begin
      return
        (Emitter => Emitter'Access,
         Closure => System.Null_Address);
   end Create_Callback;

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : System.Address) is
      use type System.Address;
      
      pragma Unreferenced (Closure);

      pragma Assert (Closure = System.Null_Address);

   begin
      Subprogram;
   end Emitter;

end A0B.Callbacks.Generic_Parameterless;