--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Callback object constructor to call subprogram with a discrete argument.

pragma Restrictions (No_Elaboration_Code);

private with System.Storage_Elements;

generic
   type Discrete_Type is (<>);

   with procedure Subprogram (Value : Discrete_Type);

package A0B.Callbacks.Generic_Discrete
  with Preelaborate, SPARK_Mode => On
is

   function Create (Value : Discrete_Type) return Callback
     with SPARK_Mode => Off;
   --  The erased emitter invokes an actual subprogram with unrestricted
   --  effects; its stored closure is not proved to satisfy Decode's contract.

   function Create_Callback (Value : Discrete_Type) return Callback
     renames Create with Obsolescent;

private

   pragma Compile_Time_Error
     (Discrete_Type'Pos (Discrete_Type'First) not in
        System.Storage_Elements.Integer_Address'Range
      or
      Discrete_Type'Pos (Discrete_Type'Last) not in
        System.Storage_Elements.Integer_Address'Range,
      "Discrete_Type is out of supported range");

end A0B.Callbacks.Generic_Discrete;
