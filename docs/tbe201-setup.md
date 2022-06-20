# EDB demo TrustBox Edge 201 firmware setup guide

This guide describes a process for setting up Scalys TrustBox Edge 201 (TBE 201) for running a demo for Enclave Device Blueprint for Confidential Computing.

# Device information

TrustBox Edge 201 is an edge device based on NXP Layerscape LS1028a CPU. It is tailored for the most secure workload. For more information please contact [Scalys](https://scalys.com).

# Firmware information

The provided firmware is a demonstrational Armbian-based system. For any real applications firmware should be based on the latest available firmware releases by Scalys.

Default credentials:
```
login: admin
password: trust
```

Default network configuration configures frontal panel ports as a bridged interface with static IP address 192.168.55.1/24. Internet availability for the exhibition demo is ensured by an LTE modem inserted into internal m.2 slot. It connects automatically if present.

# Demo composition

In an assembled case the demo consists of a:
- TrustBox Edge 201
- web camera Logitech C270
- a set of manufactured physical keys
- a PC for connecting to the running demo over network

# Demo flow

The minimal flow of the default image runs the ML demo inside of enclave only. Thus, insures that the confidential workload is possible to run on the device. For the steps related to Enclave Device Blueprint a dedicated Azure infrastructure is required with unique information (such as Azure function URLs etc.), thus it is expected to be performed on the second stages of the demo.

1. connect device to the test PC over network via any ethernet port available on TBE 201
1. plug in the USB web camera into TBE 201 by any available USB port
1. set up static IP on the side of PC: 192.168.55.2/24
1. power up the device

# Firmware update

1. download the http://trustbox.scalys.com/pub/openenclave/trustbox-201-armbian-2111-edb-2022.06.20.img]  binary image, unpack it and flash it to the SD card using "dd" utility in Linux:
```
$ sudo dd if=trustbox-201-armbian-2111-edb-2022.06.20.img of=/dev/sdX
```

where /dev/sdX is the actual SD card device. Or in Windows using tool like [Etcher](https://www.balena.io/etcher).


# Demo

For an explanation of a end-to-end Enclave Device Blueprint reference implementation see the [EDB demo guide](https://github.com/Scalys/edb-key-demo/blob/main/docs/edb-demo-guide.md)
