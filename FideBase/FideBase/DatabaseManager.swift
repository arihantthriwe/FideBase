//
//  DatabaseManager.swift
//  FideBase
//
//  Created by Arihant Thriwe on 06/09/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    
}

// MARK: - Account Management

extension DatabaseManager{
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)){
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else{
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    ///Inserts new user to database
    public func insertUser(with user: ChatAppUser){
        database.child(user.safeEmail).setValue([
            "name": user.name,
            "group_name": user.groupName,
            "date_of_birth": user.dateOfBirth
        ])
    }

}

struct ChatAppUser {
    let name: String
    let emailAddress: String
    let groupName: String
    let dateOfBirth: String
    
    var safeEmail: String{
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
