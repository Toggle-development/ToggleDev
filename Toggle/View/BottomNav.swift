//
//  BottomNav.swift
//  Toggle
//
//  Created by user185695 on 11/4/20.
//

import SwiftUI

struct BottomNav: View {
    @State var index = 0
    @Binding var view : Int
    var body: some View {
        HStack{
            Group{
                
                Button(action: {self.index = 0
                        
                        self.view = 0                }){
                    HStack{
                        
                        Image(systemName: "plus.circle.fill").foregroundColor(.white).imageScale(.large)
                        
                    }
                    .padding(.vertical,4)
                    .padding(.horizontal)
                    
                }
                .foregroundColor(.white)
                .background(Color.blue.opacity(self.index == 0 ? 0.65 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 11))
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Button(action: {self.index = 1
                        self.view = 1                }){
                    HStack{
                        Image(systemName: "gamecontroller.fill").foregroundColor(.white).imageScale(.large)
                        
                    }
                    .padding(.vertical,4)
                    .padding(.horizontal)
                }
                .foregroundColor(.white)
                .background(Color.blue.opacity(self.index == 1 ? 0.65 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 11))
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Button(action: {self.index = 2
                    self.view = 2
                }){
                    HStack{
                        
                        Image(systemName: "person.circle.fill").foregroundColor(.white).imageScale(.large)
                        
                    }
                    .padding(.vertical,4)
                    .padding(.horizontal)
                    
                }
                .foregroundColor(.white)
                .background(Color.blue.opacity(self.index == 2 ? 0.65 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 11))
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Button(action: {self.index = 3
                    self.view = 3
                }){
                    HStack{
                        Image(systemName: "gamecontroller.fill").foregroundColor(.white).imageScale(.large)
                        
                    }
                    .padding(.vertical,4)
                    .padding(.horizontal)
                    
                }
                .foregroundColor(.white)
                .background(Color.blue.opacity(self.index == 3 ? 0.65 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 11))
            }
            
        }
        .padding(.top, 5)
        .padding(.horizontal,20)
        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        .background(Color.gray.opacity(4))
        .animation(.default)
    }
    
}

/*struct BottomNav_Previews: PreviewProvider {
 @State var view = 0
 static var previews: some View {
 BottomNav(view: 0)
 }
 }*/
