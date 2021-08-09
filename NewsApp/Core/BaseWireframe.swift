//
//  BaseWireframe.swift
//  ViberTemplate
//
//  Created by Abdelrhman Eliwa on 05/05/2021.
//

import UIKit

protocol BaseProtocol: ProgressDisplayerProtocol, AlertDisplayerProtocol { }

class BaseWireframe: UIViewController, BaseProtocol {
    
    // MARK: Init
    required init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
