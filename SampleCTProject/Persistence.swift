//
//  Persistence.swift
//  SampleCTProject
//
//  Created by Max Balsam  Margolis on 6/18/25.
//

import Foundation

extension UserDefaults {
    static let group = UserDefaults(suiteName: "group.clevertap.sample1")
}

enum UserDefaultsKeys {
    static let loggedInUserPropertiesKey = "loggedInUserProperties"
}
