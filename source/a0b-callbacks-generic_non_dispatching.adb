--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

with System.Address_To_Access_Conversions;

package body A0B.Callbacks.Generic_Non_Dispatching is

   package Conversions is
     new System.Address_To_Access_Conversions (Object_Type'Class);

   procedure Emitter (Closure : System.Address);

   ---------------------
   -- Create_Callback --
   ---------------------

   function Create_Callback
     (Object : aliased in out Object_Type'Class) return Callback is
   begin
      return
        (Emitter => Emitter'Access,
         Closure => Object'Address);
   end Create_Callback;

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : System.Address) is
   begin
      Subprogram (Conversions.To_Pointer (Closure).all);
   end Emitter;

end A0B.Callbacks.Generic_Non_Dispatching;