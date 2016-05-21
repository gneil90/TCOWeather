//
//  TCOCityListViewController.swift
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//

import UIKit

class TCOCityListViewController: TCOBaseViewController {
  @IBOutlet weak var tableView:UITableView!

  var cities = [TCOCity]()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "City".localized()
        // Do any additional setup after loading the view.
      
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(TCOCityListViewController.addCity(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if let results = TCOCity.TCO_findWithPredicate(nil, sortDescriptors: [NSSortDescriptor(key:"name", ascending: false)], inContext: ctx) as? [TCOCity] {
      cities = results
      tableView.reloadData()
    }
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  
  func addCity(sender:AnyObject) {
    if let controller = self.storyboard?.instantiateViewControllerWithIdentifier(String(TCONewCityViewController)) {
      self.navigationController?.pushViewController(controller, animated: true)
    }

  }
  //MARK: UITableView datasource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cities.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let settings = TCOUserSettings.sharedSettingsInContext(ctx)

    let cell = tableView.dequeueReusableCellWithIdentifier(TCOBaseTableViewCell.cellIdentifier())
    let city = cities[indexPath.row]
    
    if let name = city.name {
      if name == settings.locationName {
        cell?.accessoryType = .Checkmark
      } else {
        cell?.accessoryType = .None
      }
      cell?.textLabel?.text = name
    }
    cell?.selectionStyle = .None

    
    return cell!
  }

  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    self.tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    resetChecks()
    self.tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
    
    let settings = TCOUserSettings.sharedSettingsInContext(ctx)
    let city = cities[indexPath.row]
    settings.locationName = city.name

    dispatch_async(dispatch_get_main_queue()) { 
      self.dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  func resetChecks() {
    if let visibleIndexPaths = self.tableView.indexPathsForVisibleRows {
      for indexPath in visibleIndexPaths {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
          cell.accessoryType = .None
        }
      }
    }
  }

}
