--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Creates a "no operation" callback - nothing to be called, but object has
--  state.

pragma Restrictions (No_Elaboration_Code);

package A0B.Callbacks.No_Operation
  with Pure, SPARK_Mode => On
is

   function Create_Callback return Callback
     with Global  => null,
          Depends => (Create_Callback'Result => null),
          Post    => Is_Set (Create_Callback'Result);

end A0B.Callbacks.No_Operation;
