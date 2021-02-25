

import Foundation
import RealmSwift


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
                                            encryptionKey: encKey,
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



