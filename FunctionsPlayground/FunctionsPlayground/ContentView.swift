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
    
    var body: some View {
        NavigationView {
            VStack {
                let detailView = DetailView().environment(\.realmApp, app)
                NavigationLink(destination: detailView) {
                    Text("Environment Access")
                }
                Button("Direct Access") {
                    app.currentUser?.function()
                }
            }
        }.onAppear() {
            let anonymousCredentials = Credentials.anonymous
            app.login(credentials: anonymousCredentials) { (result) in
                switch result {
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                case .success(let user):
                    print("Successfully logged in as user \(user)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
