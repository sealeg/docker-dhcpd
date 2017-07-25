# Docker image for ISC DHCP Server

## Usage

Run on all interfaces:
```
docker run -it --net <macvlan net> --name dhcpd0 sealeg/dhcpd
```

