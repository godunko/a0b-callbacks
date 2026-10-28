--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

with A0B.Storage.Address_To_Access_Conversions;

package body A0B.Callbacks.Generic_Object_Aliased
  with SPARK_Mode => Off
is

   package Conversions is
     new A0B.Storage.Address_To_Access_Conversions (Object_Type);

   procedure Emitter (Closure : A0B.Storage.Address);

   ------------
   -- Create --
   ------------

   function Create
     (Object : aliased in out Object_Type) return Callback
   is
     (Emitter => Emitter'Access,
      Closure => Conversions.As_Address (Object'Unchecked_Access));

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : A0B.Storage.Address) is
   begin
      Subprogram (Conversions.As_Access (Closure).all);
   end Emitter;

end A0B.Callbacks.Generic_Object_Aliased;
