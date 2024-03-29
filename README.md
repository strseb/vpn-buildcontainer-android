﻿
# Mozilla VPN - Android Build Image

Container image containing everything to build the [mozilla-vpn-client](https://github.com/mozilla-mobile/mozilla-vpn-client) for android. 

## Usage:

Use it as a one time-throwaway:

```
docker pull ghcr.io/strseb/vpn-builder-android:main
CLIENTPATH = $(realpath path to MozillaVPN)
BINPATH = $(realpath path where you want the output)


docker run -it --rm -v $CLIENTPATH:/mnt/client -v $BINPATH:/mnt/android-build ghcr.io/strseb/vpn-builder-android:main

```

Or name it if you want to keep it 

```
docker run -it --name mvpn_android_builder -v $CLIENTPATH:/mnt/client -v $BINPATH:/mnt/android-build ghcr.io/strseb/vpn-builder-android:main
```
In that case you can just re-run the build with 

```
docker start -a mvpn_android_builder
```


## Use as a VSCode devcontainer

You can also setup vscode to open the project in the container for you to work in.
just drop a devcontainer.json in your vscode workspace:
```
// For format details, see https://aka.ms/devcontainer.json
{
	"name": "Android Dev Container",
	"image": "ghcr.io/strseb/vpn-builder-android:main",

	// Set *default* container specific settings.json values on container create.
	"settings": {},
	
	// Add the IDs of extensions you want installed when the container is created.
	"extensions": [
		//"fwcd.kotlin",
		//"redhat.java",
		//"ms-vscode.cpptools"
	],
	 "mounts": [ 
    // Change the path's here according to your workspace
		"source=${localWorkspaceFolder}/../client,target=/mnt/client,type=bind",
		"source=${localWorkspaceFolder}/../android_builds,target=/mnt/android-build,type=bind",
	],

	
}



```
