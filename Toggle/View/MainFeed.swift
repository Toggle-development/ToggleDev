//
//  MainFeedCell.swift
//  Toggle
//
//  Created by Walid Rafei on 11/5/20.
//

import SwiftUI
import AVKit

struct MainFeed: View {
    //observe the posts ovject from PostViewModel to update screen according to data we get.
    @ObservedObject private var postViewModel = PostViewModel()
    
    var body: some View {
        
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
        }
    }
}

struct MainFeed_Previews: PreviewProvider {
    static var previews: some View {
        MainFeed()
    }
}


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
    @State var showVideoPicker = false
    @State var image: UIImage?
    var body: some View {
        Button(action: { didTapButton()
            // add action for + button
        }){
            Image(systemName:"camera.circle.fill")
                .foregroundColor(.white).imageScale(.large)
                .padding(.vertical,4)
                .padding(.horizontal)
            
        }
        .foregroundColor(.white)
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 11))
        .sheet(isPresented: $showVideoPicker, content: {
            ImagePicker(image: $image)
            
        })
    }
    
    func didTapButton(){
        showVideoPicker.toggle()
        
    }
}

struct AppLogo: View {
    var body: some View {
        Image("logo1")
            .imageScale(.large)
    }
}
