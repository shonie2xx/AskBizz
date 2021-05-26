//
//  AnswerPageView.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 21/05/2021.
//

import SwiftUI


struct AnswerPageView: View {
    //var question: [Question]
    @ObservedObject var qViewModel = QuestionViewModel()
    
    @ObservedObject var aViewModel = AnswerViewModel()
    
    var question : Question
    
    var body: some View {
        VStack { // VStack for all elements on page
            ScrollView{ // ScrollView containing questioninfo and answer stack view (Answer array -> view)
                        // But NOT AnswerPostView because it should stay at the bottom at all times
                
                QuestionInfoView(question: question)
                AnswerStackView(answerArray: aViewModel.getAnswers(qDocId: question.documentId))
                
            }
            //TEST THIS
            AnswerPostView(questionID : question.documentId) //8yUKyA6oZj3NqDagWlw4
            
        }.navigationBarTitle("Question")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
        }
        
    }
}

struct QuestionInfoView: View {
    @ObservedObject var askedViewModel = ProfileViewModel()
    var question : Question
    var body : some View {
        VStack{
            Text(self.question.bodyText)
            TagView(tags : self.question.tags)
            HStack(alignment: .top){
                VStack{
                    Text("Asked by:")
                    HStack{
                        Image(systemName: "person.fill.questionmark")
                        VStack{
                            Text("\(askedViewModel.profile.name)")
                            Text("\(askedViewModel.profile.title)")
                            Text("\(askedViewModel.profile.followers)")
                        }
                    }
                }
                Spacer()
                VStack(spacing: 5){
                    Text("Total likes: ")
                    Image(systemName : "heart")
                    Text("\(question.totalAnswerLikes)")
                }
            }
            Text("\(question.date, formatter: realDateFormatter())")
            Divider()
        }.padding()
        .onAppear{
            //Very powerful line of code
            self.askedViewModel.fetchData(userId: question.userId)
        }
        
    }
}

struct TagView: View {
    var tags : [String]
    var body : some View {
        ScrollView(.horizontal){
        HStack{
            ForEach(tags, id: \.self){ item in
                Text(item)
                    .font(.caption)
                    .padding(5)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
        }
        }.padding(.horizontal, 10)
    }
}

struct AnswerStackView : View {
     var answerArray = [Answer]()
    
//    var qDocId : String
    
    var body: some View {
        VStack{
            ForEach(answerArray){ a in
                AnswerCardView(answer : a)
            }
        }
        
    }
}

struct AnswerCardView: View {
    @ObservedObject var answeredViewModel = ProfileViewModel()
    
    var answer : Answer
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius : 15)
                .foregroundColor(Color.white)
            VStack{
                HStack(alignment : .top){
                    Image(systemName : "pencil")
                    VStack{
                        Text("\(answeredViewModel.profile.name)")
                        Text("\(answeredViewModel.profile.title)")
                        Text("\(answeredViewModel.profile.followers)")
                    }
                    Spacer()
                    VStack (spacing: 10){
                        Text("\(self.answer.date, formatter: realDateFormatter())")
                        HStack{
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "heart.fill")
                            })
                            Text("\(answer.likes)")
                        }
                    }
                    
                }.padding(5.0)
                Divider()
                Text("\(answer.bodyText)")
                Spacer()
                
            }
            .padding([.top, .leading, .trailing], 5.0)
        }.frame(height: 200, alignment: .center)
        .shadow(radius: 5)
        .padding()
        .onAppear{
            //Very powerful line of code
            self.answeredViewModel.fetchData(userId: answer.userId)
        }
    }
}

struct AnswerPostView : View {
    
//    var postViewModel : QuestionViewModel
    @ObservedObject var viewModel = AnswerViewModel()
    @State private var answerMessage = ""
    
    var questionID : String
    
    var body : some View {
        HStack(spacing : 10){
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                
                TextField("Write an answer", text : $answerMessage).padding()
            }
            .frame(height: 50)
            
            
            Button(action: {
                viewModel.saveAnswer(qDocId: questionID, bodyText: answerMessage)
            }, label: {
                Text("Post").padding(15).background(Color.blue).foregroundColor(Color.white).clipShape(RoundedRectangle(cornerRadius: 30))
            })
            
        }
        .padding()
    }
}

func realDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}

struct AnswerPageView_Previews: PreviewProvider { // Hardcoded data to show in previews
    static var previews: some View {
        AnswerPageView(question  :
                        
                        Question(userId: "FEYmCXiKJSe1mdDRzJaTBx5oz713", date: Date(), tags: ["Business", "Marketing" ], bodyText: "Why cant I buy wiuhcweuhfewiufheiwufhefffheuhfiuhferiuhfiurhfiuerhfiu for my company?", totalAnswerLikes: 20000,
                                 
                                 documentId:"qweqewewqdsasqd"
                        ))
    
    }
}
