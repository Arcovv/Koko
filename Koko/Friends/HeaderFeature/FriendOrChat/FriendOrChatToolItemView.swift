//
//  FriendOrChatToolItemView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit
import SnapKit

final class FriendOrChatToolItemView: UIView {
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
    
    private let stackView = UIStackView()
    private let textLabel = UILabel()
    private let indicatorView = UIView()
    private let badgeView = FriendOrChatBadgeView()
    
    init() {
        super.init(frame: .zero)
        
        badgeView.isHidden = true
        addSubview(badgeView)
        
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        
        textLabel.textColor = .greyishBrown
        textLabel.setContentHuggingPriority(UILayoutPriority(999), for: .vertical)
        textLabel.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        stackView.addArrangedSubview(textLabel)
        
        indicatorView.backgroundColor = .whiteTwo
        indicatorView.layer.cornerRadius = 2
        indicatorView.layer.masksToBounds = true
        stackView.addArrangedSubview(indicatorView)
        
        // layout
        
        stackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        badgeView.snp.makeConstraints { make in
            let height = FriendOrChatBadgeView.defaultHeight
            make.height.equalTo(height)
            make.width.greaterThanOrEqualTo(height)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(-height * 0.5)
            make.leading.equalTo(stackView.snp.trailing).offset(2).priority(500)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 4))
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItem(_ item: SelectedItem) {
        textLabel.text = item.text
    }
    
    func setBadge(_ number: Int) {
        badgeView.isHidden = false
        badgeView.setBadgeNumber(number)
    }
}
