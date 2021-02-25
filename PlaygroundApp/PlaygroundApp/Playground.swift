//
//  Playground.swift
//  PlaygroundApp
//
//  Created by Dominic Frei on 22/01/2021.
//

import Foundation
import RealmSwift

class IntObject: Object {
    @objc dynamic var id: Int = 0
}

struct Playground {
    
    static func execute() {
//        // Generate a random encryption key
//        var key = Data(count: 64)
//        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
//            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!) }
//        // Configure for an encrypted realm
//        let config = Realm.Configuration(encryptionKey: key)
//        do {
//            // Open the encrypted realm
//            let realm = try Realm(configuration: config)
//            // ... use the realm as normal ...
//
//            try realm.write {
//                for _ in 0..<10000 {
//                    realm.add(IntObject())
//                }
//            }
//
//            print(realm.objects(IntObject.self).count)
//
//        } catch let error as NSError {
//            // If the encryption key is wrong, `error` will say that it's an invalid database
//            fatalError("Error opening realm: \(error.localizedDescription)")
//        }
        
        addRecordsTapped()
    }
    
    static func addRecordsTapped() {
        
        do {
            for _ in stride(from: 0, to: 10000, by: 1) {
                _ = try addPerson(firstName: "John", lastName: "Low", dateOfBirth: Int64(Date().timeIntervalSince1970), height: 170, weight: 80)
            }
            print(RealmDatabase.shared.realm.objects(PersonEntity.self).count)
        }catch {
            print("error: addRecordsTapped: \(error.localizedDescription)")
        }
        
    }
    
    static func addPerson(firstName: String, lastName: String, dateOfBirth: Int64, height: Double, weight: Double) throws -> PersonEntity {
        
        let realm = RealmDatabase.shared.realm
        
        do {
            let person = PersonEntity(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, height: height, weight: weight)
            
            try realm.write {
                realm.add(person, update: .all)
            }
            return person
        } catch let error {
            print("error: \(error.localizedDescription)")
            throw error
        }
    }
    
}

public class RealmDatabase {
    
    static let shared = RealmDatabase()
    
    let key: String = "f14d66df41ca84ecf1371b443277a0e55a3134df286187435a7a8f611d5ddd49abf002a085bbbe1dbe2b6f802c248e7ff13f2e572f41a52534f7f4cbc4d9b990"
    var encKey: Data {
        return Data(hexString: key)!
    }
    
    /// Realm database file
    static let filename = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)[0].appendingPathComponent("example.realm")
    
    static let currentSchemaVersion: UInt64 = 1
    
    /// List of Entities being initialize
    private static let objectTypes: [Object.Type] = [PersonEntity.self]
    
    /// Private initializer
    private init() {
        print("DB Path: - \(RealmDatabase.filename)")
    }
    
    /// Reference to Realm database
    var realm: Realm {
        
        var configuration: Realm.Configuration

        // comment line 38 "encryptionkey" to test without encryption
        configuration = Realm.Configuration(fileURL: RealmDatabase.filename,
//                                            encryptionKey: encKey,
                                            schemaVersion: RealmDatabase.currentSchemaVersion,
                                            migrationBlock: nil,
                                            deleteRealmIfMigrationNeeded: true,
                                            objectTypes: RealmDatabase.objectTypes)

        do {
            return try Realm(configuration: configuration)
        } catch {
            print("RealmDatabase: Failed to get a Realm reference, error=\(error)")
            return try! Realm(configuration: configuration)
        }
    }
    
    
}




class PersonEntity: Object {
    
    @objc private dynamic var _id: String = UUID().uuidString
    @objc private dynamic var _firstName: String = ""
    @objc private dynamic var _lastName: String = ""
    @objc private dynamic var _dateOfBirth: Int64 = 0
    @objc private dynamic var _height: Double = 0
    @objc private dynamic var _weight: Double = 0
    
    
    internal convenience init(firstName: String, lastName: String, dateOfBirth: Int64, height: Double, weight: Double) {
        self.init()
        
        _firstName = firstName
        _lastName = lastName
        _dateOfBirth = dateOfBirth
        _height = height
        _weight = weight
    }
    
    
    public var firstName: String {
        return _firstName
    }

    public var lastName: String {
        return _lastName
    }
    
    public var dateOfBirth: Int64 {
        return _dateOfBirth
    }
    
    public var height: Double {
        return _height
    }
    
    public var weight: Double {
        return _weight
    }
    
    public override static func primaryKey() -> String? {
        return "_id"
    }
}


extension Data {

    init?(hexString: String) {
        let length = hexString.count / 2
        var data = Data(capacity: length)
        for i in 0..<length {
            let j = hexString.index(hexString.startIndex, offsetBy: i * 2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
}
