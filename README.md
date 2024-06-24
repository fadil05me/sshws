To install Dropbear version 2019.78 on Ubuntu, you'll need to download and compile it from source since this specific version might not be available in the default package repositories. Here are the steps to do that:

1. **Update Your Package List**:
   Open your terminal and update your package list to ensure you have the latest information on available packages.

   ```bash
   sudo apt update
   ```

2. **Install Dependencies**:
   Install the required dependencies for building Dropbear. These typically include build tools and libraries.

   ```bash
   sudo apt install build-essential zlib1g-dev python2
   ```

3. **Download Dropbear Source Code**:
   Navigate to the Dropbear releases page and download the source code for version 2019.78. You can use `wget` for this.

   ```bash
   wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2019.78.tar.bz2
   ```

4. **Extract the Tarball**:
   Extract the downloaded tarball.

   ```bash
   tar xvjf dropbear-2019.78.tar.bz2
   ```

5. **Navigate to the Source Directory**:
   Change to the directory where the source code was extracted.

   ```bash
   cd dropbear-2019.78
   ```

6. **Configure the Build**:
   Run the `configure` script to prepare the build environment.

   ```bash
   ./configure
   ```

7. **Compile the Source Code**:
   Compile the source code using `make`.

   ```bash
   make
   ```

8. **Install Dropbear**:
   Install the compiled binaries.

   ```bash
   sudo make install
   ```

9. **Configure Dropbear**:
   After installation, you may need to configure Dropbear. The configuration files are usually located in `/etc/dropbear`. Create the directory if it doesn't exist.

   ```bash
   sudo mkdir -p /etc/dropbear
   ```

   You can then generate host keys if needed:

   ```bash
   sudo dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key;
   sudo dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key;
   ```

10. **Create a Systemd Service (Optional)**:
    To run Dropbear as a service, create a systemd service file.

    ```bash
    sudo nano /etc/systemd/system/dropbear.service
    ```

      # 1 Line Install
```
      sudo apt update; sudo apt install -y build-essential zlib1g-dev python2; wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2019.78.tar.bz2; tar xvjf dropbear-2019.78.tar.bz2; cd dropbear-2019.78; ./configure; make; sudo make install; sudo mkdir -p /etc/dropbear; sudo dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key; sudo dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key; sudo nano /etc/systemd/system/dropbear.service;
```

/etc/systemd/system/dropbear.service
```
    [Unit]
    Description=Dropbear SSH server
    After=network.target

    [Service]
    ExecStart=/usr/local/sbin/dropbear -F -E -p 109
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
```

    Save and close the file. Then, enable and start the Dropbear service:

```
    sudo systemctl enable dropbear; sudo systemctl start dropbear;
```

11. **Verify the Installation**:
    Check if Dropbear is running.

    ```bash
    sudo systemctl status dropbear
    ```



# Install SSH WS

```
wget https://raw.githubusercontent.com/fadil05me/sshws/main/ws.py;
sudo mv ws.py /usr/local/bin/ws;
```


```
sudo nano /etc/systemd/system/ws.service;
```

```
[Unit]
Description=Python Proxy
Documentation=https://google.com
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python2 -O /usr/local/bin/ws 80
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl enable ws;
sudo systemctl start ws;
sudo systemctl status ws;
```


# INSTALL BADVPN UDPGW

```
sudo nano /bin/badvpn
```

Paste this:
```
#!/bin/bash

if [ "$1" == "uninstall" ]; then
    echo 'Uninstalling badvpn'
    rm /bin/badvpn && rm /bin/badvpn-udpgw
    echo 'Uninstall complete'
fi

if [ "$1" == "start" ]; then
    screen -dmS bad badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 1000 --client-socket-sndbuf 0 --udp-mtu 9000
    echo 'Badvpn initialized on port 7300'
fi

if [ "$1" == "stop" ]; then
    badvpnpid=$(ps x | grep badvpn | grep -v grep | awk '{print $1}')
    kill -9 "$badvpnpid" >/dev/null 2>/dev/null
    kill "$badvpnpid" >/dev/null 2>/dev/null
    killall badvpn-udpgw
fi

```

```
sudo chmod +x /bin/badvpn
```

```
sudo wget -O /bin/badvpn-udpgw https://raw.githubusercontent.com/powermx/badvpn/master/badvpn-udpgw;
sudo chmod +x /bin/badvpn-udpgw;
```
To start: ```badvpn start```

To stop: ```badvpn stop```

To uninstall: ```badvpn uninstall```
