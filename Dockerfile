# Specify the parent image from which we build
FROM ubuntu:20.04

# Set the working directory
WORKDIR /app

# Copy source code to image
COPY ctrlx-datalayer-mqtt-interface/ .

# Install required packages
RUN echo 'Installing requirements in image' &&\
    apt-get update &&\
    apt-get install -y libzmq5 \
    pip \
    mosquitto-clients \
    /app/ctrlx-datalayer-1.9.1.deb &&\
    pip3 install -r /app/requirements.txt &&\
    chmod +x /app/mosquitto_publish.sh &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm /app/ctrlx-datalayer-1.9.1.deb

LABEL description="ctrlX Datalayer MQTT Interface"
LABEL maintainer="S-Gilk <https://github.com/S-Gilk>"

# Run the application
CMD ["python3", "/app/main.py"]