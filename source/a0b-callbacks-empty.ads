--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Creates an "empty" callback - nothing to be called, object has default
--  state.

pragma Restrictions (No_Elaboration_Code);

package A0B.Callbacks.Empty
  with Pure
is

   function Create_Callback return Callback;

private

   function Create_Callback return Callback is (others => <>);

end A0B.Callbacks.Empty;
