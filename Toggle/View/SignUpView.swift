//
//  SignUpPage.swift
//  Toggle
//
//  Created by Walid Rafei on 10/31/20.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    
    var body: some View {
        Background {
            VStack(spacing: 20){
                Spacer()
                Spacer()
                UserNameTextField(username: $username)
                emailTextField(email: $email)
                PasswordTextField(password: $password)
                
                Button(action: {
                    UIApplication.shared.endEditing()
                    sessionManager.signUp(username: username, password: password, email: email)
                }) {
                    DoneButtonContent()
                }
                .offset(y:20)
                
                Spacer()
                Button(action: {
                    sessionManager.showLogin()
                }, label: {
                    Text("Already have an account? Log in.")
                })
            }.offset(y:-20)
            .padding()
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
    
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionManager())
    }
}

private struct emailTextField: View {
    
    @Binding var email: String
    var body: some View {
        TextField("email", text: $email)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(30.0)
            .padding(.bottom, 20)
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

struct DoneButtonContent: View {
    var body: some View {
        Text("Done")
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .frame(minWidth: 0, idealWidth: 250, maxWidth: .infinity, minHeight: 0, idealHeight: 65, maxHeight: 65, alignment: .center)
            .background(Color.black)
            .cornerRadius(35.0)
    }
}

private struct Background<Content: View>: View {
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
