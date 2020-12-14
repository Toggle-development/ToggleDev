//
//  ImagePicker.swift
//  Toggle
//
//  Created by user185695 on 11/9/20.
//

import SwiftUI
import Amplify
import AmplifyPlugins
import Combine

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var videoURL: URL?
    @Environment(\.presentationMode) var presentationMode
    
    typealias UIViewControllerType =  UIImagePickerController
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(imagePicker: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller  = UIImagePickerController()
        controller.delegate = context.coordinator
        controller.mediaTypes = ["public.movie"]
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    let imagePicker: ImagePicker
    
    init(imagePicker: ImagePicker){
        self.imagePicker = imagePicker
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.presentationMode.wrappedValue.dismiss()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.presentationMode.wrappedValue.dismiss()
        
        guard let videoURL = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerReferenceURL")] as? URL else {return}
        imagePicker.videoURL = videoURL
        let key = UUID().uuidString +  ".mov"
        _ = Amplify.Storage.uploadFile(key: key, local: videoURL  ){ result in
            switch result{
            case .success:
                print("uploaded video")
            case .failure(let error):
                print("Failed- \(error)")
                
            
            }
            
        }
        
        print(videoURL)
    }
    
    
}

