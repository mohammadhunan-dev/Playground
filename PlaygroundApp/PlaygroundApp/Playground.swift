//
//  Playground.swift
//  PlaygroundApp
//
//  Created by Dominic Frei on 22/01/2021.
//

import Foundation
import RealmSwift

class Int1Object: Object {
    @objc dynamic var id: Int = 0
}
class Int2Object: Object {
    @objc dynamic var id: Int = 0
}
class Int3Object: Object {
    @objc dynamic var id: Int = 0
}
class Int4Object: Object {
    @objc dynamic var id: Int = 0
}
class Int5Object: Object {
    @objc dynamic var id: Int = 0
}

class TestObject: Object {
    @objc dynamic var id = UUID().uuidString
    let int1Objects: [Int1Object]? = [Int1Object(), Int1Object(), Int1Object()]
    let int2Objects: [Int2Object]? = [Int2Object(), Int2Object(), Int2Object()]
    let int3Objects: [Int3Object]? = [Int3Object(), Int3Object(), Int3Object()]
    let int4Objects: [Int4Object]? = [Int4Object(), Int4Object(), Int4Object()]
    let int5Objects: [Int5Object]? = [Int5Object(), Int5Object(), Int5Object()]
    override class func primaryKey() -> String? {
        return "id"
    }
}

struct Playground {
    
    static func execute() {
        let realm = try! Realm()
        var array = [TestObject]()
        for _ in 0..<500_000 {
            array.append(TestObject())
        }
        try! realm.write {
            realm.add(array)
        }
        print(realm.objects(TestObject.self).count)
    }
    
}
