//
//  FriendOrChatBadgeView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/12.
//

import UIKit
import SnapKit

final class FriendOrChatBadgeView: UIView {
    static let defaultHeight: CGFloat = 18
    private let numberLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .softPink
        
        layer.cornerRadius = Self.defaultHeight * 0.5
        layer.masksToBounds = true
        
        numberLabel.text = "99+"
        numberLabel.font = AppFont.pingFangTC(size: 12, weight: .medium)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        numberLabel.numberOfLines = 1
        numberLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        addSubview(numberLabel)
        
        numberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(4)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBadgeNumber(_ number: Int) {
        if number > 99 {
            numberLabel.text = "99+"
        } else {
            numberLabel.text = "\(number)"
        }
    }
}
