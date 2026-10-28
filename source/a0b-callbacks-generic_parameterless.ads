--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Callback object constructor call parameter-less procedure.

pragma Restrictions (No_Elaboration_Code);

generic
   with procedure Subprogram;

package A0B.Callbacks.Generic_Parameterless
  with Preelaborate, SPARK_Mode => Off
is

   --  Outside SPARK: constructing the callback takes access to an emitter
   --  whose actual handler may have arbitrary global effects.

   function Create return Callback;

   function Create_Callback return Callback renames Create with Obsolescent;

end A0B.Callbacks.Generic_Parameterless;
