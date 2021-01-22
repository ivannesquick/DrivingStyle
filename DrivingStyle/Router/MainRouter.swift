//
//  MainRouter.swift
//  DrivingStyle
//
//  Created by Neskin Ivan on 18.01.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import Foundation

class MainRouter: IMainRouter {
    var view: MainViewController
    
    init(view: MainViewController) {
        self.view = view
    }
}
