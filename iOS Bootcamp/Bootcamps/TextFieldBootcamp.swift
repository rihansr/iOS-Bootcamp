//
//  TextFieldBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 21/09/2023.
//

import SwiftUI

struct TextFieldBootcamp: View {
    
    enum OnboardingField: Hashable{
        case email, password, details
    }
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var details: String = ""
    
    //@FocusState private var emailFocusState: Bool
    //@FocusState private var passwordFocusState: Bool
    @FocusState private var fieldInFocus: OnboardingField?
    
    var body: some View {
        NavigationView{
            VStack(spacing: 16.0){
                TextField("Enter email...", text: $email)
                //.focused($emailFocusState)
                    .focused($fieldInFocus, equals: .email)
                //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.blue.opacity(0.05).cornerRadius(8))
                    .foregroundColor(Color.black)
                    .font(.headline)
                    .submitLabel(.next)
                    .onSubmit {
                        if email.count >= 5 {
                            self.fieldInFocus = .password
                        }
                    }
                
                SecureField("Enter password...", text: $password)
                //.focused($passwordFocusState)
                    .focused($fieldInFocus, equals: .password)
                //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.blue.opacity(0.05).cornerRadius(8))
                    .foregroundColor(Color.black)
                    .font(.headline)
                    .submitLabel(.done)
                    .onSubmit {
                        if password.count >= 6 {
                            self.fieldInFocus = .details
                        }
                    }
                
                TextEditor(text: $details)
                    .focused($fieldInFocus, equals: .details)
                    .frame(height: 96)
                    .font(.headline)
                    .foregroundColor(.black)
                    .colorMultiply(.white)
                    .cornerRadius(8)
                    .shadow(color: Color.blue, radius: 0.5)
                    .submitLabel(.continue)
                    .onSubmit {
                        signUp()
                    }
                
                Spacer(minLength: 0).frame(height: 2)
                
                Button(
                    action: signUp,
                    label: {
                        Text("Sign Up".uppercased())
                            .padding()
                            .frame(maxWidth:.infinity)
                            .background((isValidate() ? Color.blue : Color.gray).cornerRadius(8))
                            .foregroundColor(Color.white)
                            .font(.headline)
                    })
                .disabled(!isValidate())
            }
            .padding(.all)
            .navigationTitle("Register")
        }
        .onAppear{
            self.fieldInFocus = .email
        }
    }
    
    func isValidate () -> Bool {
        email.count >= 5 && password.count >= 6
    }
    
    func signUp(){
        if email.count < 5 {
            self.fieldInFocus = .email
        }
        else if password.count < 6 {
            self.fieldInFocus = .password
        }
        else {
            email = ""
            password = ""
            details = ""
        }
    }
}

struct TextFieldBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldBootcamp()
    }
}

