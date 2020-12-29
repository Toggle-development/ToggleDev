//
//  ImagePicker.swift
//  Toggle
//
//  Created by user185695 on 11/9/20.
//

import SwiftUI
import Photos

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var videoURL: NSURL?
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
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        if let url = info[.mediaURL] as? URL {
            do {
                let docDirURL: URL = documentsDirectoryURL.appendingPathComponent("test.mov")
                
                if FileManager.default.fileExists(atPath: docDirURL.path) {
                    do {
                        try FileManager.default.removeItem(at: docDirURL)
                        print("Removed pre-existing file at \(docDirURL)")
                    } catch {
                        print("Failed to remove file.")
                    }
                }
                try FileManager.default.moveItem(at: url, to: docDirURL)
                print("Movie saved in application store.")
                let dataManager = DataManager()
                movToMp4(at: docDirURL) { (mp4Url, _) in
                    dataManager.uploadFile(fileKey: mp4Url?.lastPathComponent ?? "test.mp4")
                }
                
            } catch {
                print("Error: ImagePickerController")
                print(error)
            }
        }
    }
}

