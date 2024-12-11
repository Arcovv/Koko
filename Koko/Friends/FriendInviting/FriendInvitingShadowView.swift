//
//  FriendInvitingShadowView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import UIKit

class FriendInvitingShadowView: UIView {
    static let cornerRadius: CGFloat = 6
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        layer.cornerRadius = Self.cornerRadius

        setShadow()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: Self.cornerRadius).cgPath
    }
    
    func setShadow() {
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    func removeShadow() {
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
    }
    
    func removeCornerRadius() {
        layer.cornerRadius = 0
    }
}
