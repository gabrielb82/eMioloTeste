//
//  BlurViewEffect.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/4/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import Foundation
import UIKit

class BlurViewEffect: UIView {
    
    init(view: UIView, BlurEffectStyle: UIBlurEffectStyle) {
        
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 10, height: 10)))
        
        
        let style = UIBlurEffect(style: BlurEffectStyle)
        let blurEffectView = UIVisualEffectView(effect: style)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

