# phillips_rear_vu

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# philips_project

Scan QR code for ssid, password and url.

# link to QR code generator:

- https://www.the-qrcode-generator.com/

# Sample text for json

{
"ssid": "Name of network",
"password": "Password of network",
"url": {"IP address url for camera}:81/stream"
}

{
"ssid": "ESP32_X",
"password": "Password of network",
"url": "http://192.168.4.1:81/stream"
}

# Link to Arduino setup tutorial
- https://randomnerdtutorials.com/esp32-cam-video-streaming-face-recognition-arduino-ide/

# Phone instructions
- Mobile data must be turned off or else camera won't show

# Change need for to Arduino SDK
- Locate sdkconfig file
- change HTTPD_MAX_REQ_HDR_LEN parameter from 512 to 2048