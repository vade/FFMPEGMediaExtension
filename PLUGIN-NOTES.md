#  Plugin Debugging notes

Logs below ground the current state of the plugin

- 1 Attemt to load an AVURLAsset with a mime type / uttype the system natively doesnt support
- 2 The responsible subsystem identifies an extension that claims it can read the mine type / uttype 
- 3 The responsible subsuytem hoists an instance via the factory method and establishes an XPC connection
- 4 Our plugin gets `loadFileInfoWithCompletionHandler`
- 5 This triggers our `MEByteReader` file reading via our `avio_context` callbacks 
- 6 We then get `loadMetadataWithCompletionHandler`
- 7 We then get `loadTrackReadersWithCompletionHandler`
- 8 We enumerate our available tracks, and instantiate our `LibAVTrackReader` which uses the `AVStream` `AVCodecParams` to create a `CMFormatDescription`
- 9 Our track reader gets `generateSampleCursorAtPresentationTimeStamp`
- 10 We instantiate a `LibAVSampleCursor` and seek to the timestamp we are asked to seek to.
- 11 This triggers the file seek / reading callbacks via `avio_context` callbacks
- 12 We read an AVPacket and update our sample cursor state 

# Logs

default    13:02:06.957716-0400    LibAVExtensionHost    [0x600003ca00f0] activating connection: mach=true listener=false peer=false name=com.apple.cfprefsd.daemon
default    13:02:06.957788-0400    LibAVExtensionHost    [0x600003ca01e0] activating connection: mach=true listener=false peer=false name=com.apple.cfprefsd.agent
default    13:02:06.964936-0400    LibAVExtensionHost    <<<< FigExtensionFoundationUtilities >>>> FigEXCopyExtensionList_block_invoke: MediaExtension format readers and video decoders enabled -- thank you for setting "ffctl CoreMedia/MediaExtensions=on"
default    13:02:06.965169-0400    LibAVExtensionHost    Waiting on thread <NSThread: 0x6000016eedc0>{number = 2, name = (null)} until Launch Services database seeding is complete.
default    13:02:06.965574-0400    LibAVExtensionHost    [0x11f807900] activating connection: mach=true listener=false peer=false name=com.apple.lsd.mapdb
default    13:02:06.971893-0400    LibAVExtensionHost    [0x600003ca04b0] activating connection: mach=true listener=false peer=false name=com.apple.analyticsd
default    13:02:06.972196-0400    LibAVExtensionHost    Enabling System Keychain Always due to platform
default    13:02:06.972441-0400    LibAVExtensionHost    [0x600003cb0000] activating connection: mach=true listener=false peer=false name=com.apple.trustd.agent
fault    13:02:06.973326-0400    LibAVExtensionHost    __delegate_identifier__:Performance Diagnostics__:::____message__:This method should not be called on the main thread as it may lead to UI unresponsiveness.
default    13:02:06.973589-0400    LibAVExtensionHost    Received configuration update from daemon (initial)
fault    13:02:06.974880-0400    LibAVExtensionHost    __delegate_identifier__:Performance Diagnostics__:::____message__:This method should not be called on the main thread as it may lead to UI unresponsiveness.
fault    13:02:06.977305-0400    LibAVExtensionHost    __delegate_identifier__:Performance Diagnostics__:::____message__:This method should not be called on the main thread as it may lead to UI unresponsiveness.
fault    13:02:06.978403-0400    LibAVExtensionHost    __delegate_identifier__:Performance Diagnostics__:::____message__:This method should not be called on the main thread as it may lead to UI unresponsiveness.
error    13:02:06.983633-0400    LibAVExtensionHost    Private sandbox for info.vade.LibAVExtensionHost.LibAVExtension : <none>
default    13:02:06.985985-0400    LibAVExtensionHost    <<< URLAsset >>> FigAssetCreateWithURL: Called for asset 0x6000016e8f40 by client [], url [0x6000027bc480] <redacted> createFlags 0x8 optionsDict [assetOption_LoggingIdentifier = I/ELD]
default    13:02:06.986438-0400    LibAVExtensionHost    <<<< FigCustomURLHandling >>>> FigCustomURLLoaderCreate: newLoader: 0x6000027bc600
default    13:02:06.986449-0400    LibAVExtensionHost    <<<< FigCustomURLHandling >>>> FigCustomURLHandlerCreate: newHandler: com.apple.avfoundation.customurl.cfurlconnection.0x600002d8c300 options: (null)
default    13:02:06.986457-0400    LibAVExtensionHost    <<<< FigCustomURLHandling >>>> curll_installHandler: 0x6000027bc620: handler: 0x600002d8c300 priority: 100
default    13:02:06.986514-0400    LibAVExtensionHost    <<<< FigCustomURLHandling >>>> FigCustomURLHandlerCreate: newHandler: com.apple.avfoundation.authkeychain.0x600002db4600 options: (null)
default    13:02:06.986522-0400    LibAVExtensionHost    <<<< FigCustomURLHandling >>>> curll_installHandler: 0x6000027bc620: handler: 0x600002db4600 priority: 800
default    13:02:06.986845-0400    LibAVExtensionHost    <<< URLAsset >>> EnsureContentStreamCreated: ByteStream [0x6000020bb400] created for asset [0x6000016e8f40]
default    13:02:06.987122-0400    LibAVExtensionHost    [0x11f80aa40] activating connection: mach=false listener=true peer=false name=(anonymous)
default    13:02:06.987159-0400    LibAVExtensionHost    [0x11f80aa40] Channel could not return listener port.
error    13:02:06.991666-0400    LibAVExtensionHost    Private sandbox for info.vade.LibAVExtensionHost.LibAVExtension : <none>
default    13:02:06.993593-0400    LibAVExtensionHost    [0x11f80aea0] activating connection: mach=false listener=false peer=false name=(anonymous)
default    13:02:06.994076-0400    LibAVExtensionHost    [0x10e708ce0] activating connection: mach=false listener=true peer=false name=(anonymous)
default    13:02:06.994204-0400    LibAVExtensionHost    Launching process with config: bundleID: info.vade.LibAVExtensionHost.LibAVExtension instance ID: nil
default    13:02:06.994801-0400    LibAVExtensionHost    Initializing connection
default    13:02:06.994842-0400    LibAVExtensionHost    Removing all cached process handles
default    13:02:06.994867-0400    LibAVExtensionHost    Sending handshake request attempt #1 to server
default    13:02:06.994910-0400    LibAVExtensionHost    Creating connection to com.apple.runningboard
default    13:02:06.994935-0400    LibAVExtensionHost    [0x600003c8c000] activating connection: mach=true listener=false peer=false name=com.apple.runningboard
default    13:02:06.995104-0400    LibAVExtensionHost    [0x10e605df0] activating connection: mach=false listener=false peer=false name=(anonymous)
default    13:02:06.996156-0400    LibAVExtensionHost    Handshake succeeded
default    13:02:06.996174-0400    LibAVExtensionHost    Identity resolved as app<application.info.vade.LibAVExtensionHost.115102857.115103559.B49B1EBD-B6EB-403A-A3C0-079503DB5849(501)>
default    13:02:07.056726-0400    LibAVExtensionHost    Creating side-channel connection to com.apple.runningboard
default    13:02:07.056739-0400    LibAVExtensionHost    [0x600003cbc0f0] activating connection: mach=true listener=false peer=false name=com.apple.runningboard
default    13:02:07.057463-0400    LibAVExtensionHost    Hit the server for a process handle 1143da660001380b that resolved to: [xpcservice<info.vade.LibAVExtensionHost.LibAVExtension([app<application.info.vade.LibAVExtensionHost.115102857.115103559.B49B1EBD-B6EB-403A-A3C0-079503DB5849(501)>:79879])(501)>{vt hash: 180909887}:79883]
default    13:02:07.059159-0400    LibAVExtensionHost    Created new process ExtensionProcess: bundleID: info.vade.LibAVExtensionHost.LibAVExtension instance ID: nil pid: 79883.
default    13:02:07.059309-0400    LibAVExtensionHost    [0x10e706b30] activating connection: mach=false listener=false peer=false name=(anonymous)
default    13:02:07.059437-0400    LibAVExtensionHost    [0x10e708ce0] Channel could not return listener port.
default    13:02:07.294960-0400    LibAVExtension    Extension `/Users/vade/Library/Developer/Xcode/DerivedData/LibAVExtensionHost-fjhzqmxecglhgreapupkbnlvjiuw/Build/Products/Debug/LibAVExtensionHost.app/Contents/Extensions/LibAVExtension.appex/Contents/MacOS/LibAVExtension` of type: `1` launched.
default    13:02:07.295188-0400    LibAVExtension    Initializing connection
default    13:02:07.295336-0400    LibAVExtension    Removing all cached process handles
default    13:02:07.295382-0400    LibAVExtension    Sending handshake request attempt #1 to server
default    13:02:07.295403-0400    LibAVExtension    Creating connection to com.apple.runningboard
default    13:02:07.295422-0400    LibAVExtension    [0x131009a80] activating connection: mach=true listener=false peer=false name=com.apple.runningboard
default    13:02:07.296190-0400    LibAVExtension    Handshake succeeded
default    13:02:07.296212-0400    LibAVExtension    Identity resolved as xpcservice<info.vade.LibAVExtensionHost.LibAVExtension([app<application.info.vade.LibAVExtensionHost.115102857.115103559.B49B1EBD-B6EB-403A-A3C0-079503DB5849(501)>:79879])(501)>{vt hash: 180909887}
default    13:02:07.296878-0400    LibAVExtension    [0x1311054e0] activating connection: mach=true listener=false peer=false name=com.apple.lsd.mapdb
fault    13:02:07.298454-0400    LibAVExtension    checkinWithServer Failed bootstrap_lookup2 for name of coreservicesd, kern_return_t=#1100/0x44c Permission denied name=com.apple.CoreServices.coreservicesd
default    13:02:07.302743-0400    LibAVExtension    Creating connection handler of class `MEFormatReaderConnectionHandler` with principal object `LibAVFormatReaderFactory`
default    13:02:07.303127-0400    LibAVExtension    initializing domain XPCService
default    13:02:07.303203-0400    LibAVExtension    automatic bootstrapping is complete
default    13:02:07.303236-0400    LibAVExtension    [0x1314052a0] activating connection: mach=false listener=true peer=false name=info.vade.LibAVExtensionHost.LibAVExtension
default    13:02:07.304965-0400    LibAVExtension    [0x13110b3a0] activating connection: mach=false listener=false peer=true name=info.vade.LibAVExtensionHost.LibAVExtension.peer[79879].0x13110b3a0
default    13:02:07.306659-0400    LibAVExtension    [0x130610670] activating connection: mach=true listener=false peer=false name=com.apple.cfprefsd.daemon
default    13:02:07.306729-0400    LibAVExtension    [0x13110b820] activating connection: mach=true listener=false peer=false name=com.apple.cfprefsd.agent
default    13:02:07.308002-0400    LibAVExtension    [0x13100af20] activating connection: mach=false listener=true peer=false name=(anonymous)
default    13:02:07.308026-0400    LibAVExtension    [0x13100af20] Channel could not return listener port.
default    13:02:07.310384-0400    LibAVExtension    [0x130711c20] activating connection: mach=true listener=false peer=false name=com.apple.analyticsd
default    13:02:07.310677-0400    LibAVExtension    Enabling System Keychain Always due to platform
default    13:02:07.310830-0400    LibAVExtension    [0x130711e90] activating connection: mach=true listener=false peer=false name=com.apple.trustd.agent
default    13:02:07.311897-0400    LibAVExtension    Received configuration update from daemon (initial)
default    13:02:07.312972-0400    LibAVExtension    <<<< FigExtensionFoundationUtilities >>>> FigEXCopyExtensionList_block_invoke: MediaExtension format readers and video decoders enabled -- thank you for setting "ffctl CoreMedia/MediaExtensions=on"
default    13:02:07.313086-0400    LibAVExtension    Waiting on thread <private> until Launch Services database seeding is complete.
error    13:02:07.317594-0400    LibAVExtension    Private sandbox for info.vade.LibAVExtensionHost.LibAVExtension : <none>
default    13:02:07.318981-0400    LibAVExtension    _LSBundleCopyOrCheckNode: cached node not found, _LSBundleCreateNode for bundleID 24504 returned -43
default    13:02:07.319614-0400    LibAVExtensionHost    [0x10e605f10] activating connection: mach=false listener=false peer=true name=com.apple.xpc.anonymous.0x10e708ce0.peer[79883].0x10e605f10
default    13:02:07.319693-0400    LibAVExtensionHost    [0x10e709320] activating connection: mach=false listener=false peer=false name=(anonymous)
default    13:02:07.319547-0400    LibAVExtension    [0x131011f30] activating connection: mach=false listener=false peer=false name=(anonymous)
default    13:02:07.319580-0400    LibAVExtension    [0x131011f30] invalidated after the last release of the connection object
default    13:02:07.319915-0400    LibAVExtensionHost    [0x10e605f10] invalidated because the client process (pid 79883) either cancelled the connection or exited
default    13:02:07.319809-0400    LibAVExtension    [0x1306124c0] activating connection: mach=false listener=false peer=true name=com.apple.xpc.anonymous.0x13100af20.peer[79879].0x1306124c0
default    13:02:07.320048-0400    LibAVExtensionHost    [0x10e607d70] activating connection: mach=false listener=false peer=true name=com.apple.xpc.anonymous.0x11f80aa40.peer[79883].0x10e607d70
default    13:02:07.320122-0400    LibAVExtensionHost    [0x10e708ce0] invalidated after the last release of the connection object
default    13:02:07.319993-0400    LibAVExtension    [0x13110ee10] activating connection: mach=false listener=false peer=false name=(anonymous)
default    13:02:07.320950-0400    LibAVExtension    objcWrapperPluginFormatReader_CreateInstance called
default    13:02:07.321037-0400    LibAVExtension    Creating LibAVFormatReader for output.mkv
default    13:02:07.321058-0400    LibAVExtension    Initiaizing LibAVFormatReader
error    13:02:07.323218-0400    LibAVExtensionHost    Private sandbox for info.vade.LibAVExtensionHost.LibAVExtension : <none>
default    13:02:07.324908-0400    LibAVExtensionHost    Existing process ExtensionProcess: bundleID: info.vade.LibAVExtensionHost.LibAVExtension instance ID: nil pid: 79883 is valid, returning it.
default    13:02:07.324965-0400    LibAVExtension    LibAVFormatReader loadFileInfoWithCompletionHandler
default    13:02:07.325201-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 0, size: 4096, read: 4096
default    13:02:07.327336-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4096, size: 8497, read: 8497
default    13:02:07.330157-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 12593, size: 4096, read: 4096
default    13:02:07.330193-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 16689, size: 5982, read: 5982
default    13:02:07.332452-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 22671, size: 4096, read: 4096
default    13:02:07.332477-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 26767, size: 6014, read: 6014
default    13:02:07.334481-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 32781, size: 4096, read: 4096
default    13:02:07.334506-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 36877, size: 6046, read: 6046
default    13:02:07.336492-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 42923, size: 4096, read: 4096
default    13:02:07.336514-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 47019, size: 6039, read: 6039
default    13:02:07.338474-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 53058, size: 4096, read: 4096
default    13:02:07.338500-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 57154, size: 6118, read: 6118
default    13:02:07.340481-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 63272, size: 4096, read: 4096
default    13:02:07.340503-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 67368, size: 6007, read: 6007
default    13:02:07.342470-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 73375, size: 4096, read: 4096
default    13:02:07.342494-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 77471, size: 6079, read: 6079
default    13:02:07.342920-0400    LibAVExtension    LibAVFormatReader loadFileInfoWithCompletionHandler got duration: {20000000/1000000 = 20.000}
default    13:02:07.342993-0400    LibAVExtension    loadMetadataWithCompletionHandler
error    13:02:07.343025-0400    LibAVExtension    <<<< MEFormatReaderWrapper >>>> objcWrapperPluginFormatReader_CopyProperty signalled err=-12784 (kCMBaseObjectError_PropertyNotFound) (can not find metatdata info) at ExtensionFormatReaderWrapper.m:547
default    13:02:07.343072-0400    LibAVExtension    loadTrackReadersWithCompletionHandler
default    13:02:07.343099-0400    LibAVExtension    LibAVTrackReader loadTrackInfoWithCompletionHandler
default    13:02:07.343115-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:07.343164-0400    LibAVExtension    Made Format Description: <CMVideoFormatDescription 0x13101bd10 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
default    13:02:07.351032-0400    LibAVExtensionHost    [0x600003ca02d0] activating connection: mach=true listener=false peer=false name=com.apple.coreservices.launchservicesd
default    13:02:07.351686-0400    LibAVExtensionHost    [0x600003ca40f0] activating connection: mach=true listener=false peer=false name=com.apple.pasteboard.1
default    13:02:07.352390-0400    LibAVExtensionHost    [0x600003ca41e0] activating connection: mach=true listener=false peer=false name=com.apple.distributed_notifications@Uv3
default    13:02:07.353718-0400    LibAVExtensionHost    void _NSDisableAutomaticTerminationAndLog(NSString *) No windows open yet
default    13:02:07.354552-0400    LibAVExtensionHost    [0x600003ca03c0] activating connection: mach=true listener=false peer=false name=com.apple.tccd.system
default    13:02:07.362323-0400    LibAVExtensionHost    [0x600003ca03c0] invalidated after the last release of the connection object
default    13:02:07.362546-0400    LibAVExtensionHost    server port 0x00007207, session port 0x00007207
default    13:02:07.372025-0400    LibAVExtensionHost    New connection 0x10f35b main
default    13:02:07.375407-0400    LibAVExtensionHost    CHECKIN: pid=79879
default    13:02:07.380584-0400    LibAVExtensionHost    CHECKEDIN: pid=79879 asn=0x0-0x156f56e foreground=1
default    13:02:07.380898-0400    LibAVExtensionHost    [0x11f80e6c0] activating connection: mach=false listener=true peer=false name=(anonymous)
default    13:02:07.380908-0400    LibAVExtensionHost    [0x11f80e6c0] Channel could not return listener port.
default    13:02:07.381022-0400    LibAVExtensionHost    [0x118005b80] activating connection: mach=false listener=false peer=true name=com.apple.xpc.anonymous.0x11f80e6c0.peer[372].0x118005b80
default    13:02:07.382466-0400    LibAVExtensionHost    FRONTLOGGING: version 1
default    13:02:07.382524-0400    LibAVExtensionHost    Registered, pid=79879 ASN=0x0,0x156f56e
default    13:02:07.384210-0400    LibAVExtensionHost    [0x11f80e6c0] Channel could not return listener port.
default    13:02:07.385023-0400    LibAVExtensionHost    BringForward: pid=79879 asn=0x0-0x156f56e bringForward=1 foreground=1 uiElement=0 launchedByLS=1 modifiersCount=1 allDisabled=0
default    13:02:07.385162-0400    LibAVExtensionHost    BringFrontModifier: pid=79879 asn=0x0-0x156f56e Modifier 0 hideAfter=0 hideOthers=0 dontMakeFrontmost=1 mouseDown=0/0 seed=0/0
default    13:02:07.385797-0400    LibAVExtensionHost    Current system appearance, (HLTB: 2), (SLS: 1)
default    13:02:07.387473-0400    LibAVExtensionHost    Current system appearance, (HLTB: 2), (SLS: 1)
default    13:02:07.387974-0400    LibAVExtensionHost    Post-registration system appearance: (HLTB: 2)
default    13:02:07.393332-0400    LibAVExtensionHost    [0x11f80e6c0] Channel could not return listener port.
default    13:02:07.396382-0400    LibAVExtensionHost    [0x11f80e6c0] Channel could not return listener port.
default    13:02:07.411453-0400    LibAVExtensionHost    Registering for test daemon availability notify post.
default    13:02:07.411593-0400    LibAVExtensionHost    notify_get_state check indicated test daemon not ready.
default    13:02:07.411703-0400    LibAVExtensionHost    notify_get_state check indicated test daemon not ready.
default    13:02:07.411808-0400    LibAVExtensionHost    notify_get_state check indicated test daemon not ready.
default    13:02:07.449063-0400    LibAVExtensionHost    GM is currently not available.
default    13:02:07.450040-0400    LibAVExtensionHost    isAvailable: unavailable, info = [deviceNotCapable, unknown]
default    13:02:07.450062-0400    LibAVExtensionHost    isAvailable: featureEnabled = true, isMDMAllowed = true, gmAvailable (current) = false
default    13:02:07.455455-0400    LibAVExtensionHost    [0x600003ca5590] activating connection: mach=true listener=false peer=false name=com.apple.coreservices.appleevents
default    13:02:07.456171-0400    LibAVExtensionHost    [0x11f80e6c0] Channel could not return listener port.
default    13:02:07.456590-0400    LibAVExtensionHost    SignalReady: pid=79879 asn=0x0-0x156f56e
default    13:02:07.456962-0400    LibAVExtensionHost    SIGNAL: pid=79879 asn=0x0x-0x156f56e
default    13:02:07.467447-0400    LibAVExtensionHost    void _NSDisableAutomaticTerminationAndLog(NSString *) Restoring windows
default    13:02:07.467700-0400    LibAVExtensionHost    [0x600003ca0000] activating connection: mach=true listener=false peer=false name=com.apple.window_proxies
default    13:02:07.467770-0400    LibAVExtensionHost    [0x600003ca0000] invalidated because the current process cancelled the connection by calling xpc_connection_cancel()
default    13:02:07.486308-0400    LibAVExtensionHost    NSApp cache appearance:
-NSRequiresAquaSystemAppearance: 0
-appearance: (null)
-effectiveAppearance: <NSCompositeAppearance: 0x600002d8e980
 (
    "<NSDarkAquaAppearance: 0x600002d8e780>",
    "<NSDarkAquaAppearance: 0x600002d8e500>",
    "<NSSystemAppearance: 0x600002db4b00>"
)>
default    13:02:07.489696-0400    LibAVExtensionHost    [0x600003fa1a00] activating connection: mach=true listener=false peer=false name=com.apple.fonts
default    13:02:07.509965-0400    LibAVExtensionHost    [0x10e724830] activating connection: mach=true listener=false peer=false name=com.apple.windowmanager.server
default    13:02:07.511801-0400    LibAVExtension    NotifyToken::RegisterDispatch(user.uid.501.com.apple.LaunchServices.database) fired for session key <private>
default    13:02:07.519292-0400    LibAVExtensionHost    NotifyToken::RegisterDispatch(user.uid.501.com.apple.LaunchServices.database) fired for session key LSSessionKey(system: 0 uid: 501)
default    13:02:07.548732-0400    LibAVExtensionHost    Metal API Validation Enabled
default    13:02:07.602246-0400    LibAVExtensionHost    No persisted cache on this platform.
error    13:02:07.605334-0400    LibAVExtensionHost    NSBundle file:///System/Library/PrivateFrameworks/MetalTools.framework/ principal class is nil because all fallbacks have failed
default    13:02:07.616602-0400    LibAVExtensionHost    [0x600003cb81e0] activating connection: mach=true listener=false peer=false name=com.apple.dock.fullscreen
default    13:02:07.634351-0400    LibAVExtensionHost    <<<< AVPlayer >>>> -[AVPlayer _runOnIvarAccessQueueOperationThatMayChangeCurrentItemWithPreflightBlock:modificationBlock:error:]_block_invoke: currentItem KVO: P/WO will willChange AVPlayer.currentItem
default    13:02:07.634707-0400    LibAVExtensionHost    <<<< AVPlayer >>>> -[AVPlayer _runOnIvarAccessQueueOperationThatMayChangeCurrentItemWithPreflightBlock:modificationBlock:error:]_block_invoke: currentItem KVO: P/WO did willChange AVPlayer.currentItem
default    13:02:07.638741-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> FigPlayerAirPlayRoute_Create: [0x600003cbc5a0] P/WO created
default    13:02:07.648057-0400    LibAVExtensionHost    Registered notify signal com.apple.caulk.alloc.rtdump (0)
default    13:02:07.700124-0400    LibAVExtensionHost    [0x600003ca5ef0] invalidated after the last release of the connection object
default    13:02:07.782533-0400    LibAVExtensionHost      HALPlugInManagement.cpp:439    HALPlugInManagement::RegisterPlugIns: skipping in-process plug-ins
error    13:02:07.782555-0400    LibAVExtensionHost    AddInstanceForFactory: No factory registered for id <CFUUID 0x6000003d6700> F8BB1C28-BAE8-11D6-9C31-00039315CD46
default    13:02:07.813075-0400    LibAVExtensionHost    -[AVPictureInPictureController _logContentSourceType:] AVPictureInPictureContentSourceTypePlayerLayer
default    13:02:07.813179-0400    LibAVExtensionHost    -[AVPictureInPictureViewController initWithPictureInPicturePlayerLayerView:] 35 0x6000031887e0
default    13:02:07.813587-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] current status: 0 -> proposed status: 0
default    13:02:07.813607-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] isPictureInPictureProhibited: YES {
    isContentSourceSupported: YES
    isPictureInPicturePossible: NO
    isSystemPictureInPicturePossible: YES
    allowsPictureInPicturePlayback: NO
    isPlayingOnSecondScreen: NO
    sourceIsVisible: NO
    contentDimensions: (0.0, 0.0)
    isPictureInPictureSupported: YES
}
default    13:02:07.813694-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] self.status != AVPictureInPictureControllerStatusProhibited NO
default    13:02:07.813863-0400    LibAVExtensionHost    -[AVPictureInPictureController _commonInitWithSource:]_block_invoke owner.isOtherPictureInPictureActive NO
default    13:02:07.813975-0400    LibAVExtensionHost    -[AVPlayerController init] 453
default    13:02:07.815571-0400    LibAVExtensionHost    Device Supports Analysis: YES
default    13:02:07.820161-0400    LibAVExtensionHost    -[AVPictureInPictureController setAllowsPictureInPicturePlayback:] allowsPictureInPicturePlayback NO
default    13:02:07.820225-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] current status: 0 -> proposed status: 0
default    13:02:07.820405-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] isPictureInPictureProhibited: YES {
    isContentSourceSupported: YES
    isPictureInPicturePossible: NO
    isSystemPictureInPicturePossible: YES
    allowsPictureInPicturePlayback: NO
    isPlayingOnSecondScreen: NO
    sourceIsVisible: NO
    contentDimensions: (0.0, 0.0)
    isPictureInPictureSupported: YES
}
default    13:02:07.820494-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] self.status != AVPictureInPictureControllerStatusProhibited NO
default    13:02:07.821719-0400    LibAVExtensionHost    -[AVPlayerView setPlayer:] player: <AVPlayer: 0x6000001b87e0>
default    13:02:07.821815-0400    LibAVExtensionHost    -[AVPlayerController initWithPlayer:] player: 0x6000001b87e0
default    13:02:07.822449-0400    LibAVExtensionHost    PlayerItemDidChange
default    13:02:07.822540-0400    LibAVExtensionHost    New playerItem: <AVPlayerItem: 0x6000001bd260>
default    13:02:07.822763-0400    LibAVExtensionHost    Time control status = 0
default    13:02:07.822937-0400    LibAVExtensionHost    SeekableTimeRanges changed {nan, nan} -> {nan, nan}.
default    13:02:07.823018-0400    LibAVExtensionHost    Rate changed to: 0.000000
default    13:02:07.823899-0400    LibAVExtensionHost    -[AVPlayerController setActivePlayer:] Updated player to: <AVPlayer: 0x6000001b87e0> player
default    13:02:07.823924-0400    LibAVExtensionHost    -[AVPlayerView setPlayerController:] playerController: <AVPlayerController: 0x10e619e80>
default    13:02:07.823944-0400    LibAVExtensionHost    -[AVPlayerController dealloc] 839 0x10e61aab0
default    13:02:07.824352-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] current status: 0 -> proposed status: 0
default    13:02:07.824371-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] isPictureInPictureProhibited: YES {
    isContentSourceSupported: YES
    isPictureInPicturePossible: YES
    isSystemPictureInPicturePossible: YES
    allowsPictureInPicturePlayback: NO
    isPlayingOnSecondScreen: NO
    sourceIsVisible: NO
    contentDimensions: (nan, nan)
    isPictureInPictureSupported: YES
}
default    13:02:07.824381-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] self.status != AVPictureInPictureControllerStatusProhibited NO
default    13:02:07.824471-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] current status: 0 -> proposed status: 0
default    13:02:07.824542-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] isPictureInPictureProhibited: YES {
    isContentSourceSupported: YES
    isPictureInPicturePossible: YES
    isSystemPictureInPicturePossible: YES
    allowsPictureInPicturePlayback: NO
    isPlayingOnSecondScreen: NO
    sourceIsVisible: NO
    contentDimensions: (nan, nan)
    isPictureInPictureSupported: YES
}
default    13:02:07.824667-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] self.status != AVPictureInPictureControllerStatusProhibited NO
default    13:02:07.833229-0400    LibAVExtensionHost    Window SwiftUI.AppKitWindow 0x10f843c00 ordered front from a non-active application and may order beneath the active application's windows.
default    13:02:07.833257-0400    LibAVExtensionHost    order window front conditionally: 49d9 related: 0
default    13:02:07.833415-0400    LibAVExtensionHost    void _NSEnableAutomaticTerminationAndLog(NSString *) No windows open yet
default    13:02:07.833900-0400    LibAVExtensionHost    establishing connection to agent
default    13:02:07.834117-0400    LibAVExtensionHost    [0x6000020f9130] Session created.
default    13:02:07.834304-0400    LibAVExtensionHost    [0x6000020f9130] Session created from connection [0x600003ca5fe0]
default    13:02:07.835228-0400    LibAVExtensionHost    [0x600003ca5fe0] activating connection: mach=true listener=false peer=false name=com.apple.uiintelligencesupport.agent
default    13:02:07.835489-0400    LibAVExtensionHost    void _NSEnableAutomaticTerminationAndLog(NSString *) Restoring windows
default    13:02:07.835397-0400    LibAVExtensionHost    [0x6000020f9130] Session activated
default    13:02:07.843832-0400    LibAVExtensionHost    -[AVDesktopPlaybackContentContainerView setContentDisplayType:] contentDisplayType - 6
default    13:02:07.843969-0400    LibAVExtensionHost    -[AVDesktopPlaybackContentContainerView _updateActiveContentDisplayTypeIfNeeded] activeContentDisplayType - 6
default    13:02:07.847050-0400    LibAVExtensionHost    -[AVPictureInPictureController setAllowsPictureInPicturePlayback:] allowsPictureInPicturePlayback NO
default    13:02:07.847122-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] current status: 0 -> proposed status: 0
default    13:02:07.847198-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] isPictureInPictureProhibited: YES {
    isContentSourceSupported: YES
    isPictureInPicturePossible: YES
    isSystemPictureInPicturePossible: YES
    allowsPictureInPicturePlayback: NO
    isPlayingOnSecondScreen: NO
    sourceIsVisible: YES
    contentDimensions: (nan, nan)
    isPictureInPictureSupported: YES
}
default    13:02:07.847260-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] self.status != AVPictureInPictureControllerStatusProhibited NO
default    13:02:07.848903-0400    LibAVExtensionHost    -[AVNowPlayingInfoController init] 54 0x600000d1b1b0
default    13:02:07.859175-0400    LibAVExtensionHost    -[AVDesktopPlayerViewContentView _setShouldManagePlaybackControlsState:] managesPlaybackControlsState: YES
default    13:02:07.943831-0400    LibAVExtensionHost    Set: origin-Mac-1280262988/client-info.vade.LibAVExtensionHost-79879/player-MediaRemote-DefaultPlayer setting ActivePlayerPath to <<MRPlayer: 0x6000016df400> {
    audioSessionID = 0;
    audioSessionType = Default;
    displayName = "Default Player";
    identifier = "MediaRemote-DefaultPlayer";
}>
default    13:02:07.944029-0400    LibAVExtensionHost    Request: setNowPlayingPlayer<AD9EE037-F246-4699-96F8-B05FE0D3A0DB> for origin-Mac-1280262988/client-info.vade.LibAVExtensionHost-79879/player-MediaRemote-DefaultPlayer because New player origin-Mac-1280262988/client-info.vade.LibAVExtensionHost-79879/player-MediaRemote-DefaultPlayer was added
default    13:02:07.944489-0400    LibAVExtensionHost    [0x600003c8c0f0] activating connection: mach=true listener=false peer=false name=com.apple.mediaremoted.xpc
default    13:02:07.944638-0400    LibAVExtensionHost    MediaRemote server initializing
default    13:02:07.948913-0400    LibAVExtensionHost    order window front conditionally: 49d9 related: 0
default    13:02:08.033051-0400    LibAVExtensionHost    Response: setNowPlayingPlayer<AD9EE037-F246-4699-96F8-B05FE0D3A0DB> returned for origin-Mac-1280262988/client-info.vade.LibAVExtensionHost-79879/player-MediaRemote-DefaultPlayer in 0.0891 seconds
default    13:02:08.049524-0400    LibAVExtensionHost    [0x10e6387e0] Channel could not return listener port.
default    13:02:08.049808-0400    LibAVExtensionHost    [0x600003ca1a40] invalidated after the last release of the connection object
default    13:02:08.050143-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> playerairplay_handleSetProperty: [0x118007e20] P/WO AllowsAirPlayVideo set to TRUE, state NoAirPlay)
default    13:02:08.050416-0400    LibAVExtensionHost    <<<< FigPlayerSurrogate >>>> surrogatePlayer_CreatePlaybackItemFromAsset: [0x6000034bc790] P/WO Created new item 0x6000038b8ea0 I/ELD.01
default    13:02:08.050523-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> playerairplay_CreatePlaybackItem: [0x118007e20] P/WO -> new item 0x10e733290 I/ELD.01 [8C7C3892-700E-41D2-B9D1-E8DAB9DCD345] wrapping [0x6000034bc790:0x6000038b8ea0]
default    13:02:08.050808-0400    LibAVExtensionHost    <<<< AVPlayerItem >>>> -[AVPlayerItem _updateItemIdentifierForCoordinatedPlayback]_block_invoke: self I/ELD.01: setting coordination identifier to (null)
default    13:02:08.050908-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] current status: 0 -> proposed status: 0
default    13:02:08.051103-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] isPictureInPictureProhibited: YES {
    isContentSourceSupported: YES
    isPictureInPicturePossible: YES
    isSystemPictureInPicturePossible: YES
    allowsPictureInPicturePlayback: NO
    isPlayingOnSecondScreen: NO
    sourceIsVisible: YES
    contentDimensions: (nan, nan)
    isPictureInPictureSupported: YES
}
default    13:02:08.051359-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] self.status != AVPictureInPictureControllerStatusProhibited NO
default    13:02:08.051928-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> FigPlayerFileCreateWithOptions: returning player(0x10e737160) P/WO, err=0
default    13:02:08.053970-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_setCurrentTimeWithRangeAndIDGuts: <0x10f06b000|I/ELD.01> called, time = 0.000, flags = 0x3, range = [-inf, inf], seekID = 100000001
default    13:02:08.054083-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_setCurrentTimeWithRangeAndIDGuts: <0x10f06b000|I/ELD.01> to 0.000 - setting remembered time
default    13:02:08.054231-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_setCurrentTimeWithRangeAndIDGuts: <0x10f06b000|I/ELD.01> no boss, posting SeekDidComplete immediately (seekID 100000001)
default    13:02:08.054483-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_applyLoudnessInfo: [0x10e737160] P/WO item [0x10f06b000] I/ELD.01 is not the working item so no need to pass down loudnessinfo yet for track 0
default    13:02:08.054848-0400    LibAVExtensionHost    <<<< Async >>>> playerasync_runAsynchronousCommandOnQueue: Command 26 returned -12784; this async error will be discarded
default    13:02:08.055047-0400    LibAVExtensionHost    <<<< Async >>>> playerasync_runAsynchronousCommandOnQueue: Command 26 returned -12784; this async error will be discarded
default    13:02:08.055392-0400    LibAVExtensionHost    <<<< Async >>>> playerasync_runAsynchronousCommandOnQueue: Command 26 returned -12784; this async error will be discarded
default    13:02:08.055811-0400    LibAVExtensionHost    <<<< FigPlayerSurrogate >>>> surrogatePlayer_AddToPlayQueue: [0x6000034bc790] P/WO add 0x6000038b8ea0 I/ELD.01 after 0x0
default    13:02:08.056217-0400    LibAVExtensionHost    <<<< FigPlayerSurrogate >>>> surrogatePlaybackItem_addToPlayQueueInternal: [0x6000034bc790] P/WO adding item 0x6000038b8ea0(0x10f06b000) I/ELD.01 to play queue after item 0x0(0x0)
default    13:02:08.058245-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_prepareWorkingItem: [0x10e737160] P/WO item 0x10f06b000 I/ELD.01 is the working item but is not yet ready for inspection
default    13:02:08.058963-0400    LibAVExtension    LibAVTrackReader generateSampleCursorAtPresentationTimeStamp {0/1 = 0.000}
default    13:02:08.058368-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_getNextPlaybackState: [0x10e737160] P/WO new playback state: Paused (Player) (playerRate: 0.000), WILL NOT update boss rate (nan), previous state: Paused, change reason: CurrentItemChanged, playthrough prediction: unknown, options: None
default    13:02:08.059010-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130711050> init
default    13:02:08.058406-0400    LibAVExtensionHost    -[AVDesktopPlayerViewContentView _updateControlsVisibilityStateIfNeeded] Setting playback controls (<AVInlinePlaybackControlsViewController: 0x118018c20>) visibility state to shown
default    13:02:08.059034-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.059063-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> seekToPTS {0/1 = 0.000}
default    13:02:08.059154-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6082452, size: 4096, read: 4096
default    13:02:08.058532-0400    LibAVExtensionHost    -[AVControlsContainerViewController init] 105 0x600003aa4460
default    13:02:08.059216-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6086548, size: 4096, read: 4096
default    13:02:08.059272-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6090644, size: 4096, read: 3205
default    13:02:08.059328-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> readAPacketAndUpdateState
default    13:02:08.059348-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 575, size: 4096, read: 4096
default    13:02:08.059451-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4671, size: 7922, read: 7922
default    13:02:08.059616-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket Presentation Timestamp {0/1000 = 0.000}
default    13:02:08.062680-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011e00> readAPacketAndUpdateState
default    13:02:08.062748-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 22671, size: 4096, read: 4096
default    13:02:08.062849-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 26767, size: 6014, read: 6014
default    13:02:08.062941-0400    LibAVExtensionHost    -[AVDesktopPlayerViewContentView _updateActiveControlsViewControllerIfNeeded] Updating controls view controller from (null) to <AVInlinePlaybackControlsViewController: 0x118018c20>
default    13:02:08.062912-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011e00> updateStateForPacket Presentation Timestamp {67/1000 = 0.067}
default    13:02:08.063009-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011e00> updateStateForPacket Decode Timestamp {67/1000 = 0.067}
default    13:02:08.063098-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011e00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.063148-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011e00> updateStateForPacket sampleOffset 22689
default    13:02:08.063303-0400    LibAVExtensionHost    -[AVPlayerControlsViewController _updateOrCreateTimeResolverIfNeeded] Stopping time updates
default    13:02:08.063224-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011e00> updateStateForPacket sampleSize 10088
default    13:02:08.063389-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011e00> seekToPTS already at {67/1000 = 0.067}
default    13:02:08.063474-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611830> created copy <LibAVSampleCursor: 0x131011e00>
default    13:02:08.063627-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131011e00> stepInDecodeOrderByCount  1
default    13:02:08.063781-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011e00> readAPacketAndUpdateState
default    13:02:08.063915-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 32781, size: 4096, read: 4096
default    13:02:08.064002-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 36877, size: 6046, read: 6046
default    13:02:08.064131-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011e00> updateStateForPacket Presentation Timestamp {100/1000 = 0.100}
default    13:02:08.066905-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 57154, size: 6118, read: 6118
default    13:02:08.067019-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611830> updateStateForPacket Presentation Timestamp {167/1000 = 0.167}
default    13:02:08.067063-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611830> updateStateForPacket Decode Timestamp {167/1000 = 0.167}
default    13:02:08.067192-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611830> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.067425-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611830> updateStateForPacket sampleOffset 53076
default    13:02:08.073725-0400    LibAVExtensionHost    Pixel format registry initialized. Constant classes enabled.
default    13:02:08.084402-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_establishStereoAudioSpatializationPreferenceForAsset: <0x10f06b000|I/ELD.01>: Stereo Spatialization allowed by default due to asset containing video.
default    13:02:08.085037-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_postReadyForInspectionPayloadBecauseAssetPropertyLoadedAndBasicsReady: [0x10f06b000] Track ID 1 vide (0x6000027a55c0) nominal framerate: 30.000 frames per second
default    13:02:08.086760-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011f30> updateStateForPacket Decode Timestamp {0/1000 = 0.000}
default    13:02:08.086811-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011f30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.086895-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011f30> updateStateForPacket sampleOffset 593
default    13:02:08.087019-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011f30> updateStateForPacket sampleSize 11996
default    13:02:08.087084-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011f30> seekToPTS already at {0/1 = 0.000}
default    13:02:08.087132-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131011f30> seekToPTS already at {0/1 = 0.000}
default    13:02:08.087238-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131011f30> copyWithZone
default    13:02:08.087307-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130711050> init with pts/dts
default    13:02:08.087434-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.087512-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> seekToPTS already at {0/1000 = 0.000}
default    13:02:08.087655-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> readAPacketAndUpdateState
default    13:02:08.087759-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 12593, size: 4096, read: 4096
default    13:02:08.087899-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 16689, size: 5982, read: 5982
default    13:02:08.088057-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket Presentation Timestamp {33/1000 = 0.033}
default    13:02:08.088181-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket Decode Timestamp {33/1000 = 0.033}
default    13:02:08.088310-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.088417-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket sampleOffset 12611
default    13:02:08.088500-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket sampleSize 10056
default    13:02:08.088643-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> seekToPTS already at {33/1000 = 0.033}
default    13:02:08.088784-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131011f30> created copy <LibAVSampleCursor: 0x130711050>
default    13:02:08.088888-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130711050> copyWithZone
default    13:02:08.089023-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130613140> init with pts/dts
default    13:02:08.089138-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.090954-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130613140> stepInDecodeOrderByCount  1
default    13:02:08.091003-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613140> readAPacketAndUpdateState
default    13:02:08.091073-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 42923, size: 4096, read: 4096
default    13:02:08.091136-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 47019, size: 6039, read: 6039
default    13:02:08.091208-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613140> updateStateForPacket Presentation Timestamp {133/1000 = 0.133}
default    13:02:08.091293-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613140> updateStateForPacket Decode Timestamp {133/1000 = 0.133}
default    13:02:08.091356-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613140> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.091449-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613140> updateStateForPacket sampleOffset 42941
default    13:02:08.091572-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613140> updateStateForPacket sampleSize 10113
default    13:02:08.091681-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130711050> stepInDecodeOrderByCount  1
default    13:02:08.091805-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> readAPacketAndUpdateState
default    13:02:08.091944-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 53058, size: 4096, read: 4096
default    13:02:08.092081-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 57154, size: 6118, read: 6118
default    13:02:08.092240-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket Presentation Timestamp {167/1000 = 0.167}
default    13:02:08.092365-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket Decode Timestamp {167/1000 = 0.167}
default    13:02:08.092514-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.092669-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket sampleOffset 53076
default    13:02:08.092849-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130711050> updateStateForPacket sampleSize 10192
default    13:02:08.095263-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4671, size: 7922, read: 7922
default    13:02:08.095366-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket Presentation Timestamp {0/1000 = 0.000}
default    13:02:08.095424-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket Decode Timestamp {0/1000 = 0.000}
default    13:02:08.095532-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.095582-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket sampleOffset 593
default    13:02:08.095674-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket sampleSize 11996
default    13:02:08.095748-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> seekToPTS already at {0/1000 = 0.000}
default    13:02:08.095807-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131405a40> created copy <LibAVSampleCursor: 0x13110e740>
default    13:02:08.095973-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13110e740> copyWithZone
default    13:02:08.096076-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611960> init with pts/dts
default    13:02:08.096168-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.096288-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> seekToPTS already at {0/1000 = 0.000}
default    13:02:08.096369-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> readAPacketAndUpdateState
default    13:02:08.096438-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 12593, size: 4096, read: 4096
default    13:02:08.096537-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 16689, size: 5982, read: 5982
default    13:02:08.096623-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> updateStateForPacket Presentation Timestamp {33/1000 = 0.033}
default    13:02:08.096673-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> updateStateForPacket Decode Timestamp {33/1000 = 0.033}
default    13:02:08.096726-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.096787-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> updateStateForPacket sampleOffset 12611
default    13:02:08.096883-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> updateStateForPacket sampleSize 10056
default    13:02:08.096961-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> seekToPTS already at {33/1000 = 0.033}
default    13:02:08.097016-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13110e740> created copy <LibAVSampleCursor: 0x130611960>
default    13:02:08.097105-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611960> stepInDecodeOrderByCount  1
default    13:02:08.097197-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> readAPacketAndUpdateState
default    13:02:08.097315-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 22671, size: 4096, read: 4096
default    13:02:08.097404-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 26767, size: 6014, read: 6014
default    13:02:08.097522-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> updateStateForPacket Presentation Timestamp {67/1000 = 0.067}
default    13:02:08.097644-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> updateStateForPacket Decode Timestamp {67/1000 = 0.067}
default    13:02:08.097726-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.097910-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611960> updateStateForPacket sampleOffset 22689
default    13:02:08.099430-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket Decode Timestamp {133/1000 = 0.133}
default    13:02:08.099684-0400    LibAVExtensionHost    [0x600003ca1c20] activating connection: mach=true listener=false peer=false name=com.apple.coremedia.volumecontroller.xpc
default    13:02:08.099494-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.099592-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket sampleOffset 42941
default    13:02:08.099915-0400    LibAVExtensionHost    << FigPlayMonitor >> FigPlayabilityMonitorCreate: [0x119010e30] Movie duration = 20 s
default    13:02:08.099669-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket sampleSize 10113
default    13:02:08.100003-0400    LibAVExtensionHost    << FigPlayMonitor >> FigPlayabilityMonitorCreate: [0x119010e30] new monitor (stream 0x6000020bb3e0)
default    13:02:08.100071-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_monitorPlayability: <0x10f06b000|I/ELD.01> Created playability monitor 0x119010e30 (err=0)
default    13:02:08.100162-0400    LibAVExtensionHost    << FigPlayMonitor >> fpm_likelyToKeepUpUsingDynamicAlgorithm: [0x119010e30] sending kfpmStreamLikelyToKeepUp; smoothedBandwidth=0.00 kbps dur=20.00
default    13:02:08.100214-0400    LibAVExtensionHost    << FigPlayMonitor >> fpm_likelyToKeepUpUsingDynamicAlgorithm: [0x119010e30] bandwidth: 0 kbps; smoothedBandwidth: 0 kbps; bwInflationFactor: 1.00; (movieDuration - durToPlayThrough): 0.00; durationAhead: 20.00; timeToLikelyToKeepUp: 0.00
default    13:02:08.100305-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_registerPlayabilityMonitorNotification: <0x10f06b000|I/ELD.01> playback is already LikelyToKeepUp - notifying
default    13:02:08.101002-0400    LibAVExtensionHost    <<<< Alt >>>> FPSupport_GetDisplayRefreshInformation: new found display(1) with current mode (<CGDisplayMode 0x6000003ccc00> [{
    BitsPerPixel = 32;
    BitsPerSample = 10;
    DepthFormat = 8;
    Height = 1329;
    IODisplayModeID = 72;
    IOFlags = 3;
    Mode = 72;
    PixelEncoding = "--RRRRRRRRRRGGGGGGGGGGBBBBBBBBBB";
    RefreshRate = 120;
    SamplesPerPixel = 3;
    UsableForDesktopGUI = 1;
    Width = 2056;
    kCGDisplayBytesPerRow = 16448;
    kCGDisplayHorizontalResolution = 303;
    kCGDisplayModeIsInterlaced = 0;
    kCGDisplayModeIsSafeForHardware = 1;
    kCGDisplayModeIsStretched = 0;
    kCGDisplayModeIsTelevisionOutput = 0;
    kCGDisplayModeIsUnavailable = 0;
    kCGDisplayModeSuitableForUI = 1;
    kCGDisplayPixelsHigh = 2658;
    kCGDisplayPixelsWide = 4112;
    kCGDisplayResolution = 2;
    kCGDisplayVerticalResolution = 303;
}] ) having a refresh rate(120.000000)
default    13:02:08.101128-0400    LibAVExtensionHost    <<<< Alt >>>> FPSupport_GetDisplayRefreshInformation: displayMaxRefreshInterval:1/120 displayMinRefreshInterval:1/120 displayRefreshStep:0/0
default    13:02:08.101304-0400    LibAVExtensionHost    <<<< Alt >>>> FPSupport_GetDisplayRefreshInformation: new found display(1) with current mode (<CGDisplayMode 0x6000003ccc00> [{
    BitsPerPixel = 32;
    BitsPerSample = 10;
    DepthFormat = 8;
    Height = 1329;
    IODisplayModeID = 72;
    IOFlags = 3;
    Mode = 72;
    PixelEncoding = "--RRRRRRRRRRGGGGGGGGGGBBBBBBBBBB";
    RefreshRate = 120;
    SamplesPerPixel = 3;
    UsableForDesktopGUI = 1;
    Width = 2056;
    kCGDisplayBytesPerRow = 16448;
    kCGDisplayHorizontalResolution = 303;
    kCGDisplayModeIsInterlaced = 0;
    kCGDisplayModeIsSafeForHardware = 1;
    kCGDisplayModeIsStretched = 0;
    kCGDisplayModeIsTelevisionOutput = 0;
    kCGDisplayModeIsUnavailable = 0;
    kCGDisplayModeSuitableForUI = 1;
    kCGDisplayPixelsHigh = 2658;
    kCGDisplayPixelsWide = 4112;
    kCGDisplayResolution = 2;
    kCGDisplayVerticalResolution = 303;
}] ) having a refresh rate(120.000000)
default    13:02:08.101398-0400    LibAVExtensionHost    <<<< Alt >>>> FPSupport_GetDisplayRefreshInformation: displayMaxRefreshInterval:1/120 displayMinRefreshInterval:1/120 displayRefreshStep:0/0
default    13:02:08.117837-0400    LibAVExtensionHost    [0x600003cbd0e0] activating connection: mach=false listener=false peer=false name=com.apple.coremedia.videodecoder
default    13:02:08.118047-0400    LibAVExtensionHost    [0x10e65d6e0] activating connection: mach=false listener=true peer=false name=(anonymous)
default    13:02:08.118073-0400    LibAVExtensionHost    [0x10e65d6e0] Channel could not return listener port.
default    13:02:08.122642-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> playerairplay_copyRoutingContext: [0x600003cbc5a0] P/WO Ensuring RoutingContext using RoutingContext UUID 6490ED50-125E-4405-98AA-F85D2B40955D
default    13:02:08.123101-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> playerairplayroute_updateRoutingRegistryInternal: [0x600003cbc5a0] P/WO Updating routing registry. playbackActive: 0. routingContextUUID: [6490ED50-125E-4405-98AA-F85D2B40955D]. AudioSessionDisallowsBuffered: 0. Saved UUID: [(null)]
default    13:02:08.123166-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> playerairplayroute_updateRouteInformation: [0x600003cbc5a0] P/WO Called. Current route: (null) [pb: 0 t: [0x0] ][sc: 0x0][buf: 0x0][lpb: 1][usc:0]
default    13:02:08.123421-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> playerairplayroute_updateRouteInformation: [0x600003cbc5a0] P/WO Selected endpoint from routing context [0x0], Local Playback = 1
default    13:02:08.123450-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> playerairplayroute_updateRouteInformation: [0x600003cbc5a0] P/WO Exiting (current: (null) [pb: 0 t: [0x0] ][sc: 0x0][buf: 0x0][lpb: 1][usc:0][epsAPVwSharePlay:0])
default    13:02:08.123461-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> playerairplayroute_updateRouteInformation: [0x600003cbc5a0] P/WO change route type to 0, err = 0
default    13:02:08.126380-0400    LibAVExtensionHost    View <AVDesktopButton: 0x11840b2d0> returned a baseline offset that is not integral in pixels (8.500000).  The developer should always make sure -firstBaselineOffsetFromTop and -lastBaselineOffsetFromBottom are pixel-integral.
default    13:02:08.127759-0400    LibAVExtensionHost    -[AVRoutePickerView _updatePickerButtonAppearance] Setting mica color: (R: 255.00 G: 255.00 B: 255.00 Alpha: 0.49) and state: Inactive.
default    13:02:08.131524-0400    LibAVExtensionHost    [0x600003cb42d0] activating connection: mach=true listener=false peer=false name=com.apple.coremedia.routediscoverer.xpc
default    13:02:08.137830-0400    LibAVExtensionHost    -[AVRoutePickerView _updatePickerButtonAppearance] Setting mica color: (R: 255.00 G: 255.00 B: 255.00 Alpha: 0.49) and state: Inactive.
default    13:02:08.141343-0400    LibAVExtensionHost    -[AVPlayerControlsViewController _updateOrCreateTimeResolverIfNeeded] Starting time updates
default    13:02:08.160196-0400    LibAVExtensionHost    [0x10e7432e0] activating connection: mach=false listener=false peer=true name=com.apple.xpc.anonymous.0x10e65d6e0.peer[79884].0x10e7432e0
default    13:02:08.168072-0400    LibAVExtensionHost    <<<< FigDeferredTransaction >>>> fdt_commitTransactionOnMainQueue: Warning: deferred transaction <FigDeferredTransaction 0x600001606680, wants CATransaction, is committed
Changes:
<FigDeferredTransactionChange 0x600001606240
-[FigBaseCALayer initWithDeferredTransaction:] requesting to

set ContentsScale: 2.000000>
<FigDeferredTransactionChange 0x600001608140
-[FigVideoLayer initWithDeferredTransaction:] requesting to

set allowsDisplayCompositing: 1>
<FigDeferredTransactionChange 0x600001609000
playerfig_setClientVideoLayerArray requesting to
Attach fig video layers: [<FigVideoLayer: 0x600000d7a250>]
to client layers: [<FigVideoContainerLayer: 0x6000020ff7f0>]>
<FigDeferredTransactionChange 0x60000160b800
playerfig_setClientVideoLayerArray requesting to
Set edge antialiasing mask 0
on layers: [<FigVideoLayer: 0x600000d7a250>]>

Post commit changes:
> was delayed by 0.110s before it began running
default    13:02:08.168931-0400    LibAVExtensionHost    <<<< AVRouteDetector >>>> -[AVRouteDetector init]_block_invoke: app is in the foreground/active. route detection is allowed.
default    13:02:08.168962-0400    LibAVExtensionHost    <<<< AVOutputDeviceDiscoverySession >>>> -[AVOutputDeviceDiscoverySession setDiscoveryMode:forClientIdentifiers:]: called (session=0x600000186800, discoveryMode=1, clientIdentifiers=(
))
default    13:02:08.168978-0400    LibAVExtensionHost    <<<< AVOutputDeviceDiscoverySession (FigRouteDiscoverer) >>>> -[AVFigRouteDiscovererOutputDeviceDiscoverySessionImpl outputDeviceDiscoverySessionDidChangeDiscoveryMode:forClientIdentifiers:]: Setting device discovery mode to DiscoveryMode_Presence (client: LibAVExtensionHost) for session=0x600000186800
default    13:02:08.169868-0400    LibAVExtensionHost    <<<< AVOutputDeviceDiscoverySession >>>> -[AVOutputDeviceDiscoverySession setDiscoveryMode:forClientIdentifiers:]: called (session=0x600000186800, discoveryMode=1, clientIdentifiers=(
))
default    13:02:08.169887-0400    LibAVExtensionHost    <<<< AVOutputDeviceDiscoverySession (FigRouteDiscoverer) >>>> -[AVFigRouteDiscovererOutputDeviceDiscoverySessionImpl outputDeviceDiscoverySessionDidChangeDiscoveryMode:forClientIdentifiers:]: Setting device discovery mode to DiscoveryMode_Presence (client: LibAVExtensionHost) for session=0x600000186800
default    13:02:08.178059-0400    LibAVExtensionHost    +[IMKClient subclass]: chose IMKClient_Legacy
default    13:02:08.178085-0400    LibAVExtensionHost    +[IMKInputSession subclass]: chose IMKInputSession_Legacy
default    13:02:08.180932-0400    LibAVExtensionHost    [0x11f80c5f0] activating connection: mach=true listener=false peer=false name=com.apple.inputmethodkit.getxpcendpoint
default    13:02:08.185801-0400    LibAVExtensionHost    [0x118119cf0] activating connection: mach=false listener=false peer=false name=(anonymous)
default    13:02:08.203860-0400    LibAVExtensionHost    <<<< VMC >>>> VMC2CreateWithCallbacks: Created VMC 0x10e8d5000 on behalf of client pid 79879
default    13:02:08.203957-0400    LibAVExtensionHost    <<<< IQ-CA >>>> piqca_setProperty: (0x10f8a6000) kFigImageQueueProperty_EnableImageQueueTiming -> TRUE
default    13:02:08.204025-0400    LibAVExtensionHost    <<<< IQ-CA >>>> piqca_setImageQueueTiming: (0x10f8a6000) Paused; Set IQTimingOffset: 0.000 at host time 0.000
default    13:02:08.204052-0400    LibAVExtensionHost    <<<< IQ-CA >>>> piqca_setImageQueueTiming: (0x10f8a6000) Paused; Set IQTimingOffset: 0.000 at host time 220263.145
error    13:02:08.204042-0400    LibAVExtensionHost    <<<< VRP >>>> figVideoRenderPipelineSetProperty signalled err=-12852 (kFigRenderPipelineError_InvalidParameter) (sample attachment collector not enabled) at FigStandardVideoRenderPipeline.c:2231
default    13:02:08.206986-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611980> seekToPTS {0/1 = 0.000}
default    13:02:08.207020-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611980> readAPacketAndUpdateState
default    13:02:08.207051-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 575, size: 4096, read: 4096
default    13:02:08.207073-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4671, size: 7922, read: 7922
default    13:02:08.207125-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611980> updateStateForPacket Presentation Timestamp {0/1000 = 0.000}
default    13:02:08.207145-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611980> updateStateForPacket Decode Timestamp {0/1000 = 0.000}
default    13:02:08.207164-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611980> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.207184-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611980> updateStateForPacket sampleOffset 593
default    13:02:08.207199-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611980> updateStateForPacket sampleSize 11996
default    13:02:08.207216-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611980> seekToPTS already at {0/1 = 0.000}
default    13:02:08.207253-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611980> seekToPTS already at {0/1 = 0.000}
default    13:02:08.207340-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611980> copyWithZone
default    13:02:08.207412-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131405b00> init with pts/dts
default    13:02:08.207504-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.207593-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> seekToPTS already at {0/1000 = 0.000}
default    13:02:08.207676-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> readAPacketAndUpdateState
default    13:02:08.207741-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 12593, size: 4096, read: 4096
default    13:02:08.207853-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 16689, size: 5982, read: 5982
default    13:02:08.207957-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> updateStateForPacket Presentation Timestamp {33/1000 = 0.033}
default    13:02:08.208039-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> updateStateForPacket Decode Timestamp {33/1000 = 0.033}
default    13:02:08.208117-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.208204-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> updateStateForPacket sampleOffset 12611
default    13:02:08.208311-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> updateStateForPacket sampleSize 10056
default    13:02:08.208425-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> seekToPTS already at {33/1000 = 0.033}
default    13:02:08.208487-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611980> created copy <LibAVSampleCursor: 0x131405b00>
default    13:02:08.208585-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131405b00> copyWithZone
default    13:02:08.208683-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13110e740> init with pts/dts
default    13:02:08.208760-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.208820-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> seekToPTS already at {33/1000 = 0.033}
default    13:02:08.208884-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> readAPacketAndUpdateState
default    13:02:08.208957-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 22671, size: 4096, read: 4096
default    13:02:08.209024-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 26767, size: 6014, read: 6014
default    13:02:08.209117-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket Presentation Timestamp {67/1000 = 0.067}
default    13:02:08.209182-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket Decode Timestamp {67/1000 = 0.067}
default    13:02:08.209275-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.209391-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket sampleOffset 22689
default    13:02:08.209549-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket sampleSize 10088
default    13:02:08.209666-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> seekToPTS already at {67/1000 = 0.067}
default    13:02:08.209764-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131405b00> created copy <LibAVSampleCursor: 0x13110e740>
default    13:02:08.209867-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13110e740> stepInDecodeOrderByCount  1
default    13:02:08.209949-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> readAPacketAndUpdateState
default    13:02:08.210057-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 32781, size: 4096, read: 4096
default    13:02:08.210140-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 36877, size: 6046, read: 6046
default    13:02:08.210225-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket Presentation Timestamp {100/1000 = 0.100}
default    13:02:08.210313-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13110e740> updateStateForPacket Decode Timestamp {100/1000 = 0.100}
default    13:02:08.211247-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.211481-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetTimeWithRange: <0x10e65bae0|I/ELD.01> playState set to Paused
default    13:02:08.211316-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> updateStateForPacket sampleOffset 53076
default    13:02:08.211496-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetEndTime: <0x10e65bae0|I/ELD.01> endTime nan
default    13:02:08.211334-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131405b00> updateStateForPacket sampleSize 10192
default    13:02:08.211534-0400    LibAVExtension    LibAVTrackReader generateSampleCursorAtPresentationTimeStamp {0/1 = 0.000}
default    13:02:08.211505-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetReverseEndTime: <0x10e65bae0|I/ELD.01> reverseEndTime nan
default    13:02:08.211553-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130612040> init
default    13:02:08.211513-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetStopAtEnd: <0x10e65bae0|I/ELD.01> TRUE
default    13:02:08.211566-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.211523-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetAdvanceTimeForOverlappedPlayback: <0x10e65bae0|I/ELD.01> advanceTimeForOverlappedPlayback nan
default    13:02:08.211590-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130612040> seekToPTS {0/1 = 0.000}
default    13:02:08.211529-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetAudibleRateRange: <0x10e65bae0|I/ELD.01> (no minAudibleRate) 0.000 (no maxAudibleRate) 0.000
default    13:02:08.211615-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130612040> readAPacketAndUpdateState
default    13:02:08.211539-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetRateSnapping: <0x10e65bae0|I/ELD.01> snapToSimpleRates = false, minRateToStretchAudio = 0.031, maxRateToStretchAudio = 32.000
default    13:02:08.211636-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 575, size: 4096, read: 4096
default    13:02:08.211549-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetContinuePlayingDuringPrerollForSeek: <0x10e65bae0|I/ELD.01> true
default    13:02:08.211668-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4671, size: 7922, read: 7922
default    13:02:08.211627-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetContinuePlayingDuringPrerollForRateChange: <0x10e65bae0|I/ELD.01> true
default    13:02:08.211771-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130612040> updateStateForPacket Presentation Timestamp {0/1000 = 0.000}
default    13:02:08.211709-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetUseIFrameOnlyPlaybackForHighRateScaledEdits: <0x10e65bae0|I/ELD.01> false
default    13:02:08.211817-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130612040> updateStateForPacket Decode Timestamp {0/1000 = 0.000}
default    13:02:08.211839-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetMinimumIntervalForIFrameOnlyPlayback: <0x10e65bae0|I/ELD.01> 0.100
default    13:02:08.211900-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130612040> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.211913-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetThoroughlyRefreshClosedCaptionsWhenSeeking: <0x10e65bae0|I/ELD.01> false
default    13:02:08.211987-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130612040> updateStateForPacket sampleOffset 593
default    13:02:08.212002-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetMuted: <0x10e65bae0|I/ELD.01> Muted: No
default    13:02:08.212069-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130612040> updateStateForPacket sampleSize 11996
default    13:02:08.212116-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_prepareWorkingItem2: [0x10e737160] P/WO posting PlayQueueBecameHungry
default    13:02:08.212151-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130612040> seekToPTS already at {0/1 = 0.000}
default    13:02:08.212260-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130612040> seekToPTS already at {0/1 = 0.000}
default    13:02:08.212400-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130612040> copyWithZone
default    13:02:08.212513-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131110730> init with pts/dts
default    13:02:08.212634-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.212785-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> seekToPTS already at {0/1000 = 0.000}
default    13:02:08.212902-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> readAPacketAndUpdateState
default    13:02:08.213042-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 12593, size: 4096, read: 4096
default    13:02:08.213150-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 16689, size: 5982, read: 5982
default    13:02:08.213241-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> updateStateForPacket Presentation Timestamp {33/1000 = 0.033}
default    13:02:08.213320-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> updateStateForPacket Decode Timestamp {33/1000 = 0.033}
default    13:02:08.213422-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.213507-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> updateStateForPacket sampleOffset 12611
default    13:02:08.213619-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> updateStateForPacket sampleSize 10056
default    13:02:08.213702-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> seekToPTS already at {33/1000 = 0.033}
default    13:02:08.213777-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130612040> created copy <LibAVSampleCursor: 0x131110730>
default    13:02:08.213839-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131110730> copyWithZone
default    13:02:08.213884-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131013ae0> init with pts/dts
default    13:02:08.213970-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.214056-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013ae0> seekToPTS already at {33/1000 = 0.033}
default    13:02:08.215374-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013ae0> updateStateForPacket Decode Timestamp {133/1000 = 0.133}
default    13:02:08.215403-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013ae0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.215457-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013ae0> updateStateForPacket sampleOffset 42941
default    13:02:08.215497-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013ae0> updateStateForPacket sampleSize 10113
default    13:02:08.215516-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131110730> stepInDecodeOrderByCount  1
default    13:02:08.215572-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> readAPacketAndUpdateState
default    13:02:08.215612-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 53058, size: 4096, read: 4096
default    13:02:08.215662-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 57154, size: 6118, read: 6118
default    13:02:08.215713-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> updateStateForPacket Presentation Timestamp {167/1000 = 0.167}
default    13:02:08.215778-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> updateStateForPacket Decode Timestamp {167/1000 = 0.167}
default    13:02:08.215883-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.215970-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> updateStateForPacket sampleOffset 53076
default    13:02:08.216032-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131110730> updateStateForPacket sampleSize 10192
default    13:02:08.216233-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130612040> copyWithZone
default    13:02:08.216257-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130613ad0> init with pts/dts
default    13:02:08.216273-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.216295-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> seekToPTS already at {0/1000 = 0.000}
default    13:02:08.216314-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> readAPacketAndUpdateState
default    13:02:08.216386-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 63272, size: 4096, read: 4096
default    13:02:08.216445-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 67368, size: 6007, read: 6007
default    13:02:08.216523-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> updateStateForPacket Presentation Timestamp {200/1000 = 0.200}
default    13:02:08.216569-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> updateStateForPacket Decode Timestamp {200/1000 = 0.200}
default    13:02:08.216593-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.216649-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> updateStateForPacket sampleOffset 63290
default    13:02:08.216732-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> updateStateForPacket sampleSize 10081
default    13:02:08.216787-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> seekToPTS already at {200/1000 = 0.200}
default    13:02:08.216847-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130612040> created copy <LibAVSampleCursor: 0x130613ad0>
default    13:02:08.216926-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130613ad0> stepInDecodeOrderByCount  1
default    13:02:08.216986-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> readAPacketAndUpdateState
default    13:02:08.217062-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 73375, size: 4096, read: 4096
default    13:02:08.217147-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 77471, size: 6079, read: 6079
default    13:02:08.217206-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> updateStateForPacket Presentation Timestamp {233/1000 = 0.233}
default    13:02:08.217283-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> updateStateForPacket Decode Timestamp {233/1000 = 0.233}
default    13:02:08.217305-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.217382-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> updateStateForPacket sampleOffset 73393
default    13:02:08.217518-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130613ad0> updateStateForPacket sampleSize 10153
default    13:02:08.217596-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130613ad0> copyWithZone
default    13:02:08.217637-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f2d0> init with pts/dts
default    13:02:08.217700-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.217763-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> seekToPTS already at {233/1000 = 0.233}
default    13:02:08.217804-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> readAPacketAndUpdateState
default    13:02:08.217854-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 83550, size: 4096, read: 4096
default    13:02:08.217909-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 87646, size: 6082, read: 6082
default    13:02:08.217935-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> updateStateForPacket Presentation Timestamp {267/1000 = 0.267}
default    13:02:08.217987-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> updateStateForPacket Decode Timestamp {267/1000 = 0.267}
default    13:02:08.218004-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.218022-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> updateStateForPacket sampleOffset 83569
default    13:02:08.218058-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> updateStateForPacket sampleSize 10155
default    13:02:08.218096-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> seekToPTS already at {267/1000 = 0.267}
default    13:02:08.218113-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130613ad0> created copy <LibAVSampleCursor: 0x13060f2d0>
default    13:02:08.218133-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f2d0> copyWithZone
default    13:02:08.218175-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012f50> init with pts/dts
default    13:02:08.218195-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:08.218239-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> seekToPTS already at {267/1000 = 0.267}
default    13:02:08.218259-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> readAPacketAndUpdateState
default    13:02:08.218285-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 93728, size: 4096, read: 4096
default    13:02:08.218305-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 97824, size: 6038, read: 6038
default    13:02:08.218336-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket Presentation Timestamp {300/1000 = 0.300}
default    13:02:08.218400-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket Decode Timestamp {300/1000 = 0.300}
default    13:02:08.218424-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.218449-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket sampleOffset 93747
default    13:02:08.218478-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket sampleSize 10111
default    13:02:08.218522-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> seekToPTS already at {300/1000 = 0.300}
default    13:02:08.218540-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f2d0> created copy <LibAVSampleCursor: 0x131012f50>
default    13:02:08.218560-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012f50> stepInDecodeOrderByCount  1
default    13:02:08.218607-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> readAPacketAndUpdateState
default    13:02:08.218663-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 103862, size: 4096, read: 4096
default    13:02:08.218728-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 107958, size: 6069, read: 6069
default    13:02:08.218749-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket Presentation Timestamp {333/1000 = 0.333}
default    13:02:08.218767-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket Decode Timestamp {333/1000 = 0.333}
default    13:02:08.218786-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.218802-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket sampleOffset 103881
default    13:02:08.218818-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket sampleSize 10142
default    13:02:08.218849-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012f50> stepInDecodeOrderByCount  1
default    13:02:08.218892-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> readAPacketAndUpdateState
default    13:02:08.218909-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 114027, size: 4096, read: 4096
default    13:02:08.218926-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 118123, size: 6036, read: 6036
default    13:02:08.218945-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket Presentation Timestamp {367/1000 = 0.367}
default    13:02:08.218962-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket Decode Timestamp {367/1000 = 0.367}
default    13:02:08.218978-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.218993-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket sampleOffset 114046
default    13:02:08.219011-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012f50> updateStateForPacket sampleSize 10109
default    13:02:08.219049-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f2d0> stepInDecodeOrderByCount  1
default    13:02:08.219068-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> readAPacketAndUpdateState
default    13:02:08.219109-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 124159, size: 4096, read: 4096
default    13:02:08.219135-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 128255, size: 6026, read: 6026
default    13:02:08.219189-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> updateStateForPacket Presentation Timestamp {400/1000 = 0.400}
default    13:02:08.219209-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> updateStateForPacket Decode Timestamp {400/1000 = 0.400}
default    13:02:08.219259-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f2d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:08.220295-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_getNextPlaybackState: [0x10e737160] P/WO new playback state: Paused (Player) (playerRate: 0.000), WILL NOT update boss rate (nan), previous state: Paused, change reason: PlaythroughPredictionChanged, playthrough prediction: likely, options: None
default    13:02:08.220350-0400    LibAVExtensionHost    isPlaybackBufferEmpty: 0
default    13:02:08.220405-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_getNextPlaybackState: [0x10e737160] P/WO new playback state: Paused (Player) (playerRate: 0.000), WILL NOT update boss rate (nan), previous state: Paused, change reason: PlaythroughPredictionChanged, playthrough prediction: likely, options: None
default    13:02:08.221054-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] current status: 0 -> proposed status: 0
default    13:02:08.221088-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] isPictureInPictureProhibited: YES {
    isContentSourceSupported: YES
    isPictureInPicturePossible: YES
    isSystemPictureInPicturePossible: YES
    allowsPictureInPicturePlayback: NO
    isPlayingOnSecondScreen: NO
    sourceIsVisible: YES
    contentDimensions: (nan, nan)
    isPictureInPictureSupported: YES
}
default    13:02:08.221102-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] self.status != AVPictureInPictureControllerStatusProhibited NO
default    13:02:08.221304-0400    LibAVExtensionHost    SeekableTimeRanges changed {nan, nan} -> {0.000000, 20.000000}.
default    13:02:08.222399-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] current status: 0 -> proposed status: 0
default    13:02:08.222429-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] isPictureInPictureProhibited: YES {
    isContentSourceSupported: YES
    isPictureInPicturePossible: YES
    isSystemPictureInPicturePossible: YES
    allowsPictureInPicturePlayback: NO
    isPlayingOnSecondScreen: NO
    sourceIsVisible: YES
    contentDimensions: (nan, nan)
    isPictureInPictureSupported: YES
}
default    13:02:08.222449-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] self.status != AVPictureInPictureControllerStatusProhibited NO
error    13:02:08.223893-0400    LibAVExtensionHost    cannot open file at line 49425 of [1b37c146ee]
error    13:02:08.223925-0400    LibAVExtensionHost    os_unix.c:49425: (2) open(/private/var/db/DetachedSignatures) - No such file or directory
default    13:02:08.239152-0400    LibAVExtensionHost    -[AVDesktopPlaybackContentContainerView setContentDisplayType:] contentDisplayType - 5
default    13:02:08.239166-0400    LibAVExtensionHost    -[AVDesktopPlaybackContentContainerView _updateActiveContentDisplayTypeIfNeeded] activeContentDisplayType - 5
default    13:02:08.239197-0400    LibAVExtensionHost    Certificate trust validation failed requirements with message: code failed to satisfy specified code requirement(s) (-67050)
default    13:02:08.239311-0400    LibAVExtensionHost    [0x118017f20] activating connection: mach=true listener=false peer=false name=com.apple.UsageTrackingAgent
default    13:02:08.239624-0400    LibAVExtensionHost    <<<< VMC >>>> vmc2GMFigLogDumpStats: VMC(0x10e8d5000): client pid 79879; timebase time: 0.000 s rate: 0.00. recent stats: cfq empty: 1 times; frames decoded: 1, dropped: 0; decode: mean 0.003 s, max: 0.003 s; codec service tier: 0.
default    13:02:08.239629-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] current status: 0 -> proposed status: 0
default    13:02:08.239639-0400    LibAVExtensionHost    <<<< VMC >>>> vmc2GMFigLogDumpStats: VMC(0x10e8d5000):Snapshots:
CodecType: avc1 (HW decoder), DecodedPixelBuffer: &8v0, 1920 x 1080
Last Decoded Frames [
{PTS: 0.433 s, decode: 3.363 ms},
]
default    13:02:08.239650-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] isPictureInPictureProhibited: YES {
    isContentSourceSupported: YES
    isPictureInPicturePossible: YES
    isSystemPictureInPicturePossible: YES
    allowsPictureInPicturePlayback: NO
    isPlayingOnSecondScreen: NO
    sourceIsVisible: YES
    contentDimensions: (1920.0, 1080.0)
    isPictureInPictureSupported: YES
}
default    13:02:08.239662-0400    LibAVExtensionHost    -[AVPictureInPicturePlatformAdapter(Common) _updateStatusUsingProposedStatus:] self.status != AVPictureInPictureControllerStatusProhibited NO
default    13:02:08.241980-0400    LibAVExtensionHost    <<<< AVAssetInspectorLoader >>>> -[AVFigAssetInspectorLoader _invokeCompletionHandlerForLoadingBatches:]: Batch 0x600000370900: dispatching completion handler
default    13:02:08.242098-0400    LibAVExtensionHost    -[AVAssetTrack loadValuesAsynchronouslyForKeys:completionHandler:] invoked with unrecognized keys (
    "currentVideoTrack.preferredTransform"
).
default    13:02:08.245609-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_handleSetProperty: [0x10e737160] P/WO: kFigPlayerProperty_ClosedCaptionLayerBoundsUpdate: closedcaption layer(0) newBounds: x=122.444444, y=0.000000, w=623.111111, h=350.500000
default    13:02:08.245635-0400    LibAVExtensionHost    <<<< FigCaptionRendererAVFLayoutRegion >>>> basicLayout: No viewport size!
default    13:02:08.245651-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_handleSetProperty: [0x10e737160] P/WO: kFigPlayerProperty_ClosedCaptionLayerBoundsUpdate: closedcaption layer(0) newBounds: x=122.444444, y=0.000000, w=623.111111, h=350.500000
default    13:02:08.247061-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_DeferredFirstVideoFrameEnqueued: [0x10e737160|P/WO] <0x10f06b000|I/ELD.01> Received first video frame enqueued notification
default    13:02:08.247417-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_connectLayerSynchronizerToLayer: FigLayerSynchronizerSetLayerArraysWithDeferredTransaction: layersSubjectToImageQueueMediaTiming = (
    "<FigVideoLayer: 0x600000d7a250>"
), layersNotSubjectToImageQueueMediaTiming = (
)
default    13:02:08.247436-0400    LibAVExtensionHost    <<<< LayerSync >>>> FigLayerSynchronizerSetLayerArraysWithDeferredTransaction: (0x6000027fc000) set layersSubjectToImageQueueMediaTiming ((
    "<FigVideoLayer: 0x600000d7a250>"
)); layersNotSubjectToImageQueueMediaTiming ((
))
default    13:02:08.247472-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_handleReadyToDisplayVideoLatch: <0x10f06b000|I/ELD.01> Posting kFigPlaybackItemNotification_FirstVideoFrameEnqueued
default    13:02:08.247492-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_doingGapless: P/WO NO, because rate (0.0) is not 1.0
default    13:02:08.247500-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_scheduleVideoSlotAndVideoTargetConfigurationSwitchAndPossiblyStartBossForNextItem: Not doing gapless
default    13:02:08.248024-0400    LibAVExtensionHost    <<<< AVError >>>> AVLocalizedErrorWithUnderlyingOSStatus: Returning error (AVFoundationErrorDomain / -11800) status (-16505)
default    13:02:08.248352-0400    LibAVExtensionHost    <<<< AVError >>>> AVLocalizedErrorWithUnderlyingOSStatus: Returning error (AVFoundationErrorDomain / -11800) status (-16505)
default    13:02:08.248531-0400    LibAVExtensionHost    <<<< AVError >>>> AVLocalizedErrorWithUnderlyingOSStatus: Returning error (AVFoundationErrorDomain / -11800) status (-16505)
default    13:02:08.248666-0400    LibAVExtensionHost    <<<< AVError >>>> AVLocalizedErrorWithUnderlyingOSStatus: Returning error (AVFoundationErrorDomain / -11800) status (-16505)
default    13:02:08.248776-0400    LibAVExtensionHost    New asset: <AVURLAsset: 0x600000397000>
default    13:02:08.248828-0400    LibAVExtensionHost    <<<< AVError >>>> AVLocalizedErrorWithUnderlyingOSStatus: Returning error (AVFoundationErrorDomain / -11800) status (-16505)
default    13:02:08.248941-0400    LibAVExtensionHost    <<<< AVError >>>> AVLocalizedErrorWithUnderlyingOSStatus: Returning error (AVFoundationErrorDomain / -11800) status (-16505)
default    13:02:08.249077-0400    LibAVExtensionHost    -[AVPlayerController(AVMediaSelection) setAudioMediaSelectionOptions:] AudioMediaSelectionOptions: (
)
default    13:02:08.249159-0400    LibAVExtensionHost    -[AVPlayerController(AVMediaSelection) setLegibleMediaSelectionOptions:] LegibleMediaSelectionOptions: (
)
default    13:02:08.249185-0400    LibAVExtensionHost    <<<< AVError >>>> AVLocalizedErrorWithUnderlyingOSStatus: Returning error (AVFoundationErrorDomain / -11800) status (-16505)
default    13:02:08.249253-0400    LibAVExtensionHost    <<<< AVError >>>> AVLocalizedErrorWithUnderlyingOSStatus: Returning error (AVFoundationErrorDomain / -11800) status (-16505)
default    13:02:08.249329-0400    LibAVExtensionHost    <<<< AVError >>>> AVLocalizedErrorWithUnderlyingOSStatus: Returning error (AVFoundationErrorDomain / -11800) status (-16505)
default    13:02:08.249567-0400    LibAVExtensionHost    <<<< LayerSync >>>> figlayersync_getLayerDisplayLatency: layer 0x600000d7a250, context 0x6000001b84c0, displayID 1: latency 0.000
default    13:02:08.249578-0400    LibAVExtensionHost    <<<< LayerSync >>>> figlayersync_setLayerTiming: (layer 0x600000d7a250) only set layer timeOffset: 0.000000 at hostTime 220263.190500
default    13:02:08.254378-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_handleSetProperty: [0x10e737160] P/WO: kFigPlayerProperty_ClosedCaptionLayerBoundsUpdate: closedcaption layer(0) newBounds: x=122.444444, y=0.000000, w=623.111111, h=350.500000
default    13:02:08.501022-0400    LibAVExtensionHost    Processing Request: 1 - <VKCImageAnalyzerRequest: 0x600003cb8f00> 
 requestID: 1 
 madRequestID: (Not Set) 
 cancelled: NO 
 analysisTypes: Text,VisualSearch,ImageSegmentation 
 requestType: PixelBuffer 
 locales: (null) 
 barcodeSymbologies (null) 
 imageSize W: 1920.00 H: 1080.00 
 orientation: Up
default    13:02:08.501965-0400    LibAVExtensionHost    [0x10e743e30] activating connection: mach=true listener=false peer=false name=com.apple.mediaanalysisd.service.public
default    13:02:08.502202-0400    LibAVExtensionHost    Assigned madId: 1 to vkId: 1
default    13:02:08.785629-0400    LibAVExtensionHost    Completed MRC Parsing of 0 elements in 0.000001 seconds.
error    13:02:08.786006-0400    LibAVExtensionHost    VSGating: Could not get visual search result from MADService with Error Domain=VisualIntelligence.EligibilityError Code=0 "(null)"
default    13:02:08.786164-0400    LibAVExtensionHost    Request completed: <VKCImageAnalyzerRequest: 0x600003cb8f00> requestID: 1 madRequestID: 1 cancelled: NO
default    13:02:08.786225-0400    LibAVExtensionHost    Calling completion handler id: 1
Total Processing Time 285.27ms
Has Analysis: YES
TextLength: 0 DD: 0, MRC: 0, VS:0 
request: <VKCImageAnalyzerRequest: 0x600003cb8f00> requestID: 1 madRequestID: 1 cancelled: NO
Error: (null)
default    13:02:08.791163-0400    LibAVExtensionHost    Setting DDTypes: All, <VKCImageAnalysisBaseView: 0x10e7444a0> id: 0
default    13:02:08.791376-0400    LibAVExtensionHost    Setting Active Interaction Types: Text,DD, <VKCImageAnalysisBaseView: 0x10e7444a0> id: 0
default    13:02:08.792239-0400    LibAVExtensionHost    Setting Active Interaction Types: Text,Subject, <VKCImageAnalysisBaseView: 0x10e7444a0> id: 0
default    13:02:08.795969-0400    LibAVExtensionHost    Setting Analysis: <VKCImageAnalysisResult: 0x11f8739f0>, <VKCImageAnalysisBaseView: 0x10e7444a0> id: 1
error    13:02:08.829391-0400    LibAVExtensionHost    Visual isTranslatable: NO; reason: observation failure: noObservations
default    13:02:08.835421-0400    LibAVExtensionHost    Interaction does not want automaticContentsRectCalculation, but did not implement contentsRectFor...... Falling back to Unit Rect: <VKCImageAnalysisBaseView: 0x10e7444a0> id: 1
default    13:02:08.847918-0400    LibAVExtensionHost    Translation Check completed with result: NO, <VKCImageAnalysisBaseView: 0x10e7444a0> id: 1
default    13:02:08.847965-0400    LibAVExtensionHost    Check for is analysis all data detectors completed with result: YES, <VKCImageAnalysisBaseView: 0x10e7444a0> id: 1
default    13:02:09.639048-0400    LibAVExtensionHost    -[AVPlayerController togglePlayback:] setPlaying:YES
default    13:02:09.639247-0400    LibAVExtensionHost    -[AVPlayerController setPlaying:] 1
default    13:02:09.639583-0400    LibAVExtensionHost    -[AVPlayerController _queuePlayer] queuePlayer: 0
default    13:02:09.649198-0400    LibAVExtensionHost    -[AVPlayerController _playAtRate:] 1.0 on 0x6000001b87e0
default    13:02:09.649374-0400    LibAVExtensionHost    <<<< AVPlayer >>>> -[AVPlayer _setRate:rateChangeReason:figPlayerSetRateHandler:]_block_invoke: P/WO setting timeControlStatus=1, reasonForWaitingToPlay=AVPlayerWaitingWhileEvaluatingBufferingRateReason
default    13:02:09.649461-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_getNextPlaybackState: [0x10e737160] P/WO new playback state: Playing (Player) (playerRate: 1.000), NEED TO update boss rate (1.000), previous state: Paused, change reason: ClientInitiated, playthrough prediction: likely, options: None
default    13:02:09.649497-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_setBossRateWithFade: [0x10e737160] P/WO called, new rate = 1.000, previous rate = 0.000, fadeDuration = nan, itemTime nan, hostClockTime nan (now 220264.590 + nan)
default    13:02:09.649513-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_applySoftwareVolume: [0x10e737160] P/WO rp: NULL, propertyName = SoftwareVolume1, targetVolume = 0.00, rampDuration = 0.00, synchronous = YES
default    13:02:09.649524-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_applySoftwareVolume: [0x10e737160] P/WO can't apply volume, no audio render pipeline
default    13:02:09.649535-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_applySoftwareVolume: [0x10e737160] P/WO rp: NULL, propertyName = SoftwareVolume5, targetVolume = 1.00, rampDuration = 0.00, synchronous = YES
default    13:02:09.649544-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_applySoftwareVolume: [0x10e737160] P/WO can't apply volume, no audio render pipeline
default    13:02:09.649612-0400    LibAVExtensionHost    <<<< Alt >>>> FPSupport_GetDisplayRefreshInformation: new found display(1) with current mode (<CGDisplayMode 0x6000003ccc00> [{
    BitsPerPixel = 32;
    BitsPerSample = 10;
    DepthFormat = 8;
    Height = 1329;
    IODisplayModeID = 72;
    IOFlags = 3;
    Mode = 72;
    PixelEncoding = "--RRRRRRRRRRGGGGGGGGGGBBBBBBBBBB";
    RefreshRate = 120;
    SamplesPerPixel = 3;
    UsableForDesktopGUI = 1;
    Width = 2056;
    kCGDisplayBytesPerRow = 16448;
    kCGDisplayHorizontalResolution = 303;
    kCGDisplayModeIsInterlaced = 0;
    kCGDisplayModeIsSafeForHardware = 1;
    kCGDisplayModeIsStretched = 0;
    kCGDisplayModeIsTelevisionOutput = 0;
    kCGDisplayModeIsUnavailable = 0;
    kCGDisplayModeSuitableForUI = 1;
    kCGDisplayPixelsHigh = 2658;
    kCGDisplayPixelsWide = 4112;
    kCGDisplayResolution = 2;
    kCGDisplayVerticalResolution = 303;
}] ) having a refresh rate(120.000000)
default    13:02:09.649632-0400    LibAVExtensionHost    <<<< Alt >>>> FPSupport_GetDisplayRefreshInformation: displayMaxRefreshInterval:1/120 displayMinRefreshInterval:1/120 displayRefreshStep:0/0
default    13:02:09.649652-0400    LibAVExtensionHost    <<<< Boss >>>> FigPlaybackBossSetRateAndAnchorTime: <0x10e65bae0|I/ELD.01> called, newRate = 1.000, itemTime = nan, hostClockTime = nan = now (220264.591) + nan
default    13:02:09.649665-0400    LibAVExtensionHost    <<<< Boss >>>> bossScheduleReachedEndCallbackForTime: <0x10e65bae0|I/ELD.01> called, endTime = nan
default    13:02:09.649710-0400    LibAVExtensionHost    <<<< Boss >>>> bossScheduleAdvanceForOverlappedPlaybackCallbackForTime: <0x10e65bae0|I/ELD.01> called, advanceTime = nan
default    13:02:09.649735-0400    LibAVExtensionHost    <<<< Boss >>>> bossConfigureRatePlan: requested rate 1.000 => will use audio time compression rate 1.000, timebase rate 1.000, NON-snippetised playback
default    13:02:09.649749-0400    LibAVExtensionHost    <<<< Boss >>>> figPlaybackBossSetRateToNonZero: <0x10e65bae0|I/ELD.01> last preroll is not compatible: no previous preroll
default    13:02:09.649794-0400    LibAVExtensionHost    <<<< Boss >>>> figPlaybackBossStartPrerollAndSetPlayState: <0x10e65bae0|I/ELD.01> called, prerollRate == 1.000, itemTime = nan, hostClockTime = nan, prerollTime = nan, useSnippetPlayback = NO, currentTimebaseTime == 0.000, newPlayState = PrerollingWillPlay
default    13:02:09.649821-0400    LibAVExtensionHost    <<<< Boss >>>> bossSetMentorModesToForwardPlayback: <0x10e65bae0|I/ELD.01> called, tracks 0...0, start time 0.000, end time nan, rate 1.00, previousOutputDisposition=3
default    13:02:09.649836-0400    LibAVExtensionHost    <<<< Boss >>>> bossTrackShouldRemoveExcessFramesInRefreshIntervals: track 1: minFrameDuration nan >= droppableFrameMinimumInterval 0.008333 * maxEditRate 1.00 * playRate 1.00 * 0.7 (0.006) => DO NOT remove excess frames
default    13:02:09.649882-0400    LibAVExtensionHost    <<<< Boss >>>> figPlaybackBossSetRateToNonZero: <0x10e65bae0|I/ELD.01> playState set to PrerollingWillPlay
default    13:02:09.649897-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_applySoftwareVolume: [0x10e737160] P/WO rp: NULL, propertyName = SoftwareVolume1, targetVolume = 1.00, rampDuration = 0.00, synchronous = NO
default    13:02:09.649960-0400    LibAVExtension    LibAVTrackReader generateSampleCursorAtPresentationTimeStamp {0/1 = 0.000}
default    13:02:09.649909-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_applySoftwareVolume: [0x10e737160] P/WO can't apply volume, no audio render pipeline
default    13:02:09.650021-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> init
default    13:02:09.649940-0400    LibAVExtensionHost    <<<< FigPlayer_AP >>>> playerairplay_setRateCommon: [0x118007e20] P/WO Changing airplayRate 0.000 -> 1.000
default    13:02:09.650047-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.650084-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> seekToPTS {0/1 = 0.000}
default    13:02:09.650134-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> readAPacketAndUpdateState
default    13:02:09.650170-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 575, size: 4096, read: 4096
default    13:02:09.650197-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4671, size: 7922, read: 7922
default    13:02:09.650275-0400    LibAVExtensionHost    Setting Analysis: (null), <VKCImageAnalysisBaseView: 0x10e7444a0> id: 0
default    13:02:09.650263-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> updateStateForPacket Presentation Timestamp {0/1000 = 0.000}
default    13:02:09.650288-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> updateStateForPacket Decode Timestamp {0/1000 = 0.000}
default    13:02:09.650311-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.650332-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> updateStateForPacket sampleOffset 593
default    13:02:09.650353-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> updateStateForPacket sampleSize 11996
default    13:02:09.650376-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> seekToPTS already at {0/1 = 0.000}
default    13:02:09.650397-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> seekToPTS already at {0/1 = 0.000}
default    13:02:09.650450-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> copyWithZone
default    13:02:09.650473-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f0a0> init with pts/dts
default    13:02:09.650841-0400    LibAVExtensionHost    Rate changed to: 1.000000
default    13:02:09.650490-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.650875-0400    LibAVExtensionHost    Time control status = 1
default    13:02:09.650590-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> seekToPTS already at {0/1000 = 0.000}
default    13:02:09.650630-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> readAPacketAndUpdateState
default    13:02:09.650701-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 12593, size: 4096, read: 4096
default    13:02:09.651108-0400    LibAVExtensionHost    <<<< AVPlayer >>>> avplayer_fpNotificationCallback_block_invoke: P/WO setting timeControlStatus=2, reasonForWaitingToPlay=(null)
default    13:02:09.650787-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 16689, size: 5982, read: 5982
default    13:02:09.651134-0400    LibAVExtensionHost    Time control status = 2
default    13:02:09.650885-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> updateStateForPacket Presentation Timestamp {33/1000 = 0.033}
default    13:02:09.651232-0400    LibAVExtensionHost    [MRNowPlaying] MRMediaRemoteSetCanBeNowPlayingApplication set to YES
default    13:02:09.650914-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> updateStateForPacket Decode Timestamp {33/1000 = 0.033}
default    13:02:09.650939-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.651005-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> updateStateForPacket sampleOffset 12611
default    13:02:09.651434-0400    LibAVExtensionHost    [NowPlayingInfo] Setting nowPlayingInfo with mergePolicy Replace: <NSCFDictionary 0x60000035e6c0 {
    kMRMediaRemoteNowPlayingInfoTimestamp = 2024-08-03 17:02:09 +0000
    kMRMediaRemoteNowPlayingInfoDuration = 20
    kMRMediaRemoteNowPlayingInfoElapsedTime = 0
    kMRMediaRemoteNowPlayingInfoContentItemIdentifier = A82F3484-33B6-4905-AB59-F0FB9537840E
    kMRMediaRemoteNowPlayingInfoPlaybackRate = 1
    kMRMediaRemoteNowPlayingInfoAssetURL = file:///Users/vade/output.mkv
    kMRMediaRemoteNowPlayingInfoMediaType = kMRMediaRemoteNowPlayingInfoTypeVideo
}>
default    13:02:09.651108-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> updateStateForPacket sampleSize 10056
default    13:02:09.651449-0400    LibAVExtensionHost    [NowPlayingInfo] Setting nowPlayingInfo artwork: (null)
default    13:02:09.651160-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> seekToPTS already at {33/1000 = 0.033}
default    13:02:09.651640-0400    LibAVExtensionHost    PlaybackQueueInvalidation: NowPlayingItem for origin-Mac-1280262988/client-info.vade.LibAVExtensionHost-79879/player-MediaRemote-DefaultPlayer changed from
 item:<(null)>
 -> 
item:<A82F3484-33B6-4905-AB59-F0FB9537840E/CalculatedPlaybackPosition: 0.000323/PlaybackRate: 1.000000>
default    13:02:09.651182-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> created copy <LibAVSampleCursor: 0x13060f0a0>
default    13:02:09.651257-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f0a0> copyWithZone
default    13:02:09.651319-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060e760> init with pts/dts
default    13:02:09.651422-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.651515-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> seekToPTS already at {33/1000 = 0.033}
default    13:02:09.651597-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> readAPacketAndUpdateState
default    13:02:09.651736-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 22671, size: 4096, read: 4096
default    13:02:09.651840-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 26767, size: 6014, read: 6014
default    13:02:09.651946-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket Presentation Timestamp {67/1000 = 0.067}
default    13:02:09.651989-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket Decode Timestamp {67/1000 = 0.067}
default    13:02:09.652054-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.652165-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket sampleOffset 22689
default    13:02:09.652273-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket sampleSize 10088
default    13:02:09.652368-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> seekToPTS already at {67/1000 = 0.067}
default    13:02:09.652440-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f0a0> created copy <LibAVSampleCursor: 0x13060e760>
default    13:02:09.652504-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060e760> stepInDecodeOrderByCount  1
default    13:02:09.652549-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> readAPacketAndUpdateState
default    13:02:09.652632-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 32781, size: 4096, read: 4096
default    13:02:09.652750-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 36877, size: 6046, read: 6046
default    13:02:09.652868-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket Presentation Timestamp {100/1000 = 0.100}
default    13:02:09.652949-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket Decode Timestamp {100/1000 = 0.100}
default    13:02:09.653070-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.653120-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket sampleOffset 32799
default    13:02:09.653172-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket sampleSize 10120
default    13:02:09.653245-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060e760> stepInDecodeOrderByCount  1
default    13:02:09.653314-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> readAPacketAndUpdateState
default    13:02:09.653393-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 42923, size: 4096, read: 4096
default    13:02:09.653476-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 47019, size: 6039, read: 6039
default    13:02:09.653573-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket Presentation Timestamp {133/1000 = 0.133}
default    13:02:09.653646-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket Decode Timestamp {133/1000 = 0.133}
default    13:02:09.653750-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.653863-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket sampleOffset 42941
default    13:02:09.654036-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e760> updateStateForPacket sampleSize 10113
default    13:02:09.654411-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f0a0> stepInDecodeOrderByCount  1
default    13:02:09.654619-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> readAPacketAndUpdateState
default    13:02:09.654947-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 53058, size: 4096, read: 4096
default    13:02:09.655098-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 57154, size: 6118, read: 6118
default    13:02:09.655232-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> updateStateForPacket Presentation Timestamp {167/1000 = 0.167}
default    13:02:09.655368-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> updateStateForPacket Decode Timestamp {167/1000 = 0.167}
default    13:02:09.655455-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.655513-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> updateStateForPacket sampleOffset 53076
default    13:02:09.655566-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f0a0> updateStateForPacket sampleSize 10192
default    13:02:09.655771-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> copyWithZone
default    13:02:09.655796-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f080> init with pts/dts
default    13:02:09.655901-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.656047-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> seekToPTS already at {0/1000 = 0.000}
default    13:02:09.656141-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> readAPacketAndUpdateState
default    13:02:09.656251-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 63272, size: 4096, read: 4096
default    13:02:09.656377-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 67368, size: 6007, read: 6007
default    13:02:09.656485-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> updateStateForPacket Presentation Timestamp {200/1000 = 0.200}
default    13:02:09.656596-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> updateStateForPacket Decode Timestamp {200/1000 = 0.200}
default    13:02:09.656680-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.656785-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> updateStateForPacket sampleOffset 63290
default    13:02:09.656905-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> updateStateForPacket sampleSize 10081
default    13:02:09.657021-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> seekToPTS already at {200/1000 = 0.200}
default    13:02:09.657100-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> created copy <LibAVSampleCursor: 0x13060f080>
default    13:02:09.657218-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f080> stepInDecodeOrderByCount  1
default    13:02:09.657341-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> readAPacketAndUpdateState
default    13:02:09.657527-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 73375, size: 4096, read: 4096
default    13:02:09.657696-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 77471, size: 6079, read: 6079
default    13:02:09.657864-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> updateStateForPacket Presentation Timestamp {233/1000 = 0.233}
default    13:02:09.657998-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> updateStateForPacket Decode Timestamp {233/1000 = 0.233}
default    13:02:09.658111-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.658236-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> updateStateForPacket sampleOffset 73393
default    13:02:09.658346-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f080> updateStateForPacket sampleSize 10153
default    13:02:09.658469-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f080> copyWithZone
default    13:02:09.658495-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112100> init with pts/dts
default    13:02:09.658566-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.658648-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> seekToPTS already at {233/1000 = 0.233}
default    13:02:09.658720-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> readAPacketAndUpdateState
default    13:02:09.658821-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 83550, size: 4096, read: 4096
default    13:02:09.658912-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 87646, size: 6082, read: 6082
default    13:02:09.659013-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> updateStateForPacket Presentation Timestamp {267/1000 = 0.267}
default    13:02:09.659101-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> updateStateForPacket Decode Timestamp {267/1000 = 0.267}
default    13:02:09.659183-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.659265-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> updateStateForPacket sampleOffset 83569
default    13:02:09.659384-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> updateStateForPacket sampleSize 10155
default    13:02:09.659446-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> seekToPTS already at {267/1000 = 0.267}
default    13:02:09.659524-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f080> created copy <LibAVSampleCursor: 0x131112100>
default    13:02:09.659660-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112100> copyWithZone
default    13:02:09.659745-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112440> init with pts/dts
default    13:02:09.659832-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.659954-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> seekToPTS already at {267/1000 = 0.267}
default    13:02:09.660049-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> readAPacketAndUpdateState
default    13:02:09.660144-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 93728, size: 4096, read: 4096
default    13:02:09.660295-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 97824, size: 6038, read: 6038
default    13:02:09.660418-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket Presentation Timestamp {300/1000 = 0.300}
default    13:02:09.660536-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket Decode Timestamp {300/1000 = 0.300}
default    13:02:09.660686-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.660866-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket sampleOffset 93747
default    13:02:09.661062-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket sampleSize 10111
default    13:02:09.661206-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> seekToPTS already at {300/1000 = 0.300}
default    13:02:09.661299-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112100> created copy <LibAVSampleCursor: 0x131112440>
default    13:02:09.661402-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112440> stepInDecodeOrderByCount  1
default    13:02:09.661498-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> readAPacketAndUpdateState
default    13:02:09.661636-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 103862, size: 4096, read: 4096
default    13:02:09.661727-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 107958, size: 6069, read: 6069
default    13:02:09.661823-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket Presentation Timestamp {333/1000 = 0.333}
default    13:02:09.661925-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket Decode Timestamp {333/1000 = 0.333}
default    13:02:09.662060-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.662156-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket sampleOffset 103881
default    13:02:09.662257-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket sampleSize 10142
default    13:02:09.662373-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112440> stepInDecodeOrderByCount  1
default    13:02:09.662576-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> readAPacketAndUpdateState
default    13:02:09.662796-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 114027, size: 4096, read: 4096
default    13:02:09.663161-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 118123, size: 6036, read: 6036
default    13:02:09.663482-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket Presentation Timestamp {367/1000 = 0.367}
default    13:02:09.663839-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket Decode Timestamp {367/1000 = 0.367}
default    13:02:09.664088-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.664557-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket sampleOffset 114046
default    13:02:09.664962-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112440> updateStateForPacket sampleSize 10109
default    13:02:09.665266-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112100> stepInDecodeOrderByCount  1
default    13:02:09.665550-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> readAPacketAndUpdateState
default    13:02:09.665970-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 124159, size: 4096, read: 4096
default    13:02:09.666349-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 128255, size: 6026, read: 6026
default    13:02:09.666755-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> updateStateForPacket Presentation Timestamp {400/1000 = 0.400}
default    13:02:09.667114-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> updateStateForPacket Decode Timestamp {400/1000 = 0.400}
default    13:02:09.667540-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.667884-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> updateStateForPacket sampleOffset 124178
default    13:02:09.668224-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112100> updateStateForPacket sampleSize 10099
error    13:02:09.668636-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.669053-0400    LibAVExtensionHost    <<<< VideoMentor >>>> videoMentorThreadForwardPlayback: (0x10e65be40) startCursor PTS 0.033 > target startPTS 0.000; sending timestamp interval for that gap
default    13:02:09.669461-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130612040> copyWithZone
default    13:02:09.669488-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012eb0> init with pts/dts
default    13:02:09.669790-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.670192-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> seekToPTS already at {433/1000 = 0.433}
default    13:02:09.670530-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> readAPacketAndUpdateState
default    13:02:09.670909-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 134281, size: 4096, read: 4096
default    13:02:09.671248-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 138377, size: 6110, read: 6110
default    13:02:09.671587-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Presentation Timestamp {433/1000 = 0.433}
default    13:02:09.671937-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Decode Timestamp {433/1000 = 0.433}
default    13:02:09.672322-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.672672-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket sampleOffset 134300
default    13:02:09.673111-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket sampleSize 10183
default    13:02:09.673475-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> seekToPTS already at {433/1000 = 0.433}
default    13:02:09.673919-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130612040> created copy <LibAVSampleCursor: 0x131012eb0>
default    13:02:09.674355-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012eb0> stepInPresentationOrderByCount 1
default    13:02:09.674709-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> readAPacketAndUpdateState
default    13:02:09.675072-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 144487, size: 4096, read: 4096
default    13:02:09.675436-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 148583, size: 6119, read: 6119
default    13:02:09.675826-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Presentation Timestamp {467/1000 = 0.467}
default    13:02:09.676093-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Decode Timestamp {467/1000 = 0.467}
default    13:02:09.676415-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.676759-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket sampleOffset 144506
default    13:02:09.677104-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket sampleSize 10192
default    13:02:09.677419-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012eb0> copyWithZone
default    13:02:09.677700-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071c270> init with pts/dts
default    13:02:09.678026-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.678309-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> seekToPTS already at {467/1000 = 0.467}
default    13:02:09.678666-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> readAPacketAndUpdateState
default    13:02:09.679008-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 154702, size: 4096, read: 4096
default    13:02:09.679445-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 158798, size: 5997, read: 5997
default    13:02:09.679792-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> updateStateForPacket Presentation Timestamp {500/1000 = 0.500}
default    13:02:09.680113-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> updateStateForPacket Decode Timestamp {500/1000 = 0.500}
default    13:02:09.680524-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.680877-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> updateStateForPacket sampleOffset 154721
default    13:02:09.681190-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> updateStateForPacket sampleSize 10070
default    13:02:09.681480-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> seekToPTS already at {500/1000 = 0.500}
default    13:02:09.681763-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012eb0> created copy <LibAVSampleCursor: 0x13071c270>
default    13:02:09.682075-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071c270> copyWithZone
default    13:02:09.682415-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112340> init with pts/dts
default    13:02:09.682744-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.683056-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> seekToPTS already at {500/1000 = 0.500}
default    13:02:09.683294-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> readAPacketAndUpdateState
default    13:02:09.683577-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 164795, size: 4096, read: 4096
default    13:02:09.683917-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 168891, size: 6075, read: 6075
default    13:02:09.684292-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Presentation Timestamp {533/1000 = 0.533}
default    13:02:09.684700-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Decode Timestamp {533/1000 = 0.533}
default    13:02:09.685076-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.685404-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket sampleOffset 164814
default    13:02:09.685745-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket sampleSize 10148
default    13:02:09.686062-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> seekToPTS already at {533/1000 = 0.533}
default    13:02:09.686372-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071c270> created copy <LibAVSampleCursor: 0x131112340>
default    13:02:09.686676-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112340> stepInDecodeOrderByCount  1
default    13:02:09.686959-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> readAPacketAndUpdateState
default    13:02:09.687304-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 174966, size: 4096, read: 4096
default    13:02:09.687694-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 179062, size: 6059, read: 6059
default    13:02:09.688093-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Presentation Timestamp {567/1000 = 0.567, rounded}
default    13:02:09.688477-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Decode Timestamp {567/1000 = 0.567, rounded}
default    13:02:09.688838-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.689197-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket sampleOffset 174985
default    13:02:09.689558-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket sampleSize 10132
default    13:02:09.689901-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112340> stepInDecodeOrderByCount  1
default    13:02:09.690284-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> readAPacketAndUpdateState
default    13:02:09.690576-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 185121, size: 4096, read: 4096
default    13:02:09.690933-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 189217, size: 6050, read: 6050
default    13:02:09.691266-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Presentation Timestamp {600/1000 = 0.600}
default    13:02:09.691510-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Decode Timestamp {600/1000 = 0.600}
default    13:02:09.691781-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.691975-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket sampleOffset 185140
default    13:02:09.692133-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket sampleSize 10123
default    13:02:09.692331-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071c270> stepInDecodeOrderByCount  1
default    13:02:09.692506-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> readAPacketAndUpdateState
default    13:02:09.692656-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 195267, size: 4096, read: 4096
default    13:02:09.692796-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 199363, size: 6094, read: 6094
default    13:02:09.693002-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> updateStateForPacket Presentation Timestamp {633/1000 = 0.633}
default    13:02:09.693190-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> updateStateForPacket Decode Timestamp {633/1000 = 0.633}
default    13:02:09.693423-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.693711-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> updateStateForPacket sampleOffset 195286
default    13:02:09.694040-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071c270> updateStateForPacket sampleSize 10167
default    13:02:09.694586-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> copyWithZone
default    13:02:09.694758-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012eb0> init with pts/dts
default    13:02:09.695127-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.695450-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> seekToPTS already at {0/1000 = 0.000}
default    13:02:09.695766-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> readAPacketAndUpdateState
default    13:02:09.696105-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 205457, size: 4096, read: 4096
default    13:02:09.696590-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 209553, size: 6001, read: 6001
default    13:02:09.697047-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Presentation Timestamp {667/1000 = 0.667}
default    13:02:09.697391-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Decode Timestamp {667/1000 = 0.667}
default    13:02:09.697771-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.698133-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket sampleOffset 205476
default    13:02:09.698477-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket sampleSize 10074
default    13:02:09.698869-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> seekToPTS already at {667/1000 = 0.667}
default    13:02:09.699263-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> created copy <LibAVSampleCursor: 0x131012eb0>
default    13:02:09.699589-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012eb0> stepInPresentationOrderByCount 1
default    13:02:09.699963-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> readAPacketAndUpdateState
default    13:02:09.700248-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 215554, size: 4096, read: 4096
default    13:02:09.700596-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 219650, size: 6009, read: 6009
default    13:02:09.700876-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Presentation Timestamp {700/1000 = 0.700, rounded}
default    13:02:09.701164-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Decode Timestamp {700/1000 = 0.700, rounded}
default    13:02:09.701415-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.701687-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket sampleOffset 215573
default    13:02:09.702006-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131012eb0> updateStateForPacket sampleSize 10082
default    13:02:09.702358-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012eb0> copyWithZone
default    13:02:09.702609-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112d30> init with pts/dts
default    13:02:09.702904-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.703255-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> seekToPTS already at {700/1000 = 0.700, rounded}
default    13:02:09.703629-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> readAPacketAndUpdateState
default    13:02:09.703957-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 225659, size: 4096, read: 4096
default    13:02:09.704292-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 229755, size: 6009, read: 6009
default    13:02:09.704590-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> updateStateForPacket Presentation Timestamp {733/1000 = 0.733}
default    13:02:09.704911-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> updateStateForPacket Decode Timestamp {733/1000 = 0.733}
default    13:02:09.705229-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.705513-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> updateStateForPacket sampleOffset 225678
default    13:02:09.705806-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> updateStateForPacket sampleSize 10082
default    13:02:09.706095-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> seekToPTS already at {733/1000 = 0.733}
default    13:02:09.706413-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012eb0> created copy <LibAVSampleCursor: 0x131112d30>
default    13:02:09.706681-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112d30> copyWithZone
default    13:02:09.706948-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611c50> init with pts/dts
default    13:02:09.707176-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.707456-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> seekToPTS already at {733/1000 = 0.733}
default    13:02:09.707653-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> readAPacketAndUpdateState
default    13:02:09.707928-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 235764, size: 4096, read: 4096
default    13:02:09.708177-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 239860, size: 6057, read: 6057
default    13:02:09.708448-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Presentation Timestamp {767/1000 = 0.767}
default    13:02:09.708700-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Decode Timestamp {767/1000 = 0.767}
default    13:02:09.708879-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.709150-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleOffset 235783
default    13:02:09.709366-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleSize 10130
default    13:02:09.709589-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> seekToPTS already at {767/1000 = 0.767}
default    13:02:09.709815-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112d30> created copy <LibAVSampleCursor: 0x130611c50>
default    13:02:09.710076-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611c50> stepInDecodeOrderByCount  1
default    13:02:09.710295-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> readAPacketAndUpdateState
default    13:02:09.710542-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 245917, size: 4096, read: 4096
default    13:02:09.710728-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 250013, size: 6043, read: 6043
default    13:02:09.710971-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Presentation Timestamp {800/1000 = 0.800}
default    13:02:09.711186-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Decode Timestamp {800/1000 = 0.800}
default    13:02:09.711397-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.711651-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleOffset 245936
default    13:02:09.711890-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleSize 10116
default    13:02:09.712172-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611c50> stepInDecodeOrderByCount  1
default    13:02:09.712346-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> readAPacketAndUpdateState
default    13:02:09.712560-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 256056, size: 4096, read: 4096
default    13:02:09.712790-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 260152, size: 6022, read: 6022
default    13:02:09.712982-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Presentation Timestamp {833/1000 = 0.833}
default    13:02:09.713159-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Decode Timestamp {833/1000 = 0.833}
default    13:02:09.713335-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.713536-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleOffset 256075
default    13:02:09.713748-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleSize 10095
default    13:02:09.713923-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112d30> stepInDecodeOrderByCount  1
default    13:02:09.714082-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> readAPacketAndUpdateState
default    13:02:09.714252-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 266174, size: 4096, read: 4096
default    13:02:09.714394-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 270270, size: 5998, read: 5998
default    13:02:09.714517-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> updateStateForPacket Presentation Timestamp {867/1000 = 0.867}
default    13:02:09.714648-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> updateStateForPacket Decode Timestamp {867/1000 = 0.867}
default    13:02:09.714799-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.714947-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> updateStateForPacket sampleOffset 266193
default    13:02:09.715065-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112d30> updateStateForPacket sampleSize 10071
default    13:02:09.715293-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012eb0> copyWithZone
default    13:02:09.715313-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060ed30> init with pts/dts
default    13:02:09.715409-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.715514-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> seekToPTS already at {700/1000 = 0.700, rounded}
default    13:02:09.715590-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> readAPacketAndUpdateState
default    13:02:09.715692-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 276268, size: 4096, read: 4096
default    13:02:09.715776-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 280364, size: 6006, read: 6006
default    13:02:09.715862-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> updateStateForPacket Presentation Timestamp {900/1000 = 0.900}
default    13:02:09.715958-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> updateStateForPacket Decode Timestamp {900/1000 = 0.900}
default    13:02:09.716037-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.716104-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> updateStateForPacket sampleOffset 276287
default    13:02:09.716170-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> updateStateForPacket sampleSize 10079
default    13:02:09.716243-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> seekToPTS already at {900/1000 = 0.900}
default    13:02:09.716329-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131012eb0> created copy <LibAVSampleCursor: 0x13060ed30>
default    13:02:09.716392-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060ed30> stepInPresentationOrderByCount 1
default    13:02:09.716437-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> readAPacketAndUpdateState
default    13:02:09.716515-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 286370, size: 4096, read: 4096
default    13:02:09.716555-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 290466, size: 6054, read: 6054
default    13:02:09.716610-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> updateStateForPacket Presentation Timestamp {933/1000 = 0.933}
default    13:02:09.716674-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> updateStateForPacket Decode Timestamp {933/1000 = 0.933}
default    13:02:09.716732-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.716798-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> updateStateForPacket sampleOffset 286389
default    13:02:09.716878-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060ed30> updateStateForPacket sampleSize 10127
default    13:02:09.716948-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060ed30> copyWithZone
default    13:02:09.717000-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112340> init with pts/dts
default    13:02:09.717070-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.717144-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> seekToPTS already at {933/1000 = 0.933}
default    13:02:09.717209-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> readAPacketAndUpdateState
default    13:02:09.717293-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 296520, size: 4096, read: 4096
default    13:02:09.717412-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 300616, size: 5951, read: 5951
default    13:02:09.717514-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Presentation Timestamp {967/1000 = 0.967}
default    13:02:09.717566-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Decode Timestamp {967/1000 = 0.967}
default    13:02:09.717638-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.717701-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket sampleOffset 296539
default    13:02:09.717797-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket sampleSize 10024
default    13:02:09.717904-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> seekToPTS already at {967/1000 = 0.967}
default    13:02:09.718009-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060ed30> created copy <LibAVSampleCursor: 0x131112340>
default    13:02:09.718122-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112340> copyWithZone
default    13:02:09.718193-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071cb70> init with pts/dts
default    13:02:09.718292-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.718385-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> seekToPTS already at {967/1000 = 0.967}
default    13:02:09.718470-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> readAPacketAndUpdateState
default    13:02:09.718599-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 306567, size: 4096, read: 4096
default    13:02:09.718715-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 310663, size: 5931, read: 5931
default    13:02:09.718792-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket Presentation Timestamp {1000/1000 = 1.000}
default    13:02:09.718864-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket Decode Timestamp {1000/1000 = 1.000}
default    13:02:09.718947-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.719016-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket sampleOffset 306586
default    13:02:09.719098-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket sampleSize 10004
default    13:02:09.719189-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> seekToPTS already at {1000/1000 = 1.000}
default    13:02:09.719286-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112340> created copy <LibAVSampleCursor: 0x13071cb70>
default    13:02:09.719374-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071cb70> stepInDecodeOrderByCount  1
default    13:02:09.719485-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> readAPacketAndUpdateState
default    13:02:09.719574-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 316594, size: 4096, read: 4096
default    13:02:09.719679-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 320690, size: 5956, read: 5956
default    13:02:09.719752-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket Presentation Timestamp {1033/1000 = 1.033}
default    13:02:09.719810-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket Decode Timestamp {1033/1000 = 1.033}
default    13:02:09.719878-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.719937-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket sampleOffset 316613
default    13:02:09.719980-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket sampleSize 10029
default    13:02:09.720037-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071cb70> stepInDecodeOrderByCount  1
default    13:02:09.720107-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> readAPacketAndUpdateState
default    13:02:09.720192-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 326646, size: 4096, read: 4096
default    13:02:09.720278-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 330742, size: 6002, read: 6002
default    13:02:09.720372-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket Presentation Timestamp {1067/1000 = 1.067}
default    13:02:09.720438-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket Decode Timestamp {1067/1000 = 1.067}
default    13:02:09.720520-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.720582-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket sampleOffset 326665
default    13:02:09.720676-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071cb70> updateStateForPacket sampleSize 10075
default    13:02:09.720779-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131112340> stepInDecodeOrderByCount  1
default    13:02:09.720952-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> readAPacketAndUpdateState
default    13:02:09.721113-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 336744, size: 4096, read: 4096
default    13:02:09.721287-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 340840, size: 6105, read: 6105
default    13:02:09.721390-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Presentation Timestamp {1100/1000 = 1.100}
default    13:02:09.721488-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Decode Timestamp {1100/1000 = 1.100}
default    13:02:09.721573-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.721755-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket sampleOffset 336763
default    13:02:09.721906-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131112340> updateStateForPacket sampleSize 10178
default    13:02:09.722105-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> copyWithZone
default    13:02:09.722146-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131013680> init with pts/dts
default    13:02:09.722269-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.722381-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> seekToPTS already at {0/1000 = 0.000}
default    13:02:09.722505-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> readAPacketAndUpdateState
default    13:02:09.722615-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 346945, size: 4096, read: 4096
default    13:02:09.722729-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 351041, size: 6104, read: 6104
default    13:02:09.722841-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> updateStateForPacket Presentation Timestamp {1133/1000 = 1.133}
default    13:02:09.722976-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> updateStateForPacket Decode Timestamp {1133/1000 = 1.133}
default    13:02:09.723038-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.723150-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> updateStateForPacket sampleOffset 346964
default    13:02:09.723252-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> updateStateForPacket sampleSize 10177
default    13:02:09.723361-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> seekToPTS already at {1133/1000 = 1.133}
default    13:02:09.723488-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> created copy <LibAVSampleCursor: 0x131013680>
default    13:02:09.723596-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131013680> stepInDecodeOrderByCount  1
default    13:02:09.723669-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> readAPacketAndUpdateState
default    13:02:09.723743-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 357145, size: 4096, read: 4096
default    13:02:09.723823-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 361241, size: 6184, read: 6184
default    13:02:09.723901-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> updateStateForPacket Presentation Timestamp {1167/1000 = 1.167}
default    13:02:09.723984-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> updateStateForPacket Decode Timestamp {1167/1000 = 1.167}
default    13:02:09.724082-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.724170-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> updateStateForPacket sampleOffset 357164
default    13:02:09.724289-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131013680> updateStateForPacket sampleSize 10257
default    13:02:09.724386-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131013680> copyWithZone
default    13:02:09.724458-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131406030> init with pts/dts
default    13:02:09.724534-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.724613-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> seekToPTS already at {1167/1000 = 1.167}
default    13:02:09.724688-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> readAPacketAndUpdateState
default    13:02:09.724757-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 367425, size: 4096, read: 4096
default    13:02:09.724811-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 371521, size: 6115, read: 6115
default    13:02:09.724873-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> updateStateForPacket Presentation Timestamp {1200/1000 = 1.200}
default    13:02:09.724941-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> updateStateForPacket Decode Timestamp {1200/1000 = 1.200}
default    13:02:09.725022-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.725097-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> updateStateForPacket sampleOffset 367444
default    13:02:09.725155-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> updateStateForPacket sampleSize 10188
default    13:02:09.725225-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> seekToPTS already at {1200/1000 = 1.200}
default    13:02:09.725284-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131013680> created copy <LibAVSampleCursor: 0x131406030>
default    13:02:09.725327-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131406030> copyWithZone
default    13:02:09.725380-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611c50> init with pts/dts
default    13:02:09.725424-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.725464-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> seekToPTS already at {1200/1000 = 1.200}
default    13:02:09.725497-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> readAPacketAndUpdateState
default    13:02:09.725538-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 377636, size: 4096, read: 4096
default    13:02:09.725580-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 381732, size: 6120, read: 6120
default    13:02:09.725627-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Presentation Timestamp {1233/1000 = 1.233}
default    13:02:09.725677-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Decode Timestamp {1233/1000 = 1.233}
default    13:02:09.725735-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.725795-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleOffset 377655
default    13:02:09.725857-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleSize 10193
default    13:02:09.725918-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> seekToPTS already at {1233/1000 = 1.233}
default    13:02:09.725980-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131406030> created copy <LibAVSampleCursor: 0x130611c50>
default    13:02:09.726028-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611c50> stepInDecodeOrderByCount  1
default    13:02:09.726072-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> readAPacketAndUpdateState
default    13:02:09.726111-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 387852, size: 4096, read: 4096
default    13:02:09.726172-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 391948, size: 6064, read: 6064
default    13:02:09.726232-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Presentation Timestamp {1267/1000 = 1.267, rounded}
default    13:02:09.726284-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Decode Timestamp {1267/1000 = 1.267, rounded}
default    13:02:09.726346-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.726412-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleOffset 387871
default    13:02:09.726481-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleSize 10137
default    13:02:09.726542-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130611c50> stepInDecodeOrderByCount  1
default    13:02:09.726619-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> readAPacketAndUpdateState
default    13:02:09.726687-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 398012, size: 4096, read: 4096
default    13:02:09.726746-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 402108, size: 6186, read: 6186
default    13:02:09.726804-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Presentation Timestamp {1300/1000 = 1.300}
default    13:02:09.726861-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Decode Timestamp {1300/1000 = 1.300}
default    13:02:09.726911-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.726972-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleOffset 398031
default    13:02:09.727047-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130611c50> updateStateForPacket sampleSize 10259
default    13:02:09.727096-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131406030> stepInDecodeOrderByCount  1
default    13:02:09.727170-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> readAPacketAndUpdateState
default    13:02:09.727226-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 408294, size: 4096, read: 4096
default    13:02:09.727269-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 412390, size: 6045, read: 6045
default    13:02:09.727315-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> updateStateForPacket Presentation Timestamp {1333/1000 = 1.333}
default    13:02:09.727381-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> updateStateForPacket Decode Timestamp {1333/1000 = 1.333}
default    13:02:09.727458-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.727516-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> updateStateForPacket sampleOffset 408313
default    13:02:09.727593-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131406030> updateStateForPacket sampleSize 10118
error    13:02:09.727646-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.727818-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> copyWithZone
default    13:02:09.727835-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060eb00> init with pts/dts
default    13:02:09.727852-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.727909-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> seekToPTS already at {0/1000 = 0.000}
default    13:02:09.727966-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> readAPacketAndUpdateState
default    13:02:09.728023-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 418435, size: 4096, read: 4096
default    13:02:09.728071-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 422531, size: 6083, read: 6083
default    13:02:09.728130-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> updateStateForPacket Presentation Timestamp {1367/1000 = 1.367}
default    13:02:09.728167-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> updateStateForPacket Decode Timestamp {1367/1000 = 1.367}
default    13:02:09.728224-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.728270-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> updateStateForPacket sampleOffset 418454
default    13:02:09.728324-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> updateStateForPacket sampleSize 10156
default    13:02:09.728379-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> seekToPTS already at {1367/1000 = 1.367}
default    13:02:09.728436-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> created copy <LibAVSampleCursor: 0x13060eb00>
default    13:02:09.728513-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060eb00> stepInDecodeOrderByCount  1
default    13:02:09.728554-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> readAPacketAndUpdateState
default    13:02:09.728636-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 428614, size: 4096, read: 4096
default    13:02:09.728687-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 432710, size: 6119, read: 6119
default    13:02:09.728729-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> updateStateForPacket Presentation Timestamp {1400/1000 = 1.400, rounded}
default    13:02:09.728771-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> updateStateForPacket Decode Timestamp {1400/1000 = 1.400, rounded}
default    13:02:09.728842-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.728899-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> updateStateForPacket sampleOffset 428633
default    13:02:09.728965-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060eb00> updateStateForPacket sampleSize 10192
default    13:02:09.729026-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060eb00> copyWithZone
default    13:02:09.729070-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071e210> init with pts/dts
default    13:02:09.729099-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.729166-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> seekToPTS already at {1400/1000 = 1.400, rounded}
default    13:02:09.729231-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> readAPacketAndUpdateState
default    13:02:09.729270-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 438829, size: 4096, read: 4096
default    13:02:09.729312-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 442925, size: 6135, read: 6135
default    13:02:09.729367-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> updateStateForPacket Presentation Timestamp {1433/1000 = 1.433}
default    13:02:09.729432-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> updateStateForPacket Decode Timestamp {1433/1000 = 1.433}
default    13:02:09.729485-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.729532-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> updateStateForPacket sampleOffset 438848
default    13:02:09.729578-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> updateStateForPacket sampleSize 10208
default    13:02:09.729628-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> seekToPTS already at {1433/1000 = 1.433}
default    13:02:09.729679-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060eb00> created copy <LibAVSampleCursor: 0x13071e210>
default    13:02:09.729701-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071e210> copyWithZone
default    13:02:09.729742-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130614dd0> init with pts/dts
default    13:02:09.729794-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.729847-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130614dd0> seekToPTS already at {1433/1000 = 1.433}
default    13:02:09.729907-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130614dd0> readAPacketAndUpdateState
default    13:02:09.731141-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> readAPacketAndUpdateState
default    13:02:09.731167-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 479560, size: 4096, read: 4096
default    13:02:09.731188-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 483656, size: 6073, read: 6073
default    13:02:09.731215-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> updateStateForPacket Presentation Timestamp {1567/1000 = 1.567}
default    13:02:09.731232-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> updateStateForPacket Decode Timestamp {1567/1000 = 1.567}
default    13:02:09.731251-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.731267-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> updateStateForPacket sampleOffset 479579
default    13:02:09.731283-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e210> updateStateForPacket sampleSize 10146
error    13:02:09.731359-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.731496-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060ed30> copyWithZone
default    13:02:09.731514-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071d440> init with pts/dts
default    13:02:09.731528-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.731568-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> seekToPTS already at {933/1000 = 0.933}
default    13:02:09.731623-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> readAPacketAndUpdateState
default    13:02:09.731679-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 489729, size: 4096, read: 4096
default    13:02:09.731739-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 493825, size: 6042, read: 6042
default    13:02:09.731791-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> updateStateForPacket Presentation Timestamp {1600/1000 = 1.600}
default    13:02:09.731826-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> updateStateForPacket Decode Timestamp {1600/1000 = 1.600}
default    13:02:09.731874-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.731910-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> updateStateForPacket sampleOffset 489748
default    13:02:09.731950-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> updateStateForPacket sampleSize 10115
default    13:02:09.732000-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> seekToPTS already at {1600/1000 = 1.600}
default    13:02:09.732036-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060ed30> created copy <LibAVSampleCursor: 0x13071d440>
default    13:02:09.732081-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071d440> stepInPresentationOrderByCount 1
default    13:02:09.732126-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> readAPacketAndUpdateState
default    13:02:09.732157-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 499867, size: 4096, read: 4096
default    13:02:09.732187-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 503963, size: 6031, read: 6031
default    13:02:09.732208-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> updateStateForPacket Presentation Timestamp {1633/1000 = 1.633}
default    13:02:09.732245-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> updateStateForPacket Decode Timestamp {1633/1000 = 1.633}
default    13:02:09.732315-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.732338-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> updateStateForPacket sampleOffset 499886
default    13:02:09.732395-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d440> updateStateForPacket sampleSize 10104
default    13:02:09.732470-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071d440> copyWithZone
default    13:02:09.732521-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071d650> init with pts/dts
default    13:02:09.732561-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.732640-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d650> seekToPTS already at {1633/1000 = 1.633}
default    13:02:09.732657-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d650> readAPacketAndUpdateState
default    13:02:09.732676-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 509994, size: 4096, read: 4096
default    13:02:09.732729-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 514090, size: 6108, read: 6108
default    13:02:09.732774-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d650> updateStateForPacket Presentation Timestamp {1667/1000 = 1.667}
default    13:02:09.732810-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d650> updateStateForPacket Decode Timestamp {1667/1000 = 1.667}
default    13:02:09.732846-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d650> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.732878-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d650> updateStateForPacket sampleOffset 510013
default    13:02:09.732934-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d650> updateStateForPacket sampleSize 10181
default    13:02:09.732994-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d650> seekToPTS already at {1667/1000 = 1.667}
default    13:02:09.733033-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071d440> created copy <LibAVSampleCursor: 0x13071d650>
default    13:02:09.733064-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071d650> copyWithZone
default    13:02:09.733135-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130614c00> init with pts/dts
default    13:02:09.733190-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.733248-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130614c00> seekToPTS already at {1667/1000 = 1.667}
default    13:02:09.733303-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130614c00> readAPacketAndUpdateState
default    13:02:09.733340-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 520198, size: 4096, read: 4096
default    13:02:09.733392-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 524294, size: 6110, read: 6110
default    13:02:09.733453-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130614c00> updateStateForPacket Presentation Timestamp {1700/1000 = 1.700}
default    13:02:09.735321-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> updateStateForPacket Presentation Timestamp {1833/1000 = 1.833}
default    13:02:09.735338-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> updateStateForPacket Decode Timestamp {1833/1000 = 1.833}
default    13:02:09.735357-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.735372-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> updateStateForPacket sampleOffset 560895
default    13:02:09.735387-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> updateStateForPacket sampleSize 10272
default    13:02:09.735404-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> seekToPTS already at {1833/1000 = 1.833}
default    13:02:09.735420-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> created copy <LibAVSampleCursor: 0x131305210>
default    13:02:09.735446-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131305210> stepInPresentationOrderByCount 1
default    13:02:09.735465-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> readAPacketAndUpdateState
default    13:02:09.735482-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 571171, size: 4096, read: 4096
default    13:02:09.735501-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 575267, size: 6131, read: 6131
default    13:02:09.735522-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> updateStateForPacket Presentation Timestamp {1867/1000 = 1.867}
default    13:02:09.735541-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> updateStateForPacket Decode Timestamp {1867/1000 = 1.867}
default    13:02:09.735615-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.735692-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> updateStateForPacket sampleOffset 571190
default    13:02:09.735712-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131305210> updateStateForPacket sampleSize 10204
default    13:02:09.735738-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131305210> copyWithZone
default    13:02:09.735755-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131014480> init with pts/dts
default    13:02:09.735771-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.735793-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> seekToPTS already at {1867/1000 = 1.867}
default    13:02:09.735810-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> readAPacketAndUpdateState
default    13:02:09.735830-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 581398, size: 4096, read: 4096
default    13:02:09.735847-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 585494, size: 6105, read: 6105
default    13:02:09.735868-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> updateStateForPacket Presentation Timestamp {1900/1000 = 1.900, rounded}
default    13:02:09.735933-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> updateStateForPacket Decode Timestamp {1900/1000 = 1.900, rounded}
default    13:02:09.735985-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.736052-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> updateStateForPacket sampleOffset 581417
default    13:02:09.736118-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> updateStateForPacket sampleSize 10178
default    13:02:09.736183-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> seekToPTS already at {1900/1000 = 1.900, rounded}
default    13:02:09.736254-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131305210> created copy <LibAVSampleCursor: 0x131014480>
default    13:02:09.736291-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131014480> copyWithZone
default    13:02:09.736310-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071d730> init with pts/dts
default    13:02:09.736358-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.736378-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> seekToPTS already at {1900/1000 = 1.900, rounded}
default    13:02:09.736394-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> readAPacketAndUpdateState
default    13:02:09.736412-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 591599, size: 4096, read: 4096
default    13:02:09.736428-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 595695, size: 6162, read: 6162
default    13:02:09.736447-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket Presentation Timestamp {1933/1000 = 1.933}
default    13:02:09.736464-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket Decode Timestamp {1933/1000 = 1.933}
default    13:02:09.736480-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.736495-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket sampleOffset 591618
default    13:02:09.736510-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket sampleSize 10235
default    13:02:09.736526-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> seekToPTS already at {1933/1000 = 1.933}
default    13:02:09.736543-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131014480> created copy <LibAVSampleCursor: 0x13071d730>
default    13:02:09.736562-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071d730> stepInDecodeOrderByCount  1
default    13:02:09.736577-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> readAPacketAndUpdateState
default    13:02:09.736593-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 601857, size: 4096, read: 4096
default    13:02:09.736609-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 605953, size: 6167, read: 6167
default    13:02:09.736627-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket Presentation Timestamp {1967/1000 = 1.967}
default    13:02:09.736641-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket Decode Timestamp {1967/1000 = 1.967}
default    13:02:09.736658-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.736671-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket sampleOffset 601876
default    13:02:09.736685-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket sampleSize 10240
default    13:02:09.736705-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071d730> stepInDecodeOrderByCount  1
default    13:02:09.736720-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> readAPacketAndUpdateState
default    13:02:09.736736-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 612120, size: 4096, read: 4096
default    13:02:09.736751-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 616216, size: 5995, read: 5995
default    13:02:09.736768-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket Presentation Timestamp {2000/1000 = 2.000}
default    13:02:09.736823-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket Decode Timestamp {2000/1000 = 2.000}
default    13:02:09.736884-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.736932-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket sampleOffset 612139
default    13:02:09.736948-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071d730> updateStateForPacket sampleSize 10068
default    13:02:09.736963-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131014480> stepInDecodeOrderByCount  1
default    13:02:09.736979-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> readAPacketAndUpdateState
default    13:02:09.736995-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 622211, size: 4096, read: 4096
default    13:02:09.737013-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 626307, size: 6003, read: 6003
default    13:02:09.737032-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> updateStateForPacket Presentation Timestamp {2033/1000 = 2.033}
default    13:02:09.737054-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> updateStateForPacket Decode Timestamp {2033/1000 = 2.033}
default    13:02:09.737068-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.737082-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> updateStateForPacket sampleOffset 622230
default    13:02:09.737101-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014480> updateStateForPacket sampleSize 10076
default    13:02:09.737230-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.737252-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> seekToPTS already at {0/1000 = 0.000}
default    13:02:09.737272-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 632310, size: 4096, read: 4096
default    13:02:09.737291-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 636406, size: 5977, read: 5977
default    13:02:09.737312-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> updateStateForPacket Presentation Timestamp {2067/1000 = 2.067}
default    13:02:09.737333-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> updateStateForPacket Decode Timestamp {2067/1000 = 2.067}
default    13:02:09.737349-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.737365-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> updateStateForPacket sampleOffset 632329
default    13:02:09.737380-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> updateStateForPacket sampleSize 10050
default    13:02:09.737432-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060f140> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x13060f4b0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x130612900 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {2067/1000 = 2.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {2067/1000 = 2.067}, DTS = {2067/1000 = 2.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x13060f420 totalDataLength: 10050 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10050 bytes @ offset 0 Memory Block 0x130818404, 10050 bytes (allocator 0x1f7d62490)
}
default    13:02:09.737591-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> copyWithZone
default    13:02:09.737613-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306151c0> init with pts/dts
default    13:02:09.737627-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.737648-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> seekToPTS already at {2067/1000 = 2.067}
default    13:02:09.737664-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> readAPacketAndUpdateState
default    13:02:09.737680-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 642383, size: 4096, read: 4096
default    13:02:09.737698-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 646479, size: 5960, read: 5960
default    13:02:09.737719-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Presentation Timestamp {2100/1000 = 2.100}
default    13:02:09.737745-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Decode Timestamp {2100/1000 = 2.100}
default    13:02:09.737762-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.737778-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleOffset 642402
default    13:02:09.737795-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleSize 10033
default    13:02:09.737812-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> seekToPTS already at {2100/1000 = 2.100}
default    13:02:09.737831-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060f140> created copy <LibAVSampleCursor: 0x1306151c0>
default    13:02:09.737859-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306151c0> stepInDecodeOrderByCount  1
default    13:02:09.737875-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> readAPacketAndUpdateState
default    13:02:09.737895-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 652439, size: 4096, read: 4096
default    13:02:09.737911-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 656535, size: 5954, read: 5954
default    13:02:09.737931-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Presentation Timestamp {2133/1000 = 2.133}
default    13:02:09.738018-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Decode Timestamp {2133/1000 = 2.133}
default    13:02:09.738039-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.738055-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleOffset 652458
default    13:02:09.738070-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleSize 10027
default    13:02:09.738094-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306151c0> copyWithZone
default    13:02:09.738115-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131015250> init with pts/dts
default    13:02:09.738131-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.738148-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015250> seekToPTS already at {2133/1000 = 2.133}
default    13:02:09.738163-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015250> readAPacketAndUpdateState
error    13:02:09.739252-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.739362-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306151c0> copyWithZone
default    13:02:09.739382-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060e500> init with pts/dts
default    13:02:09.739396-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.739414-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> seekToPTS already at {2133/1000 = 2.133}
default    13:02:09.739429-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> readAPacketAndUpdateState
default    13:02:09.739447-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 713114, size: 4096, read: 4096
default    13:02:09.739463-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 717210, size: 6033, read: 6033
default    13:02:09.739481-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> updateStateForPacket Presentation Timestamp {2333/1000 = 2.333}
default    13:02:09.739500-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> updateStateForPacket Decode Timestamp {2333/1000 = 2.333}
default    13:02:09.739516-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.739531-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> updateStateForPacket sampleOffset 713133
default    13:02:09.739586-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> updateStateForPacket sampleSize 10106
default    13:02:09.739614-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> seekToPTS already at {2333/1000 = 2.333}
default    13:02:09.739631-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306151c0> created copy <LibAVSampleCursor: 0x13060e500>
default    13:02:09.739660-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060e500> stepInPresentationOrderByCount 1
default    13:02:09.739675-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> readAPacketAndUpdateState
default    13:02:09.739694-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 723243, size: 4096, read: 4096
default    13:02:09.739712-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 727339, size: 6005, read: 6005
default    13:02:09.739731-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> updateStateForPacket Presentation Timestamp {2367/1000 = 2.367}
default    13:02:09.739748-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> updateStateForPacket Decode Timestamp {2367/1000 = 2.367}
default    13:02:09.739820-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.739839-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> updateStateForPacket sampleOffset 723262
default    13:02:09.739854-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13060e500> updateStateForPacket sampleSize 10078
default    13:02:09.739877-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060e500> copyWithZone
default    13:02:09.739897-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113ad0> init with pts/dts
default    13:02:09.739912-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.739932-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> seekToPTS already at {2367/1000 = 2.367}
default    13:02:09.739962-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> readAPacketAndUpdateState
default    13:02:09.740039-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 733344, size: 4096, read: 4096
default    13:02:09.740057-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 737440, size: 6068, read: 6068
default    13:02:09.740077-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> updateStateForPacket Presentation Timestamp {2400/1000 = 2.400}
default    13:02:09.740094-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> updateStateForPacket Decode Timestamp {2400/1000 = 2.400}
default    13:02:09.740112-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.740127-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> updateStateForPacket sampleOffset 733363
default    13:02:09.740140-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> updateStateForPacket sampleSize 10141
default    13:02:09.740156-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> seekToPTS already at {2400/1000 = 2.400}
default    13:02:09.740178-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13060e500> created copy <LibAVSampleCursor: 0x131113ad0>
default    13:02:09.740195-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113ad0> copyWithZone
default    13:02:09.740210-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615830> init with pts/dts
default    13:02:09.740223-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.740241-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> seekToPTS already at {2400/1000 = 2.400}
default    13:02:09.740256-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> readAPacketAndUpdateState
default    13:02:09.740271-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 743508, size: 4096, read: 4096
default    13:02:09.740288-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 747604, size: 6069, read: 6069
default    13:02:09.740305-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket Presentation Timestamp {2433/1000 = 2.433}
default    13:02:09.740324-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket Decode Timestamp {2433/1000 = 2.433}
default    13:02:09.740339-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.740354-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket sampleOffset 743527
default    13:02:09.740369-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket sampleSize 10142
default    13:02:09.740385-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> seekToPTS already at {2433/1000 = 2.433}
default    13:02:09.740401-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113ad0> created copy <LibAVSampleCursor: 0x130615830>
default    13:02:09.740417-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615830> stepInDecodeOrderByCount  1
default    13:02:09.740432-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> readAPacketAndUpdateState
default    13:02:09.740447-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 753673, size: 4096, read: 4096
default    13:02:09.740498-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 757769, size: 6093, read: 6093
default    13:02:09.740535-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket Presentation Timestamp {2467/1000 = 2.467}
default    13:02:09.740555-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket Decode Timestamp {2467/1000 = 2.467}
default    13:02:09.740572-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.740626-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket sampleOffset 753692
default    13:02:09.740643-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket sampleSize 10166
default    13:02:09.740663-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615830> stepInDecodeOrderByCount  1
default    13:02:09.740679-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> readAPacketAndUpdateState
default    13:02:09.740694-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 763862, size: 4096, read: 4096
default    13:02:09.740711-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 767958, size: 6138, read: 6138
default    13:02:09.740730-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket Presentation Timestamp {2500/1000 = 2.500}
default    13:02:09.740746-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket Decode Timestamp {2500/1000 = 2.500}
default    13:02:09.740761-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.740777-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket sampleOffset 763881
default    13:02:09.740791-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615830> updateStateForPacket sampleSize 10211
default    13:02:09.740828-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113ad0> stepInDecodeOrderByCount  1
default    13:02:09.740844-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> readAPacketAndUpdateState
default    13:02:09.740859-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 774096, size: 4096, read: 4096
default    13:02:09.740876-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 778192, size: 6111, read: 6111
default    13:02:09.740895-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> updateStateForPacket Presentation Timestamp {2533/1000 = 2.533}
default    13:02:09.740912-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> updateStateForPacket Decode Timestamp {2533/1000 = 2.533}
default    13:02:09.740928-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.740946-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> updateStateForPacket sampleOffset 774115
default    13:02:09.740959-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ad0> updateStateForPacket sampleSize 10184
default    13:02:09.741058-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.741076-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> seekToPTS already at {2133/1000 = 2.133}
default    13:02:09.741095-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 784303, size: 4096, read: 4096
default    13:02:09.741112-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 788399, size: 6098, read: 6098
default    13:02:09.741137-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Presentation Timestamp {2567/1000 = 2.567}
default    13:02:09.741156-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Decode Timestamp {2567/1000 = 2.567}
default    13:02:09.741172-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.741185-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleOffset 784322
default    13:02:09.741200-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleSize 10171
default    13:02:09.741246-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x13060e340 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x130615300 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {2567/1000 = 2.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {2567/1000 = 2.567}, DTS = {2567/1000 = 2.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x130615670 totalDataLength: 10171 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10171 bytes @ offset 0 Memory Block 0x130818404, 10171 bytes (allocator 0x1f7d62490)
}
default    13:02:09.741370-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> itemfig_DeferredFirstVideoFrameEnqueued: [0x10e737160|P/WO] <0x10f06b000|I/ELD.01> Received first video frame enqueued notification
default    13:02:09.741399-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306151c0> copyWithZone
default    13:02:09.741400-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_doingGapless: P/WO NO, because actionAtEnd (1) is not kFigPlayerActionCode_Advance
default    13:02:09.741426-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120b2f0> init with pts/dts
default    13:02:09.741414-0400    LibAVExtensionHost    <<<< FigFilePlayer >>>> playerfig_scheduleVideoSlotAndVideoTargetConfigurationSwitchAndPossiblyStartBossForNextItem: Not doing gapless
default    13:02:09.741446-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.741470-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> seekToPTS already at {2567/1000 = 2.567}
default    13:02:09.741491-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> readAPacketAndUpdateState
default    13:02:09.741512-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 794497, size: 4096, read: 4096
default    13:02:09.741533-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 798593, size: 6111, read: 6111
default    13:02:09.741554-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket Presentation Timestamp {2600/1000 = 2.600}
default    13:02:09.741574-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket Decode Timestamp {2600/1000 = 2.600}
default    13:02:09.741591-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.741700-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket sampleOffset 794516
default    13:02:09.741720-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket sampleSize 10184
default    13:02:09.741739-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> seekToPTS already at {2600/1000 = 2.600}
default    13:02:09.741760-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306151c0> created copy <LibAVSampleCursor: 0x13120b2f0>
default    13:02:09.741786-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120b2f0> stepInDecodeOrderByCount  1
default    13:02:09.741806-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> readAPacketAndUpdateState
default    13:02:09.741826-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 804704, size: 4096, read: 4096
default    13:02:09.741846-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 808800, size: 6111, read: 6111
default    13:02:09.741867-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket Presentation Timestamp {2633/1000 = 2.633}
default    13:02:09.741884-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket Decode Timestamp {2633/1000 = 2.633}
default    13:02:09.741903-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.741919-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket sampleOffset 804723
default    13:02:09.741934-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket sampleSize 10184
default    13:02:09.741957-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120b2f0> copyWithZone
default    13:02:09.741975-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310165b0> init with pts/dts
default    13:02:09.741991-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.742050-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310165b0> seekToPTS already at {2633/1000 = 2.633}
default    13:02:09.742069-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310165b0> readAPacketAndUpdateState
default    13:02:09.743237-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071dbc0> updateStateForPacket sampleSize 10235
default    13:02:09.743263-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071dbc0> seekToPTS already at {2833/1000 = 2.833}
default    13:02:09.743280-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120b2f0> created copy <LibAVSampleCursor: 0x13071dbc0>
default    13:02:09.743305-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071dbc0> stepInPresentationOrderByCount 1
default    13:02:09.743321-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071dbc0> readAPacketAndUpdateState
default    13:02:09.743336-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 876402, size: 4096, read: 4096
default    13:02:09.743354-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 880498, size: 6174, read: 6174
default    13:02:09.743371-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071dbc0> updateStateForPacket Presentation Timestamp {2867/1000 = 2.867}
default    13:02:09.743479-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071dbc0> updateStateForPacket Decode Timestamp {2867/1000 = 2.867}
default    13:02:09.743498-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071dbc0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.743514-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071dbc0> updateStateForPacket sampleOffset 876421
default    13:02:09.743529-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071dbc0> updateStateForPacket sampleSize 10247
default    13:02:09.743550-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071dbc0> copyWithZone
default    13:02:09.743608-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615700> init with pts/dts
default    13:02:09.743668-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.743706-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> seekToPTS already at {2867/1000 = 2.867}
default    13:02:09.743777-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> readAPacketAndUpdateState
default    13:02:09.743864-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 886672, size: 4096, read: 4096
default    13:02:09.743930-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 890768, size: 6141, read: 6141
default    13:02:09.743949-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> updateStateForPacket Presentation Timestamp {2900/1000 = 2.900}
default    13:02:09.743968-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> updateStateForPacket Decode Timestamp {2900/1000 = 2.900}
default    13:02:09.743984-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.744040-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> updateStateForPacket sampleOffset 886691
default    13:02:09.744103-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> updateStateForPacket sampleSize 10214
default    13:02:09.744121-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> seekToPTS already at {2900/1000 = 2.900}
default    13:02:09.744138-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071dbc0> created copy <LibAVSampleCursor: 0x130615700>
default    13:02:09.744153-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615700> copyWithZone
default    13:02:09.744169-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130616680> init with pts/dts
default    13:02:09.744184-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.744200-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> seekToPTS already at {2900/1000 = 2.900}
default    13:02:09.744220-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> readAPacketAndUpdateState
default    13:02:09.744237-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 896909, size: 4096, read: 4096
default    13:02:09.744255-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 901005, size: 6136, read: 6136
default    13:02:09.744272-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket Presentation Timestamp {2933/1000 = 2.933, rounded}
default    13:02:09.744293-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket Decode Timestamp {2933/1000 = 2.933, rounded}
default    13:02:09.744311-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.744326-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket sampleOffset 896928
default    13:02:09.744339-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket sampleSize 10209
default    13:02:09.744355-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> seekToPTS already at {2933/1000 = 2.933, rounded}
default    13:02:09.744371-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615700> created copy <LibAVSampleCursor: 0x130616680>
default    13:02:09.744388-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130616680> stepInDecodeOrderByCount  1
default    13:02:09.744402-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> readAPacketAndUpdateState
default    13:02:09.744419-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 907141, size: 4096, read: 4096
default    13:02:09.744436-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 911237, size: 6181, read: 6181
default    13:02:09.744453-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket Presentation Timestamp {2967/1000 = 2.967}
default    13:02:09.744471-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket Decode Timestamp {2967/1000 = 2.967}
default    13:02:09.744508-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.744573-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket sampleOffset 907160
default    13:02:09.744590-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket sampleSize 10254
default    13:02:09.744607-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130616680> stepInDecodeOrderByCount  1
default    13:02:09.744623-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> readAPacketAndUpdateState
default    13:02:09.744638-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 917418, size: 4096, read: 4096
default    13:02:09.744688-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 921514, size: 5997, read: 5997
default    13:02:09.744745-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket Presentation Timestamp {3000/1000 = 3.000}
default    13:02:09.744797-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket Decode Timestamp {3000/1000 = 3.000}
default    13:02:09.744888-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.744906-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket sampleOffset 917437
default    13:02:09.744921-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616680> updateStateForPacket sampleSize 10070
default    13:02:09.744939-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615700> stepInDecodeOrderByCount  1
default    13:02:09.744954-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> readAPacketAndUpdateState
default    13:02:09.745012-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 927511, size: 4096, read: 4096
default    13:02:09.745080-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 931607, size: 6096, read: 6096
default    13:02:09.745100-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> updateStateForPacket Presentation Timestamp {3033/1000 = 3.033}
default    13:02:09.745116-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> updateStateForPacket Decode Timestamp {3033/1000 = 3.033}
default    13:02:09.745132-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.745196-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> updateStateForPacket sampleOffset 927530
default    13:02:09.745212-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615700> updateStateForPacket sampleSize 10169
default    13:02:09.745357-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.745377-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> seekToPTS already at {2633/1000 = 2.633}
default    13:02:09.745394-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 937703, size: 4096, read: 4096
default    13:02:09.745412-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 941799, size: 5991, read: 5991
default    13:02:09.745429-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket Presentation Timestamp {3067/1000 = 3.067}
default    13:02:09.745445-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket Decode Timestamp {3067/1000 = 3.067}
default    13:02:09.745460-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.745488-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket sampleOffset 937722
default    13:02:09.745524-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> updateStateForPacket sampleSize 10064
default    13:02:09.745625-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2f0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x13071e760 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x13120b8f0 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {3067/1000 = 3.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {3067/1000 = 3.067}, DTS = {3067/1000 = 3.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x13071d730 totalDataLength: 10064 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10064 bytes @ offset 0 Memory Block 0x132012804, 10064 bytes (allocator 0x1f7d62490)
}
default    13:02:09.745763-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120b2f0> copyWithZone
default    13:02:09.745781-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131015710> init with pts/dts
default    13:02:09.745795-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.745814-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> seekToPTS already at {3067/1000 = 3.067}
default    13:02:09.745829-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> readAPacketAndUpdateState
default    13:02:09.745846-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 947790, size: 4096, read: 4096
default    13:02:09.745877-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 951886, size: 6031, read: 6031
default    13:02:09.745894-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket Presentation Timestamp {3100/1000 = 3.100}
default    13:02:09.745910-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket Decode Timestamp {3100/1000 = 3.100}
default    13:02:09.745925-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.745940-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket sampleOffset 947809
default    13:02:09.745954-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket sampleSize 10104
default    13:02:09.745970-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> seekToPTS already at {3100/1000 = 3.100}
default    13:02:09.745987-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120b2f0> created copy <LibAVSampleCursor: 0x131015710>
default    13:02:09.746009-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131015710> stepInDecodeOrderByCount  1
default    13:02:09.746023-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> readAPacketAndUpdateState
default    13:02:09.746102-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 957917, size: 4096, read: 4096
default    13:02:09.746124-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 962013, size: 5934, read: 5934
default    13:02:09.746144-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket Presentation Timestamp {3133/1000 = 3.133}
default    13:02:09.746160-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket Decode Timestamp {3133/1000 = 3.133}
default    13:02:09.746177-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.746192-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket sampleOffset 957936
default    13:02:09.746207-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket sampleSize 10007
default    13:02:09.746246-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131015710> copyWithZone
default    13:02:09.746267-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071e0c0> init with pts/dts
default    13:02:09.746279-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.746299-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e0c0> seekToPTS already at {3133/1000 = 3.133}
default    13:02:09.746315-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e0c0> readAPacketAndUpdateState
default    13:02:09.747103-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e0c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.747118-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e0c0> updateStateForPacket sampleOffset 1008209
default    13:02:09.747133-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071e0c0> updateStateForPacket sampleSize 10023
error    13:02:09.747150-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.747252-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131015710> copyWithZone
default    13:02:09.747275-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615080> init with pts/dts
default    13:02:09.747288-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.747308-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> seekToPTS already at {3133/1000 = 3.133}
default    13:02:09.747323-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> readAPacketAndUpdateState
default    13:02:09.747371-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1018236, size: 4096, read: 4096
default    13:02:09.747468-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1022332, size: 5926, read: 5926
default    13:02:09.747494-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> updateStateForPacket Presentation Timestamp {3333/1000 = 3.333}
default    13:02:09.747587-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> updateStateForPacket Decode Timestamp {3333/1000 = 3.333}
default    13:02:09.747606-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.747620-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> updateStateForPacket sampleOffset 1018255
default    13:02:09.747634-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> updateStateForPacket sampleSize 9999
default    13:02:09.747651-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> seekToPTS already at {3333/1000 = 3.333}
default    13:02:09.747665-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131015710> created copy <LibAVSampleCursor: 0x130615080>
default    13:02:09.747716-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615080> stepInPresentationOrderByCount 1
default    13:02:09.747734-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> readAPacketAndUpdateState
default    13:02:09.747751-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1028258, size: 4096, read: 4096
default    13:02:09.747769-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1032354, size: 5860, read: 5860
default    13:02:09.747786-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> updateStateForPacket Presentation Timestamp {3367/1000 = 3.367}
default    13:02:09.747807-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> updateStateForPacket Decode Timestamp {3367/1000 = 3.367}
default    13:02:09.747822-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.747837-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> updateStateForPacket sampleOffset 1028277
default    13:02:09.747850-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615080> updateStateForPacket sampleSize 9933
default    13:02:09.747874-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615080> copyWithZone
default    13:02:09.747956-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071f9e0> init with pts/dts
default    13:02:09.747989-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.748008-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> seekToPTS already at {3367/1000 = 3.367}
default    13:02:09.748023-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> readAPacketAndUpdateState
default    13:02:09.748039-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1038214, size: 4096, read: 4096
default    13:02:09.748055-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1042310, size: 5852, read: 5852
default    13:02:09.748073-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> updateStateForPacket Presentation Timestamp {3400/1000 = 3.400}
default    13:02:09.748089-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> updateStateForPacket Decode Timestamp {3400/1000 = 3.400}
default    13:02:09.748104-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.748119-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> updateStateForPacket sampleOffset 1038233
default    13:02:09.748131-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> updateStateForPacket sampleSize 9925
default    13:02:09.748147-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> seekToPTS already at {3400/1000 = 3.400}
default    13:02:09.748163-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615080> created copy <LibAVSampleCursor: 0x13071f9e0>
default    13:02:09.748179-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071f9e0> copyWithZone
default    13:02:09.748193-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130720ae0> init with pts/dts
default    13:02:09.748222-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.748290-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> seekToPTS already at {3400/1000 = 3.400}
default    13:02:09.748306-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> readAPacketAndUpdateState
default    13:02:09.748323-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1048162, size: 4096, read: 4096
default    13:02:09.748342-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1052258, size: 5946, read: 5946
default    13:02:09.748363-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket Presentation Timestamp {3433/1000 = 3.433, rounded}
default    13:02:09.748389-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket Decode Timestamp {3433/1000 = 3.433, rounded}
default    13:02:09.748431-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.748500-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket sampleOffset 1048181
default    13:02:09.748526-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket sampleSize 10019
default    13:02:09.748542-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> seekToPTS already at {3433/1000 = 3.433, rounded}
default    13:02:09.748557-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071f9e0> created copy <LibAVSampleCursor: 0x130720ae0>
default    13:02:09.748573-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130720ae0> stepInDecodeOrderByCount  1
default    13:02:09.748616-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> readAPacketAndUpdateState
default    13:02:09.748687-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1058204, size: 4096, read: 4096
default    13:02:09.748758-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1062300, size: 5869, read: 5869
default    13:02:09.748776-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket Presentation Timestamp {3467/1000 = 3.467}
default    13:02:09.748794-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket Decode Timestamp {3467/1000 = 3.467}
default    13:02:09.748810-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.748825-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket sampleOffset 1058223
default    13:02:09.748863-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket sampleSize 9942
default    13:02:09.748881-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130720ae0> stepInDecodeOrderByCount  1
default    13:02:09.748894-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> readAPacketAndUpdateState
default    13:02:09.748909-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1068169, size: 4096, read: 4096
default    13:02:09.748925-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1072265, size: 5990, read: 5990
default    13:02:09.748943-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket Presentation Timestamp {3500/1000 = 3.500}
default    13:02:09.748959-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket Decode Timestamp {3500/1000 = 3.500}
default    13:02:09.748974-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.748987-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket sampleOffset 1068188
default    13:02:09.749001-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720ae0> updateStateForPacket sampleSize 10063
default    13:02:09.749068-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071f9e0> stepInDecodeOrderByCount  1
default    13:02:09.749085-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> readAPacketAndUpdateState
default    13:02:09.749103-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1078255, size: 4096, read: 4096
default    13:02:09.749217-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1082351, size: 5862, read: 5862
default    13:02:09.749254-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> updateStateForPacket Presentation Timestamp {3533/1000 = 3.533}
default    13:02:09.749326-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> updateStateForPacket Decode Timestamp {3533/1000 = 3.533}
default    13:02:09.749344-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.749357-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> updateStateForPacket sampleOffset 1078274
default    13:02:09.749372-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f9e0> updateStateForPacket sampleSize 9935
default    13:02:09.749484-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.749510-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> seekToPTS already at {3133/1000 = 3.133}
default    13:02:09.749535-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1088213, size: 4096, read: 4096
default    13:02:09.749555-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1092309, size: 5907, read: 5907
default    13:02:09.749573-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket Presentation Timestamp {3567/1000 = 3.567}
default    13:02:09.749593-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket Decode Timestamp {3567/1000 = 3.567}
default    13:02:09.749610-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.749625-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket sampleOffset 1088232
default    13:02:09.749640-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> updateStateForPacket sampleSize 9980
default    13:02:09.749689-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131015710> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x13120a770 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x131013f70 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {3567/1000 = 3.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {3567/1000 = 3.567}, DTS = {3567/1000 = 3.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x13120a6e0 totalDataLength: 9980 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 9980 bytes @ offset 0 Memory Block 0x13300de04, 9980 bytes (allocator 0x1f7d62490)
}
default    13:02:09.749847-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131015710> copyWithZone
default    13:02:09.749870-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> init with pts/dts
default    13:02:09.749883-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.749902-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> seekToPTS already at {3567/1000 = 3.567}
default    13:02:09.749917-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> readAPacketAndUpdateState
default    13:02:09.749941-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1098216, size: 4096, read: 4096
default    13:02:09.749958-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1102312, size: 5868, read: 5868
default    13:02:09.749979-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Presentation Timestamp {3600/1000 = 3.600}
default    13:02:09.749994-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Decode Timestamp {3600/1000 = 3.600}
default    13:02:09.750013-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.750026-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket sampleOffset 1098235
default    13:02:09.750041-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket sampleSize 9941
default    13:02:09.750056-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> seekToPTS already at {3600/1000 = 3.600}
default    13:02:09.750072-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131015710> created copy <LibAVSampleCursor: 0x1310163d0>
default    13:02:09.750097-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> stepInDecodeOrderByCount  1
default    13:02:09.750112-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> readAPacketAndUpdateState
default    13:02:09.750127-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1108180, size: 4096, read: 4096
default    13:02:09.750143-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1112276, size: 5933, read: 5933
default    13:02:09.750159-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Presentation Timestamp {3633/1000 = 3.633}
default    13:02:09.750175-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Decode Timestamp {3633/1000 = 3.633}
default    13:02:09.750193-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.751317-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> copyWithZone
default    13:02:09.751338-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071eed0> init with pts/dts
default    13:02:09.751353-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.751372-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> seekToPTS already at {3633/1000 = 3.633}
default    13:02:09.751388-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> readAPacketAndUpdateState
default    13:02:09.751405-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1168064, size: 4096, read: 4096
default    13:02:09.751425-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1172160, size: 5867, read: 5867
default    13:02:09.751442-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> updateStateForPacket Presentation Timestamp {3833/1000 = 3.833}
default    13:02:09.751461-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> updateStateForPacket Decode Timestamp {3833/1000 = 3.833}
default    13:02:09.751478-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.751494-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> updateStateForPacket sampleOffset 1168083
default    13:02:09.751511-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> updateStateForPacket sampleSize 9940
default    13:02:09.751528-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> seekToPTS already at {3833/1000 = 3.833}
default    13:02:09.751548-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> created copy <LibAVSampleCursor: 0x13071eed0>
default    13:02:09.751570-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071eed0> stepInPresentationOrderByCount 1
default    13:02:09.751662-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> readAPacketAndUpdateState
default    13:02:09.751679-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1178027, size: 4096, read: 4096
default    13:02:09.751697-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1182123, size: 5787, read: 5787
default    13:02:09.751714-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> updateStateForPacket Presentation Timestamp {3867/1000 = 3.867}
default    13:02:09.751733-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> updateStateForPacket Decode Timestamp {3867/1000 = 3.867}
default    13:02:09.751749-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.751764-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> updateStateForPacket sampleOffset 1178046
default    13:02:09.751779-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071eed0> updateStateForPacket sampleSize 9860
default    13:02:09.751800-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071eed0> copyWithZone
default    13:02:09.751816-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131014270> init with pts/dts
default    13:02:09.751832-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.751851-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> seekToPTS already at {3867/1000 = 3.867}
default    13:02:09.751866-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> readAPacketAndUpdateState
default    13:02:09.751880-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1187910, size: 4096, read: 4096
default    13:02:09.751898-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1192006, size: 5776, read: 5776
default    13:02:09.751924-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> updateStateForPacket Presentation Timestamp {3900/1000 = 3.900}
default    13:02:09.751940-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> updateStateForPacket Decode Timestamp {3900/1000 = 3.900}
default    13:02:09.751955-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.751970-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> updateStateForPacket sampleOffset 1187929
default    13:02:09.751985-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> updateStateForPacket sampleSize 9849
default    13:02:09.752000-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> seekToPTS already at {3900/1000 = 3.900}
default    13:02:09.752017-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071eed0> created copy <LibAVSampleCursor: 0x131014270>
default    13:02:09.752032-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131014270> copyWithZone
default    13:02:09.752046-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016f00> init with pts/dts
default    13:02:09.752058-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.752079-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> seekToPTS already at {3900/1000 = 3.900}
default    13:02:09.752094-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> readAPacketAndUpdateState
default    13:02:09.752109-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1197782, size: 4096, read: 4096
default    13:02:09.752125-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1201878, size: 5858, read: 5858
default    13:02:09.752141-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket Presentation Timestamp {3933/1000 = 3.933, rounded}
default    13:02:09.752159-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket Decode Timestamp {3933/1000 = 3.933, rounded}
default    13:02:09.752176-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.752281-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket sampleOffset 1197801
default    13:02:09.752341-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket sampleSize 9931
default    13:02:09.752362-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> seekToPTS already at {3933/1000 = 3.933, rounded}
default    13:02:09.752383-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131014270> created copy <LibAVSampleCursor: 0x131016f00>
default    13:02:09.752401-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016f00> stepInDecodeOrderByCount  1
default    13:02:09.752420-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> readAPacketAndUpdateState
default    13:02:09.752437-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1207736, size: 4096, read: 4096
default    13:02:09.752458-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1211832, size: 5720, read: 5720
default    13:02:09.752475-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket Presentation Timestamp {3967/1000 = 3.967}
default    13:02:09.752490-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket Decode Timestamp {3967/1000 = 3.967}
default    13:02:09.752506-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.752521-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket sampleOffset 1207755
default    13:02:09.752535-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket sampleSize 9793
default    13:02:09.752552-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016f00> stepInDecodeOrderByCount  1
default    13:02:09.752568-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> readAPacketAndUpdateState
default    13:02:09.752635-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1217552, size: 4096, read: 4096
default    13:02:09.752651-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1221648, size: 5813, read: 5813
default    13:02:09.752737-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket Presentation Timestamp {4000/1000 = 4.000}
default    13:02:09.752756-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket Decode Timestamp {4000/1000 = 4.000}
default    13:02:09.752774-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.752789-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket sampleOffset 1217571
default    13:02:09.752804-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> updateStateForPacket sampleSize 9886
default    13:02:09.752819-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131014270> stepInDecodeOrderByCount  1
default    13:02:09.752836-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> readAPacketAndUpdateState
default    13:02:09.752852-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1227461, size: 4096, read: 4096
default    13:02:09.752868-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1231557, size: 5970, read: 5970
default    13:02:09.752890-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> updateStateForPacket Presentation Timestamp {4033/1000 = 4.033}
default    13:02:09.752908-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> updateStateForPacket Decode Timestamp {4033/1000 = 4.033}
default    13:02:09.752924-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.752939-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> updateStateForPacket sampleOffset 1227480
default    13:02:09.752990-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131014270> updateStateForPacket sampleSize 10043
default    13:02:09.753091-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.753110-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> seekToPTS already at {3633/1000 = 3.633}
default    13:02:09.753128-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1237527, size: 4096, read: 4096
default    13:02:09.753146-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1241623, size: 5951, read: 5951
default    13:02:09.753166-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Presentation Timestamp {4067/1000 = 4.067}
default    13:02:09.753184-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Decode Timestamp {4067/1000 = 4.067}
default    13:02:09.753200-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.753215-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket sampleOffset 1237546
default    13:02:09.753228-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket sampleSize 10024
default    13:02:09.753274-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x1307203d0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x13101b5a0 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {4067/1000 = 4.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {4067/1000 = 4.067}, DTS = {4067/1000 = 4.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x13071eed0 totalDataLength: 10024 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10024 bytes @ offset 0 Memory Block 0x13282ac04, 10024 bytes (allocator 0x1f7d62490)
}
default    13:02:09.753407-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> copyWithZone
default    13:02:09.753431-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113600> init with pts/dts
default    13:02:09.753446-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.753468-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> seekToPTS already at {4067/1000 = 4.067}
default    13:02:09.753494-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> readAPacketAndUpdateState
default    13:02:09.753511-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1247574, size: 4096, read: 4096
default    13:02:09.753528-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1251670, size: 6005, read: 6005
default    13:02:09.753546-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket Presentation Timestamp {4100/1000 = 4.100}
default    13:02:09.753566-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket Decode Timestamp {4100/1000 = 4.100}
default    13:02:09.753582-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.753597-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket sampleOffset 1247593
default    13:02:09.753613-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket sampleSize 10078
default    13:02:09.753629-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> seekToPTS already at {4100/1000 = 4.100}
default    13:02:09.753644-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> created copy <LibAVSampleCursor: 0x131113600>
default    13:02:09.753668-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113600> stepInDecodeOrderByCount  1
default    13:02:09.753684-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> readAPacketAndUpdateState
default    13:02:09.753701-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1257675, size: 4096, read: 4096
default    13:02:09.753771-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1261771, size: 5922, read: 5922
default    13:02:09.753792-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket Presentation Timestamp {4133/1000 = 4.133}
default    13:02:09.753808-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket Decode Timestamp {4133/1000 = 4.133}
default    13:02:09.753825-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.753840-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket sampleOffset 1257694
default    13:02:09.753855-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket sampleSize 9995
default    13:02:09.753876-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113600> copyWithZone
default    13:02:09.753897-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016f00> init with pts/dts
default    13:02:09.753911-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.753927-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> seekToPTS already at {4133/1000 = 4.133}
default    13:02:09.753947-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016f00> readAPacketAndUpdateState
default    13:02:09.753962-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1267693, size: 4096, read: 4096
default    13:02:09.754035-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1271789, size: 5987, read: 5987
default    13:02:09.755286-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> seekToPTS already at {4133/1000 = 4.133}
default    13:02:09.755304-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> readAPacketAndUpdateState
default    13:02:09.755321-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1318062, size: 4096, read: 4096
default    13:02:09.755338-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1322158, size: 5913, read: 5913
default    13:02:09.755357-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> updateStateForPacket Presentation Timestamp {4333/1000 = 4.333}
default    13:02:09.755373-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> updateStateForPacket Decode Timestamp {4333/1000 = 4.333}
default    13:02:09.755392-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.755407-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> updateStateForPacket sampleOffset 1318081
default    13:02:09.755420-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> updateStateForPacket sampleSize 9986
default    13:02:09.755436-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> seekToPTS already at {4333/1000 = 4.333}
default    13:02:09.755454-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113600> created copy <LibAVSampleCursor: 0x1310181b0>
default    13:02:09.755475-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310181b0> stepInPresentationOrderByCount 1
default    13:02:09.755490-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> readAPacketAndUpdateState
default    13:02:09.755505-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1328071, size: 4096, read: 4096
default    13:02:09.755522-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1332167, size: 5884, read: 5884
default    13:02:09.755538-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> updateStateForPacket Presentation Timestamp {4367/1000 = 4.367}
default    13:02:09.755556-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> updateStateForPacket Decode Timestamp {4367/1000 = 4.367}
default    13:02:09.755570-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.755585-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> updateStateForPacket sampleOffset 1328090
default    13:02:09.755599-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310181b0> updateStateForPacket sampleSize 9957
default    13:02:09.755620-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310181b0> copyWithZone
default    13:02:09.755637-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016e80> init with pts/dts
default    13:02:09.755650-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.755666-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> seekToPTS already at {4367/1000 = 4.367}
default    13:02:09.755681-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> readAPacketAndUpdateState
default    13:02:09.755696-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1338051, size: 4096, read: 4096
default    13:02:09.755712-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1342147, size: 5965, read: 5965
default    13:02:09.755728-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> updateStateForPacket Presentation Timestamp {4400/1000 = 4.400}
default    13:02:09.755743-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> updateStateForPacket Decode Timestamp {4400/1000 = 4.400}
default    13:02:09.755760-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.755774-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> updateStateForPacket sampleOffset 1338070
default    13:02:09.755788-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> updateStateForPacket sampleSize 10038
default    13:02:09.755803-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> seekToPTS already at {4400/1000 = 4.400}
default    13:02:09.755820-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310181b0> created copy <LibAVSampleCursor: 0x131016e80>
default    13:02:09.755836-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016e80> copyWithZone
default    13:02:09.755851-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019730> init with pts/dts
default    13:02:09.755865-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.755881-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> seekToPTS already at {4400/1000 = 4.400}
default    13:02:09.755894-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> readAPacketAndUpdateState
default    13:02:09.755909-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1348112, size: 4096, read: 4096
default    13:02:09.755925-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1352208, size: 5929, read: 5929
default    13:02:09.755942-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket Presentation Timestamp {4433/1000 = 4.433}
default    13:02:09.755956-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket Decode Timestamp {4433/1000 = 4.433}
default    13:02:09.755973-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.755986-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket sampleOffset 1348131
default    13:02:09.756006-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket sampleSize 10002
default    13:02:09.756021-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> seekToPTS already at {4433/1000 = 4.433}
default    13:02:09.756038-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016e80> created copy <LibAVSampleCursor: 0x131019730>
default    13:02:09.756055-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019730> stepInDecodeOrderByCount  1
default    13:02:09.756068-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> readAPacketAndUpdateState
default    13:02:09.756083-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1358137, size: 4096, read: 4096
default    13:02:09.756099-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1362233, size: 5987, read: 5987
default    13:02:09.756117-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket Presentation Timestamp {4467/1000 = 4.467, rounded}
default    13:02:09.756133-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket Decode Timestamp {4467/1000 = 4.467, rounded}
default    13:02:09.756148-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.756161-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket sampleOffset 1358156
default    13:02:09.756175-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket sampleSize 10060
default    13:02:09.756192-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019730> stepInDecodeOrderByCount  1
default    13:02:09.756207-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> readAPacketAndUpdateState
default    13:02:09.756222-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1368220, size: 4096, read: 4096
default    13:02:09.756237-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1372316, size: 5872, read: 5872
default    13:02:09.756253-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket Presentation Timestamp {4500/1000 = 4.500}
default    13:02:09.756268-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket Decode Timestamp {4500/1000 = 4.500}
default    13:02:09.756283-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.756298-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket sampleOffset 1368239
default    13:02:09.756311-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019730> updateStateForPacket sampleSize 9945
default    13:02:09.756325-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016e80> stepInDecodeOrderByCount  1
default    13:02:09.756341-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> readAPacketAndUpdateState
default    13:02:09.756356-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1378188, size: 4096, read: 4096
default    13:02:09.756371-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1382284, size: 5994, read: 5994
default    13:02:09.756387-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> updateStateForPacket Presentation Timestamp {4533/1000 = 4.533}
default    13:02:09.756403-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> updateStateForPacket Decode Timestamp {4533/1000 = 4.533}
default    13:02:09.756418-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.756433-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> updateStateForPacket sampleOffset 1378207
default    13:02:09.756447-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016e80> updateStateForPacket sampleSize 10067
default    13:02:09.756542-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.756565-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> seekToPTS already at {4133/1000 = 4.133}
default    13:02:09.756582-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1388278, size: 4096, read: 4096
default    13:02:09.756601-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1392374, size: 5930, read: 5930
default    13:02:09.756619-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket Presentation Timestamp {4567/1000 = 4.567}
default    13:02:09.756637-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket Decode Timestamp {4567/1000 = 4.567}
default    13:02:09.756654-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.756669-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket sampleOffset 1388297
default    13:02:09.756685-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> updateStateForPacket sampleSize 10003
default    13:02:09.756728-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113600> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x130720dc0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x131113680 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {4567/1000 = 4.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {4567/1000 = 4.567}, DTS = {4567/1000 = 4.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x13071e970 totalDataLength: 10003 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10003 bytes @ offset 0 Memory Block 0x13282ac04, 10003 bytes (allocator 0x1f7d62490)
}
default    13:02:09.756849-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113600> copyWithZone
default    13:02:09.756867-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130617870> init with pts/dts
default    13:02:09.756882-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.756901-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> seekToPTS already at {4567/1000 = 4.567}
default    13:02:09.756918-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> readAPacketAndUpdateState
default    13:02:09.756934-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1398304, size: 4096, read: 4096
default    13:02:09.756951-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1402400, size: 5939, read: 5939
default    13:02:09.756969-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket Presentation Timestamp {4600/1000 = 4.600, rounded}
default    13:02:09.756988-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket Decode Timestamp {4600/1000 = 4.600, rounded}
default    13:02:09.757004-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.757019-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket sampleOffset 1398323
default    13:02:09.757034-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket sampleSize 10012
default    13:02:09.757050-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> seekToPTS already at {4600/1000 = 4.600, rounded}
default    13:02:09.757065-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113600> created copy <LibAVSampleCursor: 0x130617870>
default    13:02:09.757086-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130617870> stepInDecodeOrderByCount  1
default    13:02:09.757103-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> readAPacketAndUpdateState
default    13:02:09.757118-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1408339, size: 4096, read: 4096
default    13:02:09.757136-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1412435, size: 5987, read: 5987
default    13:02:09.757153-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket Presentation Timestamp {4633/1000 = 4.633}
default    13:02:09.757170-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket Decode Timestamp {4633/1000 = 4.633}
default    13:02:09.757186-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.757200-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket sampleOffset 1408358
default    13:02:09.757216-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket sampleSize 10060
default    13:02:09.757237-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130617870> copyWithZone
default    13:02:09.757255-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130616280> init with pts/dts
default    13:02:09.757268-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.757286-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616280> seekToPTS already at {4633/1000 = 4.633}
default    13:02:09.757302-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616280> readAPacketAndUpdateState
default    13:02:09.757317-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1418422, size: 4096, read: 4096
default    13:02:09.757332-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1422518, size: 5910, read: 5910
default    13:02:09.757349-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616280> updateStateForPacket Presentation Timestamp {4667/1000 = 4.667}
default    13:02:09.757368-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616280> updateStateForPacket Decode Timestamp {4667/1000 = 4.667}
default    13:02:09.757383-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616280> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.757399-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616280> updateStateForPacket sampleOffset 1418441
default    13:02:09.757412-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616280> updateStateForPacket sampleSize 9983
default    13:02:09.757433-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130616280> seekToPTS already at {4667/1000 = 4.667}
default    13:02:09.757452-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130617870> created copy <LibAVSampleCursor: 0x130616280>
default    13:02:09.757469-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130616280> copyWithZone
default    13:02:09.757483-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130618ab0> init with pts/dts
default    13:02:09.757497-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.757513-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618ab0> seekToPTS already at {4667/1000 = 4.667}
default    13:02:09.757528-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618ab0> readAPacketAndUpdateState
default    13:02:09.759084-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> readAPacketAndUpdateState
default    13:02:09.759100-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1508243, size: 4096, read: 4096
default    13:02:09.759116-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1512339, size: 5930, read: 5930
default    13:02:09.759135-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> updateStateForPacket Presentation Timestamp {4967/1000 = 4.967, rounded}
default    13:02:09.759150-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> updateStateForPacket Decode Timestamp {4967/1000 = 4.967, rounded}
default    13:02:09.759166-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.759180-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> updateStateForPacket sampleOffset 1508262
default    13:02:09.759195-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> updateStateForPacket sampleSize 10003
default    13:02:09.759211-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130722450> stepInDecodeOrderByCount  1
default    13:02:09.759227-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> readAPacketAndUpdateState
default    13:02:09.759243-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1518269, size: 4096, read: 4096
default    13:02:09.759258-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1522365, size: 5824, read: 5824
default    13:02:09.759275-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> updateStateForPacket Presentation Timestamp {5000/1000 = 5.000}
default    13:02:09.759291-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> updateStateForPacket Decode Timestamp {5000/1000 = 5.000}
default    13:02:09.759308-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.759321-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> updateStateForPacket sampleOffset 1518288
default    13:02:09.759335-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722450> updateStateForPacket sampleSize 9897
default    13:02:09.759350-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130721fb0> stepInDecodeOrderByCount  1
default    13:02:09.759365-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721fb0> readAPacketAndUpdateState
default    13:02:09.759378-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1528189, size: 4096, read: 4096
default    13:02:09.759393-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1532285, size: 5863, read: 5863
default    13:02:09.759409-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721fb0> updateStateForPacket Presentation Timestamp {5033/1000 = 5.033}
default    13:02:09.759426-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721fb0> updateStateForPacket Decode Timestamp {5033/1000 = 5.033}
default    13:02:09.759442-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721fb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.759455-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721fb0> updateStateForPacket sampleOffset 1528208
default    13:02:09.759469-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721fb0> updateStateForPacket sampleSize 9936
default    13:02:09.759568-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.759592-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> seekToPTS already at {4633/1000 = 4.633}
default    13:02:09.759610-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1538148, size: 4096, read: 4096
default    13:02:09.759629-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1542244, size: 5908, read: 5908
default    13:02:09.759648-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket Presentation Timestamp {5067/1000 = 5.067}
default    13:02:09.759665-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket Decode Timestamp {5067/1000 = 5.067}
default    13:02:09.759682-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.759697-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket sampleOffset 1538167
default    13:02:09.759713-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> updateStateForPacket sampleSize 9981
default    13:02:09.759759-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617870> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x1310184a0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x130617990 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {5067/1000 = 5.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {5067/1000 = 5.067}, DTS = {5067/1000 = 5.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x131018950 totalDataLength: 9981 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 9981 bytes @ offset 0 Memory Block 0x132013204, 9981 bytes (allocator 0x1f7d62490)
}
default    13:02:09.759886-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130617870> copyWithZone
default    13:02:09.759905-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310154e0> init with pts/dts
default    13:02:09.759919-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.759938-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> seekToPTS already at {5067/1000 = 5.067}
default    13:02:09.759954-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> readAPacketAndUpdateState
default    13:02:09.759969-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1548152, size: 4096, read: 4096
default    13:02:09.759988-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1552248, size: 5969, read: 5969
default    13:02:09.760005-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket Presentation Timestamp {5100/1000 = 5.100, rounded}
default    13:02:09.760023-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket Decode Timestamp {5100/1000 = 5.100, rounded}
default    13:02:09.760039-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.760054-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket sampleOffset 1548171
default    13:02:09.760067-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket sampleSize 10042
default    13:02:09.760083-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> seekToPTS already at {5100/1000 = 5.100, rounded}
default    13:02:09.760101-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130617870> created copy <LibAVSampleCursor: 0x1310154e0>
default    13:02:09.760122-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310154e0> stepInDecodeOrderByCount  1
default    13:02:09.760138-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> readAPacketAndUpdateState
default    13:02:09.760154-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1558217, size: 4096, read: 4096
default    13:02:09.760169-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1562313, size: 5879, read: 5879
default    13:02:09.760188-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket Presentation Timestamp {5133/1000 = 5.133}
default    13:02:09.760205-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket Decode Timestamp {5133/1000 = 5.133}
default    13:02:09.760220-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.760235-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket sampleOffset 1558236
default    13:02:09.760250-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket sampleSize 9952
default    13:02:09.760270-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310154e0> copyWithZone
default    13:02:09.760286-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019320> init with pts/dts
default    13:02:09.760301-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.760318-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019320> seekToPTS already at {5133/1000 = 5.133}
default    13:02:09.760333-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019320> readAPacketAndUpdateState
default    13:02:09.760349-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1568192, size: 4096, read: 4096
default    13:02:09.760365-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1572288, size: 5926, read: 5926
default    13:02:09.760381-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019320> updateStateForPacket Presentation Timestamp {5167/1000 = 5.167}
default    13:02:09.760397-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019320> updateStateForPacket Decode Timestamp {5167/1000 = 5.167}
default    13:02:09.760413-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019320> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.760428-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019320> updateStateForPacket sampleOffset 1568211
default    13:02:09.760442-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019320> updateStateForPacket sampleSize 9999
default    13:02:09.760462-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019320> seekToPTS already at {5167/1000 = 5.167}
default    13:02:09.760481-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310154e0> created copy <LibAVSampleCursor: 0x131019320>
default    13:02:09.760497-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019320> copyWithZone
default    13:02:09.760512-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101a5a0> init with pts/dts
default    13:02:09.760524-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.760540-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> seekToPTS already at {5167/1000 = 5.167}
default    13:02:09.760556-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> readAPacketAndUpdateState
default    13:02:09.760572-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1578214, size: 4096, read: 4096
default    13:02:09.760591-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1582310, size: 5867, read: 5867
default    13:02:09.760607-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket Presentation Timestamp {5200/1000 = 5.200}
default    13:02:09.760623-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket Decode Timestamp {5200/1000 = 5.200}
default    13:02:09.760642-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.760657-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket sampleOffset 1578233
default    13:02:09.760672-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket sampleSize 9940
default    13:02:09.760687-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> seekToPTS already at {5200/1000 = 5.200}
default    13:02:09.760704-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019320> created copy <LibAVSampleCursor: 0x13101a5a0>
default    13:02:09.760719-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101a5a0> stepInDecodeOrderByCount  1
default    13:02:09.760735-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> readAPacketAndUpdateState
default    13:02:09.760750-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1588177, size: 4096, read: 4096
default    13:02:09.760765-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1592273, size: 5938, read: 5938
default    13:02:09.760782-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket Presentation Timestamp {5233/1000 = 5.233, rounded}
default    13:02:09.760798-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket Decode Timestamp {5233/1000 = 5.233, rounded}
default    13:02:09.760814-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.760837-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket sampleOffset 1588196
default    13:02:09.760886-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket sampleSize 10011
default    13:02:09.760968-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101a5a0> stepInDecodeOrderByCount  1
default    13:02:09.761019-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> readAPacketAndUpdateState
default    13:02:09.761074-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1598211, size: 4096, read: 4096
default    13:02:09.761133-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1602307, size: 5928, read: 5928
default    13:02:09.761183-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket Presentation Timestamp {5267/1000 = 5.267}
default    13:02:09.761240-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket Decode Timestamp {5267/1000 = 5.267}
default    13:02:09.761282-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.761352-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket sampleOffset 1598230
default    13:02:09.761399-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101a5a0> updateStateForPacket sampleSize 10001
default    13:02:09.761452-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019320> stepInDecodeOrderByCount  1
default    13:02:09.761514-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019320> readAPacketAndUpdateState
default    13:02:09.762833-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> readAPacketAndUpdateState
default    13:02:09.762892-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1648314, size: 4096, read: 4096
default    13:02:09.762912-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1652410, size: 5945, read: 5945
default    13:02:09.762932-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket Presentation Timestamp {5433/1000 = 5.433}
default    13:02:09.762973-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket Decode Timestamp {5433/1000 = 5.433}
default    13:02:09.763001-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.763017-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket sampleOffset 1648333
default    13:02:09.763060-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket sampleSize 10018
default    13:02:09.763134-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> seekToPTS already at {5433/1000 = 5.433}
default    13:02:09.763183-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306174f0> created copy <LibAVSampleCursor: 0x130615a20>
default    13:02:09.763257-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615a20> stepInDecodeOrderByCount  1
default    13:02:09.763309-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> readAPacketAndUpdateState
default    13:02:09.763382-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1658355, size: 4096, read: 4096
default    13:02:09.763432-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1662451, size: 6016, read: 6016
default    13:02:09.763454-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket Presentation Timestamp {5467/1000 = 5.467, rounded}
default    13:02:09.763506-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket Decode Timestamp {5467/1000 = 5.467, rounded}
default    13:02:09.763573-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.763607-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket sampleOffset 1658374
default    13:02:09.763653-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket sampleSize 10089
default    13:02:09.763705-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130615a20> stepInDecodeOrderByCount  1
default    13:02:09.763772-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> readAPacketAndUpdateState
default    13:02:09.763843-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1668467, size: 4096, read: 4096
default    13:02:09.763864-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1672563, size: 5968, read: 5968
default    13:02:09.763998-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket Presentation Timestamp {5500/1000 = 5.500}
default    13:02:09.764111-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket Decode Timestamp {5500/1000 = 5.500}
default    13:02:09.764158-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.764209-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket sampleOffset 1668486
default    13:02:09.764269-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130615a20> updateStateForPacket sampleSize 10041
default    13:02:09.764306-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306174f0> stepInDecodeOrderByCount  1
default    13:02:09.764378-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306174f0> readAPacketAndUpdateState
default    13:02:09.764396-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1678531, size: 4096, read: 4096
default    13:02:09.764415-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1682627, size: 5900, read: 5900
default    13:02:09.764436-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306174f0> updateStateForPacket Presentation Timestamp {5533/1000 = 5.533}
default    13:02:09.764457-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306174f0> updateStateForPacket Decode Timestamp {5533/1000 = 5.533}
default    13:02:09.764477-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306174f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.764493-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306174f0> updateStateForPacket sampleOffset 1678550
default    13:02:09.764509-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306174f0> updateStateForPacket sampleSize 9973
default    13:02:09.764643-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.764666-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> seekToPTS already at {5133/1000 = 5.133}
default    13:02:09.764684-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1688527, size: 4096, read: 4096
default    13:02:09.764705-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1692623, size: 5915, read: 5915
default    13:02:09.764725-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket Presentation Timestamp {5567/1000 = 5.567}
default    13:02:09.764744-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket Decode Timestamp {5567/1000 = 5.567}
default    13:02:09.764760-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.764775-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket sampleOffset 1688546
default    13:02:09.764790-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> updateStateForPacket sampleSize 9988
default    13:02:09.764837-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310154e0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x131113ce0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x1310159f0 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {5567/1000 = 5.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {5567/1000 = 5.567}, DTS = {5567/1000 = 5.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x131113c50 totalDataLength: 9988 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 9988 bytes @ offset 0 Memory Block 0x131817204, 9988 bytes (allocator 0x1f7d62490)
}
default    13:02:09.764987-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310154e0> copyWithZone
default    13:02:09.765007-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130618e90> init with pts/dts
default    13:02:09.765022-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.765043-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> seekToPTS already at {5567/1000 = 5.567}
default    13:02:09.765058-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> readAPacketAndUpdateState
default    13:02:09.765079-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1698538, size: 4096, read: 4096
default    13:02:09.765096-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1702634, size: 5998, read: 5998
default    13:02:09.765117-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket Presentation Timestamp {5600/1000 = 5.600, rounded}
default    13:02:09.765136-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket Decode Timestamp {5600/1000 = 5.600, rounded}
default    13:02:09.765153-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.765170-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket sampleOffset 1698557
default    13:02:09.765185-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket sampleSize 10071
default    13:02:09.765201-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> seekToPTS already at {5600/1000 = 5.600, rounded}
default    13:02:09.765217-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310154e0> created copy <LibAVSampleCursor: 0x130618e90>
default    13:02:09.765239-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130618e90> stepInDecodeOrderByCount  1
default    13:02:09.765254-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> readAPacketAndUpdateState
default    13:02:09.765269-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1708632, size: 4096, read: 4096
default    13:02:09.765285-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1712728, size: 5965, read: 5965
default    13:02:09.765305-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket Presentation Timestamp {5633/1000 = 5.633}
default    13:02:09.765322-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket Decode Timestamp {5633/1000 = 5.633}
default    13:02:09.765340-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.765355-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket sampleOffset 1708651
default    13:02:09.765368-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket sampleSize 10038
default    13:02:09.765389-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130618e90> copyWithZone
default    13:02:09.765407-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130617d90> init with pts/dts
default    13:02:09.765420-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.765438-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617d90> seekToPTS already at {5633/1000 = 5.633}
default    13:02:09.765455-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617d90> readAPacketAndUpdateState
default    13:02:09.765470-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1718693, size: 4096, read: 4096
default    13:02:09.765486-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1722789, size: 6033, read: 6033
default    13:02:09.765502-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617d90> updateStateForPacket Presentation Timestamp {5667/1000 = 5.667}
default    13:02:09.765521-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617d90> updateStateForPacket Decode Timestamp {5667/1000 = 5.667}
default    13:02:09.765537-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617d90> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.765552-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617d90> updateStateForPacket sampleOffset 1718712
default    13:02:09.765566-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617d90> updateStateForPacket sampleSize 10106
default    13:02:09.765587-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130617d90> seekToPTS already at {5667/1000 = 5.667}
default    13:02:09.765604-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130618e90> created copy <LibAVSampleCursor: 0x130617d90>
default    13:02:09.765619-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130617d90> copyWithZone
default    13:02:09.765635-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130619bb0> init with pts/dts
default    13:02:09.765649-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.765666-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> seekToPTS already at {5667/1000 = 5.667}
default    13:02:09.765681-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> readAPacketAndUpdateState
default    13:02:09.765696-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1728822, size: 4096, read: 4096
default    13:02:09.765712-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1732918, size: 6036, read: 6036
default    13:02:09.765728-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> updateStateForPacket Presentation Timestamp {5700/1000 = 5.700}
default    13:02:09.765747-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> updateStateForPacket Decode Timestamp {5700/1000 = 5.700}
default    13:02:09.765763-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.765779-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> updateStateForPacket sampleOffset 1728841
default    13:02:09.765793-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> updateStateForPacket sampleSize 10109
default    13:02:09.765810-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> seekToPTS already at {5700/1000 = 5.700}
default    13:02:09.765825-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130617d90> created copy <LibAVSampleCursor: 0x130619bb0>
default    13:02:09.765841-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130619bb0> stepInDecodeOrderByCount  1
default    13:02:09.765855-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> readAPacketAndUpdateState
default    13:02:09.765870-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1738954, size: 4096, read: 4096
default    13:02:09.765883-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1743050, size: 6021, read: 6021
default    13:02:09.765902-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> updateStateForPacket Presentation Timestamp {5733/1000 = 5.733, rounded}
default    13:02:09.765918-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> updateStateForPacket Decode Timestamp {5733/1000 = 5.733, rounded}
default    13:02:09.765933-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.765948-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> updateStateForPacket sampleOffset 1738973
default    13:02:09.765960-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> updateStateForPacket sampleSize 10094
default    13:02:09.765978-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130619bb0> stepInDecodeOrderByCount  1
default    13:02:09.765994-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619bb0> readAPacketAndUpdateState
default    13:02:09.766009-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1749071, size: 4096, read: 4096
default    13:02:09.766024-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1753167, size: 6030, read: 6030
default    13:02:09.767354-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ca70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.767370-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ca70> updateStateForPacket sampleOffset 1810009
default    13:02:09.767385-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ca70> updateStateForPacket sampleSize 10203
default    13:02:09.767401-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101ca70> stepInDecodeOrderByCount  1
default    13:02:09.767416-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ca70> readAPacketAndUpdateState
default    13:02:09.767431-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1820216, size: 4096, read: 4096
default    13:02:09.767446-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1824312, size: 5972, read: 5972
default    13:02:09.767462-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ca70> updateStateForPacket Presentation Timestamp {6000/1000 = 6.000}
default    13:02:09.767478-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ca70> updateStateForPacket Decode Timestamp {6000/1000 = 6.000}
default    13:02:09.767493-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ca70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.767507-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ca70> updateStateForPacket sampleOffset 1820235
default    13:02:09.767519-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ca70> updateStateForPacket sampleSize 10045
default    13:02:09.767534-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019200> stepInDecodeOrderByCount  1
default    13:02:09.767548-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019200> readAPacketAndUpdateState
default    13:02:09.767561-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1830284, size: 4096, read: 4096
default    13:02:09.767576-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1834380, size: 5968, read: 5968
default    13:02:09.767596-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019200> updateStateForPacket Presentation Timestamp {6033/1000 = 6.033}
default    13:02:09.767611-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019200> updateStateForPacket Decode Timestamp {6033/1000 = 6.033}
default    13:02:09.767627-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019200> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.767641-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019200> updateStateForPacket sampleOffset 1830303
default    13:02:09.767712-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019200> updateStateForPacket sampleSize 10041
default    13:02:09.767817-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.767838-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> seekToPTS already at {5633/1000 = 5.633}
default    13:02:09.767858-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1840348, size: 4096, read: 4096
default    13:02:09.767875-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1844444, size: 5980, read: 5980
default    13:02:09.767913-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket Presentation Timestamp {6067/1000 = 6.067}
default    13:02:09.767935-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket Decode Timestamp {6067/1000 = 6.067}
default    13:02:09.767954-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.767968-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket sampleOffset 1840367
default    13:02:09.767985-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> updateStateForPacket sampleSize 10053
default    13:02:09.768033-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130618e90> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x1306188f0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x13060e060 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {6067/1000 = 6.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {6067/1000 = 6.067}, DTS = {6067/1000 = 6.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x130616ba0 totalDataLength: 10053 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10053 bytes @ offset 0 Memory Block 0x130819804, 10053 bytes (allocator 0x1f7d62490)
}
default    13:02:09.768162-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130618e90> copyWithZone
default    13:02:09.768183-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> init with pts/dts
default    13:02:09.768198-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.768215-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> seekToPTS already at {6067/1000 = 6.067}
default    13:02:09.768232-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> readAPacketAndUpdateState
default    13:02:09.768248-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1850424, size: 4096, read: 4096
default    13:02:09.768266-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1854520, size: 6096, read: 6096
default    13:02:09.768286-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Presentation Timestamp {6100/1000 = 6.100, rounded}
default    13:02:09.768304-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Decode Timestamp {6100/1000 = 6.100, rounded}
default    13:02:09.768321-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.768336-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket sampleOffset 1850443
default    13:02:09.768349-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket sampleSize 10169
default    13:02:09.768367-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> seekToPTS already at {6100/1000 = 6.100, rounded}
default    13:02:09.768385-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130618e90> created copy <LibAVSampleCursor: 0x1310163d0>
default    13:02:09.768410-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> stepInDecodeOrderByCount  1
default    13:02:09.768426-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> readAPacketAndUpdateState
default    13:02:09.768441-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1860616, size: 4096, read: 4096
default    13:02:09.768456-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1864712, size: 6050, read: 6050
default    13:02:09.768476-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Presentation Timestamp {6133/1000 = 6.133}
default    13:02:09.768491-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Decode Timestamp {6133/1000 = 6.133}
default    13:02:09.768507-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.768522-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket sampleOffset 1860635
default    13:02:09.768568-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket sampleSize 10123
default    13:02:09.768610-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> copyWithZone
default    13:02:09.768629-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101b030> init with pts/dts
default    13:02:09.768641-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.768659-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> seekToPTS already at {6133/1000 = 6.133}
default    13:02:09.768677-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> readAPacketAndUpdateState
default    13:02:09.768692-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1870762, size: 4096, read: 4096
default    13:02:09.768707-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1874858, size: 6128, read: 6128
default    13:02:09.768765-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> updateStateForPacket Presentation Timestamp {6167/1000 = 6.167}
default    13:02:09.768786-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> updateStateForPacket Decode Timestamp {6167/1000 = 6.167}
default    13:02:09.768805-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.768822-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> updateStateForPacket sampleOffset 1870781
default    13:02:09.768838-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> updateStateForPacket sampleSize 10201
default    13:02:09.768860-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> seekToPTS already at {6167/1000 = 6.167}
default    13:02:09.768878-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> created copy <LibAVSampleCursor: 0x13101b030>
default    13:02:09.768898-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101b030> copyWithZone
default    13:02:09.768913-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306151c0> init with pts/dts
default    13:02:09.768929-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.768949-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> seekToPTS already at {6167/1000 = 6.167}
default    13:02:09.768965-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> readAPacketAndUpdateState
default    13:02:09.768982-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1880986, size: 4096, read: 4096
default    13:02:09.769001-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1885082, size: 6014, read: 6014
default    13:02:09.769020-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Presentation Timestamp {6200/1000 = 6.200}
default    13:02:09.769038-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Decode Timestamp {6200/1000 = 6.200}
default    13:02:09.769056-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.769072-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleOffset 1881005
default    13:02:09.769088-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleSize 10087
default    13:02:09.769104-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> seekToPTS already at {6200/1000 = 6.200}
default    13:02:09.769123-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101b030> created copy <LibAVSampleCursor: 0x1306151c0>
default    13:02:09.769140-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306151c0> stepInDecodeOrderByCount  1
default    13:02:09.769156-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> readAPacketAndUpdateState
default    13:02:09.769172-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1891096, size: 4096, read: 4096
default    13:02:09.769190-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1895192, size: 6088, read: 6088
default    13:02:09.769210-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Presentation Timestamp {6233/1000 = 6.233, rounded}
default    13:02:09.769228-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Decode Timestamp {6233/1000 = 6.233, rounded}
default    13:02:09.769246-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.769262-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleOffset 1891115
default    13:02:09.769277-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleSize 10161
default    13:02:09.769294-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306151c0> stepInDecodeOrderByCount  1
default    13:02:09.769311-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> readAPacketAndUpdateState
default    13:02:09.769329-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1901280, size: 4096, read: 4096
default    13:02:09.769344-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1905376, size: 6090, read: 6090
default    13:02:09.769365-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Presentation Timestamp {6267/1000 = 6.267}
default    13:02:09.769383-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Decode Timestamp {6267/1000 = 6.267}
default    13:02:09.769399-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.769416-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleOffset 1901299
default    13:02:09.769432-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306151c0> updateStateForPacket sampleSize 10163
default    13:02:09.769447-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101b030> stepInDecodeOrderByCount  1
default    13:02:09.769463-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> readAPacketAndUpdateState
default    13:02:09.769479-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1911466, size: 4096, read: 4096
default    13:02:09.769496-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1915562, size: 6046, read: 6046
default    13:02:09.769515-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> updateStateForPacket Presentation Timestamp {6300/1000 = 6.300}
default    13:02:09.769535-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> updateStateForPacket Decode Timestamp {6300/1000 = 6.300}
default    13:02:09.769551-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.769567-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> updateStateForPacket sampleOffset 1911485
default    13:02:09.769582-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101b030> updateStateForPacket sampleSize 10119
error    13:02:09.769624-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.769781-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> copyWithZone
default    13:02:09.769804-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307209c0> init with pts/dts
default    13:02:09.769820-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.769845-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307209c0> seekToPTS already at {6133/1000 = 6.133}
default    13:02:09.769862-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307209c0> readAPacketAndUpdateState
default    13:02:09.769880-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1921608, size: 4096, read: 4096
default    13:02:09.769901-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 1925704, size: 6078, read: 6078
default    13:02:09.769921-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307209c0> updateStateForPacket Presentation Timestamp {6333/1000 = 6.333}
default    13:02:09.769939-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307209c0> updateStateForPacket Decode Timestamp {6333/1000 = 6.333}
default    13:02:09.769957-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307209c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.769972-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307209c0> updateStateForPacket sampleOffset 1921627
default    13:02:09.769987-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307209c0> updateStateForPacket sampleSize 10151
default    13:02:09.770003-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307209c0> seekToPTS already at {6333/1000 = 6.333}
default    13:02:09.770020-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> created copy <LibAVSampleCursor: 0x1307209c0>
default    13:02:09.770041-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307209c0> stepInPresentationOrderByCount 1
default    13:02:09.770056-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307209c0> readAPacketAndUpdateState
default    13:02:09.771545-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> copyWithZone
default    13:02:09.771569-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113ed0> init with pts/dts
default    13:02:09.771584-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.771605-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> seekToPTS already at {6567/1000 = 6.567}
default    13:02:09.771621-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> readAPacketAndUpdateState
default    13:02:09.771639-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2002976, size: 4096, read: 4096
default    13:02:09.771660-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2007072, size: 6057, read: 6057
default    13:02:09.771680-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> updateStateForPacket Presentation Timestamp {6600/1000 = 6.600, rounded}
default    13:02:09.771698-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> updateStateForPacket Decode Timestamp {6600/1000 = 6.600, rounded}
default    13:02:09.771714-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.771729-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> updateStateForPacket sampleOffset 2002995
default    13:02:09.771744-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> updateStateForPacket sampleSize 10130
default    13:02:09.771759-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> seekToPTS already at {6600/1000 = 6.600, rounded}
default    13:02:09.771776-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> created copy <LibAVSampleCursor: 0x131113ed0>
default    13:02:09.771799-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113ed0> stepInDecodeOrderByCount  1
default    13:02:09.771816-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> readAPacketAndUpdateState
default    13:02:09.771831-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2013129, size: 4096, read: 4096
default    13:02:09.771847-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2017225, size: 6102, read: 6102
default    13:02:09.771866-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> updateStateForPacket Presentation Timestamp {6633/1000 = 6.633}
default    13:02:09.771883-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> updateStateForPacket Decode Timestamp {6633/1000 = 6.633}
default    13:02:09.771898-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.771913-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> updateStateForPacket sampleOffset 2013148
default    13:02:09.771927-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113ed0> updateStateForPacket sampleSize 10175
default    13:02:09.771950-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113ed0> copyWithZone
default    13:02:09.771967-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115170> init with pts/dts
default    13:02:09.771981-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.771997-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> seekToPTS already at {6633/1000 = 6.633}
default    13:02:09.772012-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> readAPacketAndUpdateState
default    13:02:09.772027-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2023327, size: 4096, read: 4096
default    13:02:09.772043-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2027423, size: 6012, read: 6012
default    13:02:09.772061-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> updateStateForPacket Presentation Timestamp {6667/1000 = 6.667}
default    13:02:09.772078-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> updateStateForPacket Decode Timestamp {6667/1000 = 6.667}
default    13:02:09.772094-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.772109-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> updateStateForPacket sampleOffset 2023346
default    13:02:09.772123-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> updateStateForPacket sampleSize 10085
default    13:02:09.772142-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> seekToPTS already at {6667/1000 = 6.667}
default    13:02:09.772161-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113ed0> created copy <LibAVSampleCursor: 0x131115170>
default    13:02:09.772177-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115170> copyWithZone
default    13:02:09.772192-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115990> init with pts/dts
default    13:02:09.772205-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.772222-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> seekToPTS already at {6667/1000 = 6.667}
default    13:02:09.772236-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> readAPacketAndUpdateState
default    13:02:09.772253-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2033435, size: 4096, read: 4096
default    13:02:09.772269-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2037531, size: 6016, read: 6016
default    13:02:09.772285-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket Presentation Timestamp {6700/1000 = 6.700}
default    13:02:09.772304-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket Decode Timestamp {6700/1000 = 6.700}
default    13:02:09.772319-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.772336-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket sampleOffset 2033454
default    13:02:09.772351-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket sampleSize 10089
default    13:02:09.772366-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> seekToPTS already at {6700/1000 = 6.700}
default    13:02:09.772382-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115170> created copy <LibAVSampleCursor: 0x131115990>
default    13:02:09.772397-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115990> stepInDecodeOrderByCount  1
default    13:02:09.772412-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> readAPacketAndUpdateState
default    13:02:09.772427-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2043547, size: 4096, read: 4096
default    13:02:09.772442-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2047643, size: 6091, read: 6091
default    13:02:09.772459-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket Presentation Timestamp {6733/1000 = 6.733, rounded}
default    13:02:09.772475-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket Decode Timestamp {6733/1000 = 6.733, rounded}
default    13:02:09.772521-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.772541-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket sampleOffset 2043566
default    13:02:09.772558-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket sampleSize 10164
default    13:02:09.772603-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115990> stepInDecodeOrderByCount  1
default    13:02:09.772644-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> readAPacketAndUpdateState
default    13:02:09.772661-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2053734, size: 4096, read: 4096
default    13:02:09.772677-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2057830, size: 6065, read: 6065
default    13:02:09.772696-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket Presentation Timestamp {6767/1000 = 6.767}
default    13:02:09.772713-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket Decode Timestamp {6767/1000 = 6.767}
default    13:02:09.772730-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.772746-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket sampleOffset 2053753
default    13:02:09.772811-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115990> updateStateForPacket sampleSize 10138
default    13:02:09.772826-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115170> stepInDecodeOrderByCount  1
default    13:02:09.772841-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> readAPacketAndUpdateState
default    13:02:09.772857-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2063895, size: 4096, read: 4096
default    13:02:09.772874-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2067991, size: 6104, read: 6104
default    13:02:09.772891-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> updateStateForPacket Presentation Timestamp {6800/1000 = 6.800}
default    13:02:09.772907-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> updateStateForPacket Decode Timestamp {6800/1000 = 6.800}
default    13:02:09.772923-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.772938-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> updateStateForPacket sampleOffset 2063914
default    13:02:09.772953-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115170> updateStateForPacket sampleSize 10177
error    13:02:09.772974-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.773063-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113ed0> copyWithZone
default    13:02:09.773086-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115f70> init with pts/dts
default    13:02:09.773099-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.773117-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> seekToPTS already at {6633/1000 = 6.633}
default    13:02:09.773133-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> readAPacketAndUpdateState
default    13:02:09.773148-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2074095, size: 4096, read: 4096
default    13:02:09.773164-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2078191, size: 6032, read: 6032
default    13:02:09.773181-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> updateStateForPacket Presentation Timestamp {6833/1000 = 6.833}
default    13:02:09.773200-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> updateStateForPacket Decode Timestamp {6833/1000 = 6.833}
default    13:02:09.773215-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.773230-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> updateStateForPacket sampleOffset 2074114
default    13:02:09.773243-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> updateStateForPacket sampleSize 10105
default    13:02:09.773258-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> seekToPTS already at {6833/1000 = 6.833}
default    13:02:09.773274-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113ed0> created copy <LibAVSampleCursor: 0x131115f70>
default    13:02:09.773294-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115f70> stepInPresentationOrderByCount 1
default    13:02:09.773309-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> readAPacketAndUpdateState
default    13:02:09.773324-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2084223, size: 4096, read: 4096
default    13:02:09.773339-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2088319, size: 6006, read: 6006
default    13:02:09.773356-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> updateStateForPacket Presentation Timestamp {6867/1000 = 6.867}
default    13:02:09.773375-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> updateStateForPacket Decode Timestamp {6867/1000 = 6.867}
default    13:02:09.773391-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.773405-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> updateStateForPacket sampleOffset 2084242
default    13:02:09.773417-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131115f70> updateStateForPacket sampleSize 10079
default    13:02:09.773438-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115f70> copyWithZone
default    13:02:09.773458-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1311161c0> init with pts/dts
default    13:02:09.773472-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.773492-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311161c0> seekToPTS already at {6867/1000 = 6.867}
default    13:02:09.773509-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311161c0> readAPacketAndUpdateState
default    13:02:09.773529-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2094325, size: 4096, read: 4096
default    13:02:09.773545-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2098421, size: 6030, read: 6030
default    13:02:09.773566-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311161c0> updateStateForPacket Presentation Timestamp {6900/1000 = 6.900}
default    13:02:09.773582-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311161c0> updateStateForPacket Decode Timestamp {6900/1000 = 6.900}
default    13:02:09.773598-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311161c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.773612-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311161c0> updateStateForPacket sampleOffset 2094344
default    13:02:09.773628-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311161c0> updateStateForPacket sampleSize 10103
default    13:02:09.773648-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311161c0> seekToPTS already at {6900/1000 = 6.900}
default    13:02:09.773667-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131115f70> created copy <LibAVSampleCursor: 0x1311161c0>
default    13:02:09.773684-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1311161c0> copyWithZone
default    13:02:09.773699-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131116660> init with pts/dts
default    13:02:09.773713-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.773731-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131116660> seekToPTS already at {6900/1000 = 6.900}
default    13:02:09.773749-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131116660> readAPacketAndUpdateState
default    13:02:09.773763-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2104451, size: 4096, read: 4096
default    13:02:09.773782-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2108547, size: 6065, read: 6065
default    13:02:09.773803-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131116660> updateStateForPacket Presentation Timestamp {6933/1000 = 6.933}
default    13:02:09.773821-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131116660> updateStateForPacket Decode Timestamp {6933/1000 = 6.933}
default    13:02:09.773835-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131116660> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.773849-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131116660> updateStateForPacket sampleOffset 2104470
default    13:02:09.773869-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131116660> updateStateForPacket sampleSize 10138
default    13:02:09.775490-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.775506-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> seekToPTS already at {7167/1000 = 7.167}
default    13:02:09.775521-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> readAPacketAndUpdateState
default    13:02:09.775535-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2185232, size: 4096, read: 4096
default    13:02:09.775549-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2189328, size: 6019, read: 6019
default    13:02:09.775568-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket Presentation Timestamp {7200/1000 = 7.200}
default    13:02:09.775584-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket Decode Timestamp {7200/1000 = 7.200}
default    13:02:09.775602-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.775619-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket sampleOffset 2185251
default    13:02:09.775631-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket sampleSize 10092
default    13:02:09.775646-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> seekToPTS already at {7200/1000 = 7.200}
default    13:02:09.775665-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061b5a0> created copy <LibAVSampleCursor: 0x13061ba80>
default    13:02:09.775684-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061ba80> stepInDecodeOrderByCount  1
default    13:02:09.775700-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> readAPacketAndUpdateState
default    13:02:09.775718-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2195347, size: 4096, read: 4096
default    13:02:09.775737-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2199443, size: 6067, read: 6067
default    13:02:09.775753-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket Presentation Timestamp {7233/1000 = 7.233, rounded}
default    13:02:09.775770-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket Decode Timestamp {7233/1000 = 7.233, rounded}
default    13:02:09.775785-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.775801-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket sampleOffset 2195366
default    13:02:09.775815-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket sampleSize 10140
default    13:02:09.775831-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061ba80> stepInDecodeOrderByCount  1
default    13:02:09.775846-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> readAPacketAndUpdateState
default    13:02:09.775861-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2205510, size: 4096, read: 4096
default    13:02:09.775876-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2209606, size: 6037, read: 6037
default    13:02:09.775895-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket Presentation Timestamp {7267/1000 = 7.267}
default    13:02:09.775911-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket Decode Timestamp {7267/1000 = 7.267}
default    13:02:09.775926-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.775939-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket sampleOffset 2205529
default    13:02:09.775953-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061ba80> updateStateForPacket sampleSize 10110
default    13:02:09.775966-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061b5a0> stepInDecodeOrderByCount  1
default    13:02:09.775984-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b5a0> readAPacketAndUpdateState
default    13:02:09.776001-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2215643, size: 4096, read: 4096
default    13:02:09.776020-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2219739, size: 6093, read: 6093
default    13:02:09.776036-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b5a0> updateStateForPacket Presentation Timestamp {7300/1000 = 7.300}
default    13:02:09.776087-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b5a0> updateStateForPacket Decode Timestamp {7300/1000 = 7.300}
default    13:02:09.776107-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b5a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.776124-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b5a0> updateStateForPacket sampleOffset 2215662
default    13:02:09.776143-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b5a0> updateStateForPacket sampleSize 10166
error    13:02:09.776170-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.776340-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130619150> copyWithZone
default    13:02:09.776360-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061a320> init with pts/dts
default    13:02:09.776376-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.776393-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> seekToPTS already at {7133/1000 = 7.133}
default    13:02:09.776408-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> readAPacketAndUpdateState
default    13:02:09.776427-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2225832, size: 4096, read: 4096
default    13:02:09.776444-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2229928, size: 6100, read: 6100
default    13:02:09.776462-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> updateStateForPacket Presentation Timestamp {7333/1000 = 7.333}
default    13:02:09.776479-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> updateStateForPacket Decode Timestamp {7333/1000 = 7.333}
default    13:02:09.776494-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.776509-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> updateStateForPacket sampleOffset 2225851
default    13:02:09.776523-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> updateStateForPacket sampleSize 10173
default    13:02:09.776537-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> seekToPTS already at {7333/1000 = 7.333}
default    13:02:09.776554-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130619150> created copy <LibAVSampleCursor: 0x13061a320>
default    13:02:09.776573-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061a320> stepInPresentationOrderByCount 1
default    13:02:09.776588-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> readAPacketAndUpdateState
default    13:02:09.776602-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2236028, size: 4096, read: 4096
default    13:02:09.776618-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2240124, size: 5945, read: 5945
default    13:02:09.776635-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> updateStateForPacket Presentation Timestamp {7367/1000 = 7.367}
default    13:02:09.776654-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> updateStateForPacket Decode Timestamp {7367/1000 = 7.367}
default    13:02:09.776669-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.776684-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> updateStateForPacket sampleOffset 2236047
default    13:02:09.776699-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061a320> updateStateForPacket sampleSize 10018
default    13:02:09.776720-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061a320> copyWithZone
default    13:02:09.776735-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061b590> init with pts/dts
default    13:02:09.776747-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.776765-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> seekToPTS already at {7367/1000 = 7.367}
default    13:02:09.776779-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> readAPacketAndUpdateState
default    13:02:09.776801-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2246069, size: 4096, read: 4096
default    13:02:09.776822-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2250165, size: 5965, read: 5965
default    13:02:09.776839-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> updateStateForPacket Presentation Timestamp {7400/1000 = 7.400}
default    13:02:09.776856-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> updateStateForPacket Decode Timestamp {7400/1000 = 7.400}
default    13:02:09.776873-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.776937-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> updateStateForPacket sampleOffset 2246088
default    13:02:09.776954-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> updateStateForPacket sampleSize 10038
default    13:02:09.777023-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> seekToPTS already at {7400/1000 = 7.400}
default    13:02:09.777040-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061a320> created copy <LibAVSampleCursor: 0x13061b590>
default    13:02:09.777055-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061b590> copyWithZone
default    13:02:09.777074-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061c910> init with pts/dts
default    13:02:09.777086-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.777102-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> seekToPTS already at {7400/1000 = 7.400}
default    13:02:09.777117-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> readAPacketAndUpdateState
default    13:02:09.777132-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2256130, size: 4096, read: 4096
default    13:02:09.777147-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2260226, size: 6046, read: 6046
default    13:02:09.777164-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket Presentation Timestamp {7433/1000 = 7.433}
default    13:02:09.777182-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket Decode Timestamp {7433/1000 = 7.433}
default    13:02:09.777196-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.777210-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket sampleOffset 2256149
default    13:02:09.777230-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket sampleSize 10119
default    13:02:09.777245-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> seekToPTS already at {7433/1000 = 7.433}
default    13:02:09.777260-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061b590> created copy <LibAVSampleCursor: 0x13061c910>
default    13:02:09.777275-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061c910> stepInDecodeOrderByCount  1
default    13:02:09.777288-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> readAPacketAndUpdateState
default    13:02:09.777306-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2266272, size: 4096, read: 4096
default    13:02:09.777319-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2270368, size: 6029, read: 6029
default    13:02:09.777340-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket Presentation Timestamp {7467/1000 = 7.467, rounded}
default    13:02:09.777357-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket Decode Timestamp {7467/1000 = 7.467, rounded}
default    13:02:09.777371-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.777385-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket sampleOffset 2266291
default    13:02:09.777400-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket sampleSize 10102
default    13:02:09.777417-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061c910> stepInDecodeOrderByCount  1
default    13:02:09.777431-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> readAPacketAndUpdateState
default    13:02:09.777446-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2276397, size: 4096, read: 4096
default    13:02:09.777461-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2280493, size: 6085, read: 6085
default    13:02:09.777528-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket Presentation Timestamp {7500/1000 = 7.500}
default    13:02:09.777550-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket Decode Timestamp {7500/1000 = 7.500}
default    13:02:09.777569-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.777585-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket sampleOffset 2276416
default    13:02:09.777600-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061c910> updateStateForPacket sampleSize 10158
default    13:02:09.777615-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061b590> stepInDecodeOrderByCount  1
default    13:02:09.777628-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> readAPacketAndUpdateState
default    13:02:09.777645-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2286578, size: 4096, read: 4096
default    13:02:09.777662-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2290674, size: 6058, read: 6058
default    13:02:09.777679-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> updateStateForPacket Presentation Timestamp {7533/1000 = 7.533}
default    13:02:09.777695-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> updateStateForPacket Decode Timestamp {7533/1000 = 7.533}
default    13:02:09.777713-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.777728-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> updateStateForPacket sampleOffset 2286597
default    13:02:09.777741-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b590> updateStateForPacket sampleSize 10131
default    13:02:09.777843-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.777863-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> seekToPTS already at {7133/1000 = 7.133}
default    13:02:09.777880-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2296732, size: 4096, read: 4096
default    13:02:09.777896-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2300828, size: 6001, read: 6001
default    13:02:09.777915-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket Presentation Timestamp {7567/1000 = 7.567}
default    13:02:09.777935-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket Decode Timestamp {7567/1000 = 7.567}
default    13:02:09.777951-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.777966-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket sampleOffset 2296751
default    13:02:09.777981-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket sampleSize 10074
default    13:02:09.779428-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131209f30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.779444-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131209f30> updateStateForPacket sampleOffset 2357578
default    13:02:09.779462-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131209f30> updateStateForPacket sampleSize 10087
default    13:02:09.779478-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131209a70> stepInDecodeOrderByCount  1
default    13:02:09.779495-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131209a70> readAPacketAndUpdateState
default    13:02:09.779511-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2367669, size: 4096, read: 4096
default    13:02:09.779527-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2371765, size: 6058, read: 6058
default    13:02:09.779546-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131209a70> updateStateForPacket Presentation Timestamp {7800/1000 = 7.800}
default    13:02:09.779563-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131209a70> updateStateForPacket Decode Timestamp {7800/1000 = 7.800}
default    13:02:09.779582-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131209a70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.779597-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131209a70> updateStateForPacket sampleOffset 2367688
default    13:02:09.779613-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131209a70> updateStateForPacket sampleSize 10131
error    13:02:09.779630-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.779730-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120bf20> copyWithZone
default    13:02:09.779755-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723800> init with pts/dts
default    13:02:09.779772-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.779792-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> seekToPTS already at {7633/1000 = 7.633}
default    13:02:09.779808-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> readAPacketAndUpdateState
default    13:02:09.779824-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2377823, size: 4096, read: 4096
default    13:02:09.779844-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2381919, size: 6153, read: 6153
default    13:02:09.779861-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Presentation Timestamp {7833/1000 = 7.833}
default    13:02:09.779879-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Decode Timestamp {7833/1000 = 7.833}
default    13:02:09.779895-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.779908-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket sampleOffset 2377842
default    13:02:09.779923-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket sampleSize 10226
default    13:02:09.779938-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> seekToPTS already at {7833/1000 = 7.833}
default    13:02:09.779956-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120bf20> created copy <LibAVSampleCursor: 0x130723800>
default    13:02:09.779977-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723800> stepInPresentationOrderByCount 1
default    13:02:09.779994-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> readAPacketAndUpdateState
default    13:02:09.780009-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2388072, size: 4096, read: 4096
default    13:02:09.780026-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2392168, size: 6041, read: 6041
default    13:02:09.780044-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Presentation Timestamp {7867/1000 = 7.867}
default    13:02:09.780060-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Decode Timestamp {7867/1000 = 7.867}
default    13:02:09.780076-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.780090-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket sampleOffset 2388091
default    13:02:09.780103-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket sampleSize 10114
default    13:02:09.780123-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723800> copyWithZone
default    13:02:09.780141-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130721540> init with pts/dts
default    13:02:09.780155-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.780173-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> seekToPTS already at {7867/1000 = 7.867}
default    13:02:09.780186-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> readAPacketAndUpdateState
default    13:02:09.780203-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2398209, size: 4096, read: 4096
default    13:02:09.780219-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2402305, size: 6089, read: 6089
default    13:02:09.780235-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> updateStateForPacket Presentation Timestamp {7900/1000 = 7.900}
default    13:02:09.780251-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> updateStateForPacket Decode Timestamp {7900/1000 = 7.900}
default    13:02:09.780267-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.780283-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> updateStateForPacket sampleOffset 2398228
default    13:02:09.780297-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> updateStateForPacket sampleSize 10162
default    13:02:09.780313-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> seekToPTS already at {7900/1000 = 7.900}
default    13:02:09.780328-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723800> created copy <LibAVSampleCursor: 0x130721540>
default    13:02:09.780344-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130721540> copyWithZone
default    13:02:09.780361-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723d70> init with pts/dts
default    13:02:09.780375-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.780391-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> seekToPTS already at {7900/1000 = 7.900}
default    13:02:09.780406-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> readAPacketAndUpdateState
default    13:02:09.780421-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2408394, size: 4096, read: 4096
default    13:02:09.780436-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2412490, size: 6105, read: 6105
default    13:02:09.780456-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket Presentation Timestamp {7933/1000 = 7.933}
default    13:02:09.780472-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket Decode Timestamp {7933/1000 = 7.933}
default    13:02:09.780519-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.780540-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket sampleOffset 2408413
default    13:02:09.780560-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket sampleSize 10178
default    13:02:09.780576-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> seekToPTS already at {7933/1000 = 7.933}
default    13:02:09.780594-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130721540> created copy <LibAVSampleCursor: 0x130723d70>
default    13:02:09.780610-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723d70> stepInDecodeOrderByCount  1
default    13:02:09.780625-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> readAPacketAndUpdateState
default    13:02:09.780641-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2418595, size: 4096, read: 4096
default    13:02:09.780657-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2422691, size: 6069, read: 6069
default    13:02:09.780675-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket Presentation Timestamp {7967/1000 = 7.967, rounded}
default    13:02:09.780694-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket Decode Timestamp {7967/1000 = 7.967, rounded}
default    13:02:09.780710-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.780725-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket sampleOffset 2418614
default    13:02:09.780739-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket sampleSize 10142
default    13:02:09.780761-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723d70> stepInDecodeOrderByCount  1
default    13:02:09.780777-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> readAPacketAndUpdateState
default    13:02:09.780844-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2428760, size: 4096, read: 4096
default    13:02:09.780860-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2432856, size: 5944, read: 5944
default    13:02:09.780879-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket Presentation Timestamp {8000/1000 = 8.000}
default    13:02:09.780898-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket Decode Timestamp {8000/1000 = 8.000}
default    13:02:09.780913-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.780927-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket sampleOffset 2428779
default    13:02:09.780941-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723d70> updateStateForPacket sampleSize 10017
default    13:02:09.780956-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130721540> stepInDecodeOrderByCount  1
default    13:02:09.780975-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> readAPacketAndUpdateState
default    13:02:09.780989-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2438800, size: 4096, read: 4096
default    13:02:09.781003-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2442896, size: 5851, read: 5851
default    13:02:09.781024-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> updateStateForPacket Presentation Timestamp {8032/1000 = 8.032, rounded}
default    13:02:09.781043-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> updateStateForPacket Decode Timestamp {8032/1000 = 8.032, rounded}
default    13:02:09.781059-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.781073-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> updateStateForPacket sampleOffset 2438819
default    13:02:09.781085-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130721540> updateStateForPacket sampleSize 9924
default    13:02:09.781173-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120bf20> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.781192-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120bf20> seekToPTS already at {7633/1000 = 7.633}
default    13:02:09.781209-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2448747, size: 4096, read: 4096
default    13:02:09.781225-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2452843, size: 5930, read: 5930
default    13:02:09.781245-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120bf20> updateStateForPacket Presentation Timestamp {8067/1000 = 8.067}
default    13:02:09.781264-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120bf20> updateStateForPacket Decode Timestamp {8067/1000 = 8.067}
default    13:02:09.781280-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120bf20> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.781296-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120bf20> updateStateForPacket sampleOffset 2448766
default    13:02:09.781311-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120bf20> updateStateForPacket sampleSize 10003
default    13:02:09.781356-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120bf20> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x13061a800 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x13120c040 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {8067/1000 = 8.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {8067/1000 = 8.067}, DTS = {8067/1000 = 8.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x13061c750 totalDataLength: 10003 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10003 bytes @ offset 0 Memory Block 0x130819804, 10003 bytes (allocator 0x1f7d62490)
}
default    13:02:09.781470-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120bf20> copyWithZone
default    13:02:09.781490-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306185a0> init with pts/dts
default    13:02:09.781506-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.781522-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> seekToPTS already at {8067/1000 = 8.067}
default    13:02:09.781538-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> readAPacketAndUpdateState
default    13:02:09.781553-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2458773, size: 4096, read: 4096
default    13:02:09.781567-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2462869, size: 5898, read: 5898
default    13:02:09.781584-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket Presentation Timestamp {8100/1000 = 8.100}
default    13:02:09.781601-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket Decode Timestamp {8100/1000 = 8.100}
default    13:02:09.781618-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.781631-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket sampleOffset 2458792
default    13:02:09.781646-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket sampleSize 9971
default    13:02:09.781660-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> seekToPTS already at {8100/1000 = 8.100}
default    13:02:09.781676-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120bf20> created copy <LibAVSampleCursor: 0x1306185a0>
default    13:02:09.781697-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306185a0> stepInDecodeOrderByCount  1
default    13:02:09.781712-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> readAPacketAndUpdateState
default    13:02:09.781727-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2468767, size: 4096, read: 4096
default    13:02:09.781743-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2472863, size: 5929, read: 5929
default    13:02:09.781760-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket Presentation Timestamp {8133/1000 = 8.133, rounded}
default    13:02:09.781779-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket Decode Timestamp {8133/1000 = 8.133, rounded}
default    13:02:09.781795-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.781846-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket sampleOffset 2468786
default    13:02:09.781883-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket sampleSize 10002
default    13:02:09.781905-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306185a0> copyWithZone
default    13:02:09.781922-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310163d0> init with pts/dts
default    13:02:09.783540-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2518993, size: 4096, read: 4096
default    13:02:09.783576-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2523089, size: 5960, read: 5960
default    13:02:09.783612-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Presentation Timestamp {8300/1000 = 8.300}
default    13:02:09.783647-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Decode Timestamp {8300/1000 = 8.300}
default    13:02:09.783683-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.783716-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket sampleOffset 2519012
default    13:02:09.783747-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310163d0> updateStateForPacket sampleSize 10033
error    13:02:09.783785-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.783896-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306185a0> copyWithZone
default    13:02:09.783941-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130619150> init with pts/dts
default    13:02:09.783982-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.784033-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> seekToPTS already at {8133/1000 = 8.133, rounded}
default    13:02:09.784074-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> readAPacketAndUpdateState
default    13:02:09.784116-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2529049, size: 4096, read: 4096
default    13:02:09.784158-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2533145, size: 6047, read: 6047
default    13:02:09.784208-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket Presentation Timestamp {8333/1000 = 8.333}
default    13:02:09.784250-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket Decode Timestamp {8333/1000 = 8.333}
default    13:02:09.784292-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.784333-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket sampleOffset 2529068
default    13:02:09.784374-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket sampleSize 10120
default    13:02:09.784416-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> seekToPTS already at {8333/1000 = 8.333}
default    13:02:09.784456-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306185a0> created copy <LibAVSampleCursor: 0x130619150>
default    13:02:09.784504-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130619150> stepInPresentationOrderByCount 1
default    13:02:09.784545-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> readAPacketAndUpdateState
default    13:02:09.784590-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2539192, size: 4096, read: 4096
default    13:02:09.784632-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2543288, size: 5942, read: 5942
default    13:02:09.784676-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket Presentation Timestamp {8367/1000 = 8.367}
default    13:02:09.784722-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket Decode Timestamp {8367/1000 = 8.367}
default    13:02:09.784765-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.784805-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket sampleOffset 2539211
default    13:02:09.784843-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130619150> updateStateForPacket sampleSize 10015
default    13:02:09.784893-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130619150> copyWithZone
default    13:02:09.784934-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723800> init with pts/dts
default    13:02:09.784974-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.785022-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> seekToPTS already at {8367/1000 = 8.367}
default    13:02:09.785065-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> readAPacketAndUpdateState
default    13:02:09.785114-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2549230, size: 4096, read: 4096
default    13:02:09.785156-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2553326, size: 5966, read: 5966
default    13:02:09.785198-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Presentation Timestamp {8400/1000 = 8.400}
default    13:02:09.785242-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Decode Timestamp {8400/1000 = 8.400}
default    13:02:09.785283-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.785320-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket sampleOffset 2549249
default    13:02:09.785361-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket sampleSize 10039
default    13:02:09.785403-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> seekToPTS already at {8400/1000 = 8.400}
default    13:02:09.785442-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130619150> created copy <LibAVSampleCursor: 0x130723800>
default    13:02:09.785485-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723800> copyWithZone
default    13:02:09.785523-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061b340> init with pts/dts
default    13:02:09.785562-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.785605-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> seekToPTS already at {8400/1000 = 8.400}
default    13:02:09.785645-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> readAPacketAndUpdateState
default    13:02:09.785687-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2559292, size: 4096, read: 4096
default    13:02:09.785731-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2563388, size: 5999, read: 5999
default    13:02:09.785773-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket Presentation Timestamp {8433/1000 = 8.433}
default    13:02:09.785816-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket Decode Timestamp {8433/1000 = 8.433}
default    13:02:09.785856-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.785897-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket sampleOffset 2559311
default    13:02:09.785944-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket sampleSize 10072
default    13:02:09.785988-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> seekToPTS already at {8433/1000 = 8.433}
default    13:02:09.786031-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723800> created copy <LibAVSampleCursor: 0x13061b340>
default    13:02:09.786072-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061b340> stepInDecodeOrderByCount  1
default    13:02:09.786113-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> readAPacketAndUpdateState
default    13:02:09.786153-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2569387, size: 4096, read: 4096
default    13:02:09.786192-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2573483, size: 6016, read: 6016
default    13:02:09.786236-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket Presentation Timestamp {8467/1000 = 8.467}
default    13:02:09.786274-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket Decode Timestamp {8467/1000 = 8.467}
default    13:02:09.786319-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.786356-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket sampleOffset 2569406
default    13:02:09.786396-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket sampleSize 10089
default    13:02:09.786439-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061b340> stepInDecodeOrderByCount  1
default    13:02:09.786478-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> readAPacketAndUpdateState
default    13:02:09.786518-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2579499, size: 4096, read: 4096
default    13:02:09.786561-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2583595, size: 6142, read: 6142
default    13:02:09.786602-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket Presentation Timestamp {8500/1000 = 8.500}
default    13:02:09.786644-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket Decode Timestamp {8500/1000 = 8.500}
default    13:02:09.786684-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.786722-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket sampleOffset 2579518
default    13:02:09.786762-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061b340> updateStateForPacket sampleSize 10215
default    13:02:09.786801-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723800> stepInDecodeOrderByCount  1
default    13:02:09.786840-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> readAPacketAndUpdateState
default    13:02:09.786881-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2589737, size: 4096, read: 4096
default    13:02:09.786925-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2593833, size: 5995, read: 5995
default    13:02:09.786967-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Presentation Timestamp {8533/1000 = 8.533}
default    13:02:09.787012-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Decode Timestamp {8533/1000 = 8.533}
default    13:02:09.787053-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.787096-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket sampleOffset 2589756
default    13:02:09.787168-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723800> updateStateForPacket sampleSize 10068
default    13:02:09.787307-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.787350-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> seekToPTS already at {8133/1000 = 8.133, rounded}
default    13:02:09.787391-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2599828, size: 4096, read: 4096
default    13:02:09.787434-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2603924, size: 6022, read: 6022
default    13:02:09.787477-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket Presentation Timestamp {8567/1000 = 8.567}
default    13:02:09.787520-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket Decode Timestamp {8567/1000 = 8.567}
default    13:02:09.787564-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.787602-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket sampleOffset 2599847
default    13:02:09.787642-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> updateStateForPacket sampleSize 10095
default    13:02:09.787723-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306185a0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x131116d00 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x13061c960 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {8567/1000 = 8.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {8567/1000 = 8.567}, DTS = {8567/1000 = 8.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x131115f30 totalDataLength: 10095 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10095 bytes @ offset 0 Memory Block 0x130819804, 10095 bytes (allocator 0x1f7d62490)
}
default    13:02:09.787877-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306185a0> copyWithZone
default    13:02:09.787894-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130720bb0> init with pts/dts
default    13:02:09.787974-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.788008-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> seekToPTS already at {8567/1000 = 8.567}
default    13:02:09.788031-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> readAPacketAndUpdateState
default    13:02:09.788058-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2609946, size: 4096, read: 4096
default    13:02:09.788080-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2614042, size: 6053, read: 6053
default    13:02:09.788113-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket Presentation Timestamp {8600/1000 = 8.600}
default    13:02:09.788131-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket Decode Timestamp {8600/1000 = 8.600}
default    13:02:09.788151-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.788168-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket sampleOffset 2609965
default    13:02:09.788184-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket sampleSize 10126
default    13:02:09.788203-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> seekToPTS already at {8600/1000 = 8.600}
default    13:02:09.788220-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306185a0> created copy <LibAVSampleCursor: 0x130720bb0>
default    13:02:09.788249-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130720bb0> stepInDecodeOrderByCount  1
default    13:02:09.788269-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> readAPacketAndUpdateState
default    13:02:09.788285-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2620095, size: 4096, read: 4096
default    13:02:09.788304-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2624191, size: 6152, read: 6152
default    13:02:09.788324-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket Presentation Timestamp {8633/1000 = 8.633, rounded}
default    13:02:09.788341-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket Decode Timestamp {8633/1000 = 8.633, rounded}
default    13:02:09.788358-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.788373-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket sampleOffset 2620114
default    13:02:09.788388-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket sampleSize 10225
default    13:02:09.788418-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130720bb0> copyWithZone
default    13:02:09.788434-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131505b60> init with pts/dts
default    13:02:09.788449-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.788467-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131505b60> seekToPTS already at {8633/1000 = 8.633, rounded}
default    13:02:09.788484-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131505b60> readAPacketAndUpdateState
default    13:02:09.789897-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.789915-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2a0> updateStateForPacket sampleOffset 2691604
default    13:02:09.789930-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120b2a0> updateStateForPacket sampleSize 10199
default    13:02:09.789952-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120b2a0> copyWithZone
default    13:02:09.789971-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120a2a0> init with pts/dts
default    13:02:09.789984-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.790000-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> seekToPTS already at {8867/1000 = 8.867}
default    13:02:09.790016-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> readAPacketAndUpdateState
default    13:02:09.790033-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2701807, size: 4096, read: 4096
default    13:02:09.790050-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2705903, size: 6136, read: 6136
default    13:02:09.790066-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> updateStateForPacket Presentation Timestamp {8900/1000 = 8.900}
default    13:02:09.790085-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> updateStateForPacket Decode Timestamp {8900/1000 = 8.900}
default    13:02:09.790101-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.790116-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> updateStateForPacket sampleOffset 2701826
default    13:02:09.790132-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> updateStateForPacket sampleSize 10209
default    13:02:09.790147-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> seekToPTS already at {8900/1000 = 8.900}
default    13:02:09.790164-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120b2a0> created copy <LibAVSampleCursor: 0x13120a2a0>
default    13:02:09.790179-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120a2a0> copyWithZone
default    13:02:09.790195-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120d7b0> init with pts/dts
default    13:02:09.790209-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.790227-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> seekToPTS already at {8900/1000 = 8.900}
default    13:02:09.790245-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> readAPacketAndUpdateState
default    13:02:09.790261-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2712039, size: 4096, read: 4096
default    13:02:09.790282-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2716135, size: 6066, read: 6066
default    13:02:09.790299-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket Presentation Timestamp {8933/1000 = 8.933}
default    13:02:09.790317-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket Decode Timestamp {8933/1000 = 8.933}
default    13:02:09.790333-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.790349-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket sampleOffset 2712058
default    13:02:09.790369-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket sampleSize 10139
default    13:02:09.790385-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> seekToPTS already at {8933/1000 = 8.933}
default    13:02:09.790401-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120a2a0> created copy <LibAVSampleCursor: 0x13120d7b0>
default    13:02:09.790419-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120d7b0> stepInDecodeOrderByCount  1
default    13:02:09.790433-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> readAPacketAndUpdateState
default    13:02:09.790450-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2722201, size: 4096, read: 4096
default    13:02:09.790467-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2726297, size: 6131, read: 6131
default    13:02:09.790486-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket Presentation Timestamp {8967/1000 = 8.967}
default    13:02:09.790501-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket Decode Timestamp {8967/1000 = 8.967}
default    13:02:09.790517-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.790532-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket sampleOffset 2722220
default    13:02:09.790546-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket sampleSize 10204
default    13:02:09.790565-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120d7b0> stepInDecodeOrderByCount  1
default    13:02:09.790581-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> readAPacketAndUpdateState
default    13:02:09.790597-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2732428, size: 4096, read: 4096
default    13:02:09.790613-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2736524, size: 6088, read: 6088
default    13:02:09.790632-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket Presentation Timestamp {9000/1000 = 9.000}
default    13:02:09.790647-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket Decode Timestamp {9000/1000 = 9.000}
default    13:02:09.790666-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.790680-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket sampleOffset 2732447
default    13:02:09.790694-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120d7b0> updateStateForPacket sampleSize 10161
default    13:02:09.790709-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13120a2a0> stepInDecodeOrderByCount  1
default    13:02:09.790726-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> readAPacketAndUpdateState
default    13:02:09.790741-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2742612, size: 4096, read: 4096
default    13:02:09.790759-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2746708, size: 5994, read: 5994
default    13:02:09.790776-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> updateStateForPacket Presentation Timestamp {9033/1000 = 9.033}
default    13:02:09.790793-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> updateStateForPacket Decode Timestamp {9033/1000 = 9.033}
default    13:02:09.790810-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.790824-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> updateStateForPacket sampleOffset 2742631
default    13:02:09.790838-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13120a2a0> updateStateForPacket sampleSize 10067
default    13:02:09.790975-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.791007-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> seekToPTS already at {8633/1000 = 8.633, rounded}
default    13:02:09.791027-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2752702, size: 4096, read: 4096
default    13:02:09.791043-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2756798, size: 6086, read: 6086
default    13:02:09.791063-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket Presentation Timestamp {9067/1000 = 9.067}
default    13:02:09.791089-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket Decode Timestamp {9067/1000 = 9.067}
default    13:02:09.791105-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.791119-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket sampleOffset 2752721
default    13:02:09.791132-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> updateStateForPacket sampleSize 10159
default    13:02:09.791179-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130720bb0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x13061d030 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x131504c10 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {9067/1000 = 9.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {9067/1000 = 9.067}, DTS = {9067/1000 = 9.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x13061aa10 totalDataLength: 10159 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10159 bytes @ offset 0 Memory Block 0x130819804, 10159 bytes (allocator 0x1f7d62490)
}
default    13:02:09.791321-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130720bb0> copyWithZone
default    13:02:09.791352-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307200b0> init with pts/dts
default    13:02:09.791367-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.791387-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> seekToPTS already at {9067/1000 = 9.067}
default    13:02:09.791403-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> readAPacketAndUpdateState
default    13:02:09.791419-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2762884, size: 4096, read: 4096
default    13:02:09.791439-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2766980, size: 6087, read: 6087
default    13:02:09.791459-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket Presentation Timestamp {9100/1000 = 9.100}
default    13:02:09.791476-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket Decode Timestamp {9100/1000 = 9.100}
default    13:02:09.791491-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.791507-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket sampleOffset 2762903
default    13:02:09.791522-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket sampleSize 10160
default    13:02:09.791537-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> seekToPTS already at {9100/1000 = 9.100}
default    13:02:09.791554-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130720bb0> created copy <LibAVSampleCursor: 0x1307200b0>
default    13:02:09.791578-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307200b0> stepInDecodeOrderByCount  1
default    13:02:09.791593-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> readAPacketAndUpdateState
default    13:02:09.791608-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2773067, size: 4096, read: 4096
default    13:02:09.791624-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2777163, size: 6065, read: 6065
default    13:02:09.791641-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket Presentation Timestamp {9133/1000 = 9.133, rounded}
default    13:02:09.791659-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket Decode Timestamp {9133/1000 = 9.133, rounded}
default    13:02:09.791675-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.791690-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket sampleOffset 2773086
default    13:02:09.791703-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket sampleSize 10138
default    13:02:09.791733-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307200b0> copyWithZone
default    13:02:09.791749-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130724060> init with pts/dts
default    13:02:09.791764-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.791781-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130724060> seekToPTS already at {9133/1000 = 9.133, rounded}
default    13:02:09.791796-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130724060> readAPacketAndUpdateState
default    13:02:09.791811-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2783228, size: 4096, read: 4096
default    13:02:09.791827-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2787324, size: 6090, read: 6090
default    13:02:09.791845-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130724060> updateStateForPacket Presentation Timestamp {9167/1000 = 9.167}
default    13:02:09.791866-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130724060> updateStateForPacket Decode Timestamp {9167/1000 = 9.167}
default    13:02:09.791881-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130724060> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.791896-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130724060> updateStateForPacket sampleOffset 2783247
default    13:02:09.791909-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130724060> updateStateForPacket sampleSize 10163
default    13:02:09.791932-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130724060> seekToPTS already at {9167/1000 = 9.167}
default    13:02:09.791949-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307200b0> created copy <LibAVSampleCursor: 0x130724060>
default    13:02:09.791965-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130724060> copyWithZone
default    13:02:09.791980-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307244e0> init with pts/dts
default    13:02:09.791992-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.792010-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> seekToPTS already at {9167/1000 = 9.167}
default    13:02:09.792026-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> readAPacketAndUpdateState
default    13:02:09.792042-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2793414, size: 4096, read: 4096
default    13:02:09.792057-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2797510, size: 5983, read: 5983
default    13:02:09.792073-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> updateStateForPacket Presentation Timestamp {9200/1000 = 9.200, rounded}
default    13:02:09.792089-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> updateStateForPacket Decode Timestamp {9200/1000 = 9.200, rounded}
default    13:02:09.792104-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.792119-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> updateStateForPacket sampleOffset 2793433
default    13:02:09.792133-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> updateStateForPacket sampleSize 10056
default    13:02:09.792150-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> seekToPTS already at {9200/1000 = 9.200, rounded}
default    13:02:09.792169-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130724060> created copy <LibAVSampleCursor: 0x1307244e0>
default    13:02:09.792184-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307244e0> stepInDecodeOrderByCount  1
default    13:02:09.792197-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> readAPacketAndUpdateState
default    13:02:09.792231-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2803493, size: 4096, read: 4096
default    13:02:09.792251-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2807589, size: 5979, read: 5979
default    13:02:09.792273-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> updateStateForPacket Presentation Timestamp {9233/1000 = 9.233}
default    13:02:09.792292-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> updateStateForPacket Decode Timestamp {9233/1000 = 9.233}
default    13:02:09.792308-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.792323-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> updateStateForPacket sampleOffset 2803512
default    13:02:09.792337-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307244e0> updateStateForPacket sampleSize 10052
default    13:02:09.794240-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.794264-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> seekToPTS already at {9133/1000 = 9.133, rounded}
default    13:02:09.794282-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2903843, size: 4096, read: 4096
default    13:02:09.794301-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2907939, size: 5913, read: 5913
default    13:02:09.794320-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket Presentation Timestamp {9567/1000 = 9.567}
default    13:02:09.794338-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket Decode Timestamp {9567/1000 = 9.567}
default    13:02:09.794356-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.794370-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket sampleOffset 2903862
default    13:02:09.794385-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> updateStateForPacket sampleSize 9986
default    13:02:09.794434-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307200b0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x130722a80 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x130721f40 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {9567/1000 = 9.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {9567/1000 = 9.567}, DTS = {9567/1000 = 9.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x130723c10 totalDataLength: 9986 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 9986 bytes @ offset 0 Memory Block 0x13282b604, 9986 bytes (allocator 0x1f7d62490)
}
default    13:02:09.794578-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307200b0> copyWithZone
default    13:02:09.794601-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130722390> init with pts/dts
default    13:02:09.794615-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.794634-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> seekToPTS already at {9567/1000 = 9.567}
default    13:02:09.794648-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> readAPacketAndUpdateState
default    13:02:09.794665-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2913852, size: 4096, read: 4096
default    13:02:09.794681-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2917948, size: 5861, read: 5861
default    13:02:09.794702-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> updateStateForPacket Presentation Timestamp {9600/1000 = 9.600}
default    13:02:09.794719-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> updateStateForPacket Decode Timestamp {9600/1000 = 9.600}
default    13:02:09.794735-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.794749-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> updateStateForPacket sampleOffset 2913871
default    13:02:09.794764-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> updateStateForPacket sampleSize 9934
default    13:02:09.794780-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> seekToPTS already at {9600/1000 = 9.600}
default    13:02:09.794796-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307200b0> created copy <LibAVSampleCursor: 0x130722390>
default    13:02:09.794817-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130722390> stepInDecodeOrderByCount  1
default    13:02:09.794832-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> readAPacketAndUpdateState
default    13:02:09.794847-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2923809, size: 4096, read: 4096
default    13:02:09.794863-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2927905, size: 5903, read: 5903
default    13:02:09.794882-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> updateStateForPacket Presentation Timestamp {9633/1000 = 9.633, rounded}
default    13:02:09.794899-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> updateStateForPacket Decode Timestamp {9633/1000 = 9.633, rounded}
default    13:02:09.794917-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.794930-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> updateStateForPacket sampleOffset 2923828
default    13:02:09.794945-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130722390> updateStateForPacket sampleSize 9976
default    13:02:09.794965-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130722390> copyWithZone
default    13:02:09.794981-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725170> init with pts/dts
default    13:02:09.795075-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.795094-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> seekToPTS already at {9633/1000 = 9.633, rounded}
default    13:02:09.795109-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> readAPacketAndUpdateState
default    13:02:09.795164-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2933808, size: 4096, read: 4096
default    13:02:09.795249-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2937904, size: 5848, read: 5848
default    13:02:09.795270-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> updateStateForPacket Presentation Timestamp {9667/1000 = 9.667}
default    13:02:09.795289-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> updateStateForPacket Decode Timestamp {9667/1000 = 9.667}
default    13:02:09.795305-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.795324-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> updateStateForPacket sampleOffset 2933827
default    13:02:09.795339-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> updateStateForPacket sampleSize 9921
default    13:02:09.795358-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> seekToPTS already at {9667/1000 = 9.667}
default    13:02:09.795377-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130722390> created copy <LibAVSampleCursor: 0x130725170>
default    13:02:09.795392-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725170> copyWithZone
default    13:02:09.795408-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016850> init with pts/dts
default    13:02:09.795422-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.795439-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> seekToPTS already at {9667/1000 = 9.667}
default    13:02:09.795454-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> readAPacketAndUpdateState
default    13:02:09.795469-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2943752, size: 4096, read: 4096
default    13:02:09.795486-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2947848, size: 5860, read: 5860
default    13:02:09.795531-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Presentation Timestamp {9700/1000 = 9.700, rounded}
default    13:02:09.795612-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Decode Timestamp {9700/1000 = 9.700, rounded}
default    13:02:09.795628-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.795644-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleOffset 2943771
default    13:02:09.795658-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleSize 9933
default    13:02:09.795672-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> seekToPTS already at {9700/1000 = 9.700, rounded}
default    13:02:09.795689-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725170> created copy <LibAVSampleCursor: 0x131016850>
default    13:02:09.795705-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016850> stepInDecodeOrderByCount  1
default    13:02:09.795720-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> readAPacketAndUpdateState
default    13:02:09.795733-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2953708, size: 4096, read: 4096
default    13:02:09.795749-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2957804, size: 5831, read: 5831
default    13:02:09.795767-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Presentation Timestamp {9733/1000 = 9.733}
default    13:02:09.795783-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Decode Timestamp {9733/1000 = 9.733}
default    13:02:09.795806-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.795823-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleOffset 2953727
default    13:02:09.795836-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleSize 9904
default    13:02:09.795877-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016850> stepInDecodeOrderByCount  1
default    13:02:09.795900-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> readAPacketAndUpdateState
default    13:02:09.795922-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2963635, size: 4096, read: 4096
default    13:02:09.795939-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2967731, size: 5900, read: 5900
default    13:02:09.795959-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Presentation Timestamp {9767/1000 = 9.767}
default    13:02:09.795978-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Decode Timestamp {9767/1000 = 9.767}
default    13:02:09.795994-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.796010-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleOffset 2963654
default    13:02:09.796025-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleSize 9973
default    13:02:09.796041-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725170> stepInDecodeOrderByCount  1
default    13:02:09.796057-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> readAPacketAndUpdateState
default    13:02:09.796073-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2973631, size: 4096, read: 4096
default    13:02:09.796091-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2977727, size: 5891, read: 5891
default    13:02:09.796108-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> updateStateForPacket Presentation Timestamp {9800/1000 = 9.800}
default    13:02:09.796123-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> updateStateForPacket Decode Timestamp {9800/1000 = 9.800}
default    13:02:09.796140-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.796155-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> updateStateForPacket sampleOffset 2973650
default    13:02:09.796170-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725170> updateStateForPacket sampleSize 9964
error    13:02:09.796190-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.796323-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130722390> copyWithZone
default    13:02:09.796344-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131018d50> init with pts/dts
default    13:02:09.796359-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.796376-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> seekToPTS already at {9633/1000 = 9.633, rounded}
default    13:02:09.796394-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> readAPacketAndUpdateState
default    13:02:09.796410-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2983618, size: 4096, read: 4096
default    13:02:09.796427-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2987714, size: 5819, read: 5819
default    13:02:09.796446-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> updateStateForPacket Presentation Timestamp {9833/1000 = 9.833}
default    13:02:09.796463-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> updateStateForPacket Decode Timestamp {9833/1000 = 9.833}
default    13:02:09.796480-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.796497-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> updateStateForPacket sampleOffset 2983637
default    13:02:09.796514-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> updateStateForPacket sampleSize 9892
default    13:02:09.796530-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> seekToPTS already at {9833/1000 = 9.833}
default    13:02:09.796547-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130722390> created copy <LibAVSampleCursor: 0x131018d50>
default    13:02:09.796570-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131018d50> stepInPresentationOrderByCount 1
default    13:02:09.796586-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> readAPacketAndUpdateState
default    13:02:09.796605-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2993533, size: 4096, read: 4096
default    13:02:09.796621-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 2997629, size: 5735, read: 5735
default    13:02:09.796639-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> updateStateForPacket Presentation Timestamp {9867/1000 = 9.867}
default    13:02:09.796658-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> updateStateForPacket Decode Timestamp {9867/1000 = 9.867}
default    13:02:09.796674-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.796689-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> updateStateForPacket sampleOffset 2993552
default    13:02:09.796705-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131018d50> updateStateForPacket sampleSize 9808
default    13:02:09.796727-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131018d50> copyWithZone
default    13:02:09.796744-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101e740> init with pts/dts
default    13:02:09.796758-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.796777-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e740> seekToPTS already at {9867/1000 = 9.867}
default    13:02:09.796792-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e740> readAPacketAndUpdateState
default    13:02:09.796808-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3003364, size: 4096, read: 4096
default    13:02:09.796824-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3007460, size: 5760, read: 5760
default    13:02:09.796843-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e740> updateStateForPacket Presentation Timestamp {9900/1000 = 9.900}
default    13:02:09.796859-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e740> updateStateForPacket Decode Timestamp {9900/1000 = 9.900}
default    13:02:09.796876-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e740> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.796892-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e740> updateStateForPacket sampleOffset 3003383
default    13:02:09.796907-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e740> updateStateForPacket sampleSize 9833
default    13:02:09.798377-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f160> updateStateForPacket Decode Timestamp {10133/1000 = 10.133, rounded}
default    13:02:09.798398-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f160> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.798418-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f160> updateStateForPacket sampleOffset 3073192
default    13:02:09.798433-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13071f160> updateStateForPacket sampleSize 10013
default    13:02:09.798453-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071f160> copyWithZone
default    13:02:09.798469-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725bc0> init with pts/dts
default    13:02:09.798482-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.798500-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> seekToPTS already at {10133/1000 = 10.133, rounded}
default    13:02:09.798515-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> readAPacketAndUpdateState
default    13:02:09.798530-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3083209, size: 4096, read: 4096
default    13:02:09.798547-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3087305, size: 5895, read: 5895
default    13:02:09.798566-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> updateStateForPacket Presentation Timestamp {10167/1000 = 10.167}
default    13:02:09.798583-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> updateStateForPacket Decode Timestamp {10167/1000 = 10.167}
default    13:02:09.798598-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.798612-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> updateStateForPacket sampleOffset 3083228
default    13:02:09.798625-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> updateStateForPacket sampleSize 9968
default    13:02:09.798651-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> seekToPTS already at {10167/1000 = 10.167}
default    13:02:09.798671-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071f160> created copy <LibAVSampleCursor: 0x130725bc0>
default    13:02:09.798688-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725bc0> copyWithZone
default    13:02:09.798737-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113450> init with pts/dts
default    13:02:09.798810-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.798832-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> seekToPTS already at {10167/1000 = 10.167}
default    13:02:09.798849-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> readAPacketAndUpdateState
default    13:02:09.798866-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3093200, size: 4096, read: 4096
default    13:02:09.798882-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3097296, size: 5961, read: 5961
default    13:02:09.798902-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Presentation Timestamp {10200/1000 = 10.200, rounded}
default    13:02:09.798922-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Decode Timestamp {10200/1000 = 10.200, rounded}
default    13:02:09.798942-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.798957-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket sampleOffset 3093219
default    13:02:09.798971-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket sampleSize 10034
default    13:02:09.798988-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> seekToPTS already at {10200/1000 = 10.200, rounded}
default    13:02:09.799005-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725bc0> created copy <LibAVSampleCursor: 0x131113450>
default    13:02:09.799022-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113450> stepInDecodeOrderByCount  1
default    13:02:09.799041-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> readAPacketAndUpdateState
default    13:02:09.799058-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3103257, size: 4096, read: 4096
default    13:02:09.799086-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3107353, size: 6034, read: 6034
default    13:02:09.799145-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Presentation Timestamp {10233/1000 = 10.233}
default    13:02:09.799211-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Decode Timestamp {10233/1000 = 10.233}
default    13:02:09.799283-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.799299-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket sampleOffset 3103276
default    13:02:09.799313-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket sampleSize 10107
default    13:02:09.799330-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113450> stepInDecodeOrderByCount  1
default    13:02:09.799346-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> readAPacketAndUpdateState
default    13:02:09.799361-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3113387, size: 4096, read: 4096
default    13:02:09.799377-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3117483, size: 5892, read: 5892
default    13:02:09.799396-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Presentation Timestamp {10267/1000 = 10.267}
default    13:02:09.799415-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Decode Timestamp {10267/1000 = 10.267}
default    13:02:09.799431-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.799448-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket sampleOffset 3113406
default    13:02:09.799462-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket sampleSize 9965
default    13:02:09.799477-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725bc0> stepInDecodeOrderByCount  1
default    13:02:09.799494-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> readAPacketAndUpdateState
default    13:02:09.799508-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3123375, size: 4096, read: 4096
default    13:02:09.799527-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3127471, size: 6051, read: 6051
default    13:02:09.799547-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> updateStateForPacket Presentation Timestamp {10300/1000 = 10.300}
default    13:02:09.799563-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> updateStateForPacket Decode Timestamp {10300/1000 = 10.300}
default    13:02:09.799580-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.799593-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> updateStateForPacket sampleOffset 3123394
default    13:02:09.799607-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725bc0> updateStateForPacket sampleSize 10124
error    13:02:09.799644-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.799745-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071f160> copyWithZone
default    13:02:09.799770-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061e810> init with pts/dts
default    13:02:09.799783-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.799802-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> seekToPTS already at {10133/1000 = 10.133, rounded}
default    13:02:09.799817-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> readAPacketAndUpdateState
default    13:02:09.799832-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3133522, size: 4096, read: 4096
default    13:02:09.799848-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3137618, size: 5974, read: 5974
default    13:02:09.799865-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> updateStateForPacket Presentation Timestamp {10333/1000 = 10.333}
default    13:02:09.799880-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> updateStateForPacket Decode Timestamp {10333/1000 = 10.333}
default    13:02:09.799896-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.799911-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> updateStateForPacket sampleOffset 3133541
default    13:02:09.799925-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> updateStateForPacket sampleSize 10047
default    13:02:09.799938-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> seekToPTS already at {10333/1000 = 10.333}
default    13:02:09.799957-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13071f160> created copy <LibAVSampleCursor: 0x13061e810>
default    13:02:09.799978-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061e810> stepInPresentationOrderByCount 1
default    13:02:09.799993-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> readAPacketAndUpdateState
default    13:02:09.800008-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3143592, size: 4096, read: 4096
default    13:02:09.800024-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3147688, size: 6006, read: 6006
default    13:02:09.800041-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> updateStateForPacket Presentation Timestamp {10367/1000 = 10.367}
default    13:02:09.800057-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> updateStateForPacket Decode Timestamp {10367/1000 = 10.367}
default    13:02:09.800074-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.800086-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> updateStateForPacket sampleOffset 3143611
default    13:02:09.800101-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061e810> updateStateForPacket sampleSize 10079
default    13:02:09.800182-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061e810> copyWithZone
default    13:02:09.800199-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101d0d0> init with pts/dts
default    13:02:09.800213-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.800231-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101d0d0> seekToPTS already at {10367/1000 = 10.367}
default    13:02:09.800247-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101d0d0> readAPacketAndUpdateState
default    13:02:09.800263-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3153694, size: 4096, read: 4096
default    13:02:09.800280-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3157790, size: 5975, read: 5975
default    13:02:09.800297-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101d0d0> updateStateForPacket Presentation Timestamp {10400/1000 = 10.400}
default    13:02:09.800313-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101d0d0> updateStateForPacket Decode Timestamp {10400/1000 = 10.400}
default    13:02:09.800329-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101d0d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.800344-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101d0d0> updateStateForPacket sampleOffset 3153713
default    13:02:09.800359-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101d0d0> updateStateForPacket sampleSize 10048
default    13:02:09.800373-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101d0d0> seekToPTS already at {10400/1000 = 10.400}
default    13:02:09.800388-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061e810> created copy <LibAVSampleCursor: 0x13101d0d0>
default    13:02:09.800403-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101d0d0> copyWithZone
default    13:02:09.800417-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016850> init with pts/dts
default    13:02:09.800432-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.800450-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> seekToPTS already at {10400/1000 = 10.400}
default    13:02:09.800487-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> readAPacketAndUpdateState
default    13:02:09.800513-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3163765, size: 4096, read: 4096
default    13:02:09.800555-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3167861, size: 5938, read: 5938
default    13:02:09.800575-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Presentation Timestamp {10433/1000 = 10.433}
default    13:02:09.800645-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Decode Timestamp {10433/1000 = 10.433}
default    13:02:09.800662-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.800681-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleOffset 3163784
default    13:02:09.800697-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleSize 10011
default    13:02:09.800712-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> seekToPTS already at {10433/1000 = 10.433}
default    13:02:09.800726-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101d0d0> created copy <LibAVSampleCursor: 0x131016850>
default    13:02:09.800743-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016850> stepInDecodeOrderByCount  1
default    13:02:09.800760-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> readAPacketAndUpdateState
default    13:02:09.800776-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3173799, size: 4096, read: 4096
default    13:02:09.800792-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3177895, size: 6058, read: 6058
default    13:02:09.800849-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Presentation Timestamp {10467/1000 = 10.467}
default    13:02:09.800873-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Decode Timestamp {10467/1000 = 10.467}
default    13:02:09.800893-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.800909-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleOffset 3173818
default    13:02:09.800925-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleSize 10131
default    13:02:09.800945-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131016850> stepInDecodeOrderByCount  1
default    13:02:09.800961-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> readAPacketAndUpdateState
default    13:02:09.800980-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3183953, size: 4096, read: 4096
default    13:02:09.801000-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3188049, size: 5906, read: 5906
default    13:02:09.801019-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Presentation Timestamp {10500/1000 = 10.500}
default    13:02:09.801039-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Decode Timestamp {10500/1000 = 10.500}
default    13:02:09.801058-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.801074-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131016850> updateStateForPacket sampleOffset 3183972
default    13:02:09.803128-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> seekToPTS already at {10633/1000 = 10.633, rounded}
default    13:02:09.803143-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> readAPacketAndUpdateState
default    13:02:09.803159-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3284499, size: 4096, read: 4096
default    13:02:09.803178-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3288595, size: 5933, read: 5933
default    13:02:09.803198-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> updateStateForPacket Presentation Timestamp {10833/1000 = 10.833}
default    13:02:09.803215-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> updateStateForPacket Decode Timestamp {10833/1000 = 10.833}
default    13:02:09.803231-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.803246-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> updateStateForPacket sampleOffset 3284518
default    13:02:09.803261-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> updateStateForPacket sampleSize 10006
default    13:02:09.803276-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> seekToPTS already at {10833/1000 = 10.833}
default    13:02:09.803291-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d200> created copy <LibAVSampleCursor: 0x130723100>
default    13:02:09.803312-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723100> stepInPresentationOrderByCount 1
default    13:02:09.803349-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> readAPacketAndUpdateState
default    13:02:09.803431-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3294528, size: 4096, read: 4096
default    13:02:09.803447-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3298624, size: 5909, read: 5909
default    13:02:09.803482-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> updateStateForPacket Presentation Timestamp {10867/1000 = 10.867}
default    13:02:09.803500-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> updateStateForPacket Decode Timestamp {10867/1000 = 10.867}
default    13:02:09.803517-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.803531-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> updateStateForPacket sampleOffset 3294547
default    13:02:09.803545-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> updateStateForPacket sampleSize 9982
default    13:02:09.803566-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723100> copyWithZone
default    13:02:09.803581-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307264e0> init with pts/dts
default    13:02:09.803596-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.803612-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> seekToPTS already at {10867/1000 = 10.867}
default    13:02:09.803627-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> readAPacketAndUpdateState
default    13:02:09.803642-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3304533, size: 4096, read: 4096
default    13:02:09.803658-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3308629, size: 5881, read: 5881
default    13:02:09.803678-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> updateStateForPacket Presentation Timestamp {10900/1000 = 10.900}
default    13:02:09.803695-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> updateStateForPacket Decode Timestamp {10900/1000 = 10.900}
default    13:02:09.803710-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.803738-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> updateStateForPacket sampleOffset 3304552
default    13:02:09.803760-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> updateStateForPacket sampleSize 9954
default    13:02:09.803826-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> seekToPTS already at {10900/1000 = 10.900}
default    13:02:09.803842-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723100> created copy <LibAVSampleCursor: 0x1307264e0>
default    13:02:09.803858-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307264e0> copyWithZone
default    13:02:09.803873-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726920> init with pts/dts
default    13:02:09.803884-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.803900-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> seekToPTS already at {10900/1000 = 10.900}
default    13:02:09.803915-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> readAPacketAndUpdateState
default    13:02:09.803942-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3314510, size: 4096, read: 4096
default    13:02:09.803961-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3318606, size: 5920, read: 5920
default    13:02:09.803980-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket Presentation Timestamp {10933/1000 = 10.933}
default    13:02:09.804028-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket Decode Timestamp {10933/1000 = 10.933}
default    13:02:09.804047-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.804069-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket sampleOffset 3314529
default    13:02:09.804086-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket sampleSize 9993
default    13:02:09.804104-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> seekToPTS already at {10933/1000 = 10.933}
default    13:02:09.804121-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307264e0> created copy <LibAVSampleCursor: 0x130726920>
default    13:02:09.804140-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726920> stepInDecodeOrderByCount  1
default    13:02:09.804157-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> readAPacketAndUpdateState
default    13:02:09.804177-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3324526, size: 4096, read: 4096
default    13:02:09.804195-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3328622, size: 5914, read: 5914
default    13:02:09.804214-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket Presentation Timestamp {10967/1000 = 10.967}
default    13:02:09.804233-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket Decode Timestamp {10967/1000 = 10.967}
default    13:02:09.804250-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.804265-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket sampleOffset 3324545
default    13:02:09.804281-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket sampleSize 9987
default    13:02:09.804327-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726920> stepInDecodeOrderByCount  1
default    13:02:09.804369-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> readAPacketAndUpdateState
default    13:02:09.804400-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3334536, size: 4096, read: 4096
default    13:02:09.804419-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3338632, size: 5817, read: 5817
default    13:02:09.804487-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket Presentation Timestamp {11000/1000 = 11.000}
default    13:02:09.804506-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket Decode Timestamp {11000/1000 = 11.000}
default    13:02:09.804522-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.804538-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket sampleOffset 3334555
default    13:02:09.804552-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726920> updateStateForPacket sampleSize 9890
default    13:02:09.804567-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307264e0> stepInDecodeOrderByCount  1
default    13:02:09.804582-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> readAPacketAndUpdateState
default    13:02:09.804619-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3344449, size: 4096, read: 4096
default    13:02:09.804637-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3348545, size: 5987, read: 5987
default    13:02:09.804656-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> updateStateForPacket Presentation Timestamp {11033/1000 = 11.033}
default    13:02:09.804678-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> updateStateForPacket Decode Timestamp {11033/1000 = 11.033}
default    13:02:09.804702-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.804773-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> updateStateForPacket sampleOffset 3344468
default    13:02:09.804790-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307264e0> updateStateForPacket sampleSize 10060
default    13:02:09.804950-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.804972-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> seekToPTS already at {10633/1000 = 10.633, rounded}
default    13:02:09.804995-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3354532, size: 4096, read: 4096
default    13:02:09.805012-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3358628, size: 6104, read: 6104
default    13:02:09.805031-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket Presentation Timestamp {11067/1000 = 11.067}
default    13:02:09.805052-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket Decode Timestamp {11067/1000 = 11.067}
default    13:02:09.805068-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.805083-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket sampleOffset 3354551
default    13:02:09.805098-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket sampleSize 10177
default    13:02:09.805140-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x1307260f0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x13061ef50 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {11067/1000 = 11.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {11067/1000 = 11.067}, DTS = {11067/1000 = 11.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x130724ea0 totalDataLength: 10177 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10177 bytes @ offset 0 Memory Block 0x13282ca04, 10177 bytes (allocator 0x1f7d62490)
}
default    13:02:09.805272-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d200> copyWithZone
default    13:02:09.805298-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620400> init with pts/dts
default    13:02:09.805315-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.805332-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> seekToPTS already at {11067/1000 = 11.067}
default    13:02:09.805349-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> readAPacketAndUpdateState
default    13:02:09.805365-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3364732, size: 4096, read: 4096
default    13:02:09.805381-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3368828, size: 6235, read: 6235
default    13:02:09.805398-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket Presentation Timestamp {11100/1000 = 11.100}
default    13:02:09.805414-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket Decode Timestamp {11100/1000 = 11.100}
default    13:02:09.805430-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.805445-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket sampleOffset 3364751
default    13:02:09.805459-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket sampleSize 10308
default    13:02:09.805474-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> seekToPTS already at {11100/1000 = 11.100}
default    13:02:09.805490-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d200> created copy <LibAVSampleCursor: 0x130620400>
default    13:02:09.805516-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620400> stepInDecodeOrderByCount  1
default    13:02:09.805531-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> readAPacketAndUpdateState
default    13:02:09.805547-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3375063, size: 4096, read: 4096
default    13:02:09.805563-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3379159, size: 6030, read: 6030
default    13:02:09.805582-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket Presentation Timestamp {11133/1000 = 11.133, rounded}
default    13:02:09.805598-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket Decode Timestamp {11133/1000 = 11.133, rounded}
default    13:02:09.805613-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.805629-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket sampleOffset 3375082
default    13:02:09.805645-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket sampleSize 10103
default    13:02:09.805665-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620400> copyWithZone
default    13:02:09.805685-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620ca0> init with pts/dts
default    13:02:09.805699-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.805716-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> seekToPTS already at {11133/1000 = 11.133, rounded}
default    13:02:09.805746-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> readAPacketAndUpdateState
default    13:02:09.805763-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3385189, size: 4096, read: 4096
default    13:02:09.805779-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3389285, size: 6053, read: 6053
default    13:02:09.805799-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Presentation Timestamp {11167/1000 = 11.167}
default    13:02:09.805849-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Decode Timestamp {11167/1000 = 11.167}
default    13:02:09.805867-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.805886-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket sampleOffset 3385208
default    13:02:09.805902-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket sampleSize 10126
default    13:02:09.805922-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> seekToPTS already at {11167/1000 = 11.167}
default    13:02:09.805943-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620400> created copy <LibAVSampleCursor: 0x130620ca0>
default    13:02:09.805960-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620ca0> copyWithZone
default    13:02:09.805977-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130723100> init with pts/dts
default    13:02:09.805991-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.806014-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> seekToPTS already at {11167/1000 = 11.167}
default    13:02:09.806030-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130723100> readAPacketAndUpdateState
default    13:02:09.806047-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3395338, size: 4096, read: 4096
default    13:02:09.808052-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3498373, size: 4096, read: 4096
default    13:02:09.808070-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3502469, size: 6235, read: 6235
default    13:02:09.808088-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726fc0> updateStateForPacket Presentation Timestamp {11533/1000 = 11.533}
default    13:02:09.808106-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726fc0> updateStateForPacket Decode Timestamp {11533/1000 = 11.533}
default    13:02:09.808121-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726fc0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.808136-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726fc0> updateStateForPacket sampleOffset 3498392
default    13:02:09.808151-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726fc0> updateStateForPacket sampleSize 10308
default    13:02:09.808247-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.808265-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> seekToPTS already at {11133/1000 = 11.133, rounded}
default    13:02:09.808283-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3508704, size: 4096, read: 4096
default    13:02:09.808300-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3512800, size: 6174, read: 6174
default    13:02:09.808317-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket Presentation Timestamp {11567/1000 = 11.567}
default    13:02:09.808336-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket Decode Timestamp {11567/1000 = 11.567}
default    13:02:09.808353-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.808370-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket sampleOffset 3508723
default    13:02:09.808383-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> updateStateForPacket sampleSize 10247
default    13:02:09.808428-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620400> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x13071f2c0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x13061fd90 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {11567/1000 = 11.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {11567/1000 = 11.567}, DTS = {11567/1000 = 11.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x130723520 totalDataLength: 10247 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10247 bytes @ offset 0 Memory Block 0x13282ca04, 10247 bytes (allocator 0x1f7d62490)
}
default    13:02:09.808547-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620400> copyWithZone
default    13:02:09.808566-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d200> init with pts/dts
default    13:02:09.808582-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.808602-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> seekToPTS already at {11567/1000 = 11.567}
default    13:02:09.808619-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> readAPacketAndUpdateState
default    13:02:09.808634-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3518974, size: 4096, read: 4096
default    13:02:09.808653-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3523070, size: 6359, read: 6359
default    13:02:09.808672-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket Presentation Timestamp {11600/1000 = 11.600}
default    13:02:09.808691-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket Decode Timestamp {11600/1000 = 11.600}
default    13:02:09.808707-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.808725-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket sampleOffset 3518993
default    13:02:09.808739-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket sampleSize 10432
default    13:02:09.808756-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> seekToPTS already at {11600/1000 = 11.600}
default    13:02:09.808773-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620400> created copy <LibAVSampleCursor: 0x13061d200>
default    13:02:09.808795-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d200> stepInDecodeOrderByCount  1
default    13:02:09.808811-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> readAPacketAndUpdateState
default    13:02:09.808828-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3529429, size: 4096, read: 4096
default    13:02:09.808845-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3533525, size: 6198, read: 6198
default    13:02:09.808864-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket Presentation Timestamp {11633/1000 = 11.633, rounded}
default    13:02:09.808881-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket Decode Timestamp {11633/1000 = 11.633, rounded}
default    13:02:09.808898-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.808916-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket sampleOffset 3529448
default    13:02:09.808931-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d200> updateStateForPacket sampleSize 10271
default    13:02:09.808955-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d200> copyWithZone
default    13:02:09.808973-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620ca0> init with pts/dts
default    13:02:09.808988-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.809005-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> seekToPTS already at {11633/1000 = 11.633, rounded}
default    13:02:09.809022-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> readAPacketAndUpdateState
default    13:02:09.809039-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3539723, size: 4096, read: 4096
default    13:02:09.809055-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3543819, size: 6289, read: 6289
default    13:02:09.809073-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Presentation Timestamp {11667/1000 = 11.667}
default    13:02:09.809091-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Decode Timestamp {11667/1000 = 11.667}
default    13:02:09.809108-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.809123-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket sampleOffset 3539742
default    13:02:09.809139-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket sampleSize 10362
default    13:02:09.809164-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> seekToPTS already at {11667/1000 = 11.667}
default    13:02:09.809185-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d200> created copy <LibAVSampleCursor: 0x130620ca0>
default    13:02:09.809202-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620ca0> copyWithZone
default    13:02:09.809220-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306219c0> init with pts/dts
default    13:02:09.809233-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.809251-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> seekToPTS already at {11667/1000 = 11.667}
default    13:02:09.809267-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> readAPacketAndUpdateState
default    13:02:09.809283-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3550108, size: 4096, read: 4096
default    13:02:09.809299-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3554204, size: 6300, read: 6300
default    13:02:09.809318-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket Presentation Timestamp {11700/1000 = 11.700, rounded}
default    13:02:09.809334-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket Decode Timestamp {11700/1000 = 11.700, rounded}
default    13:02:09.809351-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.809366-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket sampleOffset 3550127
default    13:02:09.809382-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket sampleSize 10373
default    13:02:09.809400-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> seekToPTS already at {11700/1000 = 11.700, rounded}
default    13:02:09.809417-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620ca0> created copy <LibAVSampleCursor: 0x1306219c0>
default    13:02:09.809434-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306219c0> stepInDecodeOrderByCount  1
default    13:02:09.809448-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> readAPacketAndUpdateState
default    13:02:09.809463-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3560504, size: 4096, read: 4096
default    13:02:09.809480-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3564600, size: 6331, read: 6331
default    13:02:09.809498-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket Presentation Timestamp {11733/1000 = 11.733}
default    13:02:09.809514-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket Decode Timestamp {11733/1000 = 11.733}
default    13:02:09.809530-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.809546-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket sampleOffset 3560523
default    13:02:09.809561-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket sampleSize 10404
default    13:02:09.809577-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306219c0> stepInDecodeOrderByCount  1
default    13:02:09.809595-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> readAPacketAndUpdateState
default    13:02:09.809613-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3570931, size: 4096, read: 4096
default    13:02:09.809633-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3575027, size: 6305, read: 6305
default    13:02:09.809653-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket Presentation Timestamp {11767/1000 = 11.767}
default    13:02:09.809669-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket Decode Timestamp {11767/1000 = 11.767}
default    13:02:09.809685-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.809701-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket sampleOffset 3570950
default    13:02:09.809717-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306219c0> updateStateForPacket sampleSize 10378
default    13:02:09.809734-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620ca0> stepInDecodeOrderByCount  1
default    13:02:09.809750-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> readAPacketAndUpdateState
default    13:02:09.809765-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3581332, size: 4096, read: 4096
default    13:02:09.809802-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3585428, size: 6303, read: 6303
default    13:02:09.809820-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Presentation Timestamp {11800/1000 = 11.800}
default    13:02:09.809838-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Decode Timestamp {11800/1000 = 11.800}
default    13:02:09.809854-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.809870-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket sampleOffset 3581351
default    13:02:09.809885-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket sampleSize 10376
error    13:02:09.809900-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.809989-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d200> copyWithZone
default    13:02:09.810015-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019070> init with pts/dts
default    13:02:09.810038-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.810065-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> seekToPTS already at {11633/1000 = 11.633, rounded}
default    13:02:09.810081-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> readAPacketAndUpdateState
default    13:02:09.810097-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3591731, size: 4096, read: 4096
default    13:02:09.810115-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3595827, size: 6203, read: 6203
default    13:02:09.810132-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> updateStateForPacket Presentation Timestamp {11833/1000 = 11.833}
default    13:02:09.810151-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> updateStateForPacket Decode Timestamp {11833/1000 = 11.833}
default    13:02:09.810168-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.810183-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> updateStateForPacket sampleOffset 3591750
default    13:02:09.810198-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> updateStateForPacket sampleSize 10276
default    13:02:09.810213-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> seekToPTS already at {11833/1000 = 11.833}
default    13:02:09.810230-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d200> created copy <LibAVSampleCursor: 0x131019070>
default    13:02:09.810250-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019070> stepInPresentationOrderByCount 1
default    13:02:09.810266-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> readAPacketAndUpdateState
default    13:02:09.810283-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3602030, size: 4096, read: 4096
default    13:02:09.810300-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3606126, size: 6275, read: 6275
default    13:02:09.810317-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> updateStateForPacket Presentation Timestamp {11867/1000 = 11.867}
default    13:02:09.810334-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> updateStateForPacket Decode Timestamp {11867/1000 = 11.867}
default    13:02:09.810352-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.810365-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> updateStateForPacket sampleOffset 3602049
default    13:02:09.810390-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131019070> updateStateForPacket sampleSize 10348
default    13:02:09.810411-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131019070> copyWithZone
default    13:02:09.810427-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101f8e0> init with pts/dts
default    13:02:09.810441-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.810458-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101f8e0> seekToPTS already at {11867/1000 = 11.867}
default    13:02:09.810473-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101f8e0> readAPacketAndUpdateState
default    13:02:09.810489-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3612401, size: 4096, read: 4096
default    13:02:09.810506-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3616497, size: 6274, read: 6274
default    13:02:09.810523-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101f8e0> updateStateForPacket Presentation Timestamp {11900/1000 = 11.900}
default    13:02:09.812788-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306225b0> updateStateForPacket Presentation Timestamp {12267/1000 = 12.267}
default    13:02:09.812805-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306225b0> updateStateForPacket Decode Timestamp {12267/1000 = 12.267}
default    13:02:09.812822-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306225b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.812835-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306225b0> updateStateForPacket sampleOffset 3725813
default    13:02:09.812850-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306225b0> updateStateForPacket sampleSize 10256
default    13:02:09.812864-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620ca0> stepInDecodeOrderByCount  1
default    13:02:09.812880-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> readAPacketAndUpdateState
default    13:02:09.812895-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3736073, size: 4096, read: 4096
default    13:02:09.812910-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3740169, size: 6204, read: 6204
default    13:02:09.812927-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Presentation Timestamp {12300/1000 = 12.300}
default    13:02:09.812942-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Decode Timestamp {12300/1000 = 12.300}
default    13:02:09.812959-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.812973-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket sampleOffset 3736092
default    13:02:09.812987-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620ca0> updateStateForPacket sampleSize 10277
error    13:02:09.813004-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.813097-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d2a0> copyWithZone
default    13:02:09.813118-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101ea70> init with pts/dts
default    13:02:09.813133-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.813152-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> seekToPTS already at {12133/1000 = 12.133, rounded}
default    13:02:09.813168-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> readAPacketAndUpdateState
default    13:02:09.813184-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3746373, size: 4096, read: 4096
default    13:02:09.813199-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3750469, size: 6228, read: 6228
default    13:02:09.813216-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> updateStateForPacket Presentation Timestamp {12333/1000 = 12.333}
default    13:02:09.813234-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> updateStateForPacket Decode Timestamp {12333/1000 = 12.333}
default    13:02:09.813250-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.813265-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> updateStateForPacket sampleOffset 3746392
default    13:02:09.813282-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> updateStateForPacket sampleSize 10301
default    13:02:09.813297-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> seekToPTS already at {12333/1000 = 12.333}
default    13:02:09.813313-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d2a0> created copy <LibAVSampleCursor: 0x13101ea70>
default    13:02:09.813334-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101ea70> stepInPresentationOrderByCount 1
default    13:02:09.813349-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> readAPacketAndUpdateState
default    13:02:09.813364-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3756697, size: 4096, read: 4096
default    13:02:09.813380-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3760793, size: 6214, read: 6214
default    13:02:09.813399-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> updateStateForPacket Presentation Timestamp {12367/1000 = 12.367}
default    13:02:09.813415-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> updateStateForPacket Decode Timestamp {12367/1000 = 12.367}
default    13:02:09.813431-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.813446-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> updateStateForPacket sampleOffset 3756716
default    13:02:09.813460-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101ea70> updateStateForPacket sampleSize 10287
default    13:02:09.813483-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101ea70> copyWithZone
default    13:02:09.813498-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101e2e0> init with pts/dts
default    13:02:09.813513-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.813529-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> seekToPTS already at {12367/1000 = 12.367}
default    13:02:09.813545-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> readAPacketAndUpdateState
default    13:02:09.813564-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3767007, size: 4096, read: 4096
default    13:02:09.813579-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3771103, size: 6123, read: 6123
default    13:02:09.813596-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> updateStateForPacket Presentation Timestamp {12400/1000 = 12.400}
default    13:02:09.813612-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> updateStateForPacket Decode Timestamp {12400/1000 = 12.400}
default    13:02:09.813627-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.813642-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> updateStateForPacket sampleOffset 3767026
default    13:02:09.813657-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> updateStateForPacket sampleSize 10196
default    13:02:09.813673-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> seekToPTS already at {12400/1000 = 12.400}
default    13:02:09.813688-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101ea70> created copy <LibAVSampleCursor: 0x13101e2e0>
default    13:02:09.813704-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101e2e0> copyWithZone
default    13:02:09.813719-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131020940> init with pts/dts
default    13:02:09.813733-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.813749-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> seekToPTS already at {12400/1000 = 12.400}
default    13:02:09.813764-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> readAPacketAndUpdateState
default    13:02:09.813777-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3777226, size: 4096, read: 4096
default    13:02:09.813793-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3781322, size: 6232, read: 6232
default    13:02:09.813810-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket Presentation Timestamp {12433/1000 = 12.433}
default    13:02:09.813826-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket Decode Timestamp {12433/1000 = 12.433}
default    13:02:09.813841-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.813864-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket sampleOffset 3777245
default    13:02:09.813879-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket sampleSize 10305
default    13:02:09.813894-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> seekToPTS already at {12433/1000 = 12.433}
default    13:02:09.813910-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101e2e0> created copy <LibAVSampleCursor: 0x131020940>
default    13:02:09.813925-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131020940> stepInDecodeOrderByCount  1
default    13:02:09.813941-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> readAPacketAndUpdateState
default    13:02:09.813955-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3787554, size: 4096, read: 4096
default    13:02:09.813971-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3791650, size: 6147, read: 6147
default    13:02:09.813987-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket Presentation Timestamp {12467/1000 = 12.467}
default    13:02:09.814002-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket Decode Timestamp {12467/1000 = 12.467}
default    13:02:09.814018-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.814032-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket sampleOffset 3787573
default    13:02:09.814044-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket sampleSize 10220
default    13:02:09.814062-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131020940> stepInDecodeOrderByCount  1
default    13:02:09.814075-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> readAPacketAndUpdateState
default    13:02:09.814090-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3797797, size: 4096, read: 4096
default    13:02:09.814105-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3801893, size: 6160, read: 6160
default    13:02:09.814121-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket Presentation Timestamp {12500/1000 = 12.500}
default    13:02:09.814136-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket Decode Timestamp {12500/1000 = 12.500}
default    13:02:09.814152-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.814167-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket sampleOffset 3797816
default    13:02:09.814182-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131020940> updateStateForPacket sampleSize 10233
default    13:02:09.814194-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101e2e0> stepInDecodeOrderByCount  1
default    13:02:09.814209-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> readAPacketAndUpdateState
default    13:02:09.814224-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3808053, size: 4096, read: 4096
default    13:02:09.814239-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3812149, size: 6193, read: 6193
default    13:02:09.814255-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> updateStateForPacket Presentation Timestamp {12533/1000 = 12.533}
default    13:02:09.814271-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> updateStateForPacket Decode Timestamp {12533/1000 = 12.533}
default    13:02:09.814287-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.814301-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> updateStateForPacket sampleOffset 3808072
default    13:02:09.814316-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101e2e0> updateStateForPacket sampleSize 10266
default    13:02:09.814424-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d2a0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.814445-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d2a0> seekToPTS already at {12133/1000 = 12.133, rounded}
default    13:02:09.814461-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3818342, size: 4096, read: 4096
default    13:02:09.814477-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3822438, size: 6160, read: 6160
default    13:02:09.814496-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d2a0> updateStateForPacket Presentation Timestamp {12567/1000 = 12.567}
default    13:02:09.814512-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d2a0> updateStateForPacket Decode Timestamp {12567/1000 = 12.567}
default    13:02:09.814528-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d2a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.814544-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d2a0> updateStateForPacket sampleOffset 3818361
default    13:02:09.814559-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d2a0> updateStateForPacket sampleSize 10233
default    13:02:09.814604-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d2a0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x130622890 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x130622550 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {12567/1000 = 12.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {12567/1000 = 12.567}, DTS = {12567/1000 = 12.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x130620450 totalDataLength: 10233 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10233 bytes @ offset 0 Memory Block 0x13081a204, 10233 bytes (allocator 0x1f7d62490)
}
default    13:02:09.814729-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d2a0> copyWithZone
default    13:02:09.814749-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d5e0> init with pts/dts
default    13:02:09.814763-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.814780-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> seekToPTS already at {12567/1000 = 12.567}
default    13:02:09.814796-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> readAPacketAndUpdateState
default    13:02:09.814814-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3828598, size: 4096, read: 4096
default    13:02:09.814831-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3832694, size: 6147, read: 6147
default    13:02:09.814848-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Presentation Timestamp {12600/1000 = 12.600}
default    13:02:09.814866-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Decode Timestamp {12600/1000 = 12.600}
default    13:02:09.814882-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.814897-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket sampleOffset 3828617
default    13:02:09.814912-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket sampleSize 10220
default    13:02:09.814928-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> seekToPTS already at {12600/1000 = 12.600}
default    13:02:09.814944-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d2a0> created copy <LibAVSampleCursor: 0x13061d5e0>
default    13:02:09.814965-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d5e0> stepInDecodeOrderByCount  1
default    13:02:09.814980-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> readAPacketAndUpdateState
default    13:02:09.814996-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3838841, size: 4096, read: 4096
default    13:02:09.815011-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3842937, size: 6141, read: 6141
default    13:02:09.815030-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Presentation Timestamp {12633/1000 = 12.633, rounded}
default    13:02:09.815046-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Decode Timestamp {12633/1000 = 12.633, rounded}
default    13:02:09.815062-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.815078-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket sampleOffset 3838860
default    13:02:09.815092-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket sampleSize 10214
default    13:02:09.815115-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d5e0> copyWithZone
default    13:02:09.815131-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620c10> init with pts/dts
default    13:02:09.817619-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.817615-0400    LibAVExtensionHost    <<<< VRP >>>> figVideoRenderPipelineRequestDecodeForPreroll: (0x600003aabc60) Renderer preparation for preroll was not requested, continuing preroll without waiting for renderer
default    13:02:09.817641-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> seekToPTS already at {12633/1000 = 12.633, rounded}
default    13:02:09.817656-0400    LibAVExtensionHost    <<<< VRP >>>> videopipelineHandleCompletedDecodeForPrerollNotification: (0x600003aabc60) received CompletedDecodeForPreroll for vmc 0x10e8d5000 with requestID 1003
default    13:02:09.817658-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3971332, size: 4096, read: 4096
default    13:02:09.817667-0400    LibAVExtensionHost    <<<< VRP >>>> figVideoRenderPipelineCompletedDecodeForPreroll: (0x600003aabc60) all preparation tasks for preroll complete
default    13:02:09.817677-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3975428, size: 5877, read: 5877
default    13:02:09.817675-0400    LibAVExtensionHost    <<<< VRP >>>> figVideoRenderPipelinePostPreparationForPrerollCompletedIfPreviouslyRequested: (0x600003aabc60) posting CompletedRendererPreparationForPreroll for request: 1003
default    13:02:09.817694-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Presentation Timestamp {13067/1000 = 13.067}
default    13:02:09.817713-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Decode Timestamp {13067/1000 = 13.067}
default    13:02:09.817729-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.818075-0400    LibAVExtensionHost    <<<< IQ-CA >>>> piqca_gmstats_dump: FIQCA(0x10f8a6000) client pid 79879 (LibAVExtensionHost), timebase rate: 1.00, layer time: 0.000 s, host: 220264.759 s, diff: 220264.759 s; iq unconsumed: 5, min: 2.567, max: 4.567; preventsDisplaySleep: NO
default    13:02:09.817744-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket sampleOffset 3971351
default    13:02:09.818090-0400    LibAVExtensionHost    <<<< IQ-CA >>>> piqca_gmstats_dump: FIQCA(0x10f8a6000) recent frames: enqueued: 7, displayed: 1, dropped: 0, flushed: 0, evicted: 0, >16ms late: 0
default    13:02:09.817760-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket sampleSize 9950
default    13:02:09.818104-0400    LibAVExtensionHost    <<<< IQ-CA >>>> piqca_gmstats_dump: FIQCA(0x10f8a6000) most recently enqueued:
Enqueued Pixel Buffer:&8v0, 1920 x 1080 [
{PTS: 3.067 s, enqueued at: host 220264.705 s (media 0.000 s)},
{PTS: 3.567 s, enqueued at: host 220264.707 s (media 0.000 s)},
{PTS: 4.067 s, enqueued at: host 220264.708 s (media 0.000 s)},
{PTS: 4.567 s, enqueued at: host 220264.708 s (media 0.000 s)},
]
default    13:02:09.817804-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x130622050 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x13061e150 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {13067/1000 = 13.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {13067/1000 = 13.067}, DTS = {13067/1000 = 13.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x130624020 totalDataLength: 9950 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 9950 bytes @ offset 0 Memory Block 0x13081a204, 9950 bytes (allocator 0x1f7d62490)
}
default    13:02:09.818116-0400    LibAVExtensionHost    <<<< IQ-CA >>>> piqca_gmstats_dump: FIQCA(0x10f8a6000) most recently displayed:
DisplaySize: 1248.000000 x 702.000000 [
{PTS: 0.433 s, sampled at: 220263.205 s, displayed at: 0.000 s, on glass for: 1491.667 ms},
]
default    13:02:09.818005-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d5e0> copyWithZone
default    13:02:09.818126-0400    LibAVExtensionHost    <<<< IQ-CA >>>> piqca_setImageQueueTiming: (0x10f8a6000) Forward; Set IQTiming beginTime:220264.758756, (220264.758950 - (0.000194 / 1.000000) )
default    13:02:09.818026-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726890> init with pts/dts
default    13:02:09.818078-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.818187-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> seekToPTS already at {13067/1000 = 13.067}
default    13:02:09.818250-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> readAPacketAndUpdateState
default    13:02:09.818320-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3981305, size: 4096, read: 4096
default    13:02:09.818375-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3985401, size: 5975, read: 5975
default    13:02:09.818490-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Presentation Timestamp {13100/1000 = 13.100}
default    13:02:09.818574-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Decode Timestamp {13100/1000 = 13.100}
default    13:02:09.818635-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.818696-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket sampleOffset 3981324
default    13:02:09.818775-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket sampleSize 10048
default    13:02:09.818826-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> seekToPTS already at {13100/1000 = 13.100}
default    13:02:09.818887-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d5e0> created copy <LibAVSampleCursor: 0x130726890>
default    13:02:09.818957-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726890> stepInDecodeOrderByCount  1
default    13:02:09.819015-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> readAPacketAndUpdateState
default    13:02:09.819005-0400    LibAVExtensionHost    <<<< LayerSync >>>> figlayersync_getLayerDisplayLatency: layer 0x600000d7a250, context 0x6000001b84c0, displayID 1: latency 0.000
default    13:02:09.819056-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3991376, size: 4096, read: 4096
default    13:02:09.819072-0400    LibAVExtensionHost    <<<< LayerSync >>>> figlayersync_setLayerTiming: (layer 0x600000d7a250) only set layer timeOffset: 0.000000 at hostTime 220264.759947
default    13:02:09.819125-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 3995472, size: 5945, read: 5945
default    13:02:09.819183-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Presentation Timestamp {13133/1000 = 13.133, rounded}
default    13:02:09.819236-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Decode Timestamp {13133/1000 = 13.133, rounded}
default    13:02:09.819330-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.819387-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket sampleOffset 3991395
default    13:02:09.819459-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket sampleSize 10018
default    13:02:09.819566-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726890> copyWithZone
default    13:02:09.819626-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726910> init with pts/dts
default    13:02:09.819499-0400    LibAVExtensionHost    [0x600003ca72a0] activating connection: mach=true listener=false peer=false name=com.apple.powerlog.plxpclogger.xpc
default    13:02:09.819690-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.819762-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726910> seekToPTS already at {13133/1000 = 13.133, rounded}
default    13:02:09.819818-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726910> readAPacketAndUpdateState
default    13:02:09.819917-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4001417, size: 4096, read: 4096
default    13:02:09.819968-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4005513, size: 6002, read: 6002
default    13:02:09.820030-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726910> updateStateForPacket Presentation Timestamp {13167/1000 = 13.167}
default    13:02:09.820099-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726910> updateStateForPacket Decode Timestamp {13167/1000 = 13.167}
default    13:02:09.820143-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726910> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.820197-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726910> updateStateForPacket sampleOffset 4001436
default    13:02:09.820266-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726910> updateStateForPacket sampleSize 10075
default    13:02:09.820328-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726910> seekToPTS already at {13167/1000 = 13.167}
default    13:02:09.820401-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726890> created copy <LibAVSampleCursor: 0x130726910>
default    13:02:09.820466-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726910> copyWithZone
default    13:02:09.820513-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131113450> init with pts/dts
default    13:02:09.820591-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.820664-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> seekToPTS already at {13167/1000 = 13.167}
default    13:02:09.820705-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> readAPacketAndUpdateState
default    13:02:09.820746-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4011515, size: 4096, read: 4096
default    13:02:09.820799-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4015611, size: 5914, read: 5914
default    13:02:09.820878-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Presentation Timestamp {13200/1000 = 13.200, rounded}
default    13:02:09.820902-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Decode Timestamp {13200/1000 = 13.200, rounded}
default    13:02:09.820957-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.821022-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket sampleOffset 4011534
default    13:02:09.821063-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> updateStateForPacket sampleSize 9987
default    13:02:09.821136-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131113450> seekToPTS already at {13200/1000 = 13.200, rounded}
default    13:02:09.822731-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> updateStateForPacket Decode Timestamp {13400/1000 = 13.400}
default    13:02:09.822752-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.822767-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> updateStateForPacket sampleOffset 4071755
default    13:02:09.822782-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> updateStateForPacket sampleSize 9958
default    13:02:09.822798-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> seekToPTS already at {13400/1000 = 13.400}
default    13:02:09.822818-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307263b0> created copy <LibAVSampleCursor: 0x130728230>
default    13:02:09.822834-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130728230> copyWithZone
default    13:02:09.822849-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307286c0> init with pts/dts
default    13:02:09.822865-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.822881-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> seekToPTS already at {13400/1000 = 13.400}
default    13:02:09.822899-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> readAPacketAndUpdateState
default    13:02:09.822915-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4081717, size: 4096, read: 4096
default    13:02:09.822932-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4085813, size: 5910, read: 5910
default    13:02:09.822949-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket Presentation Timestamp {13433/1000 = 13.433}
default    13:02:09.822968-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket Decode Timestamp {13433/1000 = 13.433}
default    13:02:09.822984-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.823004-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket sampleOffset 4081736
default    13:02:09.823021-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket sampleSize 9983
default    13:02:09.823039-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> seekToPTS already at {13433/1000 = 13.433}
default    13:02:09.823056-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130728230> created copy <LibAVSampleCursor: 0x1307286c0>
default    13:02:09.823075-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307286c0> stepInDecodeOrderByCount  1
default    13:02:09.823091-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> readAPacketAndUpdateState
default    13:02:09.823106-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4091723, size: 4096, read: 4096
default    13:02:09.823124-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4095819, size: 5846, read: 5846
default    13:02:09.823144-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket Presentation Timestamp {13467/1000 = 13.467}
default    13:02:09.823162-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket Decode Timestamp {13467/1000 = 13.467}
default    13:02:09.823178-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.823194-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket sampleOffset 4091742
default    13:02:09.823210-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket sampleSize 9919
default    13:02:09.823230-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1307286c0> stepInDecodeOrderByCount  1
default    13:02:09.823246-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> readAPacketAndUpdateState
default    13:02:09.823263-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4101665, size: 4096, read: 4096
default    13:02:09.823280-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4105761, size: 5924, read: 5924
default    13:02:09.823298-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket Presentation Timestamp {13500/1000 = 13.500}
default    13:02:09.823373-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket Decode Timestamp {13500/1000 = 13.500}
default    13:02:09.823421-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.823482-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket sampleOffset 4101684
default    13:02:09.823501-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1307286c0> updateStateForPacket sampleSize 9997
default    13:02:09.823554-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130728230> stepInDecodeOrderByCount  1
default    13:02:09.823618-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> readAPacketAndUpdateState
default    13:02:09.823679-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4111685, size: 4096, read: 4096
default    13:02:09.823734-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4115781, size: 5974, read: 5974
default    13:02:09.823755-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> updateStateForPacket Presentation Timestamp {13533/1000 = 13.533}
default    13:02:09.823818-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> updateStateForPacket Decode Timestamp {13533/1000 = 13.533}
default    13:02:09.823878-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.823925-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> updateStateForPacket sampleOffset 4111704
default    13:02:09.823961-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728230> updateStateForPacket sampleSize 10047
default    13:02:09.824100-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.824120-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> seekToPTS already at {13133/1000 = 13.133, rounded}
default    13:02:09.824140-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4121755, size: 4096, read: 4096
default    13:02:09.824182-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4125851, size: 5872, read: 5872
default    13:02:09.824232-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Presentation Timestamp {13567/1000 = 13.567}
default    13:02:09.824317-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Decode Timestamp {13567/1000 = 13.567}
default    13:02:09.824382-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.824450-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket sampleOffset 4121774
default    13:02:09.824506-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket sampleSize 9945
default    13:02:09.824649-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x130728580 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x130620380 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {13567/1000 = 13.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {13567/1000 = 13.567}, DTS = {13567/1000 = 13.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x130726910 totalDataLength: 9945 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 9945 bytes @ offset 0 Memory Block 0x131817204, 9945 bytes (allocator 0x1f7d62490)
}
default    13:02:09.824829-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726890> copyWithZone
default    13:02:09.824851-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131506680> init with pts/dts
default    13:02:09.824866-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.824887-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> seekToPTS already at {13567/1000 = 13.567}
default    13:02:09.824951-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> readAPacketAndUpdateState
default    13:02:09.824975-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4131723, size: 4096, read: 4096
default    13:02:09.825063-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4135819, size: 5976, read: 5976
default    13:02:09.825086-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket Presentation Timestamp {13600/1000 = 13.600}
default    13:02:09.825103-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket Decode Timestamp {13600/1000 = 13.600}
default    13:02:09.825120-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.825136-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket sampleOffset 4131742
default    13:02:09.825154-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket sampleSize 10049
default    13:02:09.825170-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> seekToPTS already at {13600/1000 = 13.600}
default    13:02:09.825236-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726890> created copy <LibAVSampleCursor: 0x131506680>
default    13:02:09.825261-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131506680> stepInDecodeOrderByCount  1
default    13:02:09.825278-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> readAPacketAndUpdateState
default    13:02:09.825295-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4141795, size: 4096, read: 4096
default    13:02:09.825311-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4145891, size: 5912, read: 5912
default    13:02:09.825331-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket Presentation Timestamp {13633/1000 = 13.633, rounded}
default    13:02:09.825350-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket Decode Timestamp {13633/1000 = 13.633, rounded}
default    13:02:09.825367-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.825382-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket sampleOffset 4141814
default    13:02:09.825397-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket sampleSize 9985
default    13:02:09.825421-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131506680> copyWithZone
default    13:02:09.825438-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101fbc0> init with pts/dts
default    13:02:09.825453-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.825470-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101fbc0> seekToPTS already at {13633/1000 = 13.633, rounded}
default    13:02:09.825488-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101fbc0> readAPacketAndUpdateState
default    13:02:09.825552-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4151803, size: 4096, read: 4096
default    13:02:09.825634-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4155899, size: 5988, read: 5988
default    13:02:09.825654-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101fbc0> updateStateForPacket Presentation Timestamp {13667/1000 = 13.667}
default    13:02:09.825671-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101fbc0> updateStateForPacket Decode Timestamp {13667/1000 = 13.667}
default    13:02:09.825689-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101fbc0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.825704-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101fbc0> updateStateForPacket sampleOffset 4151822
default    13:02:09.825719-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101fbc0> updateStateForPacket sampleSize 10061
default    13:02:09.825738-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13101fbc0> seekToPTS already at {13667/1000 = 13.667}
default    13:02:09.825757-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131506680> created copy <LibAVSampleCursor: 0x13101fbc0>
default    13:02:09.825773-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13101fbc0> copyWithZone
default    13:02:09.825788-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131021d30> init with pts/dts
default    13:02:09.825800-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.825819-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021d30> seekToPTS already at {13667/1000 = 13.667}
default    13:02:09.827713-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131022ec0> stepInDecodeOrderByCount  1
default    13:02:09.827728-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022ec0> readAPacketAndUpdateState
default    13:02:09.827742-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4262091, size: 4096, read: 4096
default    13:02:09.827759-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4266187, size: 6016, read: 6016
default    13:02:09.827775-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022ec0> updateStateForPacket Presentation Timestamp {14033/1000 = 14.033}
default    13:02:09.827790-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022ec0> updateStateForPacket Decode Timestamp {14033/1000 = 14.033}
default    13:02:09.827805-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022ec0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.827820-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022ec0> updateStateForPacket sampleOffset 4262110
default    13:02:09.827833-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022ec0> updateStateForPacket sampleSize 10089
default    13:02:09.827920-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.827939-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> seekToPTS already at {13633/1000 = 13.633, rounded}
default    13:02:09.827958-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4272203, size: 4096, read: 4096
default    13:02:09.827974-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4276299, size: 6055, read: 6055
default    13:02:09.827991-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket Presentation Timestamp {14067/1000 = 14.067}
default    13:02:09.828012-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket Decode Timestamp {14067/1000 = 14.067}
default    13:02:09.828030-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.828044-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket sampleOffset 4272222
default    13:02:09.828058-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> updateStateForPacket sampleSize 10128
default    13:02:09.828104-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131506680> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x1310217e0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x131506720 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {14067/1000 = 14.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {14067/1000 = 14.067}, DTS = {14067/1000 = 14.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x131021fa0 totalDataLength: 10128 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10128 bytes @ offset 0 Memory Block 0x132015004, 10128 bytes (allocator 0x1f7d62490)
}
default    13:02:09.828223-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131506680> copyWithZone
default    13:02:09.828243-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620e80> init with pts/dts
default    13:02:09.828258-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.828278-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> seekToPTS already at {14067/1000 = 14.067}
default    13:02:09.828294-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> readAPacketAndUpdateState
default    13:02:09.828310-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4282354, size: 4096, read: 4096
default    13:02:09.828327-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4286450, size: 6159, read: 6159
default    13:02:09.828346-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> updateStateForPacket Presentation Timestamp {14100/1000 = 14.100}
default    13:02:09.828363-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> updateStateForPacket Decode Timestamp {14100/1000 = 14.100}
default    13:02:09.828380-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.828396-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> updateStateForPacket sampleOffset 4282373
default    13:02:09.828411-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> updateStateForPacket sampleSize 10232
default    13:02:09.828425-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> seekToPTS already at {14100/1000 = 14.100}
default    13:02:09.828443-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131506680> created copy <LibAVSampleCursor: 0x130620e80>
default    13:02:09.828464-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620e80> stepInDecodeOrderByCount  1
default    13:02:09.828479-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> readAPacketAndUpdateState
default    13:02:09.828495-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4292609, size: 4096, read: 4096
default    13:02:09.828510-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4296705, size: 6171, read: 6171
default    13:02:09.828528-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> updateStateForPacket Presentation Timestamp {14133/1000 = 14.133, rounded}
default    13:02:09.828546-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> updateStateForPacket Decode Timestamp {14133/1000 = 14.133, rounded}
default    13:02:09.828562-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.828577-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> updateStateForPacket sampleOffset 4292628
default    13:02:09.828591-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620e80> updateStateForPacket sampleSize 10244
default    13:02:09.828613-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620e80> copyWithZone
default    13:02:09.828633-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620c10> init with pts/dts
default    13:02:09.828646-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.828664-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> seekToPTS already at {14133/1000 = 14.133, rounded}
default    13:02:09.828679-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> readAPacketAndUpdateState
default    13:02:09.828694-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4302876, size: 4096, read: 4096
default    13:02:09.828710-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4306972, size: 6136, read: 6136
default    13:02:09.828727-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> updateStateForPacket Presentation Timestamp {14167/1000 = 14.167}
default    13:02:09.828742-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> updateStateForPacket Decode Timestamp {14167/1000 = 14.167}
default    13:02:09.828758-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.828773-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> updateStateForPacket sampleOffset 4302895
default    13:02:09.828787-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> updateStateForPacket sampleSize 10209
default    13:02:09.828809-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> seekToPTS already at {14167/1000 = 14.167}
default    13:02:09.828828-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620e80> created copy <LibAVSampleCursor: 0x130620c10>
default    13:02:09.828844-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620c10> copyWithZone
default    13:02:09.828857-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624680> init with pts/dts
default    13:02:09.828870-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.828887-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> seekToPTS already at {14167/1000 = 14.167}
default    13:02:09.828902-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> readAPacketAndUpdateState
default    13:02:09.828917-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4313108, size: 4096, read: 4096
default    13:02:09.828934-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4317204, size: 6106, read: 6106
default    13:02:09.828952-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket Presentation Timestamp {14200/1000 = 14.200, rounded}
default    13:02:09.828968-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket Decode Timestamp {14200/1000 = 14.200, rounded}
default    13:02:09.828983-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.828996-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket sampleOffset 4313127
default    13:02:09.829010-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket sampleSize 10179
default    13:02:09.829025-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> seekToPTS already at {14200/1000 = 14.200, rounded}
default    13:02:09.829041-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620c10> created copy <LibAVSampleCursor: 0x130624680>
default    13:02:09.829060-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624680> stepInDecodeOrderByCount  1
default    13:02:09.829073-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> readAPacketAndUpdateState
default    13:02:09.829088-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4323310, size: 4096, read: 4096
default    13:02:09.829103-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4327406, size: 6129, read: 6129
default    13:02:09.829121-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket Presentation Timestamp {14233/1000 = 14.233}
default    13:02:09.829135-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket Decode Timestamp {14233/1000 = 14.233}
default    13:02:09.829150-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.829164-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket sampleOffset 4323329
default    13:02:09.829179-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket sampleSize 10202
default    13:02:09.829195-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624680> stepInDecodeOrderByCount  1
default    13:02:09.829211-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> readAPacketAndUpdateState
default    13:02:09.829226-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4333535, size: 4096, read: 4096
default    13:02:09.829245-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4337631, size: 6159, read: 6159
default    13:02:09.829261-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket Presentation Timestamp {14267/1000 = 14.267}
default    13:02:09.829276-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket Decode Timestamp {14267/1000 = 14.267}
default    13:02:09.829292-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.829304-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket sampleOffset 4333554
default    13:02:09.829318-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624680> updateStateForPacket sampleSize 10232
default    13:02:09.829332-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620c10> stepInDecodeOrderByCount  1
default    13:02:09.829346-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> readAPacketAndUpdateState
default    13:02:09.829360-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4343790, size: 4096, read: 4096
default    13:02:09.829375-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4347886, size: 6172, read: 6172
default    13:02:09.829391-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> updateStateForPacket Presentation Timestamp {14300/1000 = 14.300}
default    13:02:09.829406-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> updateStateForPacket Decode Timestamp {14300/1000 = 14.300}
default    13:02:09.829421-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.829436-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> updateStateForPacket sampleOffset 4343809
default    13:02:09.829448-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130620c10> updateStateForPacket sampleSize 10245
error    13:02:09.829466-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.829554-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620e80> copyWithZone
default    13:02:09.829572-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306233b0> init with pts/dts
default    13:02:09.829586-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.829606-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> seekToPTS already at {14133/1000 = 14.133, rounded}
default    13:02:09.829622-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> readAPacketAndUpdateState
default    13:02:09.829642-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4354058, size: 4096, read: 4096
default    13:02:09.829660-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4358154, size: 6220, read: 6220
default    13:02:09.829682-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> updateStateForPacket Presentation Timestamp {14333/1000 = 14.333}
default    13:02:09.829699-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> updateStateForPacket Decode Timestamp {14333/1000 = 14.333}
default    13:02:09.829715-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.829731-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> updateStateForPacket sampleOffset 4354077
default    13:02:09.829746-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> updateStateForPacket sampleSize 10293
default    13:02:09.829762-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> seekToPTS already at {14333/1000 = 14.333}
default    13:02:09.829781-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130620e80> created copy <LibAVSampleCursor: 0x1306233b0>
default    13:02:09.829801-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306233b0> stepInPresentationOrderByCount 1
default    13:02:09.829817-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> readAPacketAndUpdateState
default    13:02:09.829833-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4364374, size: 4096, read: 4096
default    13:02:09.829850-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4368470, size: 6151, read: 6151
default    13:02:09.829868-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> updateStateForPacket Presentation Timestamp {14367/1000 = 14.367}
default    13:02:09.829886-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> updateStateForPacket Decode Timestamp {14367/1000 = 14.367}
default    13:02:09.829904-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.829919-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> updateStateForPacket sampleOffset 4364393
default    13:02:09.829933-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306233b0> updateStateForPacket sampleSize 10224
default    13:02:09.829956-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306233b0> copyWithZone
default    13:02:09.829972-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130622d80> init with pts/dts
default    13:02:09.829987-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.830004-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622d80> seekToPTS already at {14367/1000 = 14.367}
default    13:02:09.830020-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622d80> readAPacketAndUpdateState
default    13:02:09.830037-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4374621, size: 4096, read: 4096
default    13:02:09.832232-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131022d10> stepInDecodeOrderByCount  1
default    13:02:09.832247-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022d10> readAPacketAndUpdateState
default    13:02:09.832262-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4488082, size: 4096, read: 4096
default    13:02:09.832276-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4492178, size: 6336, read: 6336
default    13:02:09.832292-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022d10> updateStateForPacket Presentation Timestamp {14767/1000 = 14.767}
default    13:02:09.832308-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022d10> updateStateForPacket Decode Timestamp {14767/1000 = 14.767}
default    13:02:09.832321-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022d10> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.832335-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022d10> updateStateForPacket sampleOffset 4488101
default    13:02:09.832350-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131022d10> updateStateForPacket sampleSize 10409
default    13:02:09.832364-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310229b0> stepInDecodeOrderByCount  1
default    13:02:09.832376-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310229b0> readAPacketAndUpdateState
default    13:02:09.832391-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4498514, size: 4096, read: 4096
default    13:02:09.832406-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4502610, size: 6299, read: 6299
default    13:02:09.832422-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310229b0> updateStateForPacket Presentation Timestamp {14800/1000 = 14.800}
default    13:02:09.832437-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310229b0> updateStateForPacket Decode Timestamp {14800/1000 = 14.800}
default    13:02:09.832452-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310229b0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.832464-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310229b0> updateStateForPacket sampleOffset 4498533
default    13:02:09.832478-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310229b0> updateStateForPacket sampleSize 10372
error    13:02:09.832496-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.832580-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131021500> copyWithZone
default    13:02:09.832607-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306244c0> init with pts/dts
default    13:02:09.832622-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.832639-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> seekToPTS already at {14633/1000 = 14.633, rounded}
default    13:02:09.832655-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> readAPacketAndUpdateState
default    13:02:09.832670-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4508909, size: 4096, read: 4096
default    13:02:09.832686-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4513005, size: 6269, read: 6269
default    13:02:09.832705-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> updateStateForPacket Presentation Timestamp {14833/1000 = 14.833}
default    13:02:09.832720-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> updateStateForPacket Decode Timestamp {14833/1000 = 14.833}
default    13:02:09.832736-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.832751-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> updateStateForPacket sampleOffset 4508928
default    13:02:09.832765-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> updateStateForPacket sampleSize 10342
default    13:02:09.832779-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> seekToPTS already at {14833/1000 = 14.833}
default    13:02:09.832797-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131021500> created copy <LibAVSampleCursor: 0x1306244c0>
default    13:02:09.832817-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306244c0> stepInPresentationOrderByCount 1
default    13:02:09.832830-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> readAPacketAndUpdateState
default    13:02:09.832845-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4519274, size: 4096, read: 4096
default    13:02:09.832861-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4523370, size: 6283, read: 6283
default    13:02:09.832878-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> updateStateForPacket Presentation Timestamp {14867/1000 = 14.867}
default    13:02:09.832894-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> updateStateForPacket Decode Timestamp {14867/1000 = 14.867}
default    13:02:09.832909-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.832922-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> updateStateForPacket sampleOffset 4519293
default    13:02:09.832937-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306244c0> updateStateForPacket sampleSize 10356
default    13:02:09.832957-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306244c0> copyWithZone
default    13:02:09.832973-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624eb0> init with pts/dts
default    13:02:09.832987-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.833003-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> seekToPTS already at {14867/1000 = 14.867}
default    13:02:09.833018-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> readAPacketAndUpdateState
default    13:02:09.833031-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4529653, size: 4096, read: 4096
default    13:02:09.833048-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4533749, size: 6244, read: 6244
default    13:02:09.833065-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket Presentation Timestamp {14900/1000 = 14.900}
default    13:02:09.833080-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket Decode Timestamp {14900/1000 = 14.900}
default    13:02:09.833095-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.833108-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket sampleOffset 4529672
default    13:02:09.833122-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket sampleSize 10317
default    13:02:09.833137-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> seekToPTS already at {14900/1000 = 14.900}
default    13:02:09.833153-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306244c0> created copy <LibAVSampleCursor: 0x130624eb0>
default    13:02:09.833168-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624eb0> copyWithZone
default    13:02:09.833182-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306265d0> init with pts/dts
default    13:02:09.833194-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.833210-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> seekToPTS already at {14900/1000 = 14.900}
default    13:02:09.833225-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> readAPacketAndUpdateState
default    13:02:09.833240-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4539993, size: 4096, read: 4096
default    13:02:09.833256-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4544089, size: 6195, read: 6195
default    13:02:09.833273-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket Presentation Timestamp {14933/1000 = 14.933}
default    13:02:09.833291-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket Decode Timestamp {14933/1000 = 14.933}
default    13:02:09.833307-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.833331-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket sampleOffset 4540012
default    13:02:09.833347-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket sampleSize 10268
default    13:02:09.833363-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> seekToPTS already at {14933/1000 = 14.933}
default    13:02:09.833379-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624eb0> created copy <LibAVSampleCursor: 0x1306265d0>
default    13:02:09.833396-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306265d0> stepInDecodeOrderByCount  1
default    13:02:09.833411-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> readAPacketAndUpdateState
default    13:02:09.833426-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4550284, size: 4096, read: 4096
default    13:02:09.833446-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4554380, size: 6287, read: 6287
default    13:02:09.833463-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket Presentation Timestamp {14967/1000 = 14.967}
default    13:02:09.833482-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket Decode Timestamp {14967/1000 = 14.967}
default    13:02:09.833498-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.833513-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket sampleOffset 4550303
default    13:02:09.833527-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket sampleSize 10360
default    13:02:09.833544-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1306265d0> stepInDecodeOrderByCount  1
default    13:02:09.833560-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> readAPacketAndUpdateState
default    13:02:09.833576-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4560667, size: 4096, read: 4096
default    13:02:09.833594-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4564763, size: 6156, read: 6156
default    13:02:09.833623-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket Presentation Timestamp {15000/1000 = 15.000}
default    13:02:09.833663-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket Decode Timestamp {15000/1000 = 15.000}
default    13:02:09.833683-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.833700-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket sampleOffset 4560686
default    13:02:09.833715-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1306265d0> updateStateForPacket sampleSize 10229
default    13:02:09.833731-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624eb0> stepInDecodeOrderByCount  1
default    13:02:09.833745-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> readAPacketAndUpdateState
default    13:02:09.833762-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4570919, size: 4096, read: 4096
default    13:02:09.833781-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4575015, size: 6217, read: 6217
default    13:02:09.833807-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket Presentation Timestamp {15033/1000 = 15.033}
default    13:02:09.833825-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket Decode Timestamp {15033/1000 = 15.033}
default    13:02:09.833839-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.833853-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket sampleOffset 4570938
default    13:02:09.833875-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket sampleSize 10290
default    13:02:09.833964-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021500> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.833982-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021500> seekToPTS already at {14633/1000 = 14.633, rounded}
default    13:02:09.834001-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4581232, size: 4096, read: 4096
default    13:02:09.834018-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4585328, size: 6105, read: 6105
default    13:02:09.834037-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021500> updateStateForPacket Presentation Timestamp {15067/1000 = 15.067}
default    13:02:09.834074-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021500> updateStateForPacket Decode Timestamp {15067/1000 = 15.067}
default    13:02:09.834090-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021500> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.834106-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021500> updateStateForPacket sampleOffset 4581251
default    13:02:09.834122-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021500> updateStateForPacket sampleSize 10178
default    13:02:09.834167-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021500> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x131024140 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x131021ac0 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {15067/1000 = 15.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {15067/1000 = 15.067}, DTS = {15067/1000 = 15.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x131022b60 totalDataLength: 10178 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10178 bytes @ offset 0 Memory Block 0x132015004, 10178 bytes (allocator 0x1f7d62490)
}
default    13:02:09.834270-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131021500> copyWithZone
default    13:02:09.834290-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130622bd0> init with pts/dts
default    13:02:09.834304-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.834321-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> seekToPTS already at {15067/1000 = 15.067}
default    13:02:09.834337-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> readAPacketAndUpdateState
default    13:02:09.834352-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4591433, size: 4096, read: 4096
default    13:02:09.834368-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4595529, size: 6173, read: 6173
default    13:02:09.834386-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket Presentation Timestamp {15100/1000 = 15.100}
default    13:02:09.834403-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket Decode Timestamp {15100/1000 = 15.100}
default    13:02:09.834419-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.834434-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket sampleOffset 4591452
default    13:02:09.834448-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket sampleSize 10246
default    13:02:09.834462-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> seekToPTS already at {15100/1000 = 15.100}
default    13:02:09.834480-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131021500> created copy <LibAVSampleCursor: 0x130622bd0>
default    13:02:09.834500-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130622bd0> stepInDecodeOrderByCount  1
default    13:02:09.834515-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> readAPacketAndUpdateState
default    13:02:09.834530-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4601702, size: 4096, read: 4096
default    13:02:09.834547-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4605798, size: 6100, read: 6100
default    13:02:09.834563-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket Presentation Timestamp {15133/1000 = 15.133, rounded}
default    13:02:09.834579-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket Decode Timestamp {15133/1000 = 15.133, rounded}
default    13:02:09.834595-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.836808-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4693800, size: 4096, read: 4096
default    13:02:09.836859-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4697896, size: 6119, read: 6119
default    13:02:09.836879-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket Presentation Timestamp {15433/1000 = 15.433}
default    13:02:09.836896-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket Decode Timestamp {15433/1000 = 15.433}
default    13:02:09.836914-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.836937-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket sampleOffset 4693819
default    13:02:09.836952-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket sampleSize 10192
default    13:02:09.836970-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> seekToPTS already at {15433/1000 = 15.433}
default    13:02:09.836986-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729320> created copy <LibAVSampleCursor: 0x131021c30>
default    13:02:09.837002-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131021c30> stepInDecodeOrderByCount  1
default    13:02:09.837019-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> readAPacketAndUpdateState
default    13:02:09.837066-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4704015, size: 4096, read: 4096
default    13:02:09.837165-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4708111, size: 6213, read: 6213
default    13:02:09.837193-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket Presentation Timestamp {15467/1000 = 15.467}
default    13:02:09.837215-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket Decode Timestamp {15467/1000 = 15.467}
default    13:02:09.837234-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.837250-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket sampleOffset 4704034
default    13:02:09.837265-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket sampleSize 10286
default    13:02:09.837286-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131021c30> stepInDecodeOrderByCount  1
default    13:02:09.837302-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> readAPacketAndUpdateState
default    13:02:09.837383-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4714324, size: 4096, read: 4096
default    13:02:09.837529-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4718420, size: 6106, read: 6106
default    13:02:09.837553-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket Presentation Timestamp {15500/1000 = 15.500}
default    13:02:09.837570-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket Decode Timestamp {15500/1000 = 15.500}
default    13:02:09.837588-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.837603-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket sampleOffset 4714343
default    13:02:09.837616-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131021c30> updateStateForPacket sampleSize 10179
default    13:02:09.837632-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729320> stepInDecodeOrderByCount  1
default    13:02:09.837646-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729320> readAPacketAndUpdateState
default    13:02:09.837765-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4724526, size: 4096, read: 4096
default    13:02:09.837948-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4728622, size: 6015, read: 6015
default    13:02:09.837970-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729320> updateStateForPacket Presentation Timestamp {15533/1000 = 15.533}
default    13:02:09.837986-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729320> updateStateForPacket Decode Timestamp {15533/1000 = 15.533}
default    13:02:09.838002-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729320> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.838020-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729320> updateStateForPacket sampleOffset 4724545
default    13:02:09.838033-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729320> updateStateForPacket sampleSize 10088
default    13:02:09.838150-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.838177-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> seekToPTS already at {15133/1000 = 15.133, rounded}
default    13:02:09.838231-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4734637, size: 4096, read: 4096
default    13:02:09.838282-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4738733, size: 6064, read: 6064
default    13:02:09.838308-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket Presentation Timestamp {15567/1000 = 15.567}
default    13:02:09.838329-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket Decode Timestamp {15567/1000 = 15.567}
default    13:02:09.838346-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.838361-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket sampleOffset 4734656
default    13:02:09.838376-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> updateStateForPacket sampleSize 10137
default    13:02:09.838423-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130622bd0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x131114900 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x130626410 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {15567/1000 = 15.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {15567/1000 = 15.567}, DTS = {15567/1000 = 15.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x131114310 totalDataLength: 10137 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10137 bytes @ offset 0 Memory Block 0x13081b604, 10137 bytes (allocator 0x1f7d62490)
}
default    13:02:09.838567-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130622bd0> copyWithZone
default    13:02:09.838592-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131114ab0> init with pts/dts
default    13:02:09.838607-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.838628-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> seekToPTS already at {15567/1000 = 15.567}
default    13:02:09.838644-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> readAPacketAndUpdateState
default    13:02:09.838700-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4744797, size: 4096, read: 4096
default    13:02:09.838752-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4748893, size: 5977, read: 5977
default    13:02:09.838778-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket Presentation Timestamp {15600/1000 = 15.600}
default    13:02:09.838797-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket Decode Timestamp {15600/1000 = 15.600}
default    13:02:09.838814-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.838829-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket sampleOffset 4744816
default    13:02:09.838845-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket sampleSize 10050
default    13:02:09.838860-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> seekToPTS already at {15600/1000 = 15.600}
default    13:02:09.838876-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130622bd0> created copy <LibAVSampleCursor: 0x131114ab0>
default    13:02:09.838898-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131114ab0> stepInDecodeOrderByCount  1
default    13:02:09.838913-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> readAPacketAndUpdateState
default    13:02:09.838960-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4754870, size: 4096, read: 4096
default    13:02:09.839008-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4758966, size: 6058, read: 6058
default    13:02:09.839035-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket Presentation Timestamp {15633/1000 = 15.633, rounded}
default    13:02:09.839054-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket Decode Timestamp {15633/1000 = 15.633, rounded}
default    13:02:09.839071-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.839086-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket sampleOffset 4754889
default    13:02:09.839101-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket sampleSize 10131
default    13:02:09.839122-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131114ab0> copyWithZone
default    13:02:09.839138-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726890> init with pts/dts
default    13:02:09.839154-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.839173-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> seekToPTS already at {15633/1000 = 15.633, rounded}
default    13:02:09.839188-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> readAPacketAndUpdateState
default    13:02:09.839237-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4765024, size: 4096, read: 4096
default    13:02:09.839287-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4769120, size: 6042, read: 6042
default    13:02:09.839312-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Presentation Timestamp {15667/1000 = 15.667}
default    13:02:09.839329-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Decode Timestamp {15667/1000 = 15.667}
default    13:02:09.839345-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.839359-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket sampleOffset 4765043
default    13:02:09.839375-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket sampleSize 10115
default    13:02:09.839394-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> seekToPTS already at {15667/1000 = 15.667}
default    13:02:09.839411-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131114ab0> created copy <LibAVSampleCursor: 0x130726890>
default    13:02:09.839427-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726890> copyWithZone
default    13:02:09.839442-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725a80> init with pts/dts
default    13:02:09.839456-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.839473-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> seekToPTS already at {15667/1000 = 15.667}
default    13:02:09.839488-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> readAPacketAndUpdateState
default    13:02:09.839531-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4775162, size: 4096, read: 4096
default    13:02:09.839581-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4779258, size: 6025, read: 6025
default    13:02:09.839606-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket Presentation Timestamp {15700/1000 = 15.700, rounded}
default    13:02:09.839627-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket Decode Timestamp {15700/1000 = 15.700, rounded}
default    13:02:09.839643-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.839659-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket sampleOffset 4775181
default    13:02:09.839675-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket sampleSize 10098
default    13:02:09.839693-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> seekToPTS already at {15700/1000 = 15.700, rounded}
default    13:02:09.839709-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726890> created copy <LibAVSampleCursor: 0x130725a80>
default    13:02:09.839729-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725a80> stepInDecodeOrderByCount  1
default    13:02:09.839745-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> readAPacketAndUpdateState
default    13:02:09.839792-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4785283, size: 4096, read: 4096
default    13:02:09.839843-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4789379, size: 6127, read: 6127
default    13:02:09.839867-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket Presentation Timestamp {15733/1000 = 15.733}
default    13:02:09.839884-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket Decode Timestamp {15733/1000 = 15.733}
default    13:02:09.839900-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.839915-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket sampleOffset 4785302
default    13:02:09.839930-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket sampleSize 10200
default    13:02:09.839946-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130725a80> stepInDecodeOrderByCount  1
default    13:02:09.839962-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> readAPacketAndUpdateState
default    13:02:09.840004-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4795506, size: 4096, read: 4096
default    13:02:09.840054-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4799602, size: 6023, read: 6023
default    13:02:09.840074-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket Presentation Timestamp {15767/1000 = 15.767}
default    13:02:09.840091-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket Decode Timestamp {15767/1000 = 15.767}
default    13:02:09.840107-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.840122-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket sampleOffset 4795525
default    13:02:09.840137-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130725a80> updateStateForPacket sampleSize 10096
default    13:02:09.840152-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726890> stepInDecodeOrderByCount  1
default    13:02:09.840167-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> readAPacketAndUpdateState
default    13:02:09.840209-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4805625, size: 4096, read: 4096
default    13:02:09.840254-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4809721, size: 6088, read: 6088
default    13:02:09.840276-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Presentation Timestamp {15800/1000 = 15.800}
default    13:02:09.840295-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Decode Timestamp {15800/1000 = 15.800}
default    13:02:09.840311-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.840326-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket sampleOffset 4805644
default    13:02:09.840339-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726890> updateStateForPacket sampleSize 10161
error    13:02:09.840358-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.840440-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131114ab0> copyWithZone
default    13:02:09.840460-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131023bd0> init with pts/dts
default    13:02:09.841500-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket sampleOffset 4846380
default    13:02:09.841517-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket sampleSize 10063
default    13:02:09.841533-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> seekToPTS already at {15933/1000 = 15.933}
default    13:02:09.841550-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729750> created copy <LibAVSampleCursor: 0x131114bd0>
default    13:02:09.841566-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131114bd0> stepInDecodeOrderByCount  1
default    13:02:09.841579-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> readAPacketAndUpdateState
default    13:02:09.841619-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4856447, size: 4096, read: 4096
default    13:02:09.841670-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4860543, size: 6025, read: 6025
default    13:02:09.841690-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket Presentation Timestamp {15967/1000 = 15.967}
default    13:02:09.841707-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket Decode Timestamp {15967/1000 = 15.967}
default    13:02:09.841725-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.841739-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket sampleOffset 4856466
default    13:02:09.841754-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket sampleSize 10098
default    13:02:09.841773-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131114bd0> stepInDecodeOrderByCount  1
default    13:02:09.841790-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> readAPacketAndUpdateState
default    13:02:09.841834-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4866568, size: 4096, read: 4096
default    13:02:09.841881-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4870664, size: 5984, read: 5984
default    13:02:09.841900-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket Presentation Timestamp {16000/1000 = 16.000}
default    13:02:09.841917-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket Decode Timestamp {16000/1000 = 16.000}
default    13:02:09.841932-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.841945-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket sampleOffset 4866587
default    13:02:09.841959-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114bd0> updateStateForPacket sampleSize 10057
default    13:02:09.841973-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729750> stepInDecodeOrderByCount  1
default    13:02:09.841986-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729750> readAPacketAndUpdateState
default    13:02:09.842026-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4876648, size: 4096, read: 4096
default    13:02:09.842072-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4880744, size: 5928, read: 5928
default    13:02:09.842092-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729750> updateStateForPacket Presentation Timestamp {16033/1000 = 16.033}
default    13:02:09.842108-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729750> updateStateForPacket Decode Timestamp {16033/1000 = 16.033}
default    13:02:09.842123-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729750> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.842138-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729750> updateStateForPacket sampleOffset 4876667
default    13:02:09.842152-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729750> updateStateForPacket sampleSize 10001
default    13:02:09.842236-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.842256-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> seekToPTS already at {15633/1000 = 15.633, rounded}
default    13:02:09.842298-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4886672, size: 4096, read: 4096
default    13:02:09.842344-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4890768, size: 6045, read: 6045
default    13:02:09.842366-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket Presentation Timestamp {16067/1000 = 16.067}
default    13:02:09.842385-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket Decode Timestamp {16067/1000 = 16.067}
default    13:02:09.842401-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.842416-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket sampleOffset 4886691
default    13:02:09.842430-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> updateStateForPacket sampleSize 10118
default    13:02:09.842474-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131114ab0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x130729d70 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x131115850 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {16067/1000 = 16.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {16067/1000 = 16.067}, DTS = {16067/1000 = 16.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x1307280a0 totalDataLength: 10118 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10118 bytes @ offset 0 Memory Block 0x132015004, 10118 bytes (allocator 0x1f7d62490)
}
default    13:02:09.842590-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131114ab0> copyWithZone
default    13:02:09.842607-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131024650> init with pts/dts
default    13:02:09.842621-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.842638-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> seekToPTS already at {16067/1000 = 16.067}
default    13:02:09.842653-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> readAPacketAndUpdateState
default    13:02:09.842700-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4896813, size: 4096, read: 4096
default    13:02:09.842746-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4900909, size: 6031, read: 6031
default    13:02:09.842767-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket Presentation Timestamp {16100/1000 = 16.100}
default    13:02:09.842784-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket Decode Timestamp {16100/1000 = 16.100}
default    13:02:09.842801-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.842816-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket sampleOffset 4896832
default    13:02:09.842829-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket sampleSize 10104
default    13:02:09.842845-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> seekToPTS already at {16100/1000 = 16.100}
default    13:02:09.842860-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131114ab0> created copy <LibAVSampleCursor: 0x131024650>
default    13:02:09.842881-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131024650> stepInDecodeOrderByCount  1
default    13:02:09.842896-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> readAPacketAndUpdateState
default    13:02:09.842937-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4906940, size: 4096, read: 4096
default    13:02:09.842988-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4911036, size: 5980, read: 5980
default    13:02:09.843008-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket Presentation Timestamp {16133/1000 = 16.133}
default    13:02:09.843024-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket Decode Timestamp {16133/1000 = 16.133}
default    13:02:09.843039-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.843055-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket sampleOffset 4906959
default    13:02:09.843070-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket sampleSize 10053
default    13:02:09.843091-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131024650> copyWithZone
default    13:02:09.843106-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310253f0> init with pts/dts
default    13:02:09.843118-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.843136-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> seekToPTS already at {16133/1000 = 16.133}
default    13:02:09.843151-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> readAPacketAndUpdateState
default    13:02:09.843192-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4917016, size: 4096, read: 4096
default    13:02:09.843236-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4921112, size: 5914, read: 5914
default    13:02:09.843257-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> updateStateForPacket Presentation Timestamp {16167/1000 = 16.167}
default    13:02:09.843275-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> updateStateForPacket Decode Timestamp {16167/1000 = 16.167}
default    13:02:09.843291-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.843307-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> updateStateForPacket sampleOffset 4917035
default    13:02:09.843321-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> updateStateForPacket sampleSize 9987
default    13:02:09.843342-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> seekToPTS already at {16167/1000 = 16.167}
default    13:02:09.843359-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131024650> created copy <LibAVSampleCursor: 0x1310253f0>
default    13:02:09.843375-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310253f0> copyWithZone
default    13:02:09.843390-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130728d90> init with pts/dts
default    13:02:09.843405-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.843424-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> seekToPTS already at {16167/1000 = 16.167}
default    13:02:09.843439-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> readAPacketAndUpdateState
default    13:02:09.843478-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4927026, size: 4096, read: 4096
default    13:02:09.843530-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4931122, size: 5975, read: 5975
default    13:02:09.843552-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket Presentation Timestamp {16200/1000 = 16.200}
default    13:02:09.843570-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket Decode Timestamp {16200/1000 = 16.200}
default    13:02:09.843586-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.843601-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket sampleOffset 4927045
default    13:02:09.843616-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket sampleSize 10048
default    13:02:09.843631-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> seekToPTS already at {16200/1000 = 16.200}
default    13:02:09.843655-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310253f0> created copy <LibAVSampleCursor: 0x130728d90>
default    13:02:09.843677-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130728d90> stepInDecodeOrderByCount  1
default    13:02:09.843739-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> readAPacketAndUpdateState
default    13:02:09.843791-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4937097, size: 4096, read: 4096
default    13:02:09.843833-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4941193, size: 6061, read: 6061
default    13:02:09.843852-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket Presentation Timestamp {16233/1000 = 16.233}
default    13:02:09.843869-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket Decode Timestamp {16233/1000 = 16.233}
default    13:02:09.843885-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.843899-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket sampleOffset 4937116
default    13:02:09.843914-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket sampleSize 10134
default    13:02:09.843931-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130728d90> stepInDecodeOrderByCount  1
default    13:02:09.843947-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> readAPacketAndUpdateState
default    13:02:09.843991-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4947254, size: 4096, read: 4096
default    13:02:09.844033-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4951350, size: 5911, read: 5911
default    13:02:09.844053-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket Presentation Timestamp {16267/1000 = 16.267}
default    13:02:09.844070-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket Decode Timestamp {16267/1000 = 16.267}
default    13:02:09.844086-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.844100-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket sampleOffset 4947273
default    13:02:09.844119-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130728d90> updateStateForPacket sampleSize 9984
default    13:02:09.844134-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310253f0> stepInDecodeOrderByCount  1
default    13:02:09.844149-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> readAPacketAndUpdateState
default    13:02:09.844188-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4957261, size: 4096, read: 4096
default    13:02:09.844238-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 4961357, size: 6058, read: 6058
default    13:02:09.844258-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> updateStateForPacket Presentation Timestamp {16300/1000 = 16.300}
default    13:02:09.844276-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> updateStateForPacket Decode Timestamp {16300/1000 = 16.300}
default    13:02:09.844293-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.844307-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> updateStateForPacket sampleOffset 4957280
default    13:02:09.844321-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310253f0> updateStateForPacket sampleSize 10131
error    13:02:09.844340-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.844417-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131024650> copyWithZone
default    13:02:09.844434-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1311173a0> init with pts/dts
default    13:02:09.844449-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.844465-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311173a0> seekToPTS already at {16133/1000 = 16.133}
default    13:02:09.845841-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5021975, size: 5913, read: 5913
default    13:02:09.845864-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118930> updateStateForPacket Presentation Timestamp {16500/1000 = 16.500}
default    13:02:09.845881-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118930> updateStateForPacket Decode Timestamp {16500/1000 = 16.500}
default    13:02:09.845896-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118930> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.845911-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118930> updateStateForPacket sampleOffset 5017898
default    13:02:09.845926-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118930> updateStateForPacket sampleSize 9986
default    13:02:09.845941-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1311184f0> stepInDecodeOrderByCount  1
default    13:02:09.845954-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184f0> readAPacketAndUpdateState
default    13:02:09.845998-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5027888, size: 4096, read: 4096
default    13:02:09.846040-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5031984, size: 5995, read: 5995
default    13:02:09.846060-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184f0> updateStateForPacket Presentation Timestamp {16533/1000 = 16.533}
default    13:02:09.846079-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184f0> updateStateForPacket Decode Timestamp {16533/1000 = 16.533}
default    13:02:09.846093-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.846108-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184f0> updateStateForPacket sampleOffset 5027907
default    13:02:09.846122-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184f0> updateStateForPacket sampleSize 10068
default    13:02:09.846205-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.846225-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> seekToPTS already at {16133/1000 = 16.133}
default    13:02:09.846267-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5037979, size: 4096, read: 4096
default    13:02:09.846314-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5042075, size: 5986, read: 5986
default    13:02:09.846337-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket Presentation Timestamp {16567/1000 = 16.567}
default    13:02:09.846354-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket Decode Timestamp {16567/1000 = 16.567}
default    13:02:09.846370-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.846385-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket sampleOffset 5037998
default    13:02:09.846400-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> updateStateForPacket sampleSize 10059
default    13:02:09.846442-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131024650> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x1307253e0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x131023b30 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {16567/1000 = 16.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {16567/1000 = 16.567}, DTS = {16567/1000 = 16.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x130728d90 totalDataLength: 10059 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10059 bytes @ offset 0 Memory Block 0x131817204, 10059 bytes (allocator 0x1f7d62490)
}
default    13:02:09.846550-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131024650> copyWithZone
default    13:02:09.846570-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729210> init with pts/dts
default    13:02:09.846585-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.846602-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> seekToPTS already at {16567/1000 = 16.567}
default    13:02:09.846617-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> readAPacketAndUpdateState
default    13:02:09.846662-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5048061, size: 4096, read: 4096
default    13:02:09.846712-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5052157, size: 6014, read: 6014
default    13:02:09.846735-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket Presentation Timestamp {16600/1000 = 16.600}
default    13:02:09.846755-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket Decode Timestamp {16600/1000 = 16.600}
default    13:02:09.846774-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.846788-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket sampleOffset 5048080
default    13:02:09.846805-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket sampleSize 10087
default    13:02:09.846820-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> seekToPTS already at {16600/1000 = 16.600}
default    13:02:09.846837-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131024650> created copy <LibAVSampleCursor: 0x130729210>
default    13:02:09.846859-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729210> stepInDecodeOrderByCount  1
default    13:02:09.846877-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> readAPacketAndUpdateState
default    13:02:09.846920-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5058171, size: 4096, read: 4096
default    13:02:09.846967-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5062267, size: 5900, read: 5900
default    13:02:09.847003-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket Presentation Timestamp {16633/1000 = 16.633}
default    13:02:09.847028-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket Decode Timestamp {16633/1000 = 16.633}
default    13:02:09.847047-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.847063-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket sampleOffset 5058190
default    13:02:09.847078-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket sampleSize 9973
default    13:02:09.847100-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729210> copyWithZone
default    13:02:09.847117-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d5e0> init with pts/dts
default    13:02:09.847135-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.847156-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> seekToPTS already at {16633/1000 = 16.633}
default    13:02:09.847173-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> readAPacketAndUpdateState
default    13:02:09.847213-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5068167, size: 4096, read: 4096
default    13:02:09.847258-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5072263, size: 5988, read: 5988
default    13:02:09.847280-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Presentation Timestamp {16667/1000 = 16.667}
default    13:02:09.847297-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Decode Timestamp {16667/1000 = 16.667}
default    13:02:09.847315-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.847331-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket sampleOffset 5068186
default    13:02:09.847347-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket sampleSize 10061
default    13:02:09.847372-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> seekToPTS already at {16667/1000 = 16.667}
default    13:02:09.847390-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729210> created copy <LibAVSampleCursor: 0x13061d5e0>
default    13:02:09.847409-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d5e0> copyWithZone
default    13:02:09.847424-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726e50> init with pts/dts
default    13:02:09.847439-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.847455-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> seekToPTS already at {16667/1000 = 16.667}
default    13:02:09.847475-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> readAPacketAndUpdateState
default    13:02:09.847521-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5078251, size: 4096, read: 4096
default    13:02:09.847579-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5082347, size: 5962, read: 5962
default    13:02:09.847604-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket Presentation Timestamp {16700/1000 = 16.700}
default    13:02:09.847623-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket Decode Timestamp {16700/1000 = 16.700}
default    13:02:09.847639-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.847656-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket sampleOffset 5078270
default    13:02:09.847670-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket sampleSize 10035
default    13:02:09.847687-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> seekToPTS already at {16700/1000 = 16.700}
default    13:02:09.847702-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d5e0> created copy <LibAVSampleCursor: 0x130726e50>
default    13:02:09.847718-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726e50> stepInDecodeOrderByCount  1
default    13:02:09.847733-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> readAPacketAndUpdateState
default    13:02:09.847781-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5088309, size: 4096, read: 4096
default    13:02:09.847836-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5092405, size: 5966, read: 5966
default    13:02:09.847855-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket Presentation Timestamp {16733/1000 = 16.733}
default    13:02:09.847872-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket Decode Timestamp {16733/1000 = 16.733}
default    13:02:09.847889-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.847906-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket sampleOffset 5088328
default    13:02:09.847920-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket sampleSize 10039
default    13:02:09.847939-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130726e50> stepInDecodeOrderByCount  1
default    13:02:09.847959-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> readAPacketAndUpdateState
default    13:02:09.847996-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5098371, size: 4096, read: 4096
default    13:02:09.848037-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5102467, size: 6026, read: 6026
default    13:02:09.848054-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket Presentation Timestamp {16767/1000 = 16.767}
default    13:02:09.848073-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket Decode Timestamp {16767/1000 = 16.767}
default    13:02:09.848089-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.848104-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket sampleOffset 5098390
default    13:02:09.848119-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130726e50> updateStateForPacket sampleSize 10099
default    13:02:09.848134-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d5e0> stepInDecodeOrderByCount  1
default    13:02:09.848154-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> readAPacketAndUpdateState
default    13:02:09.848196-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5108493, size: 4096, read: 4096
default    13:02:09.848318-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5112589, size: 5952, read: 5952
default    13:02:09.848340-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Presentation Timestamp {16800/1000 = 16.800}
default    13:02:09.848356-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Decode Timestamp {16800/1000 = 16.800}
default    13:02:09.848373-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.848390-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket sampleOffset 5108512
default    13:02:09.848407-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d5e0> updateStateForPacket sampleSize 10025
error    13:02:09.848427-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.848639-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729210> copyWithZone
default    13:02:09.848664-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d7f0> init with pts/dts
default    13:02:09.848679-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.848697-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> seekToPTS already at {16633/1000 = 16.633}
default    13:02:09.848715-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> readAPacketAndUpdateState
default    13:02:09.848759-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5118541, size: 4096, read: 4096
default    13:02:09.848814-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5122637, size: 5946, read: 5946
default    13:02:09.848839-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> updateStateForPacket Presentation Timestamp {16833/1000 = 16.833, rounded}
default    13:02:09.848980-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> updateStateForPacket Decode Timestamp {16833/1000 = 16.833, rounded}
default    13:02:09.849004-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.849020-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> updateStateForPacket sampleOffset 5118560
default    13:02:09.849035-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> updateStateForPacket sampleSize 10019
default    13:02:09.849050-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> seekToPTS already at {16833/1000 = 16.833, rounded}
default    13:02:09.849066-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729210> created copy <LibAVSampleCursor: 0x13061d7f0>
default    13:02:09.849088-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061d7f0> stepInPresentationOrderByCount 1
default    13:02:09.849102-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> readAPacketAndUpdateState
default    13:02:09.849210-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5128583, size: 4096, read: 4096
default    13:02:09.849339-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5132679, size: 5923, read: 5923
default    13:02:09.849364-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> updateStateForPacket Presentation Timestamp {16867/1000 = 16.867}
default    13:02:09.849435-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> updateStateForPacket Decode Timestamp {16867/1000 = 16.867}
default    13:02:09.849458-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061d7f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.851003-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.851023-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> seekToPTS already at {16633/1000 = 16.633}
default    13:02:09.851063-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5188588, size: 4096, read: 4096
default    13:02:09.851145-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5192684, size: 6002, read: 6002
default    13:02:09.851176-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket Presentation Timestamp {17067/1000 = 17.067}
default    13:02:09.851246-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket Decode Timestamp {17067/1000 = 17.067}
default    13:02:09.851268-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.851283-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket sampleOffset 5188607
default    13:02:09.851298-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> updateStateForPacket sampleSize 10075
default    13:02:09.851349-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130729210> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x131025050 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x130729660 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {17067/1000 = 17.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {17067/1000 = 17.067}, DTS = {17067/1000 = 17.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x131024e10 totalDataLength: 10075 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10075 bytes @ offset 0 Memory Block 0x131817204, 10075 bytes (allocator 0x1f7d62490)
}
default    13:02:09.851480-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729210> copyWithZone
default    13:02:09.851504-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1311184a0> init with pts/dts
default    13:02:09.851519-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.851537-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> seekToPTS already at {17067/1000 = 17.067}
default    13:02:09.851555-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> readAPacketAndUpdateState
default    13:02:09.851596-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5198686, size: 4096, read: 4096
default    13:02:09.851639-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5202782, size: 6127, read: 6127
default    13:02:09.851660-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> updateStateForPacket Presentation Timestamp {17100/1000 = 17.100}
default    13:02:09.851677-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> updateStateForPacket Decode Timestamp {17100/1000 = 17.100}
default    13:02:09.851695-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.851711-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> updateStateForPacket sampleOffset 5198705
default    13:02:09.851727-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> updateStateForPacket sampleSize 10200
default    13:02:09.851746-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> seekToPTS already at {17100/1000 = 17.100}
default    13:02:09.851763-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130729210> created copy <LibAVSampleCursor: 0x1311184a0>
default    13:02:09.851788-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1311184a0> stepInDecodeOrderByCount  1
default    13:02:09.851808-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> readAPacketAndUpdateState
default    13:02:09.851854-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5208909, size: 4096, read: 4096
default    13:02:09.851902-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5213005, size: 6006, read: 6006
default    13:02:09.851924-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> updateStateForPacket Presentation Timestamp {17133/1000 = 17.133}
default    13:02:09.851942-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> updateStateForPacket Decode Timestamp {17133/1000 = 17.133}
default    13:02:09.851958-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.851974-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> updateStateForPacket sampleOffset 5208928
default    13:02:09.851989-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311184a0> updateStateForPacket sampleSize 10079
default    13:02:09.852010-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1311184a0> copyWithZone
default    13:02:09.852077-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310238f0> init with pts/dts
default    13:02:09.852097-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.852117-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> seekToPTS already at {17133/1000 = 17.133}
default    13:02:09.852133-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> readAPacketAndUpdateState
default    13:02:09.852175-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5219011, size: 4096, read: 4096
default    13:02:09.852216-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5223107, size: 6149, read: 6149
default    13:02:09.852238-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> updateStateForPacket Presentation Timestamp {17167/1000 = 17.167}
default    13:02:09.852257-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> updateStateForPacket Decode Timestamp {17167/1000 = 17.167}
default    13:02:09.852276-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.852292-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> updateStateForPacket sampleOffset 5219030
default    13:02:09.852307-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> updateStateForPacket sampleSize 10222
default    13:02:09.852334-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> seekToPTS already at {17167/1000 = 17.167}
default    13:02:09.852354-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1311184a0> created copy <LibAVSampleCursor: 0x1310238f0>
default    13:02:09.852370-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310238f0> copyWithZone
default    13:02:09.852386-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131118040> init with pts/dts
default    13:02:09.852401-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.852420-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> seekToPTS already at {17167/1000 = 17.167}
default    13:02:09.852436-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> readAPacketAndUpdateState
default    13:02:09.852478-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5229256, size: 4096, read: 4096
default    13:02:09.852534-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5233352, size: 6115, read: 6115
default    13:02:09.852559-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket Presentation Timestamp {17200/1000 = 17.200}
default    13:02:09.852576-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket Decode Timestamp {17200/1000 = 17.200}
default    13:02:09.852593-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.852610-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket sampleOffset 5229275
default    13:02:09.852624-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket sampleSize 10188
default    13:02:09.852641-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> seekToPTS already at {17200/1000 = 17.200}
default    13:02:09.852660-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310238f0> created copy <LibAVSampleCursor: 0x131118040>
default    13:02:09.852678-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131118040> stepInDecodeOrderByCount  1
default    13:02:09.852694-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> readAPacketAndUpdateState
default    13:02:09.852741-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5239467, size: 4096, read: 4096
default    13:02:09.852783-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5243563, size: 6223, read: 6223
default    13:02:09.852806-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket Presentation Timestamp {17233/1000 = 17.233}
default    13:02:09.852828-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket Decode Timestamp {17233/1000 = 17.233}
default    13:02:09.852847-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.852861-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket sampleOffset 5239486
default    13:02:09.852876-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket sampleSize 10296
default    13:02:09.852896-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131118040> stepInDecodeOrderByCount  1
default    13:02:09.852911-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> readAPacketAndUpdateState
default    13:02:09.852951-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5249786, size: 4096, read: 4096
default    13:02:09.852996-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5253882, size: 6116, read: 6116
default    13:02:09.853018-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket Presentation Timestamp {17267/1000 = 17.267}
default    13:02:09.853034-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket Decode Timestamp {17267/1000 = 17.267}
default    13:02:09.853051-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.853066-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket sampleOffset 5249805
default    13:02:09.853081-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131118040> updateStateForPacket sampleSize 10189
default    13:02:09.853096-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1310238f0> stepInDecodeOrderByCount  1
default    13:02:09.853111-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> readAPacketAndUpdateState
default    13:02:09.853151-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5259998, size: 4096, read: 4096
default    13:02:09.853193-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5264094, size: 6148, read: 6148
default    13:02:09.853214-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> updateStateForPacket Presentation Timestamp {17300/1000 = 17.300}
default    13:02:09.853235-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> updateStateForPacket Decode Timestamp {17300/1000 = 17.300}
default    13:02:09.853254-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.853269-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> updateStateForPacket sampleOffset 5260017
default    13:02:09.853283-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1310238f0> updateStateForPacket sampleSize 10221
error    13:02:09.853302-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.853413-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1311184a0> copyWithZone
default    13:02:09.853435-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624a10> init with pts/dts
default    13:02:09.853450-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.853468-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> seekToPTS already at {17133/1000 = 17.133}
default    13:02:09.853486-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> readAPacketAndUpdateState
default    13:02:09.853527-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5270242, size: 4096, read: 4096
default    13:02:09.853579-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5274338, size: 6142, read: 6142
default    13:02:09.853607-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> updateStateForPacket Presentation Timestamp {17333/1000 = 17.333, rounded}
default    13:02:09.853625-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> updateStateForPacket Decode Timestamp {17333/1000 = 17.333, rounded}
default    13:02:09.853641-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.853657-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> updateStateForPacket sampleOffset 5270261
default    13:02:09.853672-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> updateStateForPacket sampleSize 10215
default    13:02:09.853688-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> seekToPTS already at {17333/1000 = 17.333, rounded}
default    13:02:09.853703-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x1311184a0> created copy <LibAVSampleCursor: 0x130624a10>
default    13:02:09.853725-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624a10> stepInPresentationOrderByCount 1
default    13:02:09.853740-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> readAPacketAndUpdateState
default    13:02:09.853781-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5280480, size: 4096, read: 4096
default    13:02:09.853822-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5284576, size: 6156, read: 6156
default    13:02:09.853842-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> updateStateForPacket Presentation Timestamp {17367/1000 = 17.367}
default    13:02:09.853861-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> updateStateForPacket Decode Timestamp {17367/1000 = 17.367}
default    13:02:09.853877-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.853892-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> updateStateForPacket sampleOffset 5280499
default    13:02:09.853907-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624a10> updateStateForPacket sampleSize 10229
default    13:02:09.853930-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624a10> copyWithZone
default    13:02:09.853948-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130624eb0> init with pts/dts
default    13:02:09.853961-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.853980-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> seekToPTS already at {17367/1000 = 17.367}
default    13:02:09.853995-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> readAPacketAndUpdateState
default    13:02:09.854036-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5290732, size: 4096, read: 4096
default    13:02:09.854073-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5294828, size: 6103, read: 6103
default    13:02:09.854093-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket Presentation Timestamp {17400/1000 = 17.400, rounded}
default    13:02:09.854110-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket Decode Timestamp {17400/1000 = 17.400, rounded}
default    13:02:09.854126-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.854141-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket sampleOffset 5290751
default    13:02:09.854156-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130624eb0> updateStateForPacket sampleSize 10176
default    13:02:09.856194-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> readAPacketAndUpdateState
default    13:02:09.856245-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5372929, size: 4096, read: 4096
default    13:02:09.856287-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5377025, size: 6198, read: 6198
default    13:02:09.856312-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> updateStateForPacket Presentation Timestamp {17667/1000 = 17.667}
default    13:02:09.856333-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> updateStateForPacket Decode Timestamp {17667/1000 = 17.667}
default    13:02:09.856348-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.856364-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> updateStateForPacket sampleOffset 5372948
default    13:02:09.856379-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> updateStateForPacket sampleSize 10271
default    13:02:09.856403-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> seekToPTS already at {17667/1000 = 17.667}
default    13:02:09.856420-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131025200> created copy <LibAVSampleCursor: 0x13072b180>
default    13:02:09.856437-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072b180> copyWithZone
default    13:02:09.856452-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130626e30> init with pts/dts
default    13:02:09.856466-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.856484-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> seekToPTS already at {17667/1000 = 17.667}
default    13:02:09.856501-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> readAPacketAndUpdateState
default    13:02:09.856543-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5383223, size: 4096, read: 4096
default    13:02:09.856602-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5387319, size: 6234, read: 6234
default    13:02:09.856623-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket Presentation Timestamp {17700/1000 = 17.700}
default    13:02:09.856646-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket Decode Timestamp {17700/1000 = 17.700}
default    13:02:09.856662-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.856677-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket sampleOffset 5383242
default    13:02:09.856690-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket sampleSize 10307
default    13:02:09.856709-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> seekToPTS already at {17700/1000 = 17.700}
default    13:02:09.856725-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072b180> created copy <LibAVSampleCursor: 0x130626e30>
default    13:02:09.856740-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130626e30> stepInDecodeOrderByCount  1
default    13:02:09.856756-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> readAPacketAndUpdateState
default    13:02:09.856794-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5393553, size: 4096, read: 4096
default    13:02:09.856836-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5397649, size: 6171, read: 6171
default    13:02:09.856856-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket Presentation Timestamp {17733/1000 = 17.733}
default    13:02:09.856879-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket Decode Timestamp {17733/1000 = 17.733}
default    13:02:09.856894-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.856909-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket sampleOffset 5393572
default    13:02:09.856924-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket sampleSize 10244
default    13:02:09.856940-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130626e30> stepInDecodeOrderByCount  1
default    13:02:09.856955-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> readAPacketAndUpdateState
default    13:02:09.856997-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5403820, size: 4096, read: 4096
default    13:02:09.857033-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5407916, size: 6269, read: 6269
default    13:02:09.857053-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket Presentation Timestamp {17767/1000 = 17.767}
default    13:02:09.857069-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket Decode Timestamp {17767/1000 = 17.767}
default    13:02:09.857084-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.857100-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket sampleOffset 5403839
default    13:02:09.857114-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130626e30> updateStateForPacket sampleSize 10342
default    13:02:09.857127-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072b180> stepInDecodeOrderByCount  1
default    13:02:09.857142-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> readAPacketAndUpdateState
default    13:02:09.857177-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5414185, size: 4096, read: 4096
default    13:02:09.857224-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5418281, size: 6228, read: 6228
default    13:02:09.857244-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> updateStateForPacket Presentation Timestamp {17800/1000 = 17.800}
default    13:02:09.857260-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> updateStateForPacket Decode Timestamp {17800/1000 = 17.800}
default    13:02:09.857276-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.857290-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> updateStateForPacket sampleOffset 5414204
default    13:02:09.857305-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b180> updateStateForPacket sampleSize 10301
error    13:02:09.857322-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.857414-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131025200> copyWithZone
default    13:02:09.857435-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131026130> init with pts/dts
default    13:02:09.857450-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.857469-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> seekToPTS already at {17633/1000 = 17.633}
default    13:02:09.857484-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> readAPacketAndUpdateState
default    13:02:09.857526-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5424509, size: 4096, read: 4096
default    13:02:09.857573-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5428605, size: 6115, read: 6115
default    13:02:09.857598-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> updateStateForPacket Presentation Timestamp {17833/1000 = 17.833, rounded}
default    13:02:09.857618-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> updateStateForPacket Decode Timestamp {17833/1000 = 17.833, rounded}
default    13:02:09.857635-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.857650-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> updateStateForPacket sampleOffset 5424528
default    13:02:09.857665-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> updateStateForPacket sampleSize 10188
default    13:02:09.857681-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> seekToPTS already at {17833/1000 = 17.833, rounded}
default    13:02:09.857697-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131025200> created copy <LibAVSampleCursor: 0x131026130>
default    13:02:09.857717-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131026130> stepInPresentationOrderByCount 1
default    13:02:09.857733-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> readAPacketAndUpdateState
default    13:02:09.857775-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5434720, size: 4096, read: 4096
default    13:02:09.857824-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5438816, size: 6180, read: 6180
default    13:02:09.857845-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> updateStateForPacket Presentation Timestamp {17867/1000 = 17.867}
default    13:02:09.857861-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> updateStateForPacket Decode Timestamp {17867/1000 = 17.867}
default    13:02:09.857877-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.857896-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> updateStateForPacket sampleOffset 5434739
default    13:02:09.857911-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026130> updateStateForPacket sampleSize 10253
default    13:02:09.857934-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131026130> copyWithZone
default    13:02:09.857952-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131026c80> init with pts/dts
default    13:02:09.857964-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.857981-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> seekToPTS already at {17867/1000 = 17.867}
default    13:02:09.857996-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> readAPacketAndUpdateState
default    13:02:09.858041-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5444996, size: 4096, read: 4096
default    13:02:09.858078-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5449092, size: 6250, read: 6250
default    13:02:09.858103-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> updateStateForPacket Presentation Timestamp {17900/1000 = 17.900, rounded}
default    13:02:09.858123-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> updateStateForPacket Decode Timestamp {17900/1000 = 17.900, rounded}
default    13:02:09.858139-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.858154-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> updateStateForPacket sampleOffset 5445015
default    13:02:09.858167-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> updateStateForPacket sampleSize 10323
default    13:02:09.858184-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> seekToPTS already at {17900/1000 = 17.900, rounded}
default    13:02:09.858200-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131026130> created copy <LibAVSampleCursor: 0x131026c80>
default    13:02:09.858216-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131026c80> copyWithZone
default    13:02:09.858233-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072aba0> init with pts/dts
default    13:02:09.858251-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.858268-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> seekToPTS already at {17900/1000 = 17.900, rounded}
default    13:02:09.858283-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> readAPacketAndUpdateState
default    13:02:09.858325-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5455342, size: 4096, read: 4096
default    13:02:09.858366-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5459438, size: 6259, read: 6259
default    13:02:09.858387-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket Presentation Timestamp {17933/1000 = 17.933}
default    13:02:09.858406-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket Decode Timestamp {17933/1000 = 17.933}
default    13:02:09.858422-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.858447-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket sampleOffset 5455361
default    13:02:09.858462-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket sampleSize 10332
default    13:02:09.858478-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> seekToPTS already at {17933/1000 = 17.933}
default    13:02:09.858494-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131026c80> created copy <LibAVSampleCursor: 0x13072aba0>
default    13:02:09.858510-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072aba0> stepInDecodeOrderByCount  1
default    13:02:09.858525-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> readAPacketAndUpdateState
default    13:02:09.858563-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5465697, size: 4096, read: 4096
default    13:02:09.858613-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5469793, size: 6224, read: 6224
default    13:02:09.858633-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket Presentation Timestamp {17967/1000 = 17.967}
default    13:02:09.858653-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket Decode Timestamp {17967/1000 = 17.967}
default    13:02:09.858669-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.858684-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket sampleOffset 5465716
default    13:02:09.858699-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket sampleSize 10297
default    13:02:09.858716-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072aba0> stepInDecodeOrderByCount  1
default    13:02:09.858732-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> readAPacketAndUpdateState
default    13:02:09.858769-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5476017, size: 4096, read: 4096
default    13:02:09.858813-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5480113, size: 6223, read: 6223
default    13:02:09.858839-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket Presentation Timestamp {18000/1000 = 18.000}
default    13:02:09.858864-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket Decode Timestamp {18000/1000 = 18.000}
default    13:02:09.858882-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.858899-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket sampleOffset 5476036
default    13:02:09.858912-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072aba0> updateStateForPacket sampleSize 10296
default    13:02:09.858928-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x131026c80> stepInDecodeOrderByCount  1
default    13:02:09.858946-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> readAPacketAndUpdateState
default    13:02:09.858989-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5486336, size: 4096, read: 4096
default    13:02:09.859033-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5490432, size: 6079, read: 6079
default    13:02:09.859054-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> updateStateForPacket Presentation Timestamp {18033/1000 = 18.033}
default    13:02:09.859071-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> updateStateForPacket Decode Timestamp {18033/1000 = 18.033}
default    13:02:09.859087-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x131026c80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.861210-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5572091, size: 6077, read: 6077
default    13:02:09.861227-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311151a0> updateStateForPacket Presentation Timestamp {18300/1000 = 18.300}
default    13:02:09.861243-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311151a0> updateStateForPacket Decode Timestamp {18300/1000 = 18.300}
default    13:02:09.861258-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311151a0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.861272-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311151a0> updateStateForPacket sampleOffset 5568014
default    13:02:09.861284-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x1311151a0> updateStateForPacket sampleSize 10150
error    13:02:09.861301-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.861402-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061da80> copyWithZone
default    13:02:09.861427-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130628a50> init with pts/dts
default    13:02:09.861440-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.861465-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> seekToPTS already at {18133/1000 = 18.133}
default    13:02:09.861480-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> readAPacketAndUpdateState
default    13:02:09.861525-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5578168, size: 4096, read: 4096
default    13:02:09.861571-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5582264, size: 6168, read: 6168
default    13:02:09.861593-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> updateStateForPacket Presentation Timestamp {18333/1000 = 18.333, rounded}
default    13:02:09.861612-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> updateStateForPacket Decode Timestamp {18333/1000 = 18.333, rounded}
default    13:02:09.861629-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.861644-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> updateStateForPacket sampleOffset 5578187
default    13:02:09.861658-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> updateStateForPacket sampleSize 10241
default    13:02:09.861674-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> seekToPTS already at {18333/1000 = 18.333, rounded}
default    13:02:09.861690-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061da80> created copy <LibAVSampleCursor: 0x130628a50>
default    13:02:09.861713-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130628a50> stepInPresentationOrderByCount 1
default    13:02:09.861727-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> readAPacketAndUpdateState
default    13:02:09.861763-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5588432, size: 4096, read: 4096
default    13:02:09.861799-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5592528, size: 6109, read: 6109
default    13:02:09.861819-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> updateStateForPacket Presentation Timestamp {18367/1000 = 18.367}
default    13:02:09.861835-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> updateStateForPacket Decode Timestamp {18367/1000 = 18.367}
default    13:02:09.861850-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.861867-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> updateStateForPacket sampleOffset 5588451
default    13:02:09.861885-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130628a50> updateStateForPacket sampleSize 10182
default    13:02:09.861910-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130628a50> copyWithZone
default    13:02:09.861932-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072bca0> init with pts/dts
default    13:02:09.861944-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.861963-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> seekToPTS already at {18367/1000 = 18.367}
default    13:02:09.861978-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> readAPacketAndUpdateState
default    13:02:09.862015-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5598637, size: 4096, read: 4096
default    13:02:09.862055-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5602733, size: 6110, read: 6110
default    13:02:09.862073-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> updateStateForPacket Presentation Timestamp {18400/1000 = 18.400, rounded}
default    13:02:09.862091-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> updateStateForPacket Decode Timestamp {18400/1000 = 18.400, rounded}
default    13:02:09.862107-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.862122-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> updateStateForPacket sampleOffset 5598656
default    13:02:09.862135-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> updateStateForPacket sampleSize 10183
default    13:02:09.862150-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> seekToPTS already at {18400/1000 = 18.400, rounded}
default    13:02:09.862168-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130628a50> created copy <LibAVSampleCursor: 0x13072bca0>
default    13:02:09.862185-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072bca0> copyWithZone
default    13:02:09.862200-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072c180> init with pts/dts
default    13:02:09.862220-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.862238-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> seekToPTS already at {18400/1000 = 18.400, rounded}
default    13:02:09.862257-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> readAPacketAndUpdateState
default    13:02:09.862297-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5608843, size: 4096, read: 4096
default    13:02:09.862338-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5612939, size: 6139, read: 6139
default    13:02:09.862359-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket Presentation Timestamp {18433/1000 = 18.433}
default    13:02:09.862376-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket Decode Timestamp {18433/1000 = 18.433}
default    13:02:09.862395-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.862413-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket sampleOffset 5608862
default    13:02:09.862428-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket sampleSize 10212
default    13:02:09.862443-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> seekToPTS already at {18433/1000 = 18.433}
default    13:02:09.862459-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072bca0> created copy <LibAVSampleCursor: 0x13072c180>
default    13:02:09.862476-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072c180> stepInDecodeOrderByCount  1
default    13:02:09.862489-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> readAPacketAndUpdateState
default    13:02:09.862534-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5619078, size: 4096, read: 4096
default    13:02:09.862572-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5623174, size: 6101, read: 6101
default    13:02:09.862596-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket Presentation Timestamp {18467/1000 = 18.467}
default    13:02:09.862616-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket Decode Timestamp {18467/1000 = 18.467}
default    13:02:09.862631-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.862644-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket sampleOffset 5619097
default    13:02:09.862658-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket sampleSize 10174
default    13:02:09.862674-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072c180> stepInDecodeOrderByCount  1
default    13:02:09.862689-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> readAPacketAndUpdateState
default    13:02:09.862729-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5629275, size: 4096, read: 4096
default    13:02:09.862770-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5633371, size: 6153, read: 6153
default    13:02:09.862791-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket Presentation Timestamp {18500/1000 = 18.500}
default    13:02:09.862807-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket Decode Timestamp {18500/1000 = 18.500}
default    13:02:09.862823-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.862838-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket sampleOffset 5629294
default    13:02:09.862852-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c180> updateStateForPacket sampleSize 10226
default    13:02:09.862865-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072bca0> stepInDecodeOrderByCount  1
default    13:02:09.862879-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> readAPacketAndUpdateState
default    13:02:09.862917-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5639524, size: 4096, read: 4096
default    13:02:09.862953-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5643620, size: 6037, read: 6037
default    13:02:09.862976-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> updateStateForPacket Presentation Timestamp {18533/1000 = 18.533}
default    13:02:09.862993-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> updateStateForPacket Decode Timestamp {18533/1000 = 18.533}
default    13:02:09.863010-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.863027-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> updateStateForPacket sampleOffset 5639543
default    13:02:09.863040-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bca0> updateStateForPacket sampleSize 10110
default    13:02:09.863123-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061da80> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.863143-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061da80> seekToPTS already at {18133/1000 = 18.133}
default    13:02:09.863185-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5649657, size: 4096, read: 4096
default    13:02:09.863228-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5653753, size: 6071, read: 6071
default    13:02:09.863250-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061da80> updateStateForPacket Presentation Timestamp {18567/1000 = 18.567}
default    13:02:09.863270-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061da80> updateStateForPacket Decode Timestamp {18567/1000 = 18.567}
default    13:02:09.863286-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061da80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.863301-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061da80> updateStateForPacket sampleOffset 5649676
default    13:02:09.863316-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061da80> updateStateForPacket sampleSize 10144
default    13:02:09.863362-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13061da80> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x13072a6c0 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x130620bb0 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {18567/1000 = 18.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {18567/1000 = 18.567}, DTS = {18567/1000 = 18.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x13072a2d0 totalDataLength: 10144 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10144 bytes @ offset 0 Memory Block 0x13081b604, 10144 bytes (allocator 0x1f7d62490)
}
default    13:02:09.863480-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061da80> copyWithZone
default    13:02:09.863498-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072b0f0> init with pts/dts
default    13:02:09.863512-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.863533-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> seekToPTS already at {18567/1000 = 18.567}
default    13:02:09.863548-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> readAPacketAndUpdateState
default    13:02:09.863591-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5659824, size: 4096, read: 4096
default    13:02:09.863641-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5663920, size: 6137, read: 6137
default    13:02:09.863661-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket Presentation Timestamp {18600/1000 = 18.600}
default    13:02:09.863679-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket Decode Timestamp {18600/1000 = 18.600}
default    13:02:09.863698-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.863714-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket sampleOffset 5659843
default    13:02:09.863729-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket sampleSize 10210
default    13:02:09.863744-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> seekToPTS already at {18600/1000 = 18.600}
default    13:02:09.863759-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13061da80> created copy <LibAVSampleCursor: 0x13072b0f0>
default    13:02:09.863780-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072b0f0> stepInDecodeOrderByCount  1
default    13:02:09.863795-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> readAPacketAndUpdateState
default    13:02:09.863830-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5670057, size: 4096, read: 4096
default    13:02:09.863867-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5674153, size: 6035, read: 6035
default    13:02:09.863888-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket Presentation Timestamp {18633/1000 = 18.633}
default    13:02:09.863905-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket Decode Timestamp {18633/1000 = 18.633}
default    13:02:09.863920-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.863935-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket sampleOffset 5670076
default    13:02:09.863950-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket sampleSize 10108
default    13:02:09.863976-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072b0f0> copyWithZone
default    13:02:09.863991-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072cda0> init with pts/dts
default    13:02:09.864006-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.864022-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cda0> seekToPTS already at {18633/1000 = 18.633}
default    13:02:09.864037-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cda0> readAPacketAndUpdateState
default    13:02:09.864073-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5680188, size: 4096, read: 4096
default    13:02:09.864115-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5684284, size: 5976, read: 5976
default    13:02:09.864135-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cda0> updateStateForPacket Presentation Timestamp {18667/1000 = 18.667}
default    13:02:09.864151-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cda0> updateStateForPacket Decode Timestamp {18667/1000 = 18.667}
default    13:02:09.864168-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cda0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.865906-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5750951, size: 4096, read: 4096
default    13:02:09.865955-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5755047, size: 5995, read: 5995
default    13:02:09.865979-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> updateStateForPacket Presentation Timestamp {18900/1000 = 18.900, rounded}
default    13:02:09.866002-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> updateStateForPacket Decode Timestamp {18900/1000 = 18.900, rounded}
default    13:02:09.866018-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.866033-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> updateStateForPacket sampleOffset 5750970
default    13:02:09.866046-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> updateStateForPacket sampleSize 10068
default    13:02:09.866061-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> seekToPTS already at {18900/1000 = 18.900, rounded}
default    13:02:09.866077-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130628b10> created copy <LibAVSampleCursor: 0x13072d320>
default    13:02:09.866094-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072d320> copyWithZone
default    13:02:09.866108-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072d780> init with pts/dts
default    13:02:09.866122-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.866138-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> seekToPTS already at {18900/1000 = 18.900, rounded}
default    13:02:09.866153-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> readAPacketAndUpdateState
default    13:02:09.866194-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5761042, size: 4096, read: 4096
default    13:02:09.866250-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5765138, size: 5981, read: 5981
default    13:02:09.866275-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket Presentation Timestamp {18933/1000 = 18.933}
default    13:02:09.866297-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket Decode Timestamp {18933/1000 = 18.933}
default    13:02:09.866314-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.866341-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket sampleOffset 5761061
default    13:02:09.866355-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket sampleSize 10054
default    13:02:09.866372-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> seekToPTS already at {18933/1000 = 18.933}
default    13:02:09.866389-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072d320> created copy <LibAVSampleCursor: 0x13072d780>
default    13:02:09.866405-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072d780> stepInDecodeOrderByCount  1
default    13:02:09.866421-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> readAPacketAndUpdateState
default    13:02:09.866470-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5771119, size: 4096, read: 4096
default    13:02:09.866519-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5775215, size: 5943, read: 5943
default    13:02:09.866547-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket Presentation Timestamp {18967/1000 = 18.967}
default    13:02:09.866569-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket Decode Timestamp {18967/1000 = 18.967}
default    13:02:09.866590-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.866610-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket sampleOffset 5771138
default    13:02:09.866626-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket sampleSize 10016
default    13:02:09.866645-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072d780> stepInDecodeOrderByCount  1
default    13:02:09.866662-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> readAPacketAndUpdateState
default    13:02:09.866703-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5781158, size: 4096, read: 4096
default    13:02:09.866749-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5785254, size: 6070, read: 6070
default    13:02:09.866771-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket Presentation Timestamp {19000/1000 = 19.000}
default    13:02:09.866795-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket Decode Timestamp {19000/1000 = 19.000}
default    13:02:09.866811-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.866825-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket sampleOffset 5781177
default    13:02:09.866838-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d780> updateStateForPacket sampleSize 10143
default    13:02:09.866852-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072d320> stepInDecodeOrderByCount  1
default    13:02:09.866867-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> readAPacketAndUpdateState
default    13:02:09.866905-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5791324, size: 4096, read: 4096
default    13:02:09.866956-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5795420, size: 5985, read: 5985
default    13:02:09.866981-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> updateStateForPacket Presentation Timestamp {19033/1000 = 19.033}
default    13:02:09.867000-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> updateStateForPacket Decode Timestamp {19033/1000 = 19.033}
default    13:02:09.867016-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.867031-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> updateStateForPacket sampleOffset 5791343
default    13:02:09.867044-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072d320> updateStateForPacket sampleSize 10058
default    13:02:09.867139-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.867157-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> seekToPTS already at {18633/1000 = 18.633}
default    13:02:09.867198-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5801405, size: 4096, read: 4096
default    13:02:09.867238-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5805501, size: 5912, read: 5912
default    13:02:09.867259-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket Presentation Timestamp {19067/1000 = 19.067}
default    13:02:09.867276-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket Decode Timestamp {19067/1000 = 19.067}
default    13:02:09.867291-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.867307-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket sampleOffset 5801424
default    13:02:09.867321-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> updateStateForPacket sampleSize 9985
default    13:02:09.867368-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072b0f0> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x130629700 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x13072afa0 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {19067/1000 = 19.067}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {19067/1000 = 19.067}, DTS = {19067/1000 = 19.067}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x1306293b0 totalDataLength: 9985 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 9985 bytes @ offset 0 Memory Block 0x13081b604, 9985 bytes (allocator 0x1f7d62490)
}
default    13:02:09.867490-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072b0f0> copyWithZone
default    13:02:09.867511-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130627300> init with pts/dts
default    13:02:09.867525-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.867544-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> seekToPTS already at {19067/1000 = 19.067}
default    13:02:09.867561-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> readAPacketAndUpdateState
default    13:02:09.867603-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5811413, size: 4096, read: 4096
default    13:02:09.867646-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5815509, size: 5961, read: 5961
default    13:02:09.867666-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket Presentation Timestamp {19100/1000 = 19.100}
default    13:02:09.867681-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket Decode Timestamp {19100/1000 = 19.100}
default    13:02:09.867702-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.867717-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket sampleOffset 5811432
default    13:02:09.867729-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket sampleSize 10034
default    13:02:09.867746-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> seekToPTS already at {19100/1000 = 19.100}
default    13:02:09.867762-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072b0f0> created copy <LibAVSampleCursor: 0x130627300>
default    13:02:09.867783-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130627300> stepInDecodeOrderByCount  1
default    13:02:09.867799-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> readAPacketAndUpdateState
default    13:02:09.867839-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5821470, size: 4096, read: 4096
default    13:02:09.867881-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5825566, size: 5944, read: 5944
default    13:02:09.867903-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket Presentation Timestamp {19133/1000 = 19.133}
default    13:02:09.867923-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket Decode Timestamp {19133/1000 = 19.133}
default    13:02:09.867939-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.867954-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket sampleOffset 5821489
default    13:02:09.867969-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket sampleSize 10017
default    13:02:09.867994-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130627300> copyWithZone
default    13:02:09.868009-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072bfc0> init with pts/dts
default    13:02:09.868022-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.868041-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bfc0> seekToPTS already at {19133/1000 = 19.133}
default    13:02:09.868056-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bfc0> readAPacketAndUpdateState
default    13:02:09.868098-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5831510, size: 4096, read: 4096
default    13:02:09.868138-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5835606, size: 5964, read: 5964
default    13:02:09.868159-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bfc0> updateStateForPacket Presentation Timestamp {19167/1000 = 19.167}
default    13:02:09.868177-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bfc0> updateStateForPacket Decode Timestamp {19167/1000 = 19.167}
default    13:02:09.868194-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bfc0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.868208-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bfc0> updateStateForPacket sampleOffset 5831529
default    13:02:09.868223-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bfc0> updateStateForPacket sampleSize 10037
default    13:02:09.868244-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072bfc0> seekToPTS already at {19167/1000 = 19.167}
default    13:02:09.868263-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130627300> created copy <LibAVSampleCursor: 0x13072bfc0>
default    13:02:09.868279-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072bfc0> copyWithZone
default    13:02:09.868294-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072ba20> init with pts/dts
default    13:02:09.868324-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.868375-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072ba20> seekToPTS already at {19167/1000 = 19.167}
default    13:02:09.868444-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072ba20> readAPacketAndUpdateState
default    13:02:09.868511-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5841570, size: 4096, read: 4096
default    13:02:09.868561-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5845666, size: 5927, read: 5927
default    13:02:09.868583-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072ba20> updateStateForPacket Presentation Timestamp {19200/1000 = 19.200}
default    13:02:09.870909-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072e070> stepInDecodeOrderByCount  1
default    13:02:09.870924-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072e070> readAPacketAndUpdateState
default    13:02:09.870959-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5931850, size: 4096, read: 4096
default    13:02:09.870997-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5935946, size: 5941, read: 5941
default    13:02:09.871017-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072e070> updateStateForPacket Presentation Timestamp {19500/1000 = 19.500}
default    13:02:09.871038-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072e070> updateStateForPacket Decode Timestamp {19500/1000 = 19.500}
default    13:02:09.871056-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072e070> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.871069-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072e070> updateStateForPacket sampleOffset 5931869
default    13:02:09.871085-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072e070> updateStateForPacket sampleSize 10014
default    13:02:09.871100-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072cc80> stepInDecodeOrderByCount  1
default    13:02:09.871114-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc80> readAPacketAndUpdateState
default    13:02:09.871159-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5941887, size: 4096, read: 4096
default    13:02:09.871201-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5945983, size: 5968, read: 5968
default    13:02:09.871223-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc80> updateStateForPacket Presentation Timestamp {19533/1000 = 19.533}
default    13:02:09.871239-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc80> updateStateForPacket Decode Timestamp {19533/1000 = 19.533}
default    13:02:09.871256-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc80> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.871269-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc80> updateStateForPacket sampleOffset 5941906
default    13:02:09.871283-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc80> updateStateForPacket sampleSize 10041
default    13:02:09.871373-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> loadSampleBufferContainingSamplesToEndCursor endCursor(null)
default    13:02:09.871392-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> seekToPTS already at {19133/1000 = 19.133}
default    13:02:09.871436-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5951951, size: 4096, read: 4096
default    13:02:09.871479-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5956047, size: 5963, read: 5963
default    13:02:09.871500-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket Presentation Timestamp {19567/1000 = 19.567}
default    13:02:09.871517-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket Decode Timestamp {19567/1000 = 19.567}
default    13:02:09.871534-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.871553-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket sampleOffset 5951970
default    13:02:09.871570-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> updateStateForPacket sampleSize 10036
default    13:02:09.871620-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130627300> loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer CMSampleBuffer 0x131026250 retainCount: 1 allocator: 0x1f7d62220
    invalid = NO
    dataReady = YES
    makeDataReadyCallback = 0x0
    makeDataReadyRefcon = 0x0
    formatDescription = <CMVideoFormatDescription 0x13061dbd0 [0x1f7d62220]> {
    mediaType:'vide' 
    mediaSubType:'avc1' 
    mediaSpecific: {
        codecType: 'avc1'        dimensions: 1920 x 1080 
    } 
    extensions: {{
    SampleDescriptionExtensionAtoms =     {
        avcC = {length = 42, bytes = 0x01641028 ffe10016 67641028 acb80f00 ... ee0f2c8b fdf8f800 };
    };
}}
}
    sbufToTrackReadiness = 0x0
    numSamples = 1
    outputPTS = {19567/1000 = 19.567}(based on cachedOutputPresentationTimeStamp)
    sampleTimingArray[1] = {
        {PTS = {19567/1000 = 19.567}, DTS = {19567/1000 = 19.567}, duration = {33/1000 = 0.033}},
    }
    dataBuffer = {
CMBlockBuffer 0x131025da0 totalDataLength: 10036 retainCount: 2 allocator: 0x1f7d62220 subBlockCapacity: 2
 [0] 10036 bytes @ offset 0 Memory Block 0x13282ea04, 10036 bytes (allocator 0x1f7d62490)
}
default    13:02:09.871752-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130627300> copyWithZone
default    13:02:09.871777-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130629a70> init with pts/dts
default    13:02:09.871790-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.871809-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> seekToPTS already at {19567/1000 = 19.567}
default    13:02:09.871824-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> readAPacketAndUpdateState
default    13:02:09.871869-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5962010, size: 4096, read: 4096
default    13:02:09.871911-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5966106, size: 5968, read: 5968
default    13:02:09.871931-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> updateStateForPacket Presentation Timestamp {19600/1000 = 19.600}
default    13:02:09.871948-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> updateStateForPacket Decode Timestamp {19600/1000 = 19.600}
default    13:02:09.871963-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.871979-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> updateStateForPacket sampleOffset 5962029
default    13:02:09.871994-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> updateStateForPacket sampleSize 10041
default    13:02:09.872009-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> seekToPTS already at {19600/1000 = 19.600}
default    13:02:09.872025-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130627300> created copy <LibAVSampleCursor: 0x130629a70>
default    13:02:09.872047-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130629a70> stepInDecodeOrderByCount  1
default    13:02:09.872066-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> readAPacketAndUpdateState
default    13:02:09.872102-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5972074, size: 4096, read: 4096
default    13:02:09.872145-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5976170, size: 5915, read: 5915
default    13:02:09.872165-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> updateStateForPacket Presentation Timestamp {19633/1000 = 19.633}
default    13:02:09.872183-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> updateStateForPacket Decode Timestamp {19633/1000 = 19.633}
default    13:02:09.872199-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.872212-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> updateStateForPacket sampleOffset 5972093
default    13:02:09.872226-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629a70> updateStateForPacket sampleSize 9988
default    13:02:09.872247-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130629a70> copyWithZone
default    13:02:09.872262-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072c5c0> init with pts/dts
default    13:02:09.872276-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.872293-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> seekToPTS already at {19633/1000 = 19.633}
default    13:02:09.872311-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> readAPacketAndUpdateState
default    13:02:09.872354-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5982085, size: 4096, read: 4096
default    13:02:09.872391-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5986181, size: 5968, read: 5968
default    13:02:09.872411-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> updateStateForPacket Presentation Timestamp {19667/1000 = 19.667}
default    13:02:09.872431-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> updateStateForPacket Decode Timestamp {19667/1000 = 19.667}
default    13:02:09.872447-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.872462-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> updateStateForPacket sampleOffset 5982104
default    13:02:09.872477-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> updateStateForPacket sampleSize 10041
default    13:02:09.872497-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> seekToPTS already at {19667/1000 = 19.667}
default    13:02:09.872514-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130629a70> created copy <LibAVSampleCursor: 0x13072c5c0>
default    13:02:09.872530-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072c5c0> copyWithZone
default    13:02:09.872545-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072cc00> init with pts/dts
default    13:02:09.872559-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.872575-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> seekToPTS already at {19667/1000 = 19.667}
default    13:02:09.872591-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> readAPacketAndUpdateState
default    13:02:09.872629-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5992149, size: 4096, read: 4096
default    13:02:09.872677-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 5996245, size: 5889, read: 5889
default    13:02:09.872701-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket Presentation Timestamp {19700/1000 = 19.700}
default    13:02:09.872719-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket Decode Timestamp {19700/1000 = 19.700}
default    13:02:09.872735-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.872750-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket sampleOffset 5992168
default    13:02:09.872766-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket sampleSize 9962
default    13:02:09.872781-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> seekToPTS already at {19700/1000 = 19.700}
default    13:02:09.872797-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072c5c0> created copy <LibAVSampleCursor: 0x13072cc00>
default    13:02:09.872812-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072cc00> stepInDecodeOrderByCount  1
default    13:02:09.872828-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> readAPacketAndUpdateState
default    13:02:09.872862-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6002134, size: 4096, read: 4096
default    13:02:09.872905-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6006230, size: 5924, read: 5924
default    13:02:09.872924-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket Presentation Timestamp {19733/1000 = 19.733}
default    13:02:09.872941-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket Decode Timestamp {19733/1000 = 19.733}
default    13:02:09.872956-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.872970-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket sampleOffset 6002153
default    13:02:09.872982-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket sampleSize 9997
default    13:02:09.872999-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072cc00> stepInDecodeOrderByCount  1
default    13:02:09.873013-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> readAPacketAndUpdateState
default    13:02:09.873050-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6012154, size: 4096, read: 4096
default    13:02:09.873090-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6016250, size: 5892, read: 5892
default    13:02:09.873110-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket Presentation Timestamp {19767/1000 = 19.767}
default    13:02:09.873127-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket Decode Timestamp {19767/1000 = 19.767}
default    13:02:09.873146-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.873159-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket sampleOffset 6012173
default    13:02:09.873173-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072cc00> updateStateForPacket sampleSize 9965
default    13:02:09.873188-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x13072c5c0> stepInDecodeOrderByCount  1
default    13:02:09.873202-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> readAPacketAndUpdateState
default    13:02:09.873236-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6022142, size: 4096, read: 4096
default    13:02:09.873275-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6026238, size: 6002, read: 6002
default    13:02:09.873297-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> updateStateForPacket Presentation Timestamp {19800/1000 = 19.800}
default    13:02:09.873312-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> updateStateForPacket Decode Timestamp {19800/1000 = 19.800}
default    13:02:09.873328-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.873342-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> updateStateForPacket sampleOffset 6022161
default    13:02:09.873356-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x13072c5c0> updateStateForPacket sampleSize 10075
error    13:02:09.873377-0400    LibAVExtension    <<<< FigPartialSampleTable >>>> fpst_writing_updateDecodeDurationIfNecessary signalled err=-17714 (kFigPartialSampleTableError_ParamErr) ( decode duration <= 0.) at FigPartialSampleTable.c:1115
default    13:02:09.873467-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130629a70> copyWithZone
default    13:02:09.873488-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130629c70> init with pts/dts
default    13:02:09.873502-0400    LibAVExtension    LibAVTrackReader videoFormatDescription Found Codec Type: 1635148593
default    13:02:09.873519-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> seekToPTS already at {19633/1000 = 19.633}
default    13:02:09.873534-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> readAPacketAndUpdateState
default    13:02:09.873577-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6032240, size: 4096, read: 4096
default    13:02:09.873619-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6036336, size: 5951, read: 5951
default    13:02:09.873640-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> updateStateForPacket Presentation Timestamp {19833/1000 = 19.833, rounded}
default    13:02:09.873656-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> updateStateForPacket Decode Timestamp {19833/1000 = 19.833, rounded}
default    13:02:09.873672-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.873687-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> updateStateForPacket sampleOffset 6032259
default    13:02:09.873701-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> updateStateForPacket sampleSize 10024
default    13:02:09.873717-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> seekToPTS already at {19833/1000 = 19.833, rounded}
default    13:02:09.873739-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130629a70> created copy <LibAVSampleCursor: 0x130629c70>
default    13:02:09.873759-0400    LibAVExtension    LibAVSampleCursor <LibAVSampleCursor: 0x130629c70> stepInPresentationOrderByCount 1
default    13:02:09.873774-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> readAPacketAndUpdateState
default    13:02:09.873816-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6042287, size: 4096, read: 4096
default    13:02:09.873857-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 1 fromOffset: 6046383, size: 5949, read: 5949
default    13:02:09.873878-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> updateStateForPacket Presentation Timestamp {19867/1000 = 19.867}
default    13:02:09.873895-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> updateStateForPacket Decode Timestamp {19867/1000 = 19.867}
default    13:02:09.873912-0400    LibAVExtension    LibAVSampleCursor: <LibAVSampleCursor: 0x130629c70> updateStateForPacket Duration {33/1000 = 0.033}
default    13:02:09.875540-0400    LibAVExtension    LibAVFormatReader got readPacket Success: 0 fromOffset: 6093849, size: 4096, read: 0

