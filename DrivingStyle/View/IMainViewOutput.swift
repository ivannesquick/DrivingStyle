//
//  IMainPresenter.swift
//  DrivingStyle
//
//  Created by Neskin Ivan on 18.01.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import Foundation

protocol IMainViewOutput {
    var router: IMainRouter! { get set }
    func viewDidLoad() -> Void
    func updateEntity(currentSpeed: Int, maxSpeed: Int)
}
