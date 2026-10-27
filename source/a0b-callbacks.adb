--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Callbacks is

   use type System.Storage_Elements.Integer_Address;

   ----------
   -- Emit --
   ----------

   procedure Emit (Self : Callback) is
   begin
      if Self.Emitter /= null then
         Self.Emitter (Self.Closure);
      end if;
   end Emit;

   ---------------
   -- Emit_Once --
   ---------------

   procedure Emit_Once (Self : aliased in out Callback) is
      Emitter : constant
        access procedure (Closure : System.Storage_Elements.Integer_Address) :=
          Self.Emitter;
      Closure : constant System.Storage_Elements.Integer_Address :=
        Self.Closure;

   begin
      Unset (Self);

      if Emitter /= null then
         pragma Assert (not Is_Set (Self));
         --  Callback has been unset before invocation.

         Emitter (Closure);
      end if;
   end Emit_Once;

   -----------
   -- Unset --
   -----------

   procedure Unset (Self : in out Callback)
     with Refined_Post => Self.Emitter = null and Self.Closure = 0
   is
   begin
      Self.Emitter := null;
      Self.Closure := Null_Address;
   end Unset;

end A0B.Callbacks;
