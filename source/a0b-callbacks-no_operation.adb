--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Callbacks.No_Operation
  with SPARK_Mode => On
is

   procedure Emitter
     (Closure : System.Storage_Elements.Integer_Address)
     with Global  => null,
          Depends => (null => Closure);

   ---------------------
   -- Create_Callback --
   ---------------------

   function Create_Callback return Callback
   is
     (Emitter => Emitter'Access,
      Closure => Null_Address);

   -------------
   -- Emitter --
   -------------

   procedure Emitter
     (Closure : System.Storage_Elements.Integer_Address) is null;

end A0B.Callbacks.No_Operation;
