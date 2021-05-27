//
//  ProfilePageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfilePageView: View {
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var userId = Auth.auth().currentUser!.uid
    @State var sourceType:UIImagePickerController.SourceType = .camera
   
    
    @State var image:UIImage?
    
    var body: some View {
        
    
            VStack(spacing: 20){
                if image != nil {
                    Image(uiImage: image!)
                        .renderingMode(.original)
                        .resizable(capInsets: EdgeInsets(top: 7.0, leading: 6.0, bottom: 8.0, trailing: 9.0), resizingMode: .tile)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60.0, height: 60.0)
                } else {
                    Image("profilepic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70.0, height: 70.0)
                }
                
                Text(profileViewModel.profile.name)
                Text(profileViewModel.profile.title)
                
                NavigationLink(
                    destination: EditProfilePageView(),
                    label: {
                        Text("Edit Profile")
                    })
                
                Divider()
                InfoCardView(titleText: "About me", descText: profileViewModel.profile.about)
                InfoCardView(titleText: "Industry", descText: profileViewModel.profile.industry)
                InfoCardView(titleText: "Contact", descText: profileViewModel.profile.email)
                Spacer()
                Button(action: {
                    AuthViewModel.init().signOut()
                }, label: {
                    Text("Logout")
                })
            }
            .navigationTitle("Profile")
            .onAppear() {
                self.profileViewModel.fetchData(userId: userId)
            }
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Back"){
//                        
//                    }
//                }
//            }
//            .padding()
        }
    }


struct InfoCardView : View{
    var titleText : String
    var descText : String
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white)
                .shadow(radius: 1)
            VStack(spacing: 10) {
                Text(titleText)
                    .font(.headline)
                HStack{
                    Text(descText)
                        .font(.footnote)
                    Spacer()
                }
                Spacer()
            }.padding(10)
        }.frame(height:120)
        .padding()
    }
}
struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}
