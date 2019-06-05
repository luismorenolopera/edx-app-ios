//
//  SamlAuthProvider.swift
//  edX
//
//  Created by andrey.canon on 10/10/18.
//  Copyright © 2018 edX. All rights reserved.
//

import Foundation

@objc class SamlAuthProvider: NSObject {
  
    typealias Environment = OEXStylesProvider & OEXConfigProvider & OEXRouterProvider
    private let environment: Environment
    private let authEntry: String
    
    init(environment: Environment, authEntry: String) {
        self.environment = environment
        self.authEntry = authEntry
    }
    
    func baseColorButton() -> UIColor {
        return environment.styles.primaryBaseColor()
    }
    
    func displayName() -> String {
        return environment.config.samlProviderConfig.samlName
    }

    func freshAuthButton() -> UIButton {
        let button = UIButton(frame: CGRect.zero)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        button.backgroundColor = self.baseColorButton()
        button.titleLabel?.font = button.titleLabel?.font.withSize(12)
        button.setTitle(self.displayName(), for: UIControlState.normal)
        button.layer.cornerRadius = 8
        return button
    }
    
    func initializeSamlViewController(view:UIViewController) {        
        let samlLoginViewController = SamlLoginViewController(environment: environment, authEntry: authEntry)
        let navigationController = UINavigationController(rootViewController: samlLoginViewController)
        view.present(navigationController, animated: true, completion: nil)
    }
    
}
