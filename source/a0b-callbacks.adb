--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Callbacks is

   ----------
   -- Emit --
   ----------

   procedure Emit (Self : Callback) is
   begin
      if Self.Emitter /= null then
         Self.Emitter (Self.Closure);
      end if;
   end Emit;

end A0B.Callbacks;
