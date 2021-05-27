//
//  SearchPageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI

struct SearchPageView: View {
    var body: some View {
        SearchView()
    }
}
struct SearchView: View {
    @State var tagString : String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                SearchTagView(text : ["Leadership", "Funding","Soft Skills", "Legal Issues", "Technology",
                                      "Marketing", "Modernization"])
            }
            .navigationTitle("Search").navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back"){
                        
                    }
                }
            })
        }
    }
}

struct SearchTagView: View {
    var text : [String]
    @State private var tagString : String = ""
    var body : some View {
        HStack {
            Image(systemName : "pencil")
                .padding()
            VStack(alignment: .leading){
                Text("Tags")
                TextField("Enter tags", text : $tagString)
            }.padding()
            
        }
        
        
        HStack{
            ForEach(text, id: \.self){ item in
                Button(action: {
                        tagString += " \(item)"
                    
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
        Button(action : {} , label : {
            Text("Done")
        })
        
        Spacer()
    }
}
struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
