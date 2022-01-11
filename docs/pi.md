# Rasbian Lite Setup

1. Flash rasbian lite using the imager or whatever.

2. Enable ssh
```bash
# /Volumes/boot
touch ssh
```

3. Setup wifi
```bash
touch wpa_supplicant.conf
```

4. Setup wifi in firmware conf using wpa
```
country=US # replace with your country code
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
network={
    ssid="WIFI_NETWORK_NAME"
    psk="WIFI_PASSWORD"
    key_mgmt=WPA-PSK
}
```


## Troubleshooting
Here is the raspberrypi computer technical specification:
https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#typical-power-requirements

Main issue is with power. The Pi is constantly experiencing under-voltage errors and causing eratic behaviour. The undervoltage is caused by large current draw from both the capture card and the LED strip. This has been verified using `dmesg`

Based on the RPi4B technical specification the recommended PSU current capacity is 3.0A. This is the highest amperage rating of all other RPi generations. The amperage per LED is roughly modelled by:
```
Am = n * 0.06A
```
Where n is the number of LEDs in the strip. Therefore, the max amperage for 220 LEDs is 13.2A. Factoring in the 3.0A for the pi we get 16.2A which is significantly more than the 10A supply we purchased.


Therefore there are a few options that can be done to mitigate this problem:

- [ ] Add 1000uF bulk decoupling capacitor for the LED strip\
- [ ] Add logic level inverter for PWM signal (3.3 -> 5V)
- [ ] Increase the PSU specification and add voltage regulator for pi
- [ ] Add dual USB 3.0 driver cable to support external power requirements for the capture card
- [ ] Increase the PSU specification

### Power Consumption
You can check how much power is negotiated for the 4K capture card device (`1e4e:7103`) using `lsusb`:
```
pi@raspberrypi:~ $ lsusb -v|egrep "^Bus|MaxPower"
Couldn't open device, some information will be missing
Couldn't open device, some information will be missing
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
    MaxPower                0mA
Bus 001 Device 023: ID 1e4e:7103 Cubeternet 
    MaxPower              150mA
Couldn't open device, some information will be missing
Couldn't open device, some information will be missing
Bus 001 Device 002: ID 2109:3431 VIA Labs, Inc. Hub
    MaxPower              100mA
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    MaxPower                0mA
```

This is way below the 1.2A USB power budget for the RPi4 Model B. Therefore there is no power compatibility problem between the capture card and the RPi4.

### Capture Card UVC Driver
After some power cycles initiated by the RPi the device appears to be recognized:
```
[ 1242.891130] usb usb2-port1: attempt power cycle
[ 1247.330467] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[ 1251.670204] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[ 1251.670611] usb usb2-port1: unable to enumerate USB device
[ 1255.989989] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[ 1260.529701] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[ 1264.869483] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[ 1264.869891] usb usb2-port1: attempt power cycle
[ 1269.309203] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[ 1271.739284] usb 2-1: new SuperSpeed Gen 1 USB device number 52 using xhci_hcd
[ 1271.777322] usb 2-1: New USB device found, idVendor=1e4e, idProduct=7103, bcdDevice= 1.00
[ 1271.777343] usb 2-1: New USB device strings: Mfr=6, Product=7, SerialNumber=3
[ 1271.777361] usb 2-1: Product: UHA-UTCA
[ 1271.777379] usb 2-1: Manufacturer: UHA-UTCA
[ 1271.777396] usb 2-1: SerialNumber: 20000130041415
[ 1271.781874] usb 2-1: WARN: Max Exit Latency too large
[ 1271.781897] usb 2-1: Could not enable U2 link state, xHCI error -22.
[ 1271.783771] uvcvideo: Found UVC 1.00 device UHA-UTCA (1e4e:7103)
[ 1271.787861] uvcvideo: UVC non compliance - GET_DEF(PROBE) not supported. Enabling workaround.
[ 1273.758892] usb 2-1: USB disconnect, device number 52
[ 1274.109122] usb 2-1: new SuperSpeed Gen 1 USB device number 53 using xhci_hcd
[ 1274.147032] usb 2-1: New USB device found, idVendor=1e4e, idProduct=7103, bcdDevice= 1.00
[ 1274.147053] usb 2-1: New USB device strings: Mfr=6, Product=7, SerialNumber=3
[ 1274.147072] usb 2-1: Product: UHA-UTCA
[ 1274.147089] usb 2-1: Manufacturer: UHA-UTCA
[ 1274.147107] usb 2-1: SerialNumber: 20000130041415
[ 1274.149677] uvcvideo: Found UVC 1.00 device UHA-UTCA (1e4e:7103)
```