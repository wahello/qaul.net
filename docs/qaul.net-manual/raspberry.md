# Build qaul.net for Raspberry Pi

qaul.net cannot be built on raspberry pi directly, as the
protobuf compiler does not run on ARM.
To build qaul.net for Raspberry Pi's ARM architecture, you
can cross-compile it on your development machine and transfer the
binaries to the raspberry pi.


## Prerequisites

Install prerequisites to cross-build qaul for raspberry pi.

```sh
# Install GCC linker for
apt install -y gcc-arm-linux-gnueabihf

# Install cross compiler via rustup
rustup target add armv7-unknown-linux-gnueabihf
```

In order for cargo to find the linker for the target,
one needs to set the configuration for cargo to find 
the gcc ARM linker library.

In this projects `rust` folder create a `.cargo` folder and in it the file `config` with the following content.

`rust/.cargo/config`

```
[target.armv7-unknown-linux-gnueabihf]
linker = "arm-linux-gnueabihf-gcc"
```


## Run Build

Start the build from terminal from within this project folder.

```sh
# build the debug binaries with cargo
cargo build --target=armv7-unknown-linux-gnueabihf

# build the release binaries with cargo
cargo build --release --target=armv7-unknown-linux-gnueabihf
```

The binaries can be found in the `target/armv7-unknown-linux-gnueabihf` folder.