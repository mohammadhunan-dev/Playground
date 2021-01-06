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
        let object = TestObject()
        try! realm.write {
            realm.add(object)
        }
        let list = List<TestObject>()
        list.append(object)
        let expectation = XCTestExpectation()
        DispatchQueue.init(label: "queue1").async {
            let realm = try! Realm()
            try! realm.write {
                for object in list {
                    realm.delete(object)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
}
