//
//  HealthClientType.swift
//  ObesityApp
//
//  Created by Mohammed Al Ameen on 4/14/18.
//  Copyright © 2018 uos. All rights reserved.
//

import UIKit
import HealthKit

protocol HealthClientType {
    var healthStore: HKHealthStore? { get set }
}

extension UIViewController {
    
    func injectHealthStore(_ healthStore: HKHealthStore) {
        if var client = self as? HealthClientType {
            client.healthStore = healthStore
        }
        
        for childViewController in childViewControllers {
            childViewController.injectHealthStore(healthStore)
        }
    }
}
