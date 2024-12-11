//
//  TopToolView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit
import SnapKit

final class TopToolView: UIStackView {
    private static let buttonSize = CGSize(width: 24, height: 24)
    
    let atmButton = UIButton(type: .system)
    let transferButton = UIButton(type: .system)
    private let emptyView = UIView()
    let scanButton = UIButton(type: .system)
    
    init() {
        super.init(frame: .zero)
        
        axis = .horizontal
        spacing = 24
        alignment = .center
        distribution = .fill
//        backgroundColor = .gray
        
        do {
            let image = UIImage(named: "icNavPinkWithdraw")?.withRenderingMode(.alwaysOriginal)
            atmButton.setImage(image, for: .normal)
            addArrangedSubview(atmButton)
        }
        
        do {
            let image = UIImage(named: "icNavPinkTransfer")?.withRenderingMode(.alwaysOriginal)
            transferButton.setImage(image, for: .normal)
            addArrangedSubview(transferButton)
        }
        
        emptyView.backgroundColor = .red
        emptyView.setContentHuggingPriority(UILayoutPriority(100), for: .horizontal)
        emptyView.setContentCompressionResistancePriority(UILayoutPriority(100), for: .horizontal)
        addArrangedSubview(emptyView)
        
        do {
            let image = UIImage(named: "icNavPinkScan")?.withRenderingMode(.alwaysOriginal)
            scanButton.setImage(image, for: .normal)
            scanButton.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
            scanButton.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
            addArrangedSubview(scanButton)
        }
        
        atmButton.snp.makeConstraints { make in
            make.size.equalTo(TopToolView.buttonSize)
        }
        
        transferButton.snp.makeConstraints { make in
            make.size.equalTo(TopToolView.buttonSize)
        }
        
        scanButton.snp.makeConstraints { make in
            make.size.equalTo(TopToolView.buttonSize)
        }
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
