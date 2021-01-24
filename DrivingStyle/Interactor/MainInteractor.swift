//
//  MainInteractor.swift
//  DrivingStyle
//
//  Created by Neskin Ivan on 22.01.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import Foundation

class MainInteractor: IMainInteractor {
    private var speedCharacteristic: SpeedCharakteristic?
    weak var interactorOutput: IMainInteractorOutput?
    
    func updateSpeedCharacteristic(currentSpeed: Int, maxSpeed: Int) {
        speedCharacteristic = SpeedCharakteristic(maxSpeed: maxSpeed, currentSpeed: currentSpeed)
        guard let speedCharacteristic = speedCharacteristic else { return }
        interactorOutput?.updatePresenter(speedCharacteristic: speedCharacteristic)
    }
    
    
}
