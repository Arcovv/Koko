//
//  SetStragetyViewController.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SetStragetyViewController: UIViewController {
    
    let stackView = UIStackView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        ApiClientStrategy.allCases.forEach { strategy in
            let appDependency = AppDependency(apiClient: .apiClientRemote, apiClientStrategy: strategy)
            
            let button = UIButton(type: .system)
            button.setTitle(strategy.buttonTitle, for: .normal)
            stackView.addArrangedSubview(button)
            
            button.rx.tap
                .subscribe(with: self, onNext: { (_self, _) in
                    let viewModel = FriendsViewModel(appDependency: appDependency)
                    let friendsViewController = FriendsViewController(viewModel: viewModel)
                    friendsViewController.modalPresentationStyle = .overFullScreen

                    _self.present(friendsViewController, animated: false)
                })
                .disposed(by: disposeBag)
        }
    }
}

