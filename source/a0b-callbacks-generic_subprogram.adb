--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

with System.Address_To_Access_Conversions;

package body A0B.Callbacks.Generic_Subprogram
  with SPARK_Mode => Off
is

   package Conversions is
     new System.Address_To_Access_Conversions (Object_Type);

   procedure Emitter (Closure : System.Storage_Elements.Integer_Address);

   ---------------------
   -- Create_Callback --
   ---------------------

   function Create_Callback
     (Object : aliased in out Object_Type) return Callback
   is
     (Emitter => Emitter'Access,
      Closure =>
         System.Storage_Elements.To_Integer
           (Conversions.To_Address (Object'Unchecked_Access)));

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : System.Storage_Elements.Integer_Address) is
   begin
      Subprogram
        (Conversions.To_Pointer
           (System.Storage_Elements.To_Address (Closure)).all);
   end Emitter;

end A0B.Callbacks.Generic_Subprogram;
