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
        VStack(spacing: 0) {
            HStack{
                Group{
                    Button(action: {
                        self.index = 0
                        self.view = 0
                    }){
                        HStack{
                            
                            Image("logo1").frame(width: 120.0, height: 30.0).imageScale(.small)
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal)
                        
                    }
                    Spacer()
                    Button(action: {
                            self.index = 0
                            self.view = 0
                    }){
                        HStack{
                            
                            Image(systemName: "plus.circle.fill").foregroundColor(.white).imageScale(.large)
                            
                        }
                        .padding(.vertical,6)
                        .padding(.horizontal)
                        
                    }
                    .foregroundColor(.white)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                    
                }
            }
            .padding(.horizontal,20)
            .animation(.default)
            .padding(.vertical, 2)
            
            HStack(spacing: 0) {
                Button( action: {
                    self.index = 1
                    self.view = 1
                }) {
                    Text("Following")
                        .frame(width: UIScreen.main.bounds.width / 2 ,height:UIScreen.main.bounds.width / 10,  alignment: .center)
                        .font(.headline)
                        .foregroundColor(Color.white)
                }
                .background(Color.blue.opacity(self.index == 1 ? 0.65 : 0))
                .cornerRadius(22)
                
                Button( action: {
                    self.index = 2
                    self.view = 2
                }) {
                    Text("Discover")
                        .frame(width: UIScreen.main.bounds.width / 2 ,height:UIScreen.main.bounds.width / 10,  alignment: .center)
                        .font(.headline)
                        .foregroundColor(Color.white)
                }
                .background(Color.blue.opacity(self.index == 2 ? 0.65 : 0))
                .cornerRadius(22)
            }
            .animation(.default)
        }
        
        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color.gray.opacity(4))
        
        
    }
}

struct TopNav_Previews: PreviewProvider {
    static var previews: some View {
        TopNav()
    }
}
