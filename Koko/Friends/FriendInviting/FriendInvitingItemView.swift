//
//  FriendInvitingView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import UIKit
import SnapKit

final class FriendInvitingItemView: FriendInvitingShadowView {
    static let avatarSize = CGSize(width: 40, height: 40)
    static let buttonSize = CGSize(width: 30, height: 30)
    
    private let contentStackView = UIStackView()
    let avatarImageView = UIImageView()
    private let nameWithMessageStackView = UIStackView()
    let nameLabel = UILabel()
    let messageLabel = UILabel()
    private let spacerView = UIView()
    private let buttonsStackView = UIStackView()
    let sureButton = UIButton(type: .system)
    let cancelButton = UIButton(type: .system)
    
    override init() {
        super.init()

        do {
            contentStackView.axis = .horizontal
            contentStackView.alignment = .center
            addSubview(contentStackView)
        }
        
        do {
            avatarImageView.image = UIImage(named: "imgFriendsList")
            contentStackView.addArrangedSubview(avatarImageView)
            contentStackView.setCustomSpacing(15, after: avatarImageView)
        }
        
        do {
            nameWithMessageStackView.axis = .vertical
            nameWithMessageStackView.alignment = .leading
            nameWithMessageStackView.spacing = 2
            contentStackView.addArrangedSubview(nameWithMessageStackView)
        }
        
        do {
            nameLabel.text = "Hello"
            nameLabel.font = AppFont.pingFangTC(size: 16)
            nameLabel.textColor = .greyishBrown
            nameLabel.numberOfLines = 1
            nameWithMessageStackView.addArrangedSubview(nameLabel)
        }
        
        do {
            messageLabel.text = "邀請你成為好友：）"
            messageLabel.font = AppFont.pingFangTC(size: 13)
            messageLabel.textColor = .lightGrey
            messageLabel.numberOfLines = 1
            nameWithMessageStackView.addArrangedSubview(messageLabel)
        }
        
        do {
            contentStackView.addArrangedSubview(spacerView)
        }
        
        do {
            buttonsStackView.axis = .horizontal
            buttonsStackView.spacing = 15
            buttonsStackView.alignment = .center
            buttonsStackView.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
            contentStackView.addArrangedSubview(buttonsStackView)
        }
        
        do {
            let image = UIImage(named: "btnFriendsAgree")?.withRenderingMode(.alwaysOriginal)
            sureButton.setImage(image, for: .normal)
            buttonsStackView.addArrangedSubview(sureButton)
        }
        
        do {
            let image = UIImage(named: "btnFriendsDelet")?.withRenderingMode(.alwaysOriginal)
            cancelButton.setImage(image, for: .normal)
            buttonsStackView.addArrangedSubview(cancelButton)
        }
        
        // layout
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(Self.avatarSize)
        }
        
        sureButton.snp.makeConstraints { make in
            make.size.equalTo(Self.buttonSize)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.size.equalTo(Self.buttonSize)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFriend(_ friend: Friend) {
        nameLabel.text = friend.name
    }
}
