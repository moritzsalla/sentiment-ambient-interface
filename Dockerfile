FROM arm32v7/debian:jessie-slim AS base
LABEL maintainer="Moritz Salla <moritz.salla@hotmail.de>"

# install the necessary software
RUN apt-get update \
      && apt-get install --no-install-recommends --no-install-suggests -y \
      ca-certificates \
      curl \
      python3-numpy \
      python3-pil \
      python3-pip

# install sensehat dependency
WORKDIR /tmp
ARG RTIMULIB_VERSION=7.2.1-3
RUN curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-dev_${RTIMULIB_VERSION}_armhf.deb \
      && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-utils_${RTIMULIB_VERSION}_armhf.deb \
      && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib7_${RTIMULIB_VERSION}_armhf.deb \
      && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/python3-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
      && curl -LO https://archive.raspberrypi.org/debian/pool/main/p/python-sense-hat/python3-sense-hat_2.2.0-1_armhf.deb
RUN dpkg -i \
      librtimulib-dev_${RTIMULIB_VERSION}_armhf.deb \
      librtimulib-utils_${RTIMULIB_VERSION}_armhf.deb \
      librtimulib7_${RTIMULIB_VERSION}_armhf.deb \
      python3-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
      python3-sense-hat_2.2.0-1_armhf.deb

# cleanups
RUN rm -f /tmp/*.deb \
      && apt-get clean \ 
      && rm -rf /var/lib/apt/lists/*

# lock and install python requirements
COPY ./app /app
WORKDIR /app
RUN pip3 install sense-hat flask

# run server
EXPOSE 80
RUN FLASK_APP=main.py && export FLASK_ENV=production
CMD ["flask", "run"]