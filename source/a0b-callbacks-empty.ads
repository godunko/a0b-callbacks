--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Creates an "empty" callback - nothing to be called, object has default
--  state.

pragma Restrictions (No_Elaboration_Code);

package A0B.Callbacks.Empty
  with Pure, SPARK_Mode => On
is

   function Create return Callback
     with Global  => null,
          Depends => (Create'Result => null),
          Post    => not Is_Set (Create'Result);

   function Create_Callback return Callback renames Create with Obsolescent;

private

   function Create return Callback is (others => <>);

end A0B.Callbacks.Empty;
