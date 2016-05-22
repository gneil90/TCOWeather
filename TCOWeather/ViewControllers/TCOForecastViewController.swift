//
//  TCOForecastViewController.swift
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

import UIKit

class TCOForecastViewController: TCOBaseViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView:UITableView?
  var forecast = [TCOCondition]()
  var city:TCOCity?
  
  override func viewDidLoad() {
   super.viewDidLoad()
    
    
    let settings = TCOUserSettings.sharedSettingsInContext(ctx)
    
    if settings.locationName! == TCOSettingsLocationMy {
      city = TCOCity.myCityInContext(ctx)
    } else {
      city = TCOCity(name: settings.locationName!, inContext: ctx)
    }
    fetchHourlyForecast()

  }
  
  func fetchHourlyForecast() {
    let settings = TCOUserSettings.sharedSettingsInContext(ctx)
    
    if let name = settings.locationName {
      if name == TCOSettingsLocationMy {
        if let location = TCOLocationService.sharedManager().currentLocation {
          OWMClient.sharedWeatherClient.fetchHourlyForecast(location.coordinate, completion: {[weak self] (success, results) in
            self?.handleForecastResponse(success, results: results)
          })
        }
      } else {
        OWMClient.sharedWeatherClient.fetchHourlyForecastForCity(name, completion: {[weak self] (success, results) in
          self?.handleForecastResponse(success, results: results)
        })
      }
    }
  }
  
  func handleForecastResponse(success:Bool, results:RKMappingResult?) {
    if let mapping = results {
      if let conditions = mapping.array() as? [TCOCondition] {
        self.forecast.removeAll()
        self.forecast.appendContentsOf(conditions)
        self.tableView?.reloadData()
        
        city?.addConditions(Set(conditions))
        
        for object in self.forecast {
          object.locationName = city?.name
        }
      }
    } else {
      if city != nil {
        if let name = city!.name {
          if let backupResults = TCOCondition.TCO_findWithPredicate(NSPredicate(format:"city.name ==[c] %@", name), sortDescriptors: [NSSortDescriptor(key:"date", ascending: true)], fetchLimit:12, inContext: ctx) as? [TCOCondition] {
            forecast = backupResults
            self.tableView?.reloadData()
          }
        }
      }
    }
    
  }
  
  //MARK: IBAction
  
  @IBAction func changeCityPressed(sender:AnyObject) {
    if let controller = self.storyboard?.instantiateViewControllerWithIdentifier(String(TCOCityListViewController)) {
      self.navigationController?.pushViewController(controller, animated: true)
    }
  }

  //MARK: UITableView datasource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return forecast.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(TCOForecastTableViewCell.cellIdentifier()) as! TCOForecastTableViewCell
    let condition = forecast[indexPath.row]
    
    cell.tempLabel?.text = String(format: "%@°", String(condition.temperature?.integerValue ?? 0))
    cell.dateLabel?.text = TCOWeatherDateFormatter.sharedFormatter().forecastFormattedStringFromDate(condition.date)
    if let imageName = condition.icon {
      cell.iconImageView?.image = UIImage(named: imageName)
    }

    return cell
  }
}
