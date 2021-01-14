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

extension RealmSwift.User {
    
    func function() {
        self.functions.function0([1, 2]) { sum, error in
            guard error == nil else {
                print("Function call failed: \(String(describing: error))")
                return
            }
            guard case let .double(value) = sum else {
                print("Unexpected non-double result: \(sum ?? "nil")");
                return
            }
            print("Called function 'sum' and got result: \(value)")
            assert(value == 3)
        }
    }
    
}
