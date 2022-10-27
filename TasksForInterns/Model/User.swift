//
//  DataModel.swift
//  Tets Table
//
//  Created by Даниил Гетманцев on 09.06.2022.
//

import Foundation

struct User: Codable{
    var name: String
    var surName: String
    var middleName: String?
    var dateOfBirth : Date
    var gender: Gender
    
    init() {
        name = ""
        surName = ""
        middleName = ""
        dateOfBirth = Date()
        gender = Gender.Other
    }
}

extension User{
    
    enum Constants{
        static let key: String = "userData"
    }
    
    func responseUserData(_ userData: User){
        if let data = try? JSONEncoder().encode(userData){
            UserDefaults.standard.setValue(data, forKey: Constants.key)
        }
    }

    static func requestUserData() -> User?{
        if let data = UserDefaults.standard.object(forKey: Constants.key) as? Data{
            if let dataUd = try? JSONDecoder().decode(User.self, from: data){
                return dataUd
            }
        }
        return nil
    }
}
