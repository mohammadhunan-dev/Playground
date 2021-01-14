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
            let anonymousCredentials = Credentials.anonymous
            App(id: "functions-gjsvg").login(credentials: anonymousCredentials) { (loginResult) in
                switch loginResult {
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                case .success(let user):
                    print("Successfully logged in as user \(user)")
                }
            }
            return self[AppKey.self]
        }
        set {
            self[AppKey.self] = newValue
        }
    }
}
