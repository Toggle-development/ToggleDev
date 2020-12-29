//
//  MainFeedCell.swift
//  Toggle
//
//  Created by Walid Rafei on 11/5/20.
//

import SwiftUI
import AVKit
import Amplify

struct MainFeed: View {
    //observe the posts object from PostViewModel to update screen according to data we get.
    @ObservedObject private var postViewModel = PostViewModel()
    
    let dataManager = DataManager()
    @State var PostsRead: [String: Bool] = [String: Bool]()
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                List {
                    // for each post in post in posts create a post cell
                    ForEach(postViewModel.posts, id: \.id) { post in
                        let url = URL(string: "https://toggle-storage172749-dev.s3-us-west-2.amazonaws.com/public/\(post.id).mp4")
                        PostCell(postOwner: post.postOwner, caption: post.caption, videoURL: url!, postFrame: geometry)
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: AppLogo(),trailing: UploadVideoButton())
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

#if DEBUG
struct MainFeed_Previews: PreviewProvider {
    static var previews: some View {
        MainFeed()
    }
}
#endif


struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}

struct UploadVideoButton: View {
    // this videoURL should eventually hold the actual video url string.
    @State var videoURL: NSURL? = NSURL(string: "")
    var body: some View {
        NavigationLink(destination: ImagePicker(videoURL: $videoURL)) {
            Image(systemName:"camera.circle.fill")
                .foregroundColor(.white).imageScale(.large)
                .padding(.vertical,4)
                .padding(.horizontal)
                .foregroundColor(.white)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 11))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Choose Video")
        .navigationBarBackButtonHidden(true)
    }
}

struct AppLogo: View {
    var body: some View {
        Image("logo1")
            .imageScale(.large)
    }
}
