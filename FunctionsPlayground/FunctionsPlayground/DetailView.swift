//
//  foo.swift
//  FunctionsPlayground
//
//  Created by Dominic Frei on 14/01/2021.
//

import SwiftUI
import RealmSwift

struct DetailView: View {
    
    @Environment(\.realmApp) var app
    
    var body: some View {
        Button("Function") {
            app.currentUser!.function()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
