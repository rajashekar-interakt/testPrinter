//
//  ding.swift
//  Dprint
//
//  Created by lappy on 20/09/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import UIKit


@objc(Bulb)
class Bulb: NSObject {
  
  @objc static var isOn = false
  
  @objc static func requiresMainQueueSetup() -> Bool {  return true}
  
  @objc func turnOn() {
    Bulb.isOn = true
    
  }
  
  @objc func turnOff() {
    Bulb.isOn = false
  }
  
  @objc func getPrinters() {
    
  }
  
}
