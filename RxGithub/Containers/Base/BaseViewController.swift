//
//  BaseViewController.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit

public class BaseViewController<T: UIView>: UIViewController {
    open var underlyingView: T {
        if let myView = view as? T {
            return myView
        }
        
        let newView = T()
        view = newView
        return newView
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = T()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupAccessibility()
    }
    
    // MARK: - Setup
    
    /// Abstract method. Subclasses should override this method to setup their view.
    public func setupView() {
        
    }
    
    /// Abstract method. Subclasses should override this method to add accessibility.
    public func setupAccessibility() {
        
    }
    
}
