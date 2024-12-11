//
//  FriendInvitingUnfoldedCell.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/12.
//

import UIKit
import SnapKit

final class FriendInvitingUnfoldedCell: UICollectionViewCell {
    private typealias InnerView = FriendInvitingItemView
    
    static let defaultHeight: CGFloat = 73
    static let identifier = "FriendInvitingUnfoldedCell"
    
    private let innerView = InnerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setShadow()
        setCornerRaduis()
        setContentView()
        
        innerView.removeShadow()
        contentView.addSubview(innerView)
        
        innerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: InnerView.cornerRadius).cgPath
    }
    
    func setFriend(_ friend: Friend) {
        innerView.setFriend(friend)
    }
    
    func setShadow() {
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    private func setCornerRaduis() {
        layer.cornerRadius = InnerView.cornerRadius
        layer.masksToBounds = false
    }
    
    private func setContentView() {
        contentView.layer.cornerRadius = InnerView.cornerRadius
        contentView.layer.masksToBounds = true
    }
}
