import XCTest
import RealmSwift

final class CodableObject: Object, Codable {
    var doubleOpt = RealmOptional<Double>()
    var doubleOptNoKey = RealmOptional<Double>()
}

extension JSONDecoder {
    open func decode<T>(_ type: T.Type, from data: Data, allowMissingKeys: Bool) throws -> T where T: Object, T: Codable {
        var jsonObject = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        if var jsonDictionary = jsonObject as? [String: Any] {
            let mirror = Mirror(reflecting: type.init())
            for child in mirror.children {
                if let label = child.label {
                    if !jsonDictionary.keys.contains(label) {
                        switch child.value {
                        case is RealmOptional<Int>:
                            jsonDictionary[label] = Int()
                        case is RealmOptional<Int8>:
                            jsonDictionary[label] = Int8()
                        case is RealmOptional<Int16>:
                            jsonDictionary[label] = Int16()
                        case is RealmOptional<Int32>:
                            jsonDictionary[label] = Int32()
                        case is RealmOptional<Int64>:
                            jsonDictionary[label] = Int64()
                        case is RealmOptional<Float>:
                            jsonDictionary[label] = Float()
                        case is RealmOptional<Double>:
                            jsonDictionary[label] = Double()
                        case is RealmOptional<Bool>:
                            jsonDictionary[label] = Bool()
                        default:
                            // Only the `RealmOptional` type is relevant here.
                            break
                        }
                    }
                }
            }
            jsonObject = jsonDictionary
        }
        let newData = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
        return try self.decode(type, from: newData)
    }
}

final class PlaygroundTests: XCTestCase {
    
    func testCodableObjectRealm() {
        let str = "{ \"doubleOpt\": 23 }"
        do {
            let decodedObject = try JSONDecoder().decode(CodableObject.self, from: Data(str.utf8), allowMissingKeys: true)
            XCTAssertEqual(decodedObject.doubleOpt.value, 23)
            XCTAssertEqual(decodedObject.doubleOptNoKey.value, 0)
        } catch let error {
            XCTFail(String(describing: error))
        }
    }
    
}
