//
//  ResearchContainerSegue.swift
//  ObesityApp
//
//  Created by Mohammed Al Ameen on 4/14/18.
//  Copyright © 2018 uos. All rights reserved.
//

import UIKit

class ResearchContainerSegue: UIStoryboardSegue {
    
    override func perform() {
        let controllerToReplace = source.childViewControllers.first
        let destinationControllerView = destination.view
        
        destinationControllerView?.translatesAutoresizingMaskIntoConstraints = true
        destinationControllerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        destinationControllerView?.frame = source.view.bounds
        
        controllerToReplace?.willMove(toParentViewController: nil)
        source.addChildViewController(destination)
        
        source.view.addSubview(destinationControllerView!)
        controllerToReplace?.view.removeFromSuperview()
        
        destination.didMove(toParentViewController: source)
        controllerToReplace?.removeFromParentViewController()
    }
}
