//
//  UserDao.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation
import RealmSwift

// CRUD operation...
class UserDao {
    // Singleton
    static let shared = UserDao()
    
    private init() { }
    
    // save user
    func saveUserInfo(user: UserVO) {
        do {
            let realm = try Realm()
            
            try realm.write({
                realm.deleteAll()
                realm.add(user.toUserObject(), update: .all)
            })
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error \(error) \(error.userInfo)")
        }
    }
    
    // set City
    func setUserCity(token: String, cityID: Int) {
        do {
            let realm = try Realm()
            let object = realm.objects(UserObject.self).first

            try realm.write({
                object?.city = cityID
                let newObject = realm.create(UserObject.self, value: object ?? UserObject(), update: .all)
                realm.add(newObject, update: .all)
            })
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error \(error) \(error.userInfo)")
        }
    }
    
    // get User
    func getUserInfo() -> UserVO? {
        do {
            let realm = try Realm()
            let userObject = realm.objects(UserObject.self).first
            return userObject?.toUserVO()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error \(error) \(error.userInfo)")
        }
    }
    
    // get user token
    func getUserToken() -> String {
        do {
            let realm = try Realm()
            let object = realm.objects(UserObject.self).first
            let user = object?.toUserVO()
            return "Bearer \(user?.token ?? "undefined")"
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error \(error) \(error.userInfo)")
        }
    }
    
}
