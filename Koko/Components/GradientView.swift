//
//  GradientView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import UIKit

final class GradientView: UIView {
    private var gradientLayer: CAGradientLayer?

    var startPoint: CGPoint = .zero { didSet { updateView() } }
    var endPoint: CGPoint = .zero { didSet { updateView() } }
    var colors: [UIColor]? { didSet { updateView() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateView() {
        guard let colors = colors else { return }
        
        let cgColors = colors.map { $0.cgColor }

        gradientLayer?.removeFromSuperlayer()
        gradientLayer = CAGradientLayer()
        gradientLayer!.colors = cgColors
        gradientLayer!.startPoint = startPoint
        gradientLayer!.endPoint = endPoint
        gradientLayer!.frame = bounds
        layer.insertSublayer(gradientLayer!, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
}
