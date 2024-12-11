//
//  ProfileView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit
import SnapKit

final class ProfileView: UIStackView {
    private let nicknameWithIdStackView = UIStackView()
    let nicknameLabel = UILabel()
    let emptyIdView = EmptyIdView()
    private let emptyView = UIView()
    let avatarImageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        
        axis = .horizontal
        spacing = 10
        alignment = .center
        
        nicknameWithIdStackView.axis = .vertical
        nicknameWithIdStackView.spacing = 8
        nicknameWithIdStackView.alignment = .leading
        addArrangedSubview(nicknameWithIdStackView)
        
        nicknameLabel.text = "Test"
        nicknameLabel.textColor = .greyishBrown
        nicknameLabel.font = AppFont.pingFangTC(size: 17, weight: .medium)
        nicknameLabel.numberOfLines = 1
        nicknameWithIdStackView.addArrangedSubview(nicknameLabel)
        
        nicknameWithIdStackView.addArrangedSubview(emptyIdView)
        
        emptyView.backgroundColor = .clear
        addArrangedSubview(emptyView)
        
        avatarImageView.image = UIImage(named: "imgFriendsFemaleDefault")
        addArrangedSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 52, height: 54))
        }
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

