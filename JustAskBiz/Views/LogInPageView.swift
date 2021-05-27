//
//  ContentView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI

// Presentation mode hide
struct LogInPageView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var oldUser = false
    
    @State private var about = ""
    @State private var title = ""
    
    @ObservedObject var viewModel = AuthViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        if viewModel.signedIn {
            //                QuestionsPageView(tags: ["Funding"])
            HomePageView()
        }
        else{
            VStack (spacing: 30){
                VStack{
                    TextField("Email Address", text : $email)
                        .padding(.horizontal, 5.0)
                        .background(Color.white)
                        .cornerRadius(3.0)
                        .shadow(radius: 0.5)
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    SecureField("Password", text : $password)
                        .padding(.horizontal, 5.0)
                        .background(Color.white)
                        .cornerRadius(3.0)
                        .shadow(radius: 0.5)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    if oldUser {
                        
                        TextField("Name", text : $name)
                            .padding(.horizontal, 5.0)
                            .background(Color.white)
                            .cornerRadius(3.0)
                            .shadow(radius: 0.5)
                            .disableAutocorrection(true)
                        TextField("About", text : $about)
                            .padding(.horizontal, 5.0)
                            .background(Color.white)
                            .cornerRadius(3.0)
                            .shadow(radius: 0.5)
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        TextField("Title", text : $title)
                            .padding(.horizontal, 5.0)
                            .background(Color.white)
                            .cornerRadius(3.0)
                            .shadow(radius: 0.5)
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    }
                   
                   
                    
                }.padding()
                
                
                
                
                Button(action: {
                    if(!oldUser){
                        viewModel.signIn(email: email, password: password)
                        
                    }else {
                        
                        viewModel.signUp(name: name, email: email, password: password, about:about, title: title)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                
                , label: {
                    Text(oldUser ? "Sign Up" : "Sign In")
                })
                
                Button(action: {oldUser.toggle()}, label: {
                    Text(oldUser ? "Already have an account?" : "Dont have an account?")
                })
                //                    Spacer()
            }.navigationTitle(oldUser ? "Sign Up" : "Sign In")
            .onAppear{
                viewModel.signedIn = viewModel.isSignedIn
            }
        }
        
        
    }
}


struct LogInPageView_Previews: PreviewProvider {
    static var previews: some View {
        LogInPageView()
    }
}

