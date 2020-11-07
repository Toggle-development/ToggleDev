//
//  PostCell.swift
//  Toggle
//
//  Created by Walid Rafei on 11/7/20.
//

import SwiftUI
import AVKit

struct PostCell: View {
    let postOwner: String
    let videoURL: String
    let caption: String
    let postFrame: GeometryProxy
        
    var body: some View {
        
        VStack {
            TopBarOfCell(postOwner: postOwner)
                .frame(width: UIScreen.main.bounds.width, height: postFrame.size.height / 15)
                .padding(.top, 5)

            let player = AVPlayer(url: (URL(string: videoURL))!) // need to change this can't force wrap URL
            VideoView(previewLength: 60, player: player)
                .frame(width: UIScreen.main.bounds.width, height: postFrame.size.height / 1.5)
                .onAppear() {
                    player.play()
                }
                .onDisappear() {
                    player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1)))
                }
            
            UserInteractions()
                .frame(width: UIScreen.main.bounds.width, height: postFrame.size.width / 10)
                .padding(.bottom, 5)
            
            CaptionsAndComments(caption: caption, postOwner: postOwner)
        }
        .listRowInsets(.init())
    }
}

struct TopBarOfCell: View {
    let postOwner: String
    
    var body: some View {
        HStack {
            GeometryReader { geo in
                HStack {
                    Image(systemName:"plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width / 6, height: geo.size
                                .height, alignment: .center)
                        .clipShape(Circle())
                        .padding(.leading, 15)
                    
                    Text(postOwner).fontWeight(.heavy)
                }
            }
        }
    }
}


struct VideoView: UIViewRepresentable {
    var previewLength:Double?
    var player: AVPlayer
    
    func makeUIView(context: Context) -> UIView {
        return PlayerView(player: player ,frame: .zero, previewLength: previewLength ?? 15)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct UserInteractions: View {
    var body: some View {
        HStack {
            Image(systemName: "suit.heart").imageScale(.large)
                .padding(.horizontal)
            Image(systemName: "message").imageScale(.large)
            Spacer()
        }
    }
}

struct CaptionsAndComments: View {
    let caption: String
    let postOwner: String
    
    var body: some View {
        HStack(alignment: .top ,spacing: 5) {
            Text("\(postOwner) ").fontWeight(.heavy) + Text(caption)
            Spacer()
        }
        .padding(.leading, 5)
        .padding(.bottom, 20)
    }
}
