--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Callbacks.No_Operation is

   procedure Emitter
     (Closure : System.Storage_Elements.Integer_Address) is null;

   ---------------------
   -- Create_Callback --
   ---------------------

   function Create_Callback return Callback is
   begin
      return (Emitter => Emitter'Access, Closure => Null_Address);
   end Create_Callback;

end A0B.Callbacks.No_Operation;
