//
//  OWMClient.swift
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

enum OWMTemperature:Int {
  case Kelvin,
  Celcius,
  Fahrenheit
}

struct OWMConstant {
  struct Key {
    static let API = "52e6887c4a4084e0f0e9d149b8b75e12"
  }
  struct Base {
    static let Scheme = "http"
    static let Domain = "api.openweathermap.org"
    static let Version = "2.5"
  }
  
  struct EndPoint {
    static let WeatherByName = "/data/%@/weather?q=%@"
    static let WeatherByLocation = "/data/%@/weather?lat=%f&lon=%f"
    static let HourlyForecastByLocation = "/data/%@/forecast?lat=%f&lon=%f&cnt=12"
    static let HourlyForecastByCity = "/data/%@/forecast?q=%@&cnt=12"

  }
}

class OWMClient: NSObject {
  static let sharedWeatherClient = OWMClient()
  
  var temperatureType:OWMTemperature = .Celcius;
  
  override init () {
    super.init()    
  }
  
  func baseURL() -> NSURL? {
    let basePath = String(format: "%@://%@", OWMConstant.Base.Scheme, OWMConstant.Base.Domain)
    let baseURL = NSURL(string: basePath)
    return baseURL
  }
  
  func fetchCurrentConditionsForCity(locationName:String, completion:(success:Bool, results:RKMappingResult?) -> Void) {
    let encodedLocationName = (locationName as NSString).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    let requestPath = String(format: OWMConstant.EndPoint.WeatherByName, OWMConstant.Base.Version, encodedLocationName!)
    
    let signedPath = signPath(requestPath)

    RKObjectManager.sharedManager().getObjectsAtPath(signedPath, parameters: nil, success: { (operation, mappingResult) in
      dispatch_async(dispatch_get_main_queue(), {
        completion(success: true, results: mappingResult)
      })
      }, failure: { (operation, error) in
        dispatch_async(dispatch_get_main_queue(), {
          completion(success: false, results: nil)
        });
    })
  }
  
  func fetchCurrentConditionsForLocation(location:CLLocationCoordinate2D, completion: (success:Bool, results:RKMappingResult?) -> Void) {
    let requestPath = String(format: OWMConstant.EndPoint.WeatherByLocation, OWMConstant.Base.Version, location.latitude, location.longitude)
    let signedPath = signPath(requestPath)

    RKObjectManager.sharedManager().getObjectsAtPath(signedPath, parameters: nil, success: { (operation, mappingResult) in
        dispatch_async(dispatch_get_main_queue(), {
          if mappingResult != nil {
          }
          completion(success: true, results: mappingResult)
        })
      }, failure: { (operation, error) in
        dispatch_async(dispatch_get_main_queue(), {
          completion(success: false, results: nil)
        });
      })
  }
  
  func fetchHourlyForecastForCity(locationName:String, completion: (success:Bool, results:RKMappingResult?) -> Void) {
    let encodedLocationName = (locationName as NSString).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    let requestPath = String(format: OWMConstant.EndPoint.HourlyForecastByCity, OWMConstant.Base.Version, encodedLocationName!)
    
    let signedPath = signPath(requestPath)
    
    RKObjectManager.sharedManager().getObjectsAtPath(signedPath, parameters: nil, success: { (operation, mappingResult) in
      dispatch_async(dispatch_get_main_queue(), {
        completion(success: true, results: mappingResult)
      })
      }, failure: { (operation, error) in
        dispatch_async(dispatch_get_main_queue(), {
          completion(success: false, results: nil)
        });
    })
  }
  
  func fetchHourlyForecast(location:CLLocationCoordinate2D, completion: (success:Bool, results:RKMappingResult?) -> Void) {
    let requestPath = String(format: OWMConstant.EndPoint.HourlyForecastByLocation, OWMConstant.Base.Version, location.latitude, location.longitude)
    let signedPath = signPath(requestPath)
    
    RKObjectManager.sharedManager().getObjectsAtPath(signedPath, parameters: nil, success: { (operation, mappingResult) in
      dispatch_async(dispatch_get_main_queue(), {
        completion(success: true, results: mappingResult)
      })
    }, failure: { (operation, error) in
        dispatch_async(dispatch_get_main_queue(), {
          completion(success: false, results: nil)
        });
    })
  }
  
  //MARK: Private
  
  func signPath(path:String) -> String {
    return path.stringByAppendingString(String(format: "&APPID=%@", OWMConstant.Key.API))
  }
  
  //MARK: Class functions 
  
  class func commonRestKitInit() {
    
    // Initialize managed object model from bundle
    
    let client = OWMClient.sharedWeatherClient
    let baseURL = client.baseURL()
    let objectManager = RKObjectManager(baseURL: baseURL)
    
    let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(nil)
    let managedObjectStore = RKManagedObjectStore(managedObjectModel: managedObjectModel)
    objectManager.managedObjectStore = managedObjectStore;

    managedObjectStore.createPersistentStoreCoordinator()
    let storePath = (RKApplicationDataDirectory() as NSString).stringByAppendingPathComponent("Store.sqlite")
    var persistentStore:NSPersistentStore?
    
    do {
      persistentStore = try managedObjectStore.addSQLitePersistentStoreAtPath(storePath, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: nil)
    } catch {
      
    }
    managedObjectStore.createManagedObjectContexts()
    managedObjectStore.managedObjectCache = RKInMemoryManagedObjectCache(managedObjectContext: managedObjectStore.persistentStoreManagedObjectContext)
    
    //Current weather mapping
    
    let conditionMapping = client.createConditionMapping(managedObjectStore, includeUnique: true)
    let currentWeatherResponseDescriptor = RKResponseDescriptor(mapping: conditionMapping, method: .GET, pathPattern: "/data/2.5/weather", keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(.Successful))
    objectManager.addResponseDescriptor(currentWeatherResponseDescriptor)

    //hourly forecast mapping
    
    let hourlyForecastMapping = client.createConditionMapping(managedObjectStore, includeUnique: false)

    let hourlyForecastResponseDescriptor = RKResponseDescriptor(mapping: hourlyForecastMapping, method: .GET, pathPattern: "/data/2.5/forecast", keyPath: "list", statusCodes: RKStatusCodeIndexSetForClass(.Successful))
    objectManager.addResponseDescriptor(hourlyForecastResponseDescriptor)
  }
  

  func createConditionMapping(managedObjectStore:RKManagedObjectStore, includeUnique:Bool) -> RKEntityMapping {
    let conditionMapping = RKEntityMapping(forEntityForName: "TCOCondition", inManagedObjectStore: managedObjectStore)
    if includeUnique {
      conditionMapping.identificationAttributes = ["id_", "date"];
    }
    conditionMapping.addAttributeMappingsFromDictionary(["main.humidity":"humidity", "id":"id_", "name": "locationName", "sys.sunrise" : "sunrise", "sys.sunset" : "sunset", "wind.deg":"windBearing", "wind.speed" : "windSpeed"])
    
    let dateMappingAttribute = RKAttributeMapping(fromKeyPath: "dt", toKeyPath: "date");
    dateMappingAttribute.valueTransformer = RKValueTransformer.timeIntervalStringSince1970ToDateValueTransformer();
    dateMappingAttribute.propertyValueClass = NSDate.self
    conditionMapping.addPropertyMapping(dateMappingAttribute)
    
    let iconMappingAttribute = RKAttributeMapping(fromKeyPath: "weather.icon", toKeyPath: "icon");
    iconMappingAttribute.valueTransformer = RKValueTransformer.weatherIconNameValueTransformer();
    iconMappingAttribute.propertyValueClass = NSArray.self
    conditionMapping.addPropertyMapping(iconMappingAttribute)
    
    let descMappingAttribute = RKAttributeMapping(fromKeyPath: "weather.description", toKeyPath: "weather_description");
    descMappingAttribute.valueTransformer = RKValueTransformer.arrayToFirstObjectValueTransformer();
    descMappingAttribute.propertyValueClass = NSArray.self
    conditionMapping.addPropertyMapping(descMappingAttribute)

    
    conditionMapping.addPropertyMapping(self.createTemperatureAttributeMapping("main.temp", toKeyPath:"temperature"))
    conditionMapping.addPropertyMapping(self.createTemperatureAttributeMapping("main.temp_max", toKeyPath:"tempHigh"))
    conditionMapping.addPropertyMapping(self.createTemperatureAttributeMapping("main.temp_min", toKeyPath:"tempLow"))

    //Uncomment bellow if you want to define one-to-many relationship between Condition-Weather
    
//    let weatherMapping = RKEntityMapping(forEntityForName: "TCOWeather", inManagedObjectStore: managedObjectStore)
//    weatherMapping.identificationAttributes = ["id_"]
//    weatherMapping.addAttributeMappingsFromDictionary(["description":"weather_description", "main":"main", "id":"id_", "icon" : "icon"])
//    
//    
//    let relationWeatherMapping = RKRelationshipMapping(fromKeyPath: "weather", toKeyPath: "weatherSet", withMapping: weatherMapping)
//    conditionMapping.addPropertyMapping(relationWeatherMapping)
    
    return conditionMapping
  }
  
  func createTemperatureAttributeMapping(fromKeyPath:String, toKeyPath:String) -> RKAttributeMapping {
    let temperatureAttribute = RKAttributeMapping(fromKeyPath: fromKeyPath, toKeyPath: toKeyPath)
    temperatureAttribute.valueTransformer = RKValueTransformer.degreeValueToCelciusTransformer();
    temperatureAttribute.propertyValueClass = NSNumber.self
    return temperatureAttribute;
  }

  class func saveMainContextChanges() {
    let ctx = RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext
    do {
      try ctx.save()
    } catch {
      
    }
  }

}
