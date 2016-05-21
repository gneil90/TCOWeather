//
//  String+TCOMethod.swift
//  TCOWeather
//
//  Created by Neil Galiaskarov on 5/21/16.
//  Copyright © 2016 neilg. All rights reserved.
//

import Foundation
import UIKit

extension String {
  func localized() -> String {
    return NSLocalizedString(self, comment: "");
  }
}
