//
//  SearchBarView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import UIKit
import SnapKit

final class SearchBarView: UIStackView {
    static let addFriendSize = CGSize(width: 24, height: 24)
    
    let searchBar = UISearchBar()
    let addFriendButton = UIButton(type: .system)
    
    init() {
        super.init(frame: .zero)
        
        axis = .horizontal
        spacing = 15
        alignment = .center
        
        layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        isLayoutMarginsRelativeArrangement = true
        
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "想轉一筆給誰呢？"
        searchBar.setContentHuggingPriority(UILayoutPriority(500), for: .horizontal)
        searchBar.setContentCompressionResistancePriority(UILayoutPriority(500), for: .horizontal)
        addArrangedSubview(searchBar)
        
        do {
            let image = UIImage(named: "icBtnAddFriends")?.withRenderingMode(.alwaysOriginal)
            addFriendButton.setImage(image, for: .normal)
            addArrangedSubview(addFriendButton)
        }
        
        // layout
        
        addFriendButton.snp.makeConstraints { make in
            make.size.equalTo(Self.addFriendSize)
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
