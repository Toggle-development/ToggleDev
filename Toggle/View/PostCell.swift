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
           
            
            let player = AVPlayer(url: (URL(string: videoURL))!) // need to change this can't force wrap URL
            //Text("\(postFrame.frame(in: .global).maxY)") ( can get min and max y of full screen from this (first and last post)
            // can get the height of the video by doing postFrame.size.height / 1.5
            VideoView(previewLength: 60, player: player)
                .frame(width: UIScreen.main.bounds.width/1.1, height: postFrame.size.height / 1.5)
                .onAppear() {
                    player.play()
                }
                .onDisappear() {
                    player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1)))
                    player.pause()
                }
           
            TopBarOfCell(postOwner: postOwner)
                .frame( width: UIScreen.main.bounds.width/1.1, height: postFrame.size.height / 15)
                .padding(.top, 5)
                
            
           
         
            CaptionsAndComments(caption: caption, postOwner: postOwner)
            
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
            .padding(.horizontal, 20)
            .onTapGesture {
                self.liked.toggle()
            }
            .foregroundColor(liked ? Color("tog") : .gray)
            Spacer(minLength:UIScreen.main.bounds.width/4 )
            Image(systemName: "message").scaleEffect(1.7)
            Spacer(minLength:UIScreen.main.bounds.width/4)
            Image(systemName: "arrowshape.turn.up.right").scaleEffect(1.7)
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

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
