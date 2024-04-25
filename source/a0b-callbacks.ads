--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Simple callback object to call user defined subprogram with single user
--  defined argument.

pragma Restrictions (No_Elaboration_Code);

private with System;

package A0B.Callbacks
  with Pure
is

   type Callback is private
     with Preelaborable_Initialization;

   function Is_Set (Self : Callback) return Boolean;
   --  Callback subprogram/argument has been set.

   procedure Emit (Self : Callback) with Inline_Always;
   --  Call subprogram when it is set.

   procedure Unset (Self : in out Callback) with Inline_Always;
   --  Clean callback object.

private

   type Callback is record
      Emitter : access procedure (Closure : System.Address);
      Closure : System.Address;
   end record;

   function Is_Set (Self : Callback) return Boolean is
     (Self.Emitter /= null);

end A0B.Callbacks;