--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Callbacks
  with SPARK_Mode => On
is

   use type System.Storage_Elements.Integer_Address;

   procedure Take (Self : in out Callback; Saved : out Callback)
     with Inline_Always,
          Always_Terminates,
          Global  => null,
          Depends => (Self => null, Saved => Self),
          Post    =>
            not Is_Set (Self)
              and then Is_Set (Saved) = Is_Set (Self'Old)
              and then Saved.Closure = Self.Closure'Old;
   --  Save callback metadata and clear the source before invocation.

   ----------
   -- Emit --
   ----------

   procedure Emit (Self : Callback)
     with SPARK_Mode => Off
   is
   begin
      if Self.Emitter /= null then
         Self.Emitter (Self.Closure);
      end if;
   end Emit;

   ---------------
   -- Emit_Once --
   ---------------

   procedure Emit_Once (Self : aliased in out Callback)
     with SPARK_Mode => Off
   is
      Saved : Callback;

   begin
      Take (Self, Saved);

      if Saved.Emitter /= null then
         pragma Assert (not Is_Set (Self));
         --  Callback has been unset before invocation.

         Saved.Emitter (Saved.Closure);
      end if;
   end Emit_Once;

   ----------
   -- Take --
   ----------

   procedure Take (Self : in out Callback; Saved : out Callback) is
   begin
      Saved := Self;
      Unset (Self);
   end Take;

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
