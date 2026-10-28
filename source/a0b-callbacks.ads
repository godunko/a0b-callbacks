--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Simple callback object to call user defined subprogram with single user
--  defined argument.

pragma Ada_2022;
pragma Restrictions (No_Elaboration_Code);

private with A0B.Storage;

package A0B.Callbacks
  with Pure, SPARK_Mode => On
is

   type Callback is private
     with Preelaborable_Initialization,
          Default_Initial_Condition => not Is_Set (Callback);

   function Is_Set (Self : Callback) return Boolean
     with Global  => null,
          Depends => (Is_Set'Result => Self);
   --  Callback subprogram/argument has been set.

   procedure Emit (Self : Callback)
     with Inline_Always,
          SPARK_Mode => Off;
   --  Call the callback subprogram when it is set. Exceptions propagated by
   --  the callback subprogram are caught and ignored.
   --
   --  `Emit` is outside SPARK because registered handlers may access arbitrary
   --  global data.

   procedure Emit_Once (Self : aliased in out Callback)
     with SPARK_Mode => Off;
   --  Clear the callback object and invoke the saved callback subprogram. The
   --  callback subprogram may register a new callback during the call.
   --
   --  `Emit_Once` is outside SPARK because registered handlers may access
   --  arbitrary global data.

   procedure Unset (Self : in out Callback)
     with Inline_Always,
          Always_Terminates,
          Global  => null,
          Depends => (Self => null, null => Self),
          Post    => not Is_Set (Self);
   --  Clean callback object.

private

   type Callback is record
      Emitter : access procedure (Closure : A0B.Storage.Address);
      Closure : A0B.Storage.Address;
   end record;

   function Is_Set (Self : Callback) return Boolean is
     (Self.Emitter /= null);

end A0B.Callbacks;
