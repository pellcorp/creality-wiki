# Obico Agent

You must **not setup Obico Agent** on a K1 series machine (which includes Ender 3 V3 KE, NebulaPad and Ender 5 Max) because
it will overwhelm the processor and cause serious stability issues.

!!! note

    It's probably fine to setup Obico Agent on the same host as Simple AF if using Simple AF for RPi series.

Instead install the Obico Agent on another device on the same network as the printer.

It is definitely possible to setup the agent on a separate device on the same network as your K series printer, a guide will be made
available here soon, but it basically requires you installing docker on a RPI on the same network and doing some config
and running some commands.
