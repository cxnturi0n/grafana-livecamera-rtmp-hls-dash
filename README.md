## Introduction

This repository contains a simple Grafana dashboard that displays live camera feed using either the HLS (HTTP Live Streaming) or DASH (Dynamic Adaptive Streaming over HTTP) streaming protocols. The dashboard is embedded within the Grafana image provided. As not all browsers support the visualization of DASH and HLS streams natively, it was necessary to embed an HTML5 video player in the HTML panel of the dashboard. For that, the Video.js library was utilized so that the live camera feed could be played across different browsers and platforms without requiring the users to use specific extensions. 

**Demo:** Grafana dashboard showing my home ip camera live feed.

https://github.com/cxnturi0n/grafana-live-camera-feed/assets/75443422/2537b6b2-f327-4068-aa6f-98b4b4d8023c

## Setting up video streaming server

If you do not already have an HLS or DASH server, you can create one using NGINX along with the NGINX RTMP module. 

![diagram](https://github.com/cxnturi0n/grafana-live-camera-feed/assets/75443422/6a7814b4-4f82-4df0-a7ef-80269b66efba)

Follow these steps:

1. **Install NGINX with RTMP Module and enable HLS and DASH:**
   - If you are on Ubuntu, instructions can be found in this tutorial (only steps 1 and 5 are strictly required): [How to Set Up a Video Streaming Server using NGINX RTMP on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-video-streaming-server-using-nginx-rtmp-on-ubuntu-20-04).

2. **Start Live Streaming:**
   - If you have an IP camera streaming over RTSP, you can use the following command to forward the stream to the RTMP server:
     ```bash
     ffmpeg -i "<rtsp-url>" -filter:v fps=fps=30 -crf 40 -preset ultrafast -vcodec libx264 -f flv "rtmp://localhost/live/stream"
     ```     
   - If you don't have an IP camera but want to try the dashboard with a camera, you can initiate live streaming, assuming the camera is connected to /dev/video0, using this command:
     ```bash
      ffmpeg -f v4l2 -i "/dev/video0" -c:v libx264 -pix_fmt yuv420p -preset ultrafast -tune zerolatency -framerate 15 -g 30 -b:v 300k -f flv "rtmp://localhost/live/stream"
     ```
     Adjust the commands according to your specific camera input and RTMP server configuration. 

## Setting up dashboard

To get started with the live camera feed dashboard, follow these steps:

1. **Modify the Server IP Address:**
   - You can customize the IP address of your http video streaming server by editing the `dashboards/dashboard.json` file, and substituting the 'content' tag with the content of 'dash.html' or 'hls.html' updating the IP address to match your server configuration. The ip can also be          changed directly from the dashboard panel.

2. **Running the Dashboard:**
   - Use the provided `build_and_run.sh` script to build the Grafana container with the embedded live camera feed dashboard and run it seamlessly. You can then open your web browser and access the dashboard by following this link: http://localhost:3000/dashboards.
	       

## Considerations

Please note that the live camera feed provided has at least 10 seconds latency due to HLS and DASH constraints. If you require a real-time, low-latency stream, it is recommended using other protocols like WebRTC (Web Real-Time Communication).
