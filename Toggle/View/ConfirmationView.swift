//
//  ConfirmationView.swift
//  Toggle
//
//  Created by Walid Rafei on 10/31/20.
//

import SwiftUI

struct ConfirmationView: View {
    @EnvironmentObject private var sessionManager: SessionManager
    
    let username: String
    let password: String
    var body: some View {
        VStack(spacing: 5) {
            Text("Hello \(username)")
                .fontWeight(.medium)
                .font(.title)
                .foregroundColor(Color.black)
            
            Text("Please Confirm Your Account")
                .fontWeight(.medium)
                .font(.headline)
                .foregroundColor(Color.black)
            
            Text("An email was sent to you")
                .fontWeight(.medium)
                .font(.headline)
                .foregroundColor(Color.black)
            
            Spacer()
            Spacer()
            VStack{
            Button(action: {
                sessionManager.resendSignUpConfirmationCode(username: username)
            }) {
                Text("Resend verification code")
                    .foregroundColor(.blue)
                    .fontWeight(.heavy)
                    .font(.headline)
            }
            Text("Enter Verification Code").font(.title)
            }.padding()
            
            Verification(username: username, password: password).environmentObject(sessionManager)
            
        }.padding(.top, 30)
    }
}

struct Verification: View {
    @State var code: [String] = []
    @EnvironmentObject private var sessionManager: SessionManager
    
    let username: String
    let password: String
    var body: some View {
        VStack {
            HStack(spacing: 25) {
                ForEach(code, id: \.self) {i in
                    Text(i).font(.title).fontWeight(.semibold)
                }
            }.animation(.spring())
            Spacer()
            NumberPad(codes: $code, username: username, password: password).environmentObject(sessionManager)
        }.padding(.vertical)
    }
}
struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(username: "Dummy", password: "Dummy").environmentObject(SessionManager())
    }
}

struct NumberPad: View {
    @EnvironmentObject private var sessionManager: SessionManager
    @Binding var codes: [String]
    @State private var isButtonSelected = false
    
    let username: String
    let password: String
    
    var body: some View {
        VStack(alignment:.leading, spacing:20) {
            ForEach(datas){i in
                HStack() {
                    ForEach(i.row){j in
                        Button(action: {
                            self.isButtonSelected.toggle()
                            if(j.value == "delete.left.fill") {
                                if(!codes.isEmpty) {
                                    self.codes.removeLast()
                                }
                            }
                            else if (j.value == "cancel") {
                                self.sessionManager.showLogin()
                            }
                            else {
                                self.codes.append(j.value)
                                if self.codes.count == 6 {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        sessionManager.confirmSignUp(for: username, with: getCode(), password: password)
                                        self.codes.removeAll()
                                    }
                                }
                            }
                            
                        }){
                            if(j.value == "delete.left.fill") {
                                Image(systemName: j.value).font(.body).padding(.vertical)
                                    .frame(width:self.getSpacing())
                            }
                            else {
                                Text(j.value).font(.title).fontWeight(.semibold).padding(.vertical)
                                    .frame(width: self.getSpacing())
                            }
                        }.background(isButtonSelected ? Color.blue.opacity(0.5) : Color.white)
                        .buttonStyle(MyButtonStyle())
                    }
                }
            }
        }.foregroundColor(.black)
    }
    
    func getSpacing()-> CGFloat {
        return UIScreen.main.bounds.width / 3
    }
    
    func getCode() -> String {
        var code = ""
        for i in self.codes {
            code += i
        }
        return code
    }
}

struct type: Identifiable {
    var id: Int
    var row: [row]
}

struct row: Identifiable {
    var id : Int
    var value : String
}

var datas = [
    type(id: 0, row: [row(id: 0, value: "1"),row(id: 1, value: "2"),row(id: 2, value: "3")]),
    type(id: 1, row: [row(id: 0, value: "4"),row(id: 1, value: "5"),row(id: 2, value: "6")]),
    type(id: 2, row: [row(id: 0, value: "7"),row(id: 1, value: "8"),row(id: 2, value: "9")]),
    type(id: 3, row: [row(id: 0, value: "cancel"),row(id: 1, value: "0"), row(id: 2, value: "delete.left.fill")])
    
]

struct MyButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.blue.opacity(0.5) : Color.white)
    }
    
}
