import XCTest
import RealmSwift

class TestObject: Object {
    @objc dynamic var foo = 1
}

final class PlaygroundTests: XCTestCase {
    
    override func setUp() {
        _ = try! Realm.deleteFiles(for: Realm.Configuration.defaultConfiguration)
    }
    
    func testExample() {
        let realm = try! Realm()
        let objects = [TestObject()]
        try! realm.write {
            realm.add(objects)
        }
        let threadSafeObjects = objects.map{ ThreadSafeReference(to: $0) }
        let expectation = XCTestExpectation()
        DispatchQueue.init(label: "queue1").async {
            let realm = try! Realm()
            try! realm.write {
                threadSafeObjects.forEach { (threadSafeObject: ThreadSafeReference<TestObject>) in
                    realm.delete(realm.resolve(threadSafeObject)!)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
}
