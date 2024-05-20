//
//  ViewController.swift
//  My Weather
//
//  Created by Zukhruf . on 19/01/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //Mark:- Otlets / Properties
    
    @IBOutlet var table: UITableView!
    var models = [Weather]()
    let loacationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    //Mark:- Intials
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setuplocation()
    }
    
    //Mark:- Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    //Mark:- Location
    
    func setuplocation() {
        
        loacationManager.delegate = self
        loacationManager.requestWhenInUseAuthorization()
        loacationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            loacationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {return}
        let longitude = currentLocation.coordinate.longitude
        let latitude = currentLocation.coordinate.latitude
        let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(latitude),\(longitude)?exclude=[flags,minutely]"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data,response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
        })
    }
    

}

struct Weather: Codable {
    
    let something: String
}

