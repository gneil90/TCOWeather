//
//  ViewController.swift
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

import UIKit

struct TCONotification {
  struct Location {
    static let DidUpdate = "TCONotification.Location.DidUpdate"
  }
  
  struct City {
    static let DidUpdate = "TCONotification.City.DidUpdate"
  }
}

class TCOBaseViewController: UIViewController {
  
  var ctx:NSManagedObjectContext {
    get {
     return RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext
    }
  }

  @IBOutlet weak var backgroundImageView:UIImageView?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    backgroundImageView?.addDefaultParallax()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func closePressed(sender:AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

}

