# FFMPEGMediaExtension

This is an attempt to build a macOS 15.0 MediaExtension for libAV* which in theory would allow for native AVFOundation container parsing and decode.

Since MediaExtensions are shipped in a host app, this has a stupid Host app.

## Requirements:

* MacOS 15 Beta 4 + 
* XCode 16 Beta 4 + 

## Building:

If you want to build FFMPEG libAVFormat and libAVCodec:

`brew install automake nasm pkg-config`

FFMPEG is installed as a submodule - so ensure you git checkout the submodule and init

`cd ffmpeg`
```
./configure --prefix=/usr/local --enable-static --disable-shared --disable-programs --disable-doc --disable-avdevice --disable-avfilter --disable-postproc --disable-swscale --disable-swresample --arch=arm64 --disable-avfoundation
```

`make -j$(sysctl -n hw.ncpu)`

This will build you the statically linked libAVFormat.a and libAVCodec.a libries 

## Todo:

* [x] libavformat / libavcodec, libavutil compiled as a .a
* [x] ffmpeg headers inlcuded
* [ ] Swift Modulemap + Obj-C libav*
* [ ] Implement necessary Media Extension protocols
    * [x] MEFormatReaderExtension
    * [ ] MEFormatReader
    * [ ] METrackReader
    * [ ] METrackInfo
    * [ ] MESampleCursor
    * [ ] MEVideoDecoderExtension
    * [ ] MEVideoDecoder
    * [ ] MEVideoDecoderPixelBufferManager
* [ ] impelment Extension requirements (plists, entitlements, etc)


## Strategy

Leverage AVIOContext to allow a MEByteSource to driven by a AVFormatContext to get us container parsing and metadata

## Running Notes:

* Weirdly MediaExtension headers imply macOS 14 supported?
* entitlements for Media Extensions
