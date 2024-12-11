//
//  AddFriendButton.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import UIKit
import SnapKit

final class AddFriendButton: UIView {
    private let gradientView = GradientView()
    private let textLabel = UILabel()
    private let imageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        
        do {
            gradientView.colors = [
                UIColor.frogGreen, UIColor.booger
            ]
            gradientView.startPoint = CGPoint(x: 0, y: 0.5)
            gradientView.endPoint = CGPoint(x: 1, y: 0.5)
            addSubview(gradientView)
        }
        
        do {
            textLabel.text = "加好友"
            textLabel.textColor = .white
            textLabel.font = AppFont.pingFangTC(size: 16, weight: .medium)
            textLabel.textAlignment = .center
            textLabel.numberOfLines = 1
            addSubview(textLabel)
        }
        
        do {
            imageView.image = UIImage(named: "icAddFriendWhite")
            addSubview(imageView)
        }
        
        // layout
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 24, height: 24))
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

