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