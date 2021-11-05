
# Mozilla VPN - Android Build Image

Container image containing everything to build the [mozilla-vpn-client](https://github.com/mozilla-mobile/mozilla-vpn-client) for android. 

## Usage:

Use it as a one time-throwaway:

```
docker pull $IMAGE
CLIENTPATH = $(realpath path to MozillaVPN)
BINPATH = $(realpath path where you want the output)


docker run -it --rm -v $CLIENTPATH:/mnt/client -v $BINPATH:/mnt/android-build $IMAGE

```

Or name it if you want to keep it 

```
docker run -it --name mvpn_android_builder -v $CLIENTPATH:/mnt/client -v $BINPATH:/mnt/android-build $IMAGE
```
In that case you can just re-run the build with 

```
docker start -a mvpn_android_builder
```


## Use as a VSCode devcontainer

todo.