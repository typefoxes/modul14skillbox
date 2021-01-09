
import Foundation

class Persistance {
    
    static let shared = Persistance()
    private let kUserNameKey = "Persistance.kUserNameKey"
    var userName: String? {
        set { UserDefaults.standard.set (newValue, forKey: kUserNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserNameKey) }
    }
    private let kUserLastNameKey = "Persistance.kUserLastNameKey"
    var userLastName: String? {
        set { UserDefaults.standard.set (newValue, forKey: kUserLastNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserLastNameKey) }
    
}
}
