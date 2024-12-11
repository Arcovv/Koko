//
//  HeaderFeatureView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit
import SnapKit

final class HeaderFeatureView: UIStackView {
    let topToolView = TopToolView()
    let profileView = ProfileView()
    let friendInvitingGroupView = FriendInvitingGroupView()
    let friendOrChatToolView = FriendOrChatToolView()
    let divisionView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        axis = .vertical
        spacing = 28
        alignment = .center
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
//        backgroundColor = .whiteTwo
//        backgroundColor = .yellow
        
        addArrangedSubview(topToolView)
        addArrangedSubview(profileView)
        addArrangedSubview(friendInvitingGroupView)
        addArrangedSubview(friendOrChatToolView)
        
        divisionView.backgroundColor = .veryLightPink
        setCustomSpacing(0, after: friendOrChatToolView)
        addArrangedSubview(divisionView)
        
        // layout
        
        topToolView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        profileView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        friendInvitingGroupView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalToSuperview().offset(FriendInvitingGroupView.defaultHeight)
        }
        
        friendOrChatToolView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        divisionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
