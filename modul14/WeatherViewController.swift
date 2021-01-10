

import UIKit
import CoreLocation
class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var weatherData = WeatherData()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text =  Persistance2.shared.cityName ?? "Город"
        statusLabel.text = Persistance2.shared.status ?? "... C°"
        weatherImage.image = UIImage(named: "\(String(describing: Persistance2.shared.image))") ?? UIImage(named: "load")
        infoLabel.text = Persistance2.shared.info ?? "Нет разрешения на геопозицию"
        startLocationManager()
}
    func updateView(){
        cityLabel.text = weatherData.name
        infoLabel.text = weatherData.weather[0].description
        statusLabel.text = "\(Int(weatherData.main.temp))°"
        weatherImage.image = UIImage(named: "\(weatherData.weather[0].icon)")
        Persistance2.shared.cityName = cityLabel.text
        Persistance2.shared.status = "\(Int(weatherData.main.temp))°"
        Persistance2.shared.image = weatherImage.description
        Persistance2.shared.info = infoLabel.text
        
    }
    
    func updateWeatherInfo(latitude: Double, longtitude: Double) {
        let session = URLSession.shared
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longtitude.description)&appid=aa85b59276439fa1df3b7b07fb1b1daa&lang=ru&units=metric")!
        let task = session.dataTask(with: url) { data, responce, error in
            guard error == nil else{
                print("DataTask error \(String(describing: error?.localizedDescription))")
                return
            }
            do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                
                DispatchQueue.main.async {
                    self.updateView()
                }
            } catch {
                print(error.localizedDescription)
            }
    }
        task.resume()
    
    }
    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.last {
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude)
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        }
    }
}
    

