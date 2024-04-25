--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Callback object constructor call parameter-less procedure.

pragma Restrictions (No_Elaboration_Code);

generic
   with procedure Subprogram;

package A0B.Callbacks.Generic_Parameterless
  with Preelaborate
is

   function Create_Callback return Callback;

end A0B.Callbacks.Generic_Parameterless;