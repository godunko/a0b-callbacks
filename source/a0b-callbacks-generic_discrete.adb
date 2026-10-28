--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package body A0B.Callbacks.Generic_Discrete
  with SPARK_Mode => On
is

   function Decode
     (Closure : System.Storage_Elements.Integer_Address) return Discrete_Type
     with Global => null,
          Pre    =>
            Closure in
              System.Storage_Elements.Integer_Address
                (Discrete_Type'Pos (Discrete_Type'First))
              .. System.Storage_Elements.Integer_Address
                (Discrete_Type'Pos (Discrete_Type'Last)),
          Post   =>
            System.Storage_Elements."="
              (System.Storage_Elements.Integer_Address
                 (Discrete_Type'Pos (Decode'Result)), Closure);

   function Encode
     (Value : Discrete_Type) return System.Storage_Elements.Integer_Address
     with Global => null,
          Post   =>
            System.Storage_Elements."="
              (Encode'Result,
               System.Storage_Elements.Integer_Address
                 (Discrete_Type'Pos (Value)))
              and then Encode'Result in
                System.Storage_Elements.Integer_Address
                  (Discrete_Type'Pos (Discrete_Type'First))
                .. System.Storage_Elements.Integer_Address
                  (Discrete_Type'Pos (Discrete_Type'Last))
              and then Decode (Encode'Result) = Value;

   procedure Emitter (Closure : System.Storage_Elements.Integer_Address)
     with SPARK_Mode => Off;

   ------------
   -- Create --
   ------------

   function Create (Value : Discrete_Type) return Callback is
     (Emitter => Emitter'Access,
      Closure => Encode (Value))
     with SPARK_Mode => Off;

   ------------
   -- Decode --
   ------------

   function Decode
     (Closure : System.Storage_Elements.Integer_Address) return Discrete_Type
   is (Discrete_Type'Val (Closure));

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : System.Storage_Elements.Integer_Address)
     with SPARK_Mode => Off
   is
   begin
      Subprogram (Decode (Closure));
   end Emitter;

   ------------
   -- Encode --
   ------------

   function Encode
     (Value : Discrete_Type) return System.Storage_Elements.Integer_Address
   is (Discrete_Type'Pos (Value));

end A0B.Callbacks.Generic_Discrete;
