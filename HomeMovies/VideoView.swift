//
//  VideoView.swift
//  Home Movies
//
//  Created by Brett Whitelaw on 12/20/22.
//

import SwiftUI
import AVKit

struct VideoView: View {
    let videoUrl: String
    @State private var player: AVPlayer?
    
    var body: some View {
        VideoPlayer(player: player)
        .onAppear() {
            guard let url = URL(string: videoUrl) else {
                return
            }
            let player = AVPlayer(url: url)
            self.player = player
            player.play()
        }
        .frame(width: 1920, height: 1080, alignment: .bottomLeading)
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
