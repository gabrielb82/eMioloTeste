//
//  FotoAstronomica.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/8/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import Foundation

class FotoAstronomica : NSObject {
    
    var url: String?
    var explanation: String?
    var title: String?
    
    
    init(dados: NSData) {
        super.init()
        
        var dicionario = NSJSONSerialization.JSONObjectWithData(dados,
            options: NSJSONReadingOptions.AllowFragments,
            error:nil) as? NSDictionary

        if let urltemp = dicionario!["url"] as? NSString {
            url = urltemp as String
        }
        if let explanationtemp = dicionario!["explanation"] as? NSString {
            explanation = explanationtemp as String
        }
        if let titletemp = dicionario!["title"] as? NSString {
            title = titletemp as String
        }
    }
}
