//
//  ActivityIndicator.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/4/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import Foundation
import UIKit

enum Position {
    case TopCenter, Center, BottomCenter , TopLeft , TopRight, CenterLeft, CenterRight
}

class ActivityIndicator : UIView {
    
    let loadingView : UIActivityIndicatorView?
    
    init(container: UIView, posicion: Position, style: UIActivityIndicatorViewStyle) {
        
        loadingView = UIActivityIndicatorView()
        
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 10, height: 10)))
        
        self.frame = inicializarFrame(container, posicion: posicion)
        
        self.backgroundColor = UIColor.clearColor()
        
        
        
        
        loadingView?.frame = CGRectMake(0, 0, 10, 10);
        loadingView?.activityIndicatorViewStyle = style
        self.addSubview(loadingView!)
        
        container.addSubview(self)
        
        self.startAnimation()
        
    }
    
    func inicializarFrame(container: UIView, posicion: Position)->CGRect {
        
        switch posicion {
        case .TopLeft:
            return CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 20, height: 20))
        case .TopCenter:
            return CGRect(origin: CGPoint(x: container.frame.width/2 - self.frame.width/2, y: 0), size: CGSize(width: 20, height: 20))
        case .TopRight:
            return CGRect(origin: CGPoint(x: container.frame.width - self.frame.width, y: 0), size: CGSize(width: 20, height: 20))
        case .CenterLeft:
            return CGRect(origin: CGPoint(x: 0, y: container.frame.height/2 - self.frame.height/2), size: CGSize(width: 20, height: 20))
        case .Center:
            return CGRect(origin: CGPoint(x: container.frame.width/2 - self.frame.width/2, y: container.frame.height/2 - self.frame.height/2), size: CGSize(width: 20, height: 20))
        case .CenterRight:
            return CGRect(origin: CGPoint(x: container.frame.width - self.frame.width, y: container.frame.height/2 - self.frame.height/2), size: CGSize(width: 20, height: 20))
        default:
            return CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 20, height: 20))
        }
        
    }
    
    func startAnimation() {
        loadingView?.startAnimating()
    }
    
    func stopAnimation() {
        loadingView?.stopAnimating()
        self.removeFromSuperview()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
