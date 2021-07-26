//
//  AddView.swift
//  AnotherRealm
//
//  Created by Daniil on 09.07.2021.
//

import SwiftUI

struct AddView: View {
    @State var titleText = ""
    @State var bodyText = ""
    @EnvironmentObject var post: Post
    @Binding var showAddView: Bool
    var posts: PostModel
    @Binding var darkMode: Bool
    @State var showAlert = false
    var body: some View {
        ZStack{
            Color.init(darkMode ? #colorLiteral(red: 0.1543801048, green: 0.1543801048, blue: 0.1543801048, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).edgesIgnoringSafeArea(.all)
        VStack{
            HStack{
                
                Button(action: {
                    withAnimation(Animation.easeOut){
                        showAddView.toggle()
                    }
                }, label: {
                    HStack{
                    Image(systemName: "chevron.left")
                        .font(.system(size: 28))
                        .foregroundColor(Color.blue)
                    Text("Назад")
                    }
                       
                })
                Spacer()
                
            }
            .padding()
            
            //Add card view
            
            VStack{
                VStack(alignment: .leading){
                    Text("Title")
                        .font(.system(size: 18, weight: .semibold))
                    TextField("title", text: $titleText)
                        .font(.system(size: 18, weight: .semibold))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                VStack(alignment: .leading){
                    Text("Body")
                        .font(.system(size: 18, weight: .semibold))
                    TextField("body", text: $bodyText)
                        .font(.system(size: 18, weight: .semibold))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Button(action: {
                        if titleText.isEmpty || bodyText.isEmpty{
                            showAlert.toggle()
                        } else {
                        posts.title = titleText
                        posts.body = bodyText
                        post.addPost(object: posts)
                        showAddView.toggle()
                        }
                    }, label: {
                        Text("Add post")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.blue)
                     
                           
                    })
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Enter all fields"))
                    })
                    .padding(5)
                }
            }
            .padding()
            .background(darkMode ? Color.white.opacity(0.05) : Color.black.opacity(0.05))
            .cornerRadius(25)
            .padding()
            Spacer()
        }
        }
        .colorScheme(darkMode ? .dark : .light)
    }
}




