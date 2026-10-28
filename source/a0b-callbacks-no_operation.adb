--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Callbacks.No_Operation
  with SPARK_Mode => On
is

   procedure Emitter (Closure : A0B.Storage.Address)
     with Global  => null,
          Depends => (null => Closure);

   ------------
   -- Create --
   ------------

   function Create return Callback
   is
     (Emitter => Emitter'Access,
      Closure => <>);

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : A0B.Storage.Address) is null;

end A0B.Callbacks.No_Operation;
