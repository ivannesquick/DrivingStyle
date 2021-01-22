//
//  MainPresenter.swift
//  DrivingStyle
//
//  Created by Neskin Ivan on 18.01.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import Foundation

class MainPresenter: IMainPresenter {
    var router: IMainRouter!
    var interactor: IMainInteractor
    weak var view: IMainViewInput!
    
    init(interactor: IMainInteractor, router: IMainRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    
}
