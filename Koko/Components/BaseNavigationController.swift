//
//  BaseNavigationController.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return visibleViewController?.preferredStatusBarStyle ?? .default
    }
    
    convenience init(root: UIViewController) {
        self.init(navigationBarClass: nil, toolbarClass: nil)
        navigationBar.isHidden = true
        
        pushViewController(root, animated: false)
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        navigationBar.isHidden = true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        navigationBar.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
