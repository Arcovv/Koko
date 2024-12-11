//
//  FriendOrChatToolItemView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit
import SnapKit

final class FriendOrChatToolItemView: UIStackView {
    enum SelectedItem {
        case friend
        case chat
        
        var text: String {
            switch self {
            case .friend:
                return "好友"
            case .chat:
                return "聊天"
            }
        }
    }
    
    var isSelected = false {
        didSet {
            if isSelected {
                textLabel.font = AppFont.pingFangTC(size: 13, weight: .medium)
                indicatorView.backgroundColor = .hotPink
            } else {
                textLabel.font = AppFont.pingFangTC(size: 13)
                indicatorView.backgroundColor = .whiteTwo // Like background
            }
        }
    }
    
    private let textLabel = UILabel()
    private let indicatorView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        axis = .vertical
        spacing = 6
        alignment = .center
        distribution = .fillProportionally
        
        textLabel.textColor = .greyishBrown
        textLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        textLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        addArrangedSubview(textLabel)
        
        indicatorView.backgroundColor = .whiteTwo
        indicatorView.layer.cornerRadius = 2
        indicatorView.layer.masksToBounds = true
        addArrangedSubview(indicatorView)
        
        indicatorView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 4))
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItem(_ item: SelectedItem) {
        textLabel.text = item.text
    }
}
