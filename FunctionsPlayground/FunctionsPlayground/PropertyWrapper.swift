//
//  PropertyWrapper.swift
//  FunctionsPlayground
//
//  Created by Dominic Frei on 14/01/2021.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

struct Foo: Identifiable {
    var id: ObjectIdentifier
}

@propertyWrapper struct MongoCallable<T>: DynamicProperty where T: Identifiable {
    @Environment(\.realmApp) var app
    @State var result: [T] = []
    @State var token: AnyCancellable?
    //    init(database: String, collection: String) {
    //
    //    }
    init() {
        fetch()
    }
    var wrappedValue: [T] {
        result
    }
    func retry() {
        fetch()
    }
    func fetch() {
        token?.cancel()
        token = app.currentUser?
            .functions.featuredCars([AnyBSON]())
            .receive(on: RunLoop.main)
            .replaceError(with: .document([:]))
            .map({ output -> [T] in
                //                if case let .array(items) = output {
                //                    return items.map { T(from: $0!.documentValue!) }
                //                }
                return [T]()
            })
            .assign(to: \.result, on: self)
    }
}
