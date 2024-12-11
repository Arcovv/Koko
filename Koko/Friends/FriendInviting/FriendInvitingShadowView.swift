//
//  FriendInvitingShadowView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import UIKit

class FriendInvitingShadowView: UIView {
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        layer.cornerRadius = 6

        layer.shadowRadius = 16
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
