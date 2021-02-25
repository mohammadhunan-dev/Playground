
import Foundation
import RealmSwift

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

