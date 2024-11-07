--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Callback object constructor to call subprogram with a discrete argument.

pragma Restrictions (No_Elaboration_Code);

with System.Storage_Elements;

generic
   type Discrete_Type is (<>);

   with procedure Subprogram (Value : Discrete_Type);

package A0B.Callbacks.Generic_Discrete
  with Preelaborate
is

   function Create_Callback (Value : Discrete_Type) return Callback;

private

   pragma Compile_Time_Error
     (Discrete_Type'Pos (Discrete_Type'First) not in
        System.Storage_Elements.Integer_Address'Range
      or
      Discrete_Type'Pos (Discrete_Type'Last) not in
        System.Storage_Elements.Integer_Address'Range,
      "Discrete_Type is out of supported range");

end A0B.Callbacks.Generic_Discrete;
