# apple-push-notification-service-script
Apple Push Notification Service Script for sending push notifications to APNs with a simple script &amp; JSON payload.

# Usage
Push notifications can be tricky to test. Using this simple script you can easily send push notifications to Apple devices with a simple command like:
```bash 
$ ./push.sh send
```

# Requirements
This uses ***<a href="https://stedolan.github.io/jq/">jq</a>***, which is usually already installed on Mac's and *nix flavors. If not you can easily install it from <a href="https://stedolan.github.io/jq/download/">jq's github website</a>.

For Mac's, you can use homebrew. Other options are included on jq's webiste as well.
```bash
$ brew install jq
```

# Installation
Clone this repo and navigate to it. 

# Creating a pem certificate
If you have a *.p12 certificate and need to extract a *.pem file out of it you can do so with:
```bash
$ openssl pkcs12 -in /path/to/your/certificate.p12 -out /path/to/save/certificate.pem -nodes
```

# Configuration
Simply update the `config.json` with your configurations like the path to your `certificate.pem`, path to your private key file (`aps_development.cer`), the name of your app (E.g. `com.guillermorobles.pushnotificationsapp`) and the device token of the device you would like to push the notification to (you'll have to get this from the device). Next update the `payload.json` file with push notification that you will send to Apple's servers. 

# Make sure the shell script is executable
Make the script executable with:
```bash 
$ chmod u+x ./push.sh
```

# Verifying your certificates are valid
Before sending a push notification you'll want to verify to see that your certificates are valid. A script is included to easily test this out:
```bash 
$ ./push.sh verify
```
# Sending a push notification
Once you confirm your certificates are valid you can begin sending push notifications! Update the `payload.json` to your hearts content with whatever you would like to send in the push notification and run:
```bash 
$ ./push.sh send
```

# Using arguments
All the config settings including the `config.json` file itself can be passed in as arguments to the script like so:
```bash 
$ ./push.sh send --DEVICE_TOKEN=mysuperlongdevicetoken123123123
```

# Notes
This script takes into account <a href="https://developer.apple.com/documentation/usernotifications/sending_push_notifications_using_command-line_tools">Apple's documentation</a> on how to send push notifications using the terminal.