//
//  ContentView.swift
//  Toggle
//
//  Created by user185695 on 10/27/20.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)
struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var showErrorAlert: Bool = false
    @State var alertError: String = ""
    
    var body: some View{
        Background {
            VStack(spacing: 10) {
                UserNameTextField(username: $username)
                PasswordTextField(password: $password)
                
                HStack(spacing: 20) {
                    Button(action: {
                        self.endEditing()
                        authenticateLoginRequest()
                    }) {
                        LoginButtonContent()
                    }
                    Button(action: {print("button tapped")}) {
                        SignUpButtonContent()
                    }

                }
                .offset(y: 30)
            }
            .padding()
        }
        .onTapGesture {
            self.endEditing()
        }
        .alert(isPresented: $showErrorAlert) { () -> Alert in
            Alert(title: Text("Error"),
                              message: Text(alertError),
                              dismissButton: .default(Text("Ok")))
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    private func authenticateLoginRequest() {
        let authentication = Login()
        authentication.signIn(username: username, password: password) { (error) in
            if let error = error {
                self.alertError = error
                self.showErrorAlert = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .frame(minWidth: 0, idealWidth: 250, maxWidth: .infinity, minHeight: 0, idealHeight: 65, maxHeight: 65, alignment: .center)
            .background(Color.black)
            .cornerRadius(35.0)
    }
}

struct SignUpButtonContent: View {
    var body: some View {
        Text("SIGNUP")
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .frame(minWidth: 0, idealWidth: 250, maxWidth: .infinity, minHeight: 0, idealHeight: 65, maxHeight: 65, alignment: .center)
            .background(Color.black)
            .cornerRadius(35.0)
    }
}

struct UserNameTextField: View {
    
    @Binding var username: String
    var body: some View {
        TextField("username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(30.0)
            .padding(.bottom, 20)
    }
}

struct PasswordTextField: View {
    
    @Binding var password: String
    var body: some View {
        SecureField("password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(30.0)
            .padding(.bottom, 20)
    }
}

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
