
import Foundation

class Persistance2 {
    
    static let shared = Persistance2()
    
    private let kCityNameKey = "Persistance.kCityNameKey"
    var cityName: String? {
        set { UserDefaults.standard.set (newValue, forKey: kCityNameKey) }
        get { return UserDefaults.standard.string(forKey: kCityNameKey) }
    }
    private let kStatusKey = "Persistance.kStatusKey"
    var status: String? {
        set { UserDefaults.standard.set (newValue, forKey: kStatusKey) }
        get { return UserDefaults.standard.string(forKey: kStatusKey) }
    
}
    private let kImageKey = "Persistance.kImageKey"
    var image: String? {
        set { UserDefaults.standard.set (newValue, forKey: kImageKey) }
        get { return UserDefaults.standard.string(forKey: kImageKey) }
}
    private let kinfoKey = "Persistance.kinfoKey"
    var info: String? {
        set { UserDefaults.standard.set (newValue, forKey: kinfoKey) }
        get { return UserDefaults.standard.string(forKey: kinfoKey) }
    }
}
