//
//  HeaderFeatureView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HeaderFeatureView: UIStackView {
    private let safeAreaSpacerView = UIView()
    let topToolView = TopToolView()
    let profileView = ProfileView()
    let friendInvitingGroupView = FriendInvitingGroupView()
    let friendInvitingUnfoldedCollectionView = FriendInvitingUnfoldedCollectionView()
    let friendOrChatToolView = FriendOrChatToolView()
    let divisionView = UIView()
    
    // status = 1
    private(set) var friendsInvitings: [Friend] = []
    // status = 2
    private(set) var invitedFriends: [Friend] = []
    
    let pinchGropViewGesture = UIPinchGestureRecognizer()
    let pinchUnfoldedCollectionViewGesture = UIPinchGestureRecognizer()
    private var isHandlingPinchGesture = false
    
    private(set) var isFriendInvitingGroupCollapsed = true
    
    init() {
        super.init(frame: .zero)
        
        axis = .vertical
        spacing = 0
        alignment = .center
//        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        backgroundColor = .whiteTwo
//        backgroundColor = .yellow
        
//        safeAreaSpacerView.backgroundColor = .red
        addArrangedSubview(safeAreaSpacerView)
        setCustomSpacing(0, after: safeAreaSpacerView)
        
        addArrangedSubview(topToolView)
        
        setCustomSpacing(28, after: topToolView)
        addArrangedSubview(profileView)
        
        setCustomSpacing(28, after: profileView)
//        addArrangedSubview(friendInvitingGroupView)
        
//        setCustomSpacing(28, after: friendInvitingGroupView)
        addArrangedSubview(friendOrChatToolView)
        
        divisionView.backgroundColor = .veryLightPink
        setCustomSpacing(0, after: friendOrChatToolView)
        addArrangedSubview(divisionView)
        
        updateCollapseView()
        
        // UIPinchGestureRecognizer for `friendInvitingGroupView`
        do {
            pinchGropViewGesture.addTarget(self, action: #selector(handlePinchGroupView(recognizer:)))
            friendInvitingGroupView.isUserInteractionEnabled = true
            friendInvitingGroupView.addGestureRecognizer(pinchGropViewGesture)
        }
        
        // UIPinchGestureRecognizer for `friendInvitingUnfoldedCollectionView`
        do {
            pinchUnfoldedCollectionViewGesture.addTarget(self, action: #selector(handlePinchUnfoldedCollectionView(recognizer:)))
            friendInvitingUnfoldedCollectionView.isUserInteractionEnabled = true
            friendInvitingUnfoldedCollectionView.addGestureRecognizer(pinchUnfoldedCollectionViewGesture)
        }
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        safeAreaSpacerView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(safeAreaInsets.top)
        }
        
        topToolView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        profileView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        friendOrChatToolView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        divisionView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func setFriendInvitings(_ friends: [Friend]) {
        self.friendsInvitings = friends
        
        if friends.isEmpty {
            removeCollapseViews()
        } else {
            friendInvitingGroupView.setFriendsInvitingModels(friends)
            friendInvitingUnfoldedCollectionView.setFriends(friends)
        }
    }
    
    func setInvitedFrinds(_ friends: [Friend]) {
        self.invitedFriends = friends
        
        showFriendOrChatToolBadgeIfNeeded()
    }
    
    private func removeCollapseViews() {
        friendInvitingGroupView.removeFromSuperview()
        friendInvitingUnfoldedCollectionView.removeFromSuperview()
    }
    
    private func updateCollapseView() {
        friendInvitingGroupView.removeFromSuperview()
        friendInvitingUnfoldedCollectionView.removeFromSuperview()
        
        if isFriendInvitingGroupCollapsed {
            insertArrangedSubview(friendInvitingGroupView, at: 3)
            setCustomSpacing(28, after: friendInvitingGroupView)
            
            friendInvitingGroupView.snp.remakeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(30)
                make.height.equalTo(FriendInvitingGroupView.defaultHeight)
            }
        } else {
            insertArrangedSubview(friendInvitingUnfoldedCollectionView, at: 3)
            setCustomSpacing(28, after: friendInvitingUnfoldedCollectionView)
            
            friendInvitingUnfoldedCollectionView.snp.remakeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(30)
                make.height.equalTo(FriendInvitingUnfoldedCollectionView.defaultHeight())
            }
        }
    }
    
    @objc private func handlePinchGroupView(recognizer: UIPinchGestureRecognizer) {
        guard friendsInvitings.count > 1 && !isHandlingPinchGesture && recognizer.scale >= 1 else { return }
        
        isHandlingPinchGesture = true
        
        isFriendInvitingGroupCollapsed = false
        updateCollapseView()
        
        isHandlingPinchGesture = false
    }
    
    @objc private func handlePinchUnfoldedCollectionView(recognizer: UIPinchGestureRecognizer) {
        guard !isHandlingPinchGesture && recognizer.scale < 1 else { return }
        
        isHandlingPinchGesture = true
        
        isFriendInvitingGroupCollapsed = true
        updateCollapseView()
        
        isHandlingPinchGesture = false
    }
    
    private func showFriendOrChatToolBadgeIfNeeded() {
        guard invitedFriends.count > 0 else { return }
        
        friendOrChatToolView.friendView.setBadge(invitedFriends.count)
        friendOrChatToolView.chatView.setBadge(100)
    }
}
