//
//  AccountView.swift
//  Toggle
//
//  Created by user185695 on 11/7/20.
//

import SwiftUI
import Amplify

struct AccountView: View {
    var colors = [Color.gray, Color.gray, Color.gray, Color.gray]
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Image(systemName: "person.circle.fill").scaleEffect(4)
                }
                .frame(width: UIScreen.main.bounds.width / 6.3, height: UIScreen.main.bounds.height/4
                        , alignment: .center)
            List {
                // for each post in post in posts create a post cell
                ForEach(self.colors, id: \.self) {color in
                  
                    RoundedRectangle(cornerRadius: 4)
                         .fill(color)
                         .frame(width: 250, height: 200)                }
            }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: Text("@USER").fontWeight(.bold).scaleEffect(1.5), trailing: UploadVideoButton())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        }
}
           
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
