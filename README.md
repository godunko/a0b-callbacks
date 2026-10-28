# [A0B](https://github.com/godunko/a0b) Callbacks

This crate provides type-safe callbacks with optional user-defined data.
It does not use tasking constructs and is compatible with the `light` runtimes.

The code that invokes a callback uses `A0B.Callbacks.Callback` to store the callback procedure and its associated data.

The code that registers a callback instantiates one of the following generic child packages and uses its `Create_Callback` function to construct the callback object:

 * `A0B.Callbacks.Generic_Parameterless`: a parameterless procedure;
 * `A0B.Callbacks.Generic_Subprogram`: a procedure with an `in out` object parameter;
 * `A0B.Callbacks.Generic_Object_Aliased`: a procedure with an `aliased in out` object parameter;
 * `A0B.Callbacks.Generic_Non_Dispatching`: a non-dispatching procedure with an `in out` class-wide parameter;
 * `A0B.Callbacks.Generic_Dispatching`: a dispatching procedure with an `in out` tagged parameter;
 * `A0B.Callbacks.Generic_Discrete`: a procedure with an `in` parameter of a discrete type.

## No-operation and Empty callbacks

`A0B.Callbacks.No_Operation` creates a callback for which `Is_Set` returns `True`, but whose handler does nothing.
This is useful when a callback must be considered registered even though no action is required.

`A0B.Callbacks.Empty` creates an "empty" callback for which `Is_Set` returns `False`.

A default-initialized callback also does nothing when emitted, while `Is_Set` returns `False` for it.

## Examples

### Device Driver

Let's use `A0B.Callbacks` to invoke an application-defined callback when an interrupt-driven device driver receives data that the application can process.

Here is a snippet of the device driver's code:

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

An example application uses a parameterless procedure as the callback:

```ada
with A0B.Callbacks.Generic_Parameterless;
with Device_Driver;

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
      null;
   end On_Data_Received;

begin
   Device_Driver.Set_On_Data_Received (On_Data_Received_Callbacks.Create_Callback);
   --  Register callback subprogram.
end Application;
```

### Task wakeup

Another example is available in the `B2F4A` library, which uses callbacks to wake up an Ada task.
See the [bbf-awaits.ads](https://github.com/godunko/b2f4a/blob/master/source/bbf-awaits.ads)
and [bbf-awaits.adb](https://github.com/godunko/b2f4a/blob/master/source/bbf-awaits.adb) files.
