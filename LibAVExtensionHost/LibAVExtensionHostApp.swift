//
//  LibAVExtensionHostApp.swift
//  LibAVExtensionHost
//
//  Created by Anton Marini on 7/25/24.
//

import SwiftUI
import MediaToolbox
import VideoToolbox

@main
struct LibAVExtensionHostApp: App
{
    init()
    {
        VTRegisterProfessionalVideoWorkflowVideoDecoders()
        MTRegisterProfessionalVideoWorkflowFormatReaders()
        
        
    }
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
        }
    }
}
