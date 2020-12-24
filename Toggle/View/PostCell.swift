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
    let numberOfLikes: Int
    let postID: Int
    
    var body: some View {
        VStack {
            let asset = AVAsset(url: URL(string: videoURL)!)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVPlayer(playerItem: playerItem)
            
            TopBarOfCell(postOwner: postOwner)
                .frame( width: UIScreen.main.bounds.width, height: postFrame.size.height / 15)
                .padding(.top, 5)
            
            VideoView(previewLength: 60, player: player)
                .frame(width: UIScreen.main.bounds.width, height: postFrame.size.height / 1.5)
                .onAppear() {
                    player.play()
                }
                .onDisappear() {
                    player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1)))
                    player.pause()
                }
            
            CaptionsAndComments(caption: caption, postOwner: postOwner, numberOfLikes: numberOfLikes)

            UserInteractions()
                .frame(width: UIScreen.main.bounds.width/2, height: postFrame.size.width / 10)
                .padding(.bottom, 5)

        }
        .frame(width: UIScreen.main.bounds.width, height: postFrame.size.height/1.1, alignment: .center)
        .listRowInsets(.init())
        .background(Color(UIColor.black).opacity(0.2))
        Spacer()
    }
}

struct TopBarOfCell: View {
    let postOwner: String
    
    var body: some View {
        HStack {
            GeometryReader { geo in
                HStack(spacing : 0) {
                    Image(systemName:"person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width / 6.3, height: geo.size
                                .height/1.3, alignment: .center)
                        .clipShape(Circle())
                        
                    
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
        PlayerView(player: player ,frame: .zero, previewLength: previewLength ?? 15).layer.addSublayer(AVPlayerLayer())
    }
}

struct UserInteractions: View {
    @State var liked = false
    var body: some View {
        HStack{
            ZStack {
                Spacer()
                Image(systemName: "heart.fill")
                    .opacity(liked ? 1 : 0)
                    .scaleEffect(liked ? 1.0 : 0.1)
                    .animation(.linear(duration: 0.2)).scaleEffect(1.7)
                Image(systemName: "heart").scaleEffect(1.7)
            }
            .padding(.trailing, 20)
            .onTapGesture {
                self.liked.toggle()
            }
            .foregroundColor(liked ? Color("tog") : .gray)
            Spacer(minLength:UIScreen.main.bounds.width/4 )
            Image(systemName: "message").scaleEffect(1.7)
            Spacer(minLength:UIScreen.main.bounds.width/4)
            Image(systemName: "arrowshape.turn.up.right").scaleEffect(1.7)
            Spacer()
            Text("44 minutes ago")
                .fontWeight(.heavy)
                .foregroundColor(.gray)
                .padding(.trailing, 10)
                .font(Font.system(size:15, design: .default))
        }
        .padding(.leading, 15)
    }
}

struct CaptionsAndComments: View {
    let caption: String
    let postOwner: String
    let numberOfLikes: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(numberOfLikes) likes").fontWeight(.heavy)
                .padding(.leading, 10)
                .padding(.bottom, 1)
            HStack(alignment: .top ,spacing: 5) {
                Text("\(postOwner) ").fontWeight(.heavy) + Text(caption)
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.bottom, 20)
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
