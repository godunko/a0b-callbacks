# A0B Callbacks

This crate provides capability to call user defined callback subprograms with optional user defined data in typesafe manner. This crate doesn't use any tasking consturcts and compatible with the `light` runtimes.

Caller uses `A0B.Callbacks` package to store callback subprogram and user defined data.

Callee instantiates one of the generic childlen packages to define type of the user data, and to create `Callback` object to pass to caller. Here is list of generic children packages:
 * `A0B.Callbacks.Generic_Parameterless` parameterless procedure;
 * `A0B.Callbacks.Generic_Subprogram` procedure with the parameter of the unconstrained limited type;
 * `A0B.Callbacks.Generic_Non_Dispatching` non dispatching procedure with the parameter of the classwide type;
 * `A0B.Callbacks.Generic_Dispatching` dispatching procedure with the parameter of the unconstrained abstract tagged type.

## Examples

### Device Driver

Lets use `A0B.Callabacks` to call application defined callback when interrupt driven device driver receives data and it can be processed by the application.

Here is snippet of the device driver's code:

```ada
with A0B.Callbacks;

package Device_Driver is

   procedure Set_On_Data_Received (Callback : A0B.Callbacks.Callback);
   --  Callback to be called when data has been received.

end Device_Driver;
```

```ada
package body Device_Driver is

   On_Data_Received : A0B.Callbacks.Callback;

   procedure Interrupt_Handler with Export, Convention => C, Linker_Name => "DeviceHandler";

   -----------------------
   -- Interrupt_Handler --
   -----------------------

   procedure Interrupt_Handler is
   begin
      ...
         A0B.Callbacks.Emit (On_Data_Received);
      ...
   end Interrupt_Handler;

   --------------------------
   -- Set_On_Data_Received --
   --------------------------

   procedure Set_On_Data_Received (Callback : A0B.Callbacks.Callback) is
   begin
      On_Data_Received := Callback;
   end Set_On_Data_Received;

end Device_Driver;
```

An example application uses parameterless procedure as callback subprogram:

```ada
with A0B.Callbacks.Generic_Parameterless;

package body Application is

   procedure On_Data_Received;

   package On_Data_Received_Callbacks is
     new A0B.Callbacks.Generic_Parameterless (On_Data_Received);

   ----------------------
   -- On_Data_Received --
   ----------------------

   procedure On_Data_Received is
   begin
      --  Process received data.
   end On_Data_Received;

begin
   Device_Driver.Set_On_Data_Received (On_Data_Received_Callbacks.Create_Callback);
   --  Register callback subprogram.
end Application;
```

### Task wakeup

Another example is available in `B2F4A` library, it allows to wakeup Ada task on callback.
See [bbf-await.ads](https://github.com/godunko/b2f4a/blob/master/source/bbf-awaits.ads) 
and [bbf-awaits.adb](https://github.com/godunko/b2f4a/blob/master/source/bbf-awaits.adb) files.
