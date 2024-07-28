#  Plugin Debugging notes

1. On loading an AVURLAsset with a MKV File. Assuming you have the extension set up correctly:

```
default    22:53:19.235287-0400    LibAVExtensionHost    <<<< FigCustomURLHandling >>>> FigCustomURLLoaderCreate: newLoader: 0x600001a4ce40
default    22:53:19.235299-0400    LibAVExtensionHost    <<<< FigCustomURLHandling >>>> FigCustomURLHandlerCreate: newHandler: com.apple.avfoundation.customurl.cfurlconnection.0x600001040880 options: (null)
default    22:53:19.235306-0400    LibAVExtensionHost    <<<< FigCustomURLHandling >>>> curll_installHandler: 0x600001a4ce60: handler: 0x600001040880 priority: 100
default    22:53:19.235351-0400    LibAVExtensionHost    <<<< FigCustomURLHandling >>>> FigCustomURLHandlerCreate: newHandler: com.apple.avfoundation.authkeychain.0x600001049980 options: (null)
default    22:53:19.235359-0400    LibAVExtensionHost    <<<< FigCustomURLHandling >>>> curll_installHandler: 0x600001a4ce60: handler: 0x600001049980 priority: 800
default    22:53:19.282955-0400    LibAVExtensionHost    <<< URLAsset >>> EnsureContentStreamCreated: ByteStream [0x600001d40480] created for asset [0x600002b4fc40]
```

2. This seems to kick off the Byte Stream to a background process XPC after lots of other logs 

`default    22:53:19.403251-0400    LibAVExtension    <<<< FigExtensionFoundationUtilities >>>> FigEXCopyExtensionList_block_invoke: MediaExtension format readers and video decoders enabled -- thank you for setting "ffctl CoreMedia/MediaExtensions=on"`


3. This kicks off The Plugins registered factory

```
default    22:53:19.409588-0400    LibAVExtension    objcWrapperPluginFormatReader_CreateInstance called
default    22:53:19.409717-0400    LibAVExtension    Initiaizing LibAVFormatReader
```

4. This then kicks off file loading
`default    22:53:19.412853-0400    LibAVExtension    loadFileInfoWithCompletionHandler`

5. Which kicks off seeking in livavformats callbacks:

```
default    22:53:19.412916-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x12e022400
default    22:53:19.413273-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x138016400
default    22:53:19.413317-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x138016400
default    22:53:19.413853-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x138016400
default    22:53:19.413886-0400    LibAVExtension    LibAVFormatReader got readPacket 128580 0x1301a0ff6
default    22:53:19.426112-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x138016400
default    22:53:19.426352-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x138016400
default    22:53:19.426557-0400    LibAVExtension    LibAVFormatReader got readPacket 34306 0x1304b03f4
default    22:53:19.426672-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x138016400
default    22:53:19.426740-0400    LibAVExtension    LibAVFormatReader got readPacket 13298 0x12e83e1fc
default    22:53:19.426803-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x138016400
default    22:53:19.426875-0400    LibAVExtension    LibAVFormatReader got readPacket 4675 0x12e0225fd
```

6. This retuns the basic file info like duration

`default    22:53:19.427272-0400    LibAVExtension    loadFileInfoWithCompletionHandler got duration: {61275000/1000000 = 61.275}`

7. We then try to load metadata:

`default    22:53:19.427352-0400    LibAVExtension    loadMetadataWithCompletionHandler`

8. We then try to get track info:

```
default    22:53:19.427433-0400    LibAVExtension    loadTrackReadersWithCompletionHandler
default    22:53:19.427474-0400    LibAVExtension    Found Codec Type: 1635148593
default    22:53:19.427508-0400    LibAVExtension    Made Format Description: <CMVideoFormatDescription 0x12f006420 [0x1f6b26220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1280 x 720 
    } 
    extensions: {(null)}
}
```

9. This kicks off a slew of shit on the Host App side esp if the asset is associated with a Player

```
... 
default    22:53:19.798882-0400    LibAVExtensionHost    Set: origin-Mac-1280262988/client-info.vade.LibAVExtensionHost-79359/player-MediaRemote-DefaultPlayer setting ActivePlayerPath to <<MRPlayer: 0x600002be0e80> {
    audioSessionID = 0;
    audioSessionType = Default;
    displayName = "Default Player";
    identifier = "MediaRemote-DefaultPlayer";
}>
default    22:53:19.799164-0400    LibAVExtensionHost    Request: setNowPlayingPlayer<53B3F02A-D010-4CEA-AA77-33AEA218A416> for origin-Mac-1280262988/client-info.vade.LibAVExtensionHost-79359/player-MediaRemote-DefaultPlayer because New player origin-Mac-1280262988/client-info.vade.LibAVExtensionHost-79359/player-MediaRemote-DefaultPlayer was added

default    22:53:19.803118-0400    LibAVExtensionHost    MediaRemote server initializing
... 

``` 

10. Back in our plugin, we get our first Sample Cursor Request

`default    22:53:19.836405-0400    LibAVExtension    generateSampleCursorAtPresentationTimeStamp {0/1 = 0.000}`

This kicks off a ton of libavseeks thanks to our callbacks

```
default    22:53:19.836456-0400    LibAVExtension    Found Codec Type: 1635148593
default    22:53:19.836515-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x138016400
default    22:53:19.836549-0400    LibAVExtension    LibAVFormatReader got readPacket 128584 0x130008ff2
default    22:53:19.836760-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x138016400
```

11. We then get a call to sampleLocationReturningError - I include some contect here 

```
default    22:53:19.849246-0400    LibAVExtension    Recieved Invalid timestamp AV_NOPTS_VALUE - returning kCMTimeInvalid
default    22:53:19.849270-0400    LibAVExtension    Converted {0/1000 = 0.000}
default    22:53:19.849287-0400    LibAVExtension    Converted {33/1000 = 0.033}
default    22:53:19.849304-0400    LibAVExtension    Decode Timestamp {0/1000 = 0.000}
default    22:53:19.849319-0400    LibAVExtension    Presentation Timestamp {0/1000 = 0.000}
default    22:53:19.849335-0400    LibAVExtension    Duration {33/1000 = 0.033}
default    22:53:19.849350-0400    LibAVExtension    sampleLocationReturningError

```

For some reason, we get

`error    22:53:19.849380-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) (invalid sample duration.) at FigPartialSampleTable.c:1099
`

The above kicks off some async loading in the Host:

```
default    22:53:19.854511-0400    LibAVExtensionHost    Pixel format registry initialized. Constant classes enabled.
default    22:53:19.865166-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_establishStereoAudioSpatializationPreferenceForAsset: <0x142858e00|I/ABF.01>: Stereo Spatialization allowed by default due to asset containing video.
default    22:53:19.865827-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> itemairplay_assetPropertyFailedToLoad: [0x14161ace0, 0x141621950] P/OM I/ABF.01 assetNotice_PropertyFailedToLoad notification for item 0x141621950 by asset 0x600002b4fc40 payload {
    "assetPayload_Property" = trackPropertyForMediaSelectionOptions;
    "assetPayload_Result" = "-16505";
}
default    22:53:19.865869-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> itemairplay_assetPropertyFailedToLoad: [0x14161ace0, 0x141621950] P/OM I/ABF.01 assetNotice_PropertyFailedToLoad notification for item 0x141621950 by asset 0x600002b4fc40 payload {
    "assetPayload_Property" = availableMediaCharacteristicsWithMediaSelectionOptions;
    "assetPayload_Result" = "-16505";
}
default    22:53:19.865890-0400    LibAVExtensionHost    <<<< AVAssetInspectorLoader >>>> handleFigAssetLoadingNotification: Received kFigAssetNotification_BatchPropertyLoadComplete (payload: {
    "assetPayload_BatchID" = 1;
})
default    22:53:19.865916-0400    LibAVExtensionHost    <<<< AVAssetInspectorLoader >>>> -[AVFigAssetInspectorLoader _invokeCompletionHandlerForLoadingBatches:]: No completed batches
default    22:53:19.865947-0400    LibAVExtensionHost    <<<< AVAssetInspectorLoader >>>> handleFigAssetLoadingNotification: Received kFigAssetNotification_BatchPropertyLoadComplete (payload: {
    "assetPayload_BatchID" = 2;
})
default    22:53:19.865959-0400    LibAVExtensionHost    <<<< AVAssetInspectorLoader >>>> -[AVFigAssetInspectorLoader _invokeCompletionHandlerForLoadingBatches:]: No completed batches
default    22:53:19.866048-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_assetPropertyBatchLoaded: [0x141622000] P/OM current item 0x142858e00 I/ABF.01 became ready for inspection for the first time
default    22:53:19.866071-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_assetPropertyBatchLoaded: Prepare item <0x142858e00|I/ABF.01> on dispatch queue
```
12. We then get another request for generateSampleCursorAtPresentationTimeStamp {0/1 = 0.000} where we return the sampleLocation

```
default    22:53:19.866391-0400    LibAVExtension    generateSampleCursorAtPresentationTimeStamp {0/1 = 0.000}
default    22:53:19.866436-0400    LibAVExtension    Found Codec Type: 1635148593
default    22:53:19.866492-0400    LibAVExtension    Found Codec Type: 1635148593
default    22:53:19.866513-0400    LibAVExtension    Found Codec Type: 1635148593
default    22:53:19.866530-0400    LibAVExtension    LibAVFormatReader got readPacket 4096 0x138016400
default    22:53:19.866554-0400    LibAVExtension    LibAVFormatReader got readPacket 128584 0x130050ff2
default    22:53:19.866849-0400    LibAVExtension    Recieved Invalid timestamp AV_NOPTS_VALUE - returning kCMTimeInvalid
default    22:53:19.866877-0400    LibAVExtension    Converted {0/1000 = 0.000}
default    22:53:19.866897-0400    LibAVExtension    Converted {33/1000 = 0.033}
default    22:53:19.866913-0400    LibAVExtension    Decode Timestamp {0/1000 = 0.000}
default    22:53:19.866929-0400    LibAVExtension    Presentation Timestamp {0/1000 = 0.000}
default    22:53:19.866944-0400    LibAVExtension    Duration {33/1000 = 0.033}
default    22:53:19.866995-0400    LibAVExtension    sampleLocationReturningError
```

13. We then get

```
error    22:53:19.867117-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) (invalid sample duration.) at FigPartialSampleTable.c:1099
```

14. We then get a request for generateSampleCursorAtPresentationTimeStamp + infinity:

```
default    22:53:19.867260-0400    LibAVExtension    generateSampleCursorAtPresentationTimeStamp {+INFINITY}
```

15. Around this time our host app implies playback can start:

```


