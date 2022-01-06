# Documentation

## Access
Server hosted on
```
http://$PI_IP:8090
```

## Configuration
 - Enable Internet API Access
 - Enable capture card source


## Hyperiond
Hyperion needs to run as root to have access to the PWM interface. Probably could find a more perm solution to this but for now:
```
sudo systemctl disable --now hyperion@pi
sudo systemctl enable --now hyperion@root
```

Got locked out once:
```
sudo systemctl stop hyperion
hyperiond -v --resetPassword
sudo systemctl restart hyperion
...
```
## LED Interface
Uses WS281x PWM inteface (one wire) on GPIO18.
