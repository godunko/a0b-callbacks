--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package body A0B.Callbacks.Generic_Discrete
  with SPARK_Mode => On
is

   function Decode
     (Closure : A0B.Storage.Address) return Discrete_Type
     with Global => null,
          Pre    =>
            A0B.Storage.As_Integer (Closure) in
              System.Storage_Elements.Integer_Address
                (Discrete_Type'Pos (Discrete_Type'First))
              .. System.Storage_Elements.Integer_Address
                (Discrete_Type'Pos (Discrete_Type'Last)),
          Post   =>
            System.Storage_Elements."="
              (System.Storage_Elements.Integer_Address
                 (Discrete_Type'Pos (Decode'Result)),
               A0B.Storage.As_Integer (Closure));

   function Encode
     (Value : Discrete_Type) return A0B.Storage.Address
     with Global => null,
          Post   =>
            System.Storage_Elements."="
              (A0B.Storage.As_Integer (Encode'Result),
               System.Storage_Elements.Integer_Address
                 (Discrete_Type'Pos (Value)))
              and then A0B.Storage.As_Integer (Encode'Result) in
                System.Storage_Elements.Integer_Address
                  (Discrete_Type'Pos (Discrete_Type'First))
                .. System.Storage_Elements.Integer_Address
                  (Discrete_Type'Pos (Discrete_Type'Last))
              and then Decode (Encode'Result) = Value;

   procedure Emitter (Closure : A0B.Storage.Address)
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
     (Closure : A0B.Storage.Address) return Discrete_Type
   is (Discrete_Type'Val (A0B.Storage.As_Integer (Closure)));

   -------------
   -- Emitter --
   -------------

   procedure Emitter (Closure : A0B.Storage.Address)
     with SPARK_Mode => Off
   is
   begin
      Subprogram (Decode (Closure));
   end Emitter;

   ------------
   -- Encode --
   ------------

   function Encode
     (Value : Discrete_Type) return A0B.Storage.Address
   is
     (A0B.Storage.As_Address
        (System.Storage_Elements.To_Address (Discrete_Type'Pos (Value))));

end A0B.Callbacks.Generic_Discrete;
