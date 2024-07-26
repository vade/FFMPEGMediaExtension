//
//  LibAVExtensionHostApp.swift
//  LibAVExtensionHost
//
//  Created by Anton Marini on 7/25/24.
//

import SwiftUI
import MediaToolbox
import VideoToolbox
import AVFoundation

@main
struct LibAVExtensionHostApp: App
{
    init()
    {
        VTRegisterProfessionalVideoWorkflowVideoDecoders()
        MTRegisterProfessionalVideoWorkflowFormatReaders()
        
        let url = URL(filePath: "/Users/vade/Downloads/Everything.Everywhere.All.At.Once.2022.1080p.WEB-DL.DDP5.1.H.264-EVO/Everything.Everywhere.All.At.Once.2022.1080p.WEB-DL.DDP5.1.H.264-EVO.mkv")
        
        let asset = AVURLAsset(url: url)
        
        print(asset.duration)
        
    }
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
        }
    }
}
