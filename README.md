To install Dropbear version 2019.78 on Ubuntu, you'll need to download and compile it from source since this specific version might not be available in the default package repositories. Here are the steps to do that:

# Install Dropbear SSH

## Option 1: Use Step by Step Installer
### 1. **Update Your Package List**:
   Open your terminal and update your package list to ensure you have the latest information on available packages.

   ```bash
   sudo apt update
   ```

### 2. **Install Dependencies**:
   Install the required dependencies for building Dropbear. These typically include build tools and libraries.

   ```bash
   sudo apt install build-essential zlib1g-dev python2
   ```

### 3. **Download Dropbear Source Code**:
   Navigate to the Dropbear releases page and download the source code for version 2019.78. You can use `wget` for this.

   ```bash
   wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2019.78.tar.bz2
   ```

### 4. **Extract the Tarball**:
   Extract the downloaded tarball.

   ```bash
   tar xvjf dropbear-2019.78.tar.bz2
   ```

### 5. **Navigate to the Source Directory**:
   Change to the directory where the source code was extracted.

   ```bash
   cd dropbear-2019.78
   ```

### 6. **Configure the Build**:
   Run the `configure` script to prepare the build environment.

   ```bash
   ./configure
   ```

### 7. **Compile the Source Code**:
   Compile the source code using `make`.

   ```
   make
   ```

### 8. **Install Dropbear**:
   Install the compiled binaries.

   ```
   sudo make install
   ```

### 9. **Configure Dropbear**:
   After installation, you may need to configure Dropbear. The configuration files are usually located in `/etc/dropbear`. Create the directory if it doesn't exist.

   ```
   sudo mkdir -p /etc/dropbear
   ```

   You can then generate host keys if needed:

   ```
   sudo dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key && sudo dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key
   ```

### 10. **Create a Systemd Service (Optional)**:
   
   To run Dropbear as a service, create a systemd service file.
   
   ```
   sudo nano /etc/systemd/system/dropbear.service
   ```


## Option 2: Use Bash script Installer

```
wget https://raw.githubusercontent.com/fadil05me/sshws/refs/heads/main/install_dropbear.sh
chmod +x install_dropbear.sh
./install_dropbear.sh
```



## Configure the Dropbear Service

```
sudo nano /etc/systemd/system/dropbear.service
```


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

### Save and close the file. Then, enable and start the Dropbear service:

```
sudo systemctl enable dropbear; sudo systemctl start dropbear;
```

### **Verify the Installation**:
Check if Dropbear is running.

```
sudo systemctl status dropbear
```


Now, the Dropbear is sucessfully installed!


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

Install docker

```
docker pull gegedesembri/badvpn;
```

docker compose file:
```
services:
  badvpn:
    image: gegedesembri/badvpn
    container_name: badvpn
    command: badvpn-udpgw
    ports:
      - "7300:7300"
    restart: always
```

start by:
```
docker compose up -d
```
