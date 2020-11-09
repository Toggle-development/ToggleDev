//
//  TopNav.swift
//  Toggle
//
//  Created by user185695 on 11/5/20.
//

import SwiftUI
import UIKit
struct TopNav: View {
    @State var showVideoPicker = false
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                Group{
                        
                    Image("logo1").frame(width: 120.0, height: 30.0).imageScale(.small)
                        .padding(.horizontal)
                    
                    Spacer()
                    Button(action: { 
                        // add action for + button
                    }){
                            
                        Image(systemName:"plus.circle.fill")
                            .foregroundColor(.white).imageScale(.large)
                            .padding(.vertical,4)
                            .padding(.horizontal)
                        
                    }
                    .foregroundColor(.white)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                    
                }
            }
            .padding(.horizontal,20)
            .animation(.default)
            .padding(.vertical, 5)
        }
    }
    
  
}

struct TopNav_Previews: PreviewProvider {
    static var previews: some View {
        TopNav()
    }
}
