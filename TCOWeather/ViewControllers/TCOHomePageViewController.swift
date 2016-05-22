//
//  TCOHomePageViewController.swift
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

import UIKit

enum TCODisplayOption:Int {
  case ByLocation,
  ByCityInput
}

class TCOHomePageViewController: TCOBaseViewController {
  @IBOutlet weak var iconImageView:UIImageView?
  @IBOutlet weak var temperatureLabel:UILabel?
  @IBOutlet weak var conditionsLabel:UILabel?
  @IBOutlet weak var hiloLabel:UILabel?
  @IBOutlet weak var cityLabel:UILabel?
  
  var currentCondition:TCOCondition? {
    didSet {
      self.updateUI()
    }
  }
  var currentDisplayOption:TCODisplayOption = .ByLocation {
    didSet {
      if currentDisplayOption == .ByLocation {
        TCOLocationService.sharedManager().findCurrentLocation();
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TCOHomePageViewController.locationDidUpdate(_:)), name: TCONotification.Location.DidUpdate, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TCOHomePageViewController.fetchCurrentWeatherCondition), name: TCONotification.City.DidUpdate, object: nil)

    TCOLocationService.sharedManager().findCurrentLocation();
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    fetchCurrentWeatherCondition()
  }
  
  func updateUI() {
    if let condition = currentCondition {
      cityLabel?.text = condition.locationName ?? "Loading...".localized()
      temperatureLabel?.text = String(format: "%@°", String(condition.temperature?.integerValue ?? 0))
      
      hiloLabel?.text = String(format: "%@° / %@°", String(condition.tempLow?.integerValue ?? 0), String(condition.tempHigh?.integerValue ?? 0))
      
      if let imageName = condition.icon {
        iconImageView?.image = UIImage(named: imageName)
      }
      
      conditionsLabel?.text = condition.weather_description;
    }
  }
  
  func fetchCurrentWeatherCondition() {
    
    let settings = TCOUserSettings.sharedSettingsInContext(ctx)
    
    if let name = settings.locationName {
      if name == TCOSettingsLocationMy {
        if let location = TCOLocationService.sharedManager().currentLocation {
          OWMClient.sharedWeatherClient.fetchCurrentConditionsForLocation(location.coordinate, completion: {[weak self] (success, results) in
            self?.handleCurrentWeatherResponse(success, results: results);
            })
        }
      } else {
        OWMClient.sharedWeatherClient.fetchCurrentConditionsForCity(name, completion: {[weak self] (success, results) in
          self?.handleCurrentWeatherResponse(success, results: results);
        })
      }
    }
  }
  
  func handleCurrentWeatherResponse(success:Bool, results:RKMappingResult?) {
    let settings = TCOUserSettings.sharedSettingsInContext(ctx)
    if success {
      if let condition = results!.firstObject as? TCOCondition {
        if TCOSettingsLocationMy == settings.locationName!  {
          settings.lastKnownLocation = condition.locationName
        }
        self.currentCondition = condition
      }
    } else {
      var name = settings.locationName;
      if TCOSettingsLocationMy == settings.locationName!  {
        if let lastKnownLocation = settings.lastKnownLocation {
          name = lastKnownLocation;
        }
      }
      if name != nil  {
        if let result = TCOCondition.TCO_findFirstWithPredicate(NSPredicate(format:"locationName ==[c] %@ AND date <= %@", name!, NSDate()), sortDescriptors: [NSSortDescriptor(key:"date", ascending: false)], inContext: ctx) as? TCOCondition {
          currentCondition = result
        }
      }
    }
  }
  
  //MARK: Notifications
  
  func locationDidUpdate(aNote:NSNotification) {
    fetchCurrentWeatherCondition()
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
}
