I finally bought myself a K1 board to setup as a dev board

Ironically my dev micro-usb was not on the board and I added a header but still I cannot connect to the printer, I tried a couple of different cables, so I think perhaps the board has been modified to not support being able to be rescued via the cloner.

# Serial

For my board, I was not able to power it via 5v only, due to the 5v usb port being defective or not enabled, not really sure which, I suspect I got my board a bit cheaper for a reason, this being the 5v interface was either broken or not implemented.

I got this serial adaptor: https://www.amazon.com.au/DSD-TECH-Converter-Compatible-Windows/dp/B072K3Z3TL

Anyway the serial interface does work, but I must power the board via 24v to use it

https://github.com/ballaswag/k1-discovery?tab=readme-ov-file#serial-pins

The pins are connected thus:

- Board TX -> Adaptor RX
- Board RX -> Adaptor TX
- Board Gnd -> Adaptor Gnd

I use this command to connect to my serial device:

```
gtkterm --port /dev/serial/by-id/usb-Silicon_Labs_CP2102N_USB_to_UART_Bridge_Controller_0001-if00-port0 --speed 115200
```

# Recovery

- https://github.com/CrealityOfficial/K1_Series_Annex/releases/tag/V1.0.0
- https://pay.reddit.com/r/crealityk1/comments/16shcls/tool_to_unbrick_k1_with_ota_swap/
- https://www.reddit.com/r/crealityk1/comments/16me5bl/recovering_a_bricked_k1_or_k1_max_motherboard_by/

The Ubuntu version is available:
https://github.com/Ingenic-community/Cloner/releases


# Pinouts

From https://github.com/Chinstrap777/Chinstrap-Creality-K1-Max-Repository?tab=readme-ov-file:
- https://docs.google.com/presentation/d/1f6kJbMq7uSggC33zmIfcTPdG6r50PbbDut14u9vAcZA/edit#slide=id.g2c17ef9f2a4_0_36

Also from Guilouz:
https://guilouz.github.io/Creality-Helper-Script-Wiki/others/boards-layout-k1/