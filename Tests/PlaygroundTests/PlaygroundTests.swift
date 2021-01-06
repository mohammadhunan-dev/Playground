import XCTest
import RealmSwift

class TestObject: Object {
    @objc dynamic var foo = 1
}

final class PlaygroundTests: XCTestCase {
    
    var notificationToken: NotificationToken? = nil
    let expectation1 = XCTestExpectation()
    let expectation2 = XCTestExpectation()
    
    override func setUp() {
        _ = try! Realm.deleteFiles(for: Realm.Configuration.defaultConfiguration)
    }
    
    func testExample() {
        let realm = try! Realm()
        let results = realm.objects(TestObject.self)
        notificationToken = results.observe { (changes: RealmCollectionChange) in
                    switch changes {
                    case .initial:
                        print("Initial: \(changes)")
                        self.expectation1.fulfill()
                    case .update(let items, let deletions, let insertions, let modifications):
                        print("items: \(items)")
                        print("deletions: \(deletions)")
                        print("insertions: \(insertions)")
                        print("modifications: \(modifications)")
                        self.expectation2.fulfill()
                    case .error(let error):
                        fatalError("\(error)")
                    }
                }
        
        let object1 = TestObject()
        let object2 = TestObject()
        
        try! realm.write {
            realm.add(object1)
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 3.0)
        
        try! realm.write {
            realm.delete(object1)
            realm.add(object2)
        }
        wait(for: [expectation2], timeout: 3.0)
    }
    
}
