//
//  ContentView.swift
//  FunctionsPlayground
//
//  Created by Dominic Frei on 13/01/2021.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    let app = App(id: "functions-gjsvg")
    @MongoCallable<Foo> var foo
    
    var body: some View {
        Button("Update") {
            let anonymousCredentials = Credentials.anonymous
            App(id: "functions-gjsvg").login(credentials: anonymousCredentials) { (loginResult) in
                switch loginResult {
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                case .success(let user):
                    print("Successfully logged in as user \(user)")
                    assert(App(id: "functions-gjsvg").currentUser != nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        assert(App(id: "functions-gjsvg").currentUser != nil)
                        App(id: "functions-gjsvg").currentUser!.functions.function0([1, 2]) { sum, error in
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
            }
        }
        Text("\(foo.count)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
