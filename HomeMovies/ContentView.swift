//
//  ContentView.swift
//  Home Movies
//
//  Created by Brett Whitelaw on 12/19/22.
//

import AVKit
import Foundation
import SwiftUI


private var mainTitle: String = Bundle.main.infoDictionary?["MAIN_TITLE"] as! String
private var jsonURL: String = (Bundle.main.infoDictionary?["JSON_URL"] as! String).replacingOccurrences(of: "\\", with: "")

class videoUrlObject: ObservableObject {
    @Published var currentVideoUrl = ""
    @Published var currentVideoTitle = ""
}

struct ContentView: View {
    @State var videoItems = [VideoItem]()
    @StateObject var currentVideoUrlObject = videoUrlObject()

    var body: some View {
        NavigationStack() {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(videoItems) { videoItem in
                        NavigationLink {
                            VideoView(videoUrl: videoItem.videoUrl)
                        } label: {
                            Text("\(videoItem.title)")
                        }
                    }
                    .navigationTitle("\(mainTitle)")
                }
            }
        }
        .onAppear() {
            loadData()
        }
    }
    
    func parseFeedJSON(text: String) {
        let data = text.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let json = try decoder.decode([VideoItemJSON].self, from: data)
            for elem in json
            {
                let videoItem = VideoItem()
                videoItem.title = elem.title
                videoItem.id = elem.id
                videoItem.videoUrl = elem.videoUrl
                videoItems.append(videoItem)
            }
        } catch {
            print(error)
        }
    }

    func loadData() {
        let url = URL(string: jsonURL)
        let task = URLSession.shared.dataTask(with: url! as URL) {(data, response, error) in
            if data != nil {
                let json = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
                parseFeedJSON(text: json)
            }
        }
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
