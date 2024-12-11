//
//  EmptyIdView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import UIKit
import SnapKit

final class EmptyIdView: UIStackView {
    static let arrowSize = CGSize(width: 18, height: 18)
    static let indicationSize = CGSize(width: 10, height: 10)
    
    let textLabel = UILabel()
    let rightArrowImageView = UIImageView()
    let pinkIndicatorView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        axis = .horizontal
        alignment = .center
        
        textLabel.text = "設定 KOKO ID"
        textLabel.font = AppFont.pingFangTC(size: 13)
        textLabel.numberOfLines = 1
        textLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        addArrangedSubview(textLabel)
        setCustomSpacing(0, after: textLabel)
        
        rightArrowImageView.image = UIImage(named: "icInfoBackDeepGray")
        addArrangedSubview(rightArrowImageView)
        setCustomSpacing(15, after: rightArrowImageView)
        
        pinkIndicatorView.backgroundColor = .hotPink
        pinkIndicatorView.layer.cornerRadius = Self.indicationSize.width * 0.5
        pinkIndicatorView.layer.masksToBounds = true
        addArrangedSubview(pinkIndicatorView)
        
        // layout
        
        rightArrowImageView.snp.makeConstraints { make in
            make.size.equalTo(Self.arrowSize)
        }
        
        pinkIndicatorView.snp.makeConstraints { make in
            make.size.equalTo(Self.indicationSize)
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
