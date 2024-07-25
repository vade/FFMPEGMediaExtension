//
//  Untitled.swift
//  LibAVExtensionHost
//
//  Created by Anton Marini on 7/25/24.
//

import MediaExtension

class LibAVFormatReaderFactory: NSObject, MEFormatReaderExtension
{
    required override init()
    {
        
    }
    
    func formatReader(with primaryByteSource: MEByteSource, options: MEFormatReaderInstantiationOptions?) throws -> any MEFormatReader {
        
        return LibAVFormatReader()
    }

}


class LibAVFormatReader: NSObject, MEFormatReader,
{
    var fileInfo: MEFileInfo
    
    var metadata: [AVMetadataItem] = []
    
    @objc var trackReaders: [any METrackReader]
    {
        get async throws
        {
            
        }
        
        
    }
    
    
    init(fileInfo: MEFileInfo, metadata: [AVMetadataItem], trackReaders: [any METrackReader]) {
        self.fileInfo = fileInfo
        self.metadata = metadata
        self.trackReaders = trackReaders
    }
    
    func loadFileInfo(completionHandler: @escaping (MEFileInfo?, (any Error)?) -> Void) {
        <#code#>
    }
    
    func loadMetadata(completionHandler: @escaping ([AVMetadataItem]?, (any Error)?) -> Void) {
        <#code#>
    }
    
    func loadTrackReaders(completionHandler: @escaping ([any METrackReader]?, (any Error)?) -> Void) {
        <#code#>
    }
}
