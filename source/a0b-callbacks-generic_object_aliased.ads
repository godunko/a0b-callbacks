--
--  Copyright (C) 2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Callback object constructor to dispatch call to the subprogram with single
--  aliased in out parameter of the some type.

pragma Restrictions (No_Elaboration_Code);

generic
   type Object_Type (<>) is limited private;

   with procedure Subprogram (Self : aliased in out Object_Type);

package A0B.Callbacks.Generic_Object_Aliased
  with Preelaborate
is

   function Create_Callback
     (Object : aliased in out Object_Type) return Callback;

end A0B.Callbacks.Generic_Object_Aliased;
