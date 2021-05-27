//
//  QuestionAddView.swift
//  JustAskIt
//
//  Created by Aleksandar Lekov on 20/05/2021.
//

import SwiftUI

struct QuestionAddPageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = QuestionViewModel()
    
    private var hardTags = ["Leadership", "Funding","Soft Skills", "Legal Issues", "Technology",
                            "Marketing", "Modernization"]
    
    @State private var tag : String = ""
    @State private var bodyText: String = ""
    @State private var tagArray = [String] ()
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                RoundedRectangle(cornerRadius: 10 , style:.continuous)
                    .fill(Color.white)
                    .shadow(radius: 4)
                VStack(alignment: .leading){
                    Text("Body")
                    
                    TextField("Type here...", text: $bodyText)
                    
                    Spacer()
                    
                }.padding(10)
                
            }.frame(width: 392, height: 173, alignment: .center)
            
            HStack{
                Image(systemName: "pencil").padding()
                VStack(alignment: .leading){
                    Text("Tags")
                    TextField("Enter tags", text: $tag)
                }.padding()
                
            }
                ScrollView(.horizontal){
                    HStack{
                        ForEach(hardTags, id: \.self){ item in
                            Button(action: {
                                tag += " \(item)"
                                tagArray.append(item)
                                
                            }, label: {
                                Text(item)
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.black, lineWidth: 0.5)
                                    )
                            })
                        }
                    }
                }
            
            Button(action: {
                viewModel.saveNewQuestion(bodyText: bodyText, tagsArray: tagArray)
                dismiss()
            },label: {
                Text("Done")
            })
        Spacer()
        }
        }
    }
    
    
    
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
    
    struct QuestionAddPageView_Previews: PreviewProvider {
        static var previews: some View {
            QuestionAddPageView()
        }
    }
}
