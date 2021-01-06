import XCTest
import RealmSwift

class TestObject: Object {
    @objc dynamic var foo = 1
}

final class PlaygroundTests: XCTestCase {
    
    override func setUp() {
        _ = try! Realm.deleteFiles(for: Realm.Configuration.defaultConfiguration)
    }
    
    override func tearDown() {
        _ = try! Realm.deleteFiles(for: Realm.Configuration.defaultConfiguration)
    }
    
    func testExample() {
        let realm = try! Realm()
        
    }
    
}
