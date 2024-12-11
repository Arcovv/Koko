//
//  FriendsCollectionViewCell.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import UIKit
import SnapKit

final class FriendsCollectionViewCell: UICollectionViewCell {
    static let identifier = "FriendsCollectionViewCell"
    static let isTopSize = CGSize(width: 14, height: 14)
    static let avatarSize = CGSize(width: 40, height: 40)
    static let moreButtonSize = CGSize(width: 18, height: 4)
    
    private let contentStackView = UIStackView()
    let isTopImageView = UIImageView(image: UIImage(named: "icFriendsStar"))
    let avatarImageView = UIImageView(image: UIImage(named: "imgFriendsList"))
    let nicknameLabel = UILabel()
    private let spacerView = UIView()
    private(set) var transferButton: UIButton!
    private(set) var invitingButton: UIButton!
    let moreButton = UIButton(type: .system)
    let dividerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
//        contentView.backgroundColor = .brown
        
        do {
            contentStackView.axis = .horizontal
            contentStackView.alignment = .center
            contentStackView.distribution = .fillProportionally
            contentStackView.isLayoutMarginsRelativeArrangement = true
            contentView.addSubview(contentStackView)
        }
        
        do {
            isTopImageView.alpha = 1
            isTopImageView.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
            contentStackView.addArrangedSubview(isTopImageView)
            contentStackView.setCustomSpacing(6, after: isTopImageView)
        }
        
        do {
            avatarImageView.layer.cornerRadius = Self.avatarSize.width * 0.5
            avatarImageView.layer.masksToBounds = true
            avatarImageView.setContentHuggingPriority(UILayoutPriority(999), for: .horizontal)
            contentStackView.addArrangedSubview(avatarImageView)
            contentStackView.setCustomSpacing(15, after: avatarImageView)
        }
        
        do {
            nicknameLabel.textColor = .greyishBrown
            nicknameLabel.font = AppFont.pingFangTC(size: 16)
            nicknameLabel.numberOfLines = 1
            contentStackView.addArrangedSubview(nicknameLabel)
        }
        
        do {
            spacerView.setContentHuggingPriority(UILayoutPriority(100), for: .horizontal)
            contentStackView.addArrangedSubview(spacerView)
        }
        
        do {
            transferButton = createButton(title: "轉帳", color: .hotPink)
            transferButton.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
            contentStackView.addArrangedSubview(transferButton)
            contentStackView.setCustomSpacing(25, after: transferButton)
        }
        
        do {
            invitingButton = createButton(title: "邀請中", color: .lightGrey)
            invitingButton.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        }
        
        do {
            let image = UIImage(named: "icFriendsMore")?.withRenderingMode(.alwaysOriginal)
            moreButton.setImage(image, for: .normal)
            moreButton.setContentHuggingPriority(UILayoutPriority(996), for: .horizontal)
            contentStackView.addArrangedSubview(moreButton)
        }
        
        do {
            dividerView.backgroundColor = .whiteThree
            dividerView.layer.cornerRadius = 1
            dividerView.layer.masksToBounds = true
            contentView.addSubview(dividerView)
        }
        
        // layout
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        isTopImageView.snp.makeConstraints { make in
            make.size.equalTo(Self.isTopSize)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(Self.avatarSize)
        }
        
        moreButton.snp.makeConstraints { make in
            make.size.equalTo(Self.moreButtonSize)
        }
        
        dividerView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.leading.equalTo(nicknameLabel)
            make.height.equalTo(1)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        invitingButton.removeFromSuperview()
        contentStackView.setCustomSpacing(25, after: transferButton)
        contentStackView.addArrangedSubview(moreButton)
    }
    
    func setFriend(_ friend: Friend) {
        isTopImageView.alpha = friend.isTop ? 1.0 : 0
        nicknameLabel.text = friend.name
        
        switch friend.status {
        case .sendInviting:
            fallthrough // Don't need to do anything
        case .finished:
            contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            invitingButton.removeFromSuperview()
            contentStackView.setCustomSpacing(25, after: transferButton)
            contentStackView.addArrangedSubview(moreButton)
        case .inviting:
            contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            moreButton.removeFromSuperview()
            contentStackView.setCustomSpacing(10, after: transferButton)
            contentStackView.addArrangedSubview(invitingButton)
        }
    }
}

fileprivate func createButton(title: String, color: UIColor) -> UIButton {
    var configuration = UIButton.Configuration.plain()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 9, bottom: 2, trailing: 9)
    configuration.background.cornerRadius = 2
    
    var container = AttributeContainer()
    container.font = AppFont.pingFangTC(size: 14, weight: .medium)
    container.foregroundColor = color
    configuration.attributedTitle = AttributedString.init(title, attributes: container)
    
    let button = UIButton(configuration: configuration)
    button.layer.borderColor = color.cgColor
    button.layer.borderWidth = 1.2
    
    return button
}
