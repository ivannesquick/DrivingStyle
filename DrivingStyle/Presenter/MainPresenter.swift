//
//  MainPresenter.swift
//  DrivingStyle
//
//  Created by Neskin Ivan on 18.01.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import Foundation

class MainPresenter: IMainViewOutput, IMainInteractorOutput {
    var router: IMainRouter!
    var interactor: IMainInteractor
    weak var view: IMainViewInput?
    
    init(interactor: IMainInteractor, router: IMainRouter, view: IMainViewInput) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    func updateEntity(currentSpeed: Int, maxSpeed: Int) {
        interactor.updateSpeedCharacteristic(currentSpeed: currentSpeed, maxSpeed: maxSpeed)
    }
    
    func updatePresenter(speedCharacteristic: SpeedCharakteristic) {
        let maxSpeed = speedCharacteristic.maxSpeed
        let currentSpeed = speedCharacteristic.currentSpeed
        view?.updateView(currentSpeed: currentSpeed, maxSpeed: maxSpeed)
    }

}

//extension MainPresenter: IMainInteractorOutput {
//    func updatePresenter(speedCharacteristic: SpeedCharakteristic) {
//        let maxSpeed = speedCharacteristic.maxSpeed
//        let currentSpeed = speedCharacteristic.currentSpeed
//        view?.updateView(currentSpeed: currentSpeed, maxSpeed: maxSpeed)
//    }
//}
