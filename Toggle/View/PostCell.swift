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
                HStack(spacing : 0) {
                    Image(systemName:"person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width / 6, height: geo.size
                                .height, alignment: .center)
                        .clipShape(Circle())
                        .padding(.leading, 8)
                    
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
                Image(systemName: "heart.fill")
                    .opacity(liked ? 1 : 0)
                    .scaleEffect(liked ? 1.0 : 0.1)
                    .animation(.linear).scaleEffect(1.7)
                Image(systemName: "heart").scaleEffect(1.7)
            }
            .padding(.horizontal, 20)
            .onTapGesture {
                self.liked.toggle()
            }
            .foregroundColor(liked ? .red : .black)
            Image(systemName: "message").scaleEffect(1.7)
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
