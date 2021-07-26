//
//  HomeView.swift
//  AnotherRealm
//
//  Created by Daniil on 09.07.2021.
//

import SwiftUI

struct HomeView: View {
    @StateObject var post = Post()
    @State var showAddView = false
    @State var darkMode = true
    var body: some View {
        ZStack{
            
            Color.init(darkMode ? #colorLiteral(red: 0.1543801048, green: 0.1543801048, blue: 0.1543801048, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).edgesIgnoringSafeArea(.all)
            
        VStack{
            HStack{
                VStack(spacing: 2){
                    Text("dark mode")
                        .font(.system(size: 12))
                Button(action: {
                    withAnimation(Animation.easeInOut){
                    darkMode.toggle()
                    }
                }, label: {
        
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(darkMode ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                        HStack{
                            if !darkMode{
                                Circle()
                                    .frame(width: 17.5, height: 17.5)
                                    .foregroundColor(Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.8))
                                Spacer()
                            } else{
                                Spacer()
                                Circle()
                                    .frame(width: 17.5, height: 17.5)
                                    .foregroundColor(Color.green.opacity(0.8))
                               
                            }
                        }
                        .padding(.horizontal, 2.5)
                    }
                    .frame(width: 50, height: 25)
                })}
                Spacer()
                Button(action: {
                    withAnimation(Animation.easeIn){
                        showAddView.toggle()
                    }
               
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 28))
                        .foregroundColor(Color.blue)
                       
                })
                .sheet(isPresented: $showAddView, content: {
                    AddView(showAddView: $showAddView, posts: PostModel(), darkMode: $darkMode)
                })
                
                
            }
            .overlay(Text("Realm posts")
                        .font(.system(size: 24, weight:.bold))
                        .frame(maxWidth: .infinity, alignment: .center))
            .padding()
            if post.post.isEmpty{
                Spacer()
                Text("Add some post...")
                    .font(.system(size: 24, weight: .semibold))
                Spacer()
            } else {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 15){
                    ForEach(post.post.reversed(), id: \.self){card in
                        CardView(darkMode: $darkMode, post: card)
                            .contextMenu(ContextMenu(menuItems: {
                                Button(action: {
                                    withAnimation(Animation.spring()){
                                    post.deletePost(object: card)
                                    }
                            
                                }, label: {
                                    Text("Delete post")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color.red.opacity(0.9))
                                })
                            }))
                       
                    }
                }
                .padding(.vertical)
            })
            }
        }
        .environmentObject(post)
        .onAppear(perform: {
            post.getPost()
        })
        .colorScheme(darkMode ? .dark : .light)
        }
    }
}

struct CardView:View{
    @Binding var darkMode: Bool
    var post: PostModel
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            VStack(alignment: .leading, spacing: 5){
                Text("Title")
                    .font(.system(size: 12, weight: .bold))
                Text(post.title!)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(darkMode ? Color.white.opacity(0.6) : Color.black.opacity(0.6))
                
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 0.4)
                .foregroundColor(darkMode ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
            VStack(alignment: .leading, spacing: 5){
                Text("Body")
                    .font(.system(size: 12, weight: .bold))
                Text(post.body!)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(darkMode ? Color.white.opacity(0.6) : Color.black.opacity(0.6))
                
            }
            .padding(.horizontal)
        }
        .padding()
        .background(darkMode ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
        .cornerRadius(15)
        .padding(.horizontal)

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
