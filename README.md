# apple-push-notification-service-script
Apple Push Notification Service Script for sending push notifications to APNs with a simple script &amp; JSON payload.

Push notifications can be tricky to test. Using this simple script you can easily send push notifications to Apple devices with a simple command like:
```bash 
$ ./push.sh send 
```

First, clone this repo and navigate to it.

Simply update the `config.json` with your configurations like the path the your `certificate.pem`, path to your private key file (`aps_development.cer`), the name of your app and the device token of the device you would like to push the notification to. Next update the `payload.json` file with the push notification that you will send to Apple's servers. 

Before sending a push notification you'll want to verify to see that your certificates are valid. A script is included to easily test this out:
```bash 
$ ./push.sh verify 
```

Once you confirm your certificates are valid you can begin sending push notifications! Update the `payload.json` to your hearts content with whatever you would like to send in the push notification and run:
```bash 
$ ./push.sh send 
```

All the config settings including the `config.json` file itself can be passed in as arguments to the script. Example:
```bash 
$ ./push.sh send --DEVICE_TOKEN=mysuperlongdevicetoken123123123
```

If the script is not executing then you may have to make it executable. Do that with the following:
```bash 
$ chmod u+x ./push.sh
```

This uses ***<a href="https://stedolan.github.io/jq/">jq</a>***, which is usually already installed on Mac's and *nix flavors. If not you can easily install it from <a href="https://stedolan.github.io/jq/download/">jq's github website</a>.

This script takes into account <a href="https://developer.apple.com/documentation/usernotifications/sending_push_notifications_using_command-line_tools">Apple's documentation</a> on how to send push notifications using the terminal.