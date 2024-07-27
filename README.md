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

## Design

MEFormatReader (LibAVFOrmatReader)
* [x] Plugin instantiation via `LibAVFormatReaderFactory`
* [x] Register a limited number of supported container formats via plist / exported content types
    * [x] MKV
    * Adding new Containers requires editing multiple annoying Plist entries
* [x] Basic Container parsing via libavformat (`LibAVFormatReader`)
* [ ] Container metadata to AVMetadataItems
* [x] Track Parsing (Audio and Video only right now) (`LibAVTrackReader`)
* [ ] Track specific metadata to AVMEtadataItems
* [x] CMFormatDescriptions for our Tracks
* [x] Seek / Stepping via `LibAVSampleCursor`
* [ ] Provide additional sample metadata that some formats require
    * [ ] Sample Sync info
    * [ ] Sample Dependency info
    * [ ] Post Decode Processing Data 

## Todo:

* [x] libavformat / libavcodec, libavutil compiled as a .a
* [x] ffmpeg headers inlcuded
* [x] Swift Modulemap + Obj-C libav*
* [ ] Implement necessary Media Extension protocols
    * [x] MEFormatReaderExtension
    * [x] MEFormatReader (partial)
    * [x] METrackReader
    * [x] METrackInfo
    * [x] MESampleCursor (partial)
    * [ ] MEVideoDecoderExtension
    * [ ] MEVideoDecoder
    * [ ] MEVideoDecoderPixelBufferManager
* [x] impelment Extension requirements (plists, entitlements, etc)
* [ ] Memory Management pass in ObjC / C 

## Strategy

We Eventually require 2 Bundle targets that are Media Extensions.

* A Media Extention that implements `MEFormatReader`, which will allow container parsing via `libavformat` and provide container metadata, track metadata, and compressed sample metadata. 

* A Media Extension that impelments `MEVideoDecoder` - a Video Decompressor which will allow for codec decompression via `libavcodec` and provide pixel buffers from appropriate samples. 


FFMPEGs library more or less follows similar design patterns to AVFoundation. The following isnt totally accurate, but more or less gets the point across:

* `CMTime` <~> `AVRational` 
* `CMMediaType` <~> `AVMediaType`
* `CMFormatDescription` <~> `AVCodecParameters`
* `CMSampleBuffer` <~> `AVPacket`
* `CMBlockBuffer` <~> `AVBuffer`
* `CVPixelBuffer` <-> `AVFrame` (decoded video)

* `AVAsset` <~> `AVFormatContext`
* `AVAssetTrack` <~> `AVStream`
* `AVSampleCursor` <~> `AVIOContext` 




Leverage AVIOContext to allow a MEByteSource to driven by a AVFormatContext to get us container parsing and metadata

## Running Notes:

* Weirdly MediaExtension headers imply macOS 14 supported?
* entitlements for Media Extensions
