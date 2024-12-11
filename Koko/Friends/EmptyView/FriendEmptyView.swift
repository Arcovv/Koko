//
//  FriendEmptyView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import UIKit
import SnapKit
import Attributed

final class FriendEmptyView: UIStackView {
    let friendEmptyImageView = UIImageView()
    let addFriendLabel = UILabel()
    let addFriendDetailLabel = UILabel()
    let addFriendButton = AddFriendButton()
    let setIdStackView = UIStackView()
    let setIdLabel = UILabel()
    let setIdButton = UIButton(type: .system)
    private let spacerView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        axis = .vertical
        alignment = .center
        backgroundColor = .white
        
        do {
            friendEmptyImageView.image = UIImage(named: "imgFriendsEmpty")
            addArrangedSubview(friendEmptyImageView)
            setCustomSpacing(41, after: friendEmptyImageView)
        }
        
        do {
            addFriendLabel.text = "就從加好友開始吧：）"
            addFriendLabel.textColor = .greyishBrown
            addFriendLabel.font = AppFont.pingFangTC(size: 21, weight: .medium)
            addFriendLabel.textAlignment = .center
            addFriendLabel.numberOfLines = 1
            addArrangedSubview(addFriendLabel)
            setCustomSpacing(8, after: addFriendLabel)
        }
        
        do {
            addFriendDetailLabel.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"
            addFriendDetailLabel.textColor = .lightGrey
            addFriendDetailLabel.font = AppFont.pingFangTC(size: 14)
            addFriendDetailLabel.textAlignment = .center
            addFriendDetailLabel.numberOfLines = 2
            addArrangedSubview(addFriendDetailLabel)
            setCustomSpacing(25, after: addFriendDetailLabel)
        }
        
        do {
            addFriendButton.backgroundColor = .green
            addFriendButton.layer.cornerRadius = 20
            addFriendButton.layer.masksToBounds = true
            addArrangedSubview(addFriendButton)
            setCustomSpacing(37, after: addFriendButton)
        }
        
        do {
            setIdStackView.axis = .horizontal
            addArrangedSubview(setIdStackView)
        }
        
        do {
            setIdLabel.text = "幫助好友更快找到你？"
            setIdLabel.textColor = .lightGrey
            setIdLabel.font = AppFont.pingFangTC(size: 13)
            setIdLabel.numberOfLines = 1
            setIdStackView.addArrangedSubview(setIdLabel)
        }
        
        do {
            let textAttributed = "設定 KOKO ID".at.attributed { at in
                at.foreground(color: .hotPink)
                    .font(AppFont.pingFangTC(size: 13))
                    .underlineStyle(.single)
            }
            setIdButton.setAttributedTitle(textAttributed, for: .normal)
            setIdStackView.addArrangedSubview(setIdButton)
        }
        
        do {
            addArrangedSubview(spacerView)
        }
        
        addFriendButton.snp.makeConstraints { make in
            make.width.equalTo(192)
            make.height.equalTo(40)
        }
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

