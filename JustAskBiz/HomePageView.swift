//
//  HomePageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    HStack {
                        Text("What is your business interest?")
                           NavigationLink(
                            destination: ProfilePageView(),
                            label: {
                                Image(systemName: "person.fill")
                            })
                    }
                    CategoryView()
                }
            }.navigationTitle("Categories")
        }
        
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

struct CategoryView: View {
    let tags = ["Leadership", "Funding","Soft Skills", "Legal Issues", "Technology",
    "Marketing", "Modernization"]
    
    let colors = [Color.red, Color.blue, Color.green, Color.yellow]
    @State private var tagNumber = 0
    @State private var currentColor = 0
    var body: some View {
        VStack (spacing: 20){
//            ForEach(0..< tags.count, id : \.self){
//                //tag , tag + 1
//                //tag spacer Spacer()
//                HStack{
//                    CircleView(text : "\(tags[$0])", color: Color.red)
//                }
//            }
            HStack(spacing: 25){
                CircleView(text : "Leadership", color: Color.red).padding([.leading, .bottom], 25.0)
                CircleView(text : "Funding", color: Color.green)
                    .padding(.top, 20.0)
            }
            HStack(spacing: 25){
                CircleView(text : "Soft Skills", color : Color.blue)
                    .padding([.top, .trailing], 20.0)
                   
            }
            
            
            
            HStack(spacing: 25){
                CircleView(text : "Legal Issues", color: Color.red)
                    .padding([.top, .trailing], 20.0)
                CircleView(text : "Technology", color : Color.green)
            }
            HStack(spacing: 25){
                CircleView(text : "Marketing", color: Color.blue)
                    .padding(.bottom)
                CircleView(text : "Modernization", color: Color.red)
                    .padding([.top, .leading], 25.0)
            }
            
        }.padding()
        
        
    }
}


struct CircleView : View {
    @State private var thepadding = false
    var text : String
    var color: Color
    
    var body : some View {
        NavigationLink(
            destination: QuestionsPageView(tags : [text]),
            label: {
//                Button(action: { /* NavigationLink Text "Categories" destination
//                        QuestionsPageView and then tell the viewModel to update questions list*/
//
//                         }, label: {
//
//                })
                Text(text)
                    .font(.body)
                    
                    .foregroundColor(.white)
                    
                    .frame(width: 140, height: 140)
                    
                    .background(color)
                    
                    .clipShape(Circle())
            })
        
        
    }
}
