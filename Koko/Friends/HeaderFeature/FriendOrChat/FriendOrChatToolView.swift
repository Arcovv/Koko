//
//  FriendOrChatToolView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit
import SnapKit

final class FriendOrChatToolView: UIStackView {
    let friendView = FriendOrChatToolItemView()
    let chatView = FriendOrChatToolItemView()
    private let emptyView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        axis = .horizontal
        spacing = 15
//        alignment = .leading
        distribution = .fill
//        backgroundColor = .red
        
        friendView.setItem(.friend)
        friendView.isSelected = true
        addArrangedSubview(friendView)
        
        chatView.setItem(.chat)
        chatView.isSelected = false
        addArrangedSubview(chatView)
        
        emptyView.backgroundColor = .clear
        addArrangedSubview(emptyView)
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
