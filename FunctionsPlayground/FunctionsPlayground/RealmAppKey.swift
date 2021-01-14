//
//  RealmAppKey.swift
//  FunctionsPlayground
//
//  Created by Dominic Frei on 14/01/2021.
//

import SwiftUI
import RealmSwift

struct AppKey: EnvironmentKey {
    typealias Value = RealmSwift.App
    static var defaultValue = App(id: "functions-gjsvg")
}

extension EnvironmentValues {
    var realmApp: RealmSwift.App {
        get {
            return self[AppKey.self]
        }
        set {
            self[AppKey.self] = newValue
        }
    }
}
