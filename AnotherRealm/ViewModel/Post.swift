//
//  Post.swift
//  AnotherRealm
//
//  Created by Daniil on 09.07.2021.
//

import Foundation
import RealmSwift

class Post: ObservableObject{
    @Published var post: [PostModel] = []
    let realm = try! Realm()
    func getPost(){
       let result = realm.objects(PostModel.self)
        self.post = result.compactMap({ (posts) -> PostModel? in
            return posts
        })
    }
    func addPost(object: PostModel){
       try! realm.write{
        realm.add(object.self)
        getPost()
        }
    }
    func deletePost(object: PostModel){
        try! realm.write{
                realm.delete(object.self)
                getPost()
        }
    }
}
