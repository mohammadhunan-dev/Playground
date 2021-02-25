

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addRecordsTapped(_ sender: Any) {
        
        do {
            for _ in stride(from: 0, to: 30000, by: 1) {
                _ = try addPerson(firstName: "John", lastName: "Low", dateOfBirth: Int64(Date().timeIntervalSince1970), height: 170, weight: 80)
            }
            print(RealmDatabase.shared.realm.objects(PersonEntity.self).count)
        }catch {
            print("error: addRecordsTapped: \(error.localizedDescription)")
        }
        
    }
    
    func addPerson(firstName: String, lastName: String, dateOfBirth: Int64, height: Double, weight: Double) throws -> PersonEntity {
        
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
