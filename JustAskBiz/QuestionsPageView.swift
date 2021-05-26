//
//  QuestionsPageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI

struct QuestionsPageView: View {
    
    @ObservedObject private var viewModel = QuestionViewModel()
    
    @State private var presentQuestionAddPageView = false
    var tags: [String]
    
    var body: some View {
        
            VStack(alignment:.leading){
                ScrollView{
                    QuestionStackView(questions: viewModel.questions)
                }.navigationBarTitle("Questions")
                .navigationTitle("Questions")
                .navigationBarItems(
                    trailing: Button(action: {
                        presentQuestionAddPageView.toggle()
                    }, label: {
                        Image(systemName:"plus")
                    })
                )
            }
            
        .sheet(isPresented: $presentQuestionAddPageView){
            QuestionAddPageView()
                }
        .onAppear{
            viewModel.getQuestionsByTag(tagsArray: tags)
        }
    }
}

struct QuestionStackView: View{
    var questions : [Question]
    var body: some View{
        VStack{
            ForEach(questions){q in
                QuestionsView(question: q)
            }
        }
    }
}
struct QuestionsView : View {
    var question : Question
    @ObservedObject private var profileViewModel = ProfileViewModel()
    @ObservedObject private var aViewModel = AnswerViewModel()
    
     
    var body : some View {
       
        ZStack{
            RoundedRectangle(cornerRadius: 10 , style:.continuous)
                .fill(Color.white)
                .shadow(radius: 4)
            VStack{
                HStack{
                    Text("New Question")
                    Spacer()
                    Text(question.date, formatter: realDateFormatter())
                }.font(.caption)
                VStack{
                    HStack{
                        Image(systemName: "person.fill.questionmark")
                            .renderingMode(.original)
                            .resizable(capInsets: EdgeInsets(top: 7.0, leading: 6.0, bottom: 8.0, trailing: 9.0), resizingMode: .tile)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60.0, height: 60.0)
                        
                        VStack {
                            Text("\(profileViewModel.profile.name)").bold()
                           
                            Text("\(profileViewModel.profile.title)")
                            Text("\(profileViewModel.profile.followers)")
                        }
                        Spacer()
                        VStack{
                            Text("Total likes:")
                            Text("\(question.totalAnswerLikes)")
                            Text("Watch")
                                .padding(10)
                                
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                        }
                        
                    }
                    TagView(tags: question.tags)
                    ZStack{
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.white)
                            .shadow(radius: 1)
                        Text(question.bodyText)
                    }
                    NavigationLink(destination: AnswerPageView(question: question)){
                        Text("View answers - ").foregroundColor(.blue)
//                        Text("View answers - \(aViewModel.countAnswer(question.documentId))")
//                            .foregroundColor(Color.blue)
                    }
                   
                    
                }.font(.subheadline)
                
            }.padding(10)
        }
        .padding()
        .frame(width: 430, height: 300)
        .onAppear{
            profileViewModel.fetchData(userId: question.userId)
            print(profileViewModel.profile.name)
        }
    }
}
struct QuestionsPageView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsPageView(tags: ["Marketing"])
    }
}

