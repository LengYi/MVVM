//
//  ViewController.swift
//  MVVM
//
//  Created by ice on 2021/3/4.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    @IBOutlet weak var coordLabel: UILabel!
    
    private let apiManager = APIManager()
    
    private(set) var windViewModel: WindViewModel?
    
    var searchResult: CurrentWeather? {
        didSet {
            guard let searchResult = self.searchResult else { return }
            windViewModel = WindViewModel.init(currentWeather: searchResult)
            DispatchQueue.main.async {
                self.updateLabels()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getWeather()
    }
}

extension ViewController {
    
    private func getWeather() {
        apiManager.getWeather() { (weather, error) in
            if let error: Error = error {
                print("Get weather error: \(error.localizedDescription)")
                return
            }
            
            guard let weather = weather  else { return }
            self.searchResult = weather
        }
    }
    
    private func updateLabels() {
        
        guard let windViewModel = windViewModel else { return }
        
        locationLabel.text = windViewModel.locationString
        windSpeedLabel.text = windViewModel.windSpeedString + " m/s"
        windDirectionLabel.text = windViewModel.windDegString
        coordLabel.text = windViewModel.coordString
    }
}

