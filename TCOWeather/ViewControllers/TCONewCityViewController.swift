//
//  TCONewCityViewController.swift
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/22/16.
//  Copyright © 2016 neilg. All rights reserved.
//

import UIKit

class TCONewCityViewController: TCOBaseViewController {
  @IBOutlet weak var textField:UITextField?
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      self.title = "New City".localized()
      // Do any additional setup after loading the view.
      
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(TCONewCityViewController.createCity(_:)))
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    textField?.becomeFirstResponder()
  }
    
  func createCity(sender:AnyObject) {
    if textField!.text == nil {
      return;
    }
    
    if textField?.text!.characters.count > 0 {
      var city:TCOCity?
      
      if let oldCity = TCOCity.TCO_findFirstWithPredicate(NSPredicate(format: "name ==[c] %@", textField!.text!), sortDescriptors: nil, inContext: ctx) as? TCOCity {
        city = oldCity;
      } else {
        if let newCity = TCOCity.TCO_createEntityInContext(ctx) as? TCOCity {
          city = newCity
        }
      }
      
      if let c = city {
        c.name = textField!.text
        self.dismissViewControllerAnimated(true, completion: nil)
      }
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

}
