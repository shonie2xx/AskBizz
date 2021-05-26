//
//  questionsviewTest.swift
//  JustAskBiz
//
//  Created by Aleksandar Lekov on 23/05/2021.
//

import SwiftUI

struct questionsviewTest: View {
    @ObservedObject private var viewModel = QuestionListViewModel()
    
    var body: some View {
        NavigationView{
            VStack(alignment: .trailing){
                List{
                    ForEach(self.viewModel.questions) { i in
                        VStack(alignment: .leading){
                            Text("\(i.bodyText)")
//                            Text("\(i.tags)")
                            
                        }
                    }
                }
            }
            .onAppear{
                viewModel.getQuestionsByTag(tagsArray: ["Business","Marketing","Funding"])
            }
        }
    }
}

struct questionsviewTest_Previews: PreviewProvider {
    static var previews: some View {
        questionsviewTest()
    }
}

//struct QuestionListView: View {
//
//    @ObservedObject private var viewModel = QuestionsViewModel()
//
//    @State private var presentQuestionAddView = false
//
//    var body: some View {
//
//        NavigationView{
//            VStack(alignment: .trailing) {
//                List{
//                    ForEach(self.viewModel.questions) {i  in
//                        VStack(alignment: .leading){
//                            Text("\(i.bodyText)")
//                            Text("\(i.tags)")
//                        }
//                    }
//                }
//            }.onAppear{
//                viewModel.fetchData()
//            }
//            .navigationBarTitle("Questions")
//            .navigationBarItems(
//                trailing: Button(action: {presentQuestionAddView.toggle()}, label: {
//                    Image(systemName:"plus")
//                })
//            )
//        }
//        .sheet(isPresented: $presentQuestionAddView){
//            QuestionAddView()
//        }
//    }
//
//}
