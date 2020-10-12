# Raspberry Pi Wekinator Client

Monorepo containing server, wekinator executable and output script. Ongoing work…

![Image](./image.jpg)

## Installation Guide

### 1. Clone this repository to your raspberry pi

`git clone https://github.com/moritzsalla/raspi-wekinator-client`

### 2. Install Wekinator

Head to the `wekinator-executable` directory.

To run Wekinator (2.1.0.4) on Raspberry Pi, use a terminal to cd to the appropriate folder and run the command: `java -jar WekiMini.jar`.

Run `python main.py` to execute.

### 3. Run the python input script

The main script periodically fetches data from an API and sends them to the serial port via OSC. You will need to use pipenv, a python package manager, to install your dependencies.

To install pipenv run `brew install pipenv` for Mac. For other platforms, run `pip install --user pipenv`. Run `pipenv install` to install all packages, or crudely: `curl https://raw.githubusercontent.com/pypa/pipenv/master/get-pipenv.py | python`.

If pipenv can't be found, run `sudo pip install pipenv`.

### 4. Run the output script

Under construction…

## Controling Wekinator via OSC

http://www.wekinator.org/detailed-instructions/#Customizing_DTW8217s_behavior

## Cheatsheets

### Docker

https://phoenixnap.com/kb/docker-on-raspberry-pi

```
curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

sudo usermod -aG docker [user_name]
sudo usermod -aG docker Pi

# test
docker version
docker info
docker run hello-world

# check out port app is running at 
sudo docker ps
```

Build image:
```
docker build -t myimage .
```

Run image:
```
docker run -d --name myimage -p 80:80 myimage 

'''
asks Docker to forward traffic incoming on the host’s port 80 to the container’s port 80
https://docs.docker.com/get-started/part2/#run-your-image-as-a-container
'''
```

Stop & remove container:
```
docker rm --force myimage
```

To expose ports:
```
# single:
docker run -p <host_port>:<container_port>

# multiple:
docker run -p <host_port1>:<container_port1> -p <host_port2>:<container_port2>
```

### Git

Clone: `git clone url`  
Push: `git push origin master`  
Pull: `git fetch origin`  
Merge changes: `git merge origin/master`

Make commits case sensitive: `git config core.ignorecase false`

### Raspberry Pi

SSH into pi using mac terminal:

```
ssh pi@raspberrypi.local
```

Ping: 
```
ping raspberrypi.local
```

## To–Do

- [x] Set up docker on raspi
- [x] Create Server that receives POST requests
- [x] Setup simple output without Wekinator
- [x] Decide what to do with data. Save them in database? Periodically train wekinator?
- [ ] Figure out how to expose 6448 port in docker for OSC connection to wekinator