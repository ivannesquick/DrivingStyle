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
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate lazy var speedInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "Helvetica Neue", size: 50.0)
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
        return button
    }()
    
    private var backgroundLayer: CAShapeLayer?
    private var progressLayer: CAShapeLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupConstraints()
        setupBackGroundLayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        
        let progressLayer = configureProgressLayer()
        containerView.layer.insertSublayer(progressLayer, above: backgroundLayer)
        self.progressLayer = progressLayer
    }
    
    private func setupConstraints() {
        view.addSubview(containerView)
        view.addSubview(estimateButton)
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
        progressLayer.strokeColor = UIColor.green.cgColor
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
    
}

