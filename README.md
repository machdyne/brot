# Brot FPGA Board

Brot is an FPGA development board designed to be plugged into a solderless breadboard.

![Brot FPGA Board](https://github.com/machdyne/brot/blob/d107d33e1bf2bb14a4ca1030c8687df5ce17a049/brot.png)

This repo contains schematics, pinouts and example gateware.

Find more information on the [Brot product page](https://machdyne.com/product/brot-fpga-board/).

## Programming

There are three ways to program Brot:

1. Using a USB or UART bootloader programmed to the MMOD flash module. (see below)
2. Remove the MMOD flash module, connect the Brot MMOD socket to a device supported by [ldprog](https://github.com/machdyne/ldprog) and program the configuration SRAM. This is useful for development. 
3. Remove the MMOD flash module and program it with a GPIO or SPI-capable device. This is useful when you want the gateware to persist without power.

See the blinky example below for specific instructions.

## Bootloader

It should be possible to use a USB or UART bootloader in order to update the gateware. Additional details and instructions will be added here as soon as there is an officially supported bootloader available for Brot.

## Blinky 

Building the blinky example requires [Yosys](https://github.com/YosysHQ/yosys), [nextpnr-ice40](https://github.com/YosysHQ/nextpnr) and [IceStorm](https://github.com/YosysHQ/icestorm).

Assuming they are installed, you can simply type `make` to build the gateware, which will be written to output/blinky.bin. You can then use [ldprog](https://github.com/machdyne/ldprog) to write the gateware to the device.

### Writing blinky to SRAM

Connect the MMOD socket to the appropriate pins of an ldprog-supported device.

You will need to use the manual reset option (-m) with ldprog and press the Brot reset button when prompted to do so. Alternatively, you can solder a 2-pin header to the unpopulated header to automate this step.

```
$ ldprog -m -s output/blinky.bin
```

### Writing blinky to the flash MMOD

It should be possible to connect and program the [MMOD](https://github.com/machdyne/mmod) using any device capable of GPIO. If using a [Müsli](https://github.com/machdyne/musli) or Raspberry Pi [Pico] you can use the ldprog tool:

```
$ ldprog -f output/blinky.bin
```

If using a [Werkzeug](https://machdyne.com/product/werkzeug-multi-tool) with the Müsli firmware you can plug the MMOD (oriented so that you can read the text) into the top of the Werkzeug PMOD socket and:

```
$ ldprog -wf output/blinky.bin
```

## GPIO Header

| Pin | Signal |
| --- | ------ |
| 1 | GPIO0 |
| 2 | GPIO1 |
| 3 | GPIO2 |
| 4 | GPIO3 |
| 5 | GPIO4 |
| 6 | GPIO5 |
| 7 | GPIO6 |
| 8 | GPIO7 |
| 9 | GND |
| 10 | PWR3V3 (out) |

## MMOD Socket

The MMOD socket can be used to program the FPGA SRAM or can be populated with
an MMOD containing a bitstream.

| Pin | Signal |
| --- | ------ |
| 6 | PWR3V3 |
| 5 | GND |
| 4 | CSPI\_SCK |
| 3 | CSPI\_SI (MISO) |
| 2 | CSPI\_SO (MOSI) |
| 1 | CSPI\_SS |
