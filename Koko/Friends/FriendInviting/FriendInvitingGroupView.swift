//
//  FriendInvitingGroupView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import UIKit
import SnapKit

final class FriendInvitingGroupView: UIView {
    static let maxCollapsedDisplayCount = 2
    static let defaultHeight: CGFloat = 80
    
    private let itemsStackView = UIStackView()
    private(set) var itemViews: [FriendInvitingItemView] = []
    private(set) var friendInvitings: [Friend] = []
    
    init() {
        super.init(frame: .zero)
        
//        backgroundColor = .yellow
        
        itemsStackView.axis = .vertical
        itemsStackView.spacing = 10
        itemsStackView.alignment = .center
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFriendsInvitingModels(_ friends: [Friend]) {
        self.friendInvitings = friends
        
        itemViews.forEach { $0.removeFromSuperview() }
        itemViews = []
        
        displayLikeCollapsed()
    }
    
    private func displayLikeCollapsed() {
        itemsStackView.removeFromSuperview()
        
        itemViews = friendInvitings.prefix(Self.maxCollapsedDisplayCount)
            .map { friend in
                print("friend name: \(friend.name)")
                let itemView = FriendInvitingItemView()
                itemView.setFriend(friend)
                return itemView
            }
        
        itemViews.enumerated().forEach { (index, itemView) in
            if index == 0 {
                addSubview(itemView)
            } else {
                insertSubview(itemView, belowSubview: itemViews.first!)
            }
            
            let centerYOffset: CGFloat = index == 0 ? -5 : 5
            let widthOffset: CGFloat = index == 0 ? 0 : 10
            
            itemView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(widthOffset)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(centerYOffset)
            }
        }
    }
}
