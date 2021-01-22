//
//  MainViewController.swift
//  DrivingStyle
//
//  Created by Neskin Ivan on 05.01.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var presenter:IMainPresenter!
    
    fileprivate lazy var speedTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите скорость"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.layer.cornerRadius = 10
        textField.font = UIFont(name: "Helvetica Neue", size: 15.0)
        return textField
    }()
    
    fileprivate lazy var maxSpeedTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Максимальная скорость на спидометре"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.layer.cornerRadius = 10
        textField.font = UIFont(name: "Helvetica Neue", size: 15.0)
        return textField
    }()
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate lazy var speedInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "Helvetica Neue", size: 45.0)
        return label
    }()
    
    fileprivate lazy var drivingStyleLabel: UILabel = {
        let label = UILabel()
        label.text = "Оценка стиля вождения"
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    fileprivate lazy var estimateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Оценить стиль", for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(estimateDrivingStyle), for: .touchUpInside)
        return button
    }()
    
    private var backgroundLayer: CAShapeLayer?
    private var progressLayer: CAShapeLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configurator.configure(with: self)
//        presenter.configureView()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        presenter.viewDidLoad()
        setupConstraints()
        setupBackGroundLayer()
        setupProgressLayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overrideLayerPath()
    }
    
    private func overrideLayerPath() {
        backgroundLayer?.path = configureProgressBarPath()
        progressLayer?.path = configureProgressBarPath()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundLayer?.path = configureProgressBarPath()
    }
    
    private func setupBackGroundLayer() {
        let backgroundLayer = configureBackgroundLayer()
        containerView.layer.addSublayer(backgroundLayer)
        self.backgroundLayer = backgroundLayer
    }
    
    private func setupProgressLayer() {
        let progressLayer = configureProgressLayer()
        containerView.layer.insertSublayer(progressLayer, above: backgroundLayer)
        self.progressLayer = progressLayer
    }
    
    private func setupConstraints() {
        view.addSubview(containerView)
        view.addSubview(estimateButton)
        view.addSubview(speedTextField)
        view.addSubview(maxSpeedTextField)
        containerView.addSubview(speedInformationLabel)
        containerView.addSubview(drivingStyleLabel)
        
        containerView.snp.makeConstraints { (make) in
            make.width.height.equalTo(200)
            make.center.equalTo(self.view)
        }
        speedInformationLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.containerView)
        }
        drivingStyleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(110)
            make.top.equalTo(containerView.snp.bottom).inset(30)
            make.centerX.equalTo(self.containerView)
        }
        estimateButton.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(70)
            make.centerX.equalTo(self.view)
            make.top.equalTo(containerView.snp.bottom).inset(-70)
        }
        speedTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.top.equalTo(containerView.snp.top).inset(-110)
        }
        maxSpeedTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(speedTextField.snp.width)
            make.height.equalTo(speedTextField.snp.height)
            make.bottom.equalTo(speedTextField.snp.top).inset(-30)
        }
    }
    
    private func configureBackgroundLayer() -> CAShapeLayer {
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = configureProgressBarPath()    //набор линий определяющий фигуру
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = 8
        backgroundLayer.lineCap = .round
        backgroundLayer.fillColor = nil
        return backgroundLayer
    }
    
    private func configureProgressLayer() -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        progressLayer.path = configureProgressBarPath()    //набор линий определяющий фигуру
        progressLayer.strokeColor = UIColor.orange.cgColor
        progressLayer.lineWidth = 8
        progressLayer.lineCap = .round
        progressLayer.fillColor = nil
        progressLayer.strokeEnd = 0
        return progressLayer
    }
    
    private func configureProgressBarPath() -> CGPath {
        UIBezierPath(arcCenter: CGPoint(x: containerView.bounds.width/2, y: containerView.bounds.height/2), radius: 94, startAngle: 3 * CGFloat.pi / 4, endAngle: CGFloat.pi / 4, clockwise: true).cgPath
    }
    
    private func resetProgressBar() {
        progressLayer?.strokeEnd = 0
        progressLayer?.removeAllAnimations()
    }
    
    private func maxSpeedValidation() -> Int? {
        if let inputText = maxSpeedTextField.text {
            guard let speed = Int(inputText) else {return nil}
            return speed
        } else {
            print()
        }
        return 180
    }
    
    private func currentSpeedValidation() -> Int? {
        if let inputText = speedTextField.text {
            guard let speed = Int(inputText) else {return nil}
            return speed
        } else {
            print()
        }
        return 90
    }
    
    private func valueValidation(maxSpeed: Int, currentSpeed: Int) -> Bool {
        if currentSpeed > maxSpeed {
            showAlert()
            return false
        } else {
            return true
        }
    }
    
    @objc private func estimateDrivingStyle() {
        let maxSpeed = maxSpeedValidation()
        let currentSpeed = currentSpeedValidation()
        if valueValidation(maxSpeed: maxSpeed!, currentSpeed: currentSpeed!) {
            startAnimation(drivingStyleRating: currentSpeed!, maxSpeedToCar: maxSpeed!, duration: 5)
            changeLabel(maxSpeed: maxSpeed!, currentSpeed: currentSpeed!)
        }
    }
    
    private func startAnimation(drivingStyleRating: Int, maxSpeedToCar: Int, duration: TimeInterval) {
        resetProgressBar()
        
        let maxSpeed = CGFloat(maxSpeedToCar)
        
        let progressFloat = CGFloat(drivingStyleRating)
        let progress = progressFloat/maxSpeed
        
        progressLayer?.strokeEnd = progress
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = progress
        strokeEndAnimation.duration = duration
        progressLayer?.add(strokeEndAnimation, forKey: "strokeEndAnimation")
    }
    
    private func changeLabel(maxSpeed: Int, currentSpeed: Int) {
        speedInformationLabel.text = "\(currentSpeed)" + "/" + "\(maxSpeed)"
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Сообщение", message: "Текущая скорость не может быть больше максимальной", preferredStyle: .alert)
        let alertCancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertCancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: IMainViewInput {
    func setValueSpeed() {
        
    }
    
    
}
