//
//  Gender.swift
//  Tets Table
//
//  Created by Даниил Гетманцев on 15.06.2022.
//

import Foundation

public enum Gender: CaseIterable,  Codable{
    case Male
    case Female
    case Other
    
    public var description: String {
        get {
            switch self {
            case .Male:
                return "Мужской"
            case .Female:
                return "Женский"
            case .Other:
                return "Не указан"
            }
        }
        set {
            switch newValue {
            case Gender.Male.description:
                self = .Male
            case Gender.Female.description:
                self = .Female
            default:
                self = .Other
            }
        }
    }
}
