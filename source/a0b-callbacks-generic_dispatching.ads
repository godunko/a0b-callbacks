--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Callback object constructor to dispatch call to the dispatching subprogram
--  of the tagged type.

pragma Restrictions (No_Elaboration_Code);

generic
   type Object_Type (<>) is abstract tagged limited private;

   with procedure Subprogram (Self : in out Object_Type) is abstract;

package A0B.Callbacks.Generic_Dispatching
  with Preelaborate
is

   function Create_Callback
     (Object : aliased in out Object_Type'Class) return Callback;

end A0B.Callbacks.Generic_Dispatching;