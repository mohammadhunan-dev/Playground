import XCTest
import RealmSwift

class TestObject: Object, Decodable {
    @objc dynamic var nonOptionalString: String = ""
    dynamic var optionalDouble = RealmOptional<Double>()
    enum CodingKeys: String, CodingKey {
        case nonOptionalString
        case optionalDouble
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nonOptionalString = try container.decode(String.self, forKey: .nonOptionalString)
        optionalDouble = try container.decode(RealmOptional<Double>.self, forKey: .optionalDouble)
        super.init()
    }
    required override init() { super.init() }
    override static func primaryKey() -> String? { return "nonOptionalString" }
}

final class PlaygroundTests: XCTestCase {
    
    override func setUp() {
        _ = try! Realm.deleteFiles(for: Realm.Configuration.defaultConfiguration)
    }
    
    override func tearDown() {
        _ = try! Realm.deleteFiles(for: Realm.Configuration.defaultConfiguration)
    }
    
    func testExamplePass() {
        do {
            guard let path = Bundle.module.path(forResource: "examplePass", ofType: "json") else {
                XCTFail("Path must not be nil.")
                return
            }
            
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let user = try JSONDecoder().decode(TestObject.self, from: data)
            
            XCTAssertEqual(user.nonOptionalString, "foo")
            XCTAssertEqual(user.optionalDouble, RealmOptional<Double>(42))
            
            let realm = try Realm()
            try realm.write {
                realm.add(user)
            }
            
        } catch let error {
            XCTFail(String(describing: error))
        }
    }
    
    func testExamplePassFail() {
        do {
            guard let path = Bundle.module.path(forResource: "exampleFail", ofType: "json") else {
                XCTFail("Path must not be nil.")
                return
            }
            
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let user = try JSONDecoder().decode(TestObject.self, from: data)
            
            XCTAssertEqual(user.nonOptionalString, "foo")
            XCTAssertEqual(user.optionalDouble, RealmOptional<Double>(42))
            
            let realm = try Realm()
            try realm.write {
                realm.add(user)
            }
            
        } catch let error {
            XCTFail(String(describing: error))
        }
    }
    
}
