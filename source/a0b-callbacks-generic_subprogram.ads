--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Callback object constructor to dispatch call to the subprogram with single
--  in out parameter of the some type.

pragma Restrictions (No_Elaboration_Code);

generic
   type Object_Type (<>) is limited private;

   with procedure Subprogram (Self : in out Object_Type);

package A0B.Callbacks.Generic_Subprogram
  with Preelaborate
is

   function Create_Callback
     (Object : aliased in out Object_Type) return Callback;

end A0B.Callbacks.Generic_Subprogram;
