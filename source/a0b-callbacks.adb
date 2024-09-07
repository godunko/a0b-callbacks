--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Callbacks is

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

   procedure Emit_Once (Self : in out Callback) is
      Emitter : constant access procedure (Closure : System.Address) :=
        Self.Emitter;
      Closure : constant System.Address := Self.Closure;

   begin
      Unset (Self);

      if Emitter /= null then
         Emitter (Closure);
      end if;
   end Emit_Once;

   -----------
   -- Unset --
   -----------

   procedure Unset (Self : in out Callback) is
   begin
      Self.Emitter := null;
      Self.Closure := System.Null_Address;
   end Unset;

end A0B.Callbacks;
