//
//  TCOForecastTableViewCell.swift
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

import UIKit

class TCOForecastTableViewCell: TCOBaseTableViewCell {
  static let TCOForecastTableViewCellIdentifier = "cell"
  
  @IBOutlet weak var iconImageView:UIImageView?
  @IBOutlet weak var dateLabel:UILabel?
  @IBOutlet weak var tempLabel:UILabel?

  override class func cellIdentifier() -> String {
    return TCOForecastTableViewCell.TCOForecastTableViewCellIdentifier
  }
}
