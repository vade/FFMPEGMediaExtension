//
//  ContentView.swift
//  LibAVExtensionHost
//
//  Created by Anton Marini on 7/25/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    let asset:AVAsset
    
    var body: some View {
        VStack {
            
            VideoPlayer(player: AVPlayer(playerItem: AVPlayerItem(asset: self.asset)))
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView(asset: AVURLAsset(url: URL(filePath: "/Users/vade/SceneEditTest-Fixed-Frame-Numbers.m4v")))
}
