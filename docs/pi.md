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