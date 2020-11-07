//
//  MainFeedCell.swift
//  Toggle
//
//  Created by Walid Rafei on 11/5/20.
//

import SwiftUI
import AVKit

// this should be coming from database
struct Post: Identifiable, Hashable {
    var id: Int
    let postOwner: String
    let caption: String
    let numberOfLikes: Int
    let videoURL: String
}

struct MainFeed: View {
    //test data
    
    let posts: [Post] =
        [.init(id: 0, postOwner: "Walid Rafei", caption: "This is awesome", numberOfLikes: 10, videoURL:"https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"),
         .init(id: 1, postOwner: "Andrew", caption: "Great News kfwle;kf lw;kfl ;wefk l;ewkkwekl l;wekl;fkew kl;kwe;l fkewl; l;ewk l;ewkl;k;wle kl;ew le;kl;wkl;ew kwl; lw;e kl;ew kl;e kl;we l;kewl l;ewk kl;wek l;k ;lkwek;l fkewl;w;lk!", numberOfLikes: 9, videoURL: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"),
         .init(id: 2, postOwner: "James", caption: "I had so much fun making this", numberOfLikes: 15, videoURL: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")
        ]
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(posts, id: \.id) {post in
                    VStack {
                        TopBarOfCell(postOwner: post.postOwner)
                            .frame(width: UIScreen.main.bounds.width, height: geometry.size.height / 15)
                            .padding(.top, 5)
                        VideoView(videoURL: URL(string: post.videoURL)!, previewLength: 60)
                            .frame(width: UIScreen.main.bounds.width, height: geometry.size.height / 1.5)
                        
                        UserInteractions()
                            .frame(width: UIScreen.main.bounds.width, height: geometry.size.width / 10)
                            .padding(.bottom, 5)
                        
                        CaptionsAndComments(caption: post.caption, postOwner: post.postOwner)
                    }
                    .listRowInsets(.init())
                }
            }
        }
    }
}

struct MainFeed_Previews: PreviewProvider {
    static var previews: some View {
        MainFeed()
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
    
    var videoURL:URL
    var previewLength:Double?
    
    func makeUIView(context: Context) -> UIView {
        return PlayerView(frame: .zero, url: videoURL, previewLength: previewLength ?? 15)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct UserInteractions: View {
    @State var liked = false
    var body: some View {
        HStack{
            Spacer(minLength: UIScreen.main.bounds.width/1.2)
            Image(systemName: "message").imageScale(.large)
            
            
            ZStack {
                    Image(systemName: "heart.fill")
                            .opacity(liked ? 1 : 0)
                            .scaleEffect(liked ? 1.0 : 0.1)
                        .animation(.linear).imageScale(.large)
                Image(systemName: "heart").imageScale(.large)
            }
            .onTapGesture {
                            self.liked.toggle()
                    }
        
            .foregroundColor(liked ? .red : .black)
            
            
            
            Spacer(minLength: 3)
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
