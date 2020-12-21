//
//  MainFeedCell.swift
//  Toggle
//
//  Created by Walid Rafei on 11/5/20.
//

import SwiftUI
import AVKit

struct MainFeedIntegratedController: UIViewControllerRepresentable {
    
    var videos = [OGPost]()
    
    func makeUIViewController(context: Context) -> MainFeedVC {
        
        let mainFeedVC = UIStoryboard(name: "MainFeed", bundle: nil).instantiateViewController(withIdentifier: "MainFeedVC") as! MainFeedVC
        mainFeedVC.postArray = videos
        return mainFeedVC
        
    }
    func updateUIViewController(_ uiViewController: MainFeedVC, context: Context) { }
}

struct MainFeed: View {
    //observe the posts ovject from PostViewModel to update screen according to data we get.
    @ObservedObject private var postViewModel = PostViewModel()
    
    let dataManager = DataManager()
    
    init() {
        dataManager.createPost()
    }
    
    var body: some View {
        
        MainFeedIntegratedController(videos: postViewModel.posts).edgesIgnoringSafeArea(.all)
        
        
        /*
         GeometryReader { geometry in
         NavigationView {
         List {
         // for each post in post in posts create a post cell
         ForEach(postViewModel.posts, id: \.id) {post in
         PostCell(postOwner: post.postOwner, videoURL: post.videoURL, caption: post.caption, postFrame: geometry)
         }
         }
         .navigationBarTitle("", displayMode: .inline)
         .navigationBarItems(leading: AppLogo(),trailing: UploadVideoButton())
         
         }
         .navigationViewStyle(StackNavigationViewStyle())
         }*/
        
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
    @State var videoURL: NSURL?
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
