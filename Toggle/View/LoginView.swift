//
//  ContentView.swift
//  Toggle
//
//  Created by user185695 on 10/27/20.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)
struct LoginView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var presentError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View{
        Background {
            VStack(spacing: 10) {
                UserNameTextField(username: $username)
                PasswordTextField(password: $password)
                
                HStack(spacing: 20) {
                    Button(action: {
                        self.endEditing()
                        sessionManager.signIn(username: username, password: password)
                    }) {
                        LoginButtonContent()
                    }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("login-error")), perform: { (errorMsg) in
                        if let userInfo = errorMsg.userInfo, let errMsg = userInfo["errorMessage"] {
                            self.presentError.toggle()
                            if let errString = errMsg as? String {
                                self.errorMessage = errString
                            }
                        }
                    }).alert(isPresented: $presentError) {
                        Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }
                    
                    Button(action: {
                        self.endEditing()
                        sessionManager.showSignUp()
                    }){
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
    }
    
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SessionManager())
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

private struct UserNameTextField: View {
    
    @Binding var username: String
    var body: some View {
        TextField("username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(30.0)
            .padding(.bottom, 20)
    }
}

private struct PasswordTextField: View {
    
    @Binding var password: String
    var body: some View {
        SecureField("password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(30.0)
            .padding(.bottom, 20)
    }
}

private struct Background<Content: View>: View {
    private var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Color.blue.opacity(0.5).ignoresSafeArea()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

