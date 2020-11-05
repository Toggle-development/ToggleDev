//
//  TopNav.swift
//  Toggle
//
//  Created by user185695 on 11/5/20.
//

import SwiftUI
import UIKit
struct TopNav: View {
    @State var index = 0
    @State var view = 0
    var body: some View {
        HStack{
            
            Group{
                Button(action: {self.index = 0
                    
                        self.view = 0                }){
                    HStack{
                        
                        Image("logo1").frame(width: 120.0, height: 30.0).imageScale(.small)
                    }
                    .padding(.vertical,4)
                    .padding(.horizontal)
                        
                }
                Spacer()
                Button(action: {self.index = 0
                    
                        self.view = 0                }){
                    HStack{
                        
                        Image(systemName: "plus.circle.fill").foregroundColor(.white).imageScale(.large)
                        
                    }
                    .padding(.vertical,4)
                    .padding(.horizontal)
                        
                }
            .foregroundColor(.white)
            .background(Color.black.opacity(self.index == 0 ? 1 : 0))
            .clipShape(RoundedRectangle(cornerRadius: 11))
            
        
        }
        }
        .padding(.vertical)
        .padding(.horizontal,20)
        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color.gray.opacity(4))
        .cornerRadius(22)
        .animation(.default)
        
        }
}

struct TopNav_Previews: PreviewProvider {
    static var previews: some View {
        TopNav()
    }
}
