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
    let asset: AVAsset
    init()
    {
        VTRegisterProfessionalVideoWorkflowVideoDecoders()
        MTRegisterProfessionalVideoWorkflowFormatReaders()
        
        let url = URL(filePath:"/Users/vade/output.mkv")
//         let url = URL(filePath:"/Users/vade/Downloads/RuPauls.Drag.Race.All.Stars.Untucked.S07E11.720p.WEB.h264-KOGi/Sample/rupauls.drag.race.all.stars.untucked.s07e11.720p.web.h264-kogi.sample.mkv")
//        let url = URL(filePath:"/Users/vade/Downloads/Everything.Everywhere.All.At.Once.2022.1080p.WEB-DL.DDP5.1.H.264-EVO/Everything.Everywhere.All.At.Once.2022.1080p.WEB-DL.DDP5.1.H.264-EVO.mkv" )
        
        self.asset = AVURLAsset(url: url)
        
        print(self.asset.duration)
        
    }
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView(asset: self.asset)
        }
    }
}
