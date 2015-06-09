//
//  FotoSatelite.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/8/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import Foundation

class FotoSatelite : NSObject {
    
    var data: String?
    var url: String?
    var cloud_score: String?
    var id: String?
    
    
    init(dicionario: NSDictionary) {
        super.init()
        
        if let datatemp = dicionario["date"] as? NSString {
            data = datatemp as String
        }
        if let urltemp = dicionario["url"] as? NSString {
            url = urltemp as String
        }
        if let cloudtemp = dicionario["cloud_score"] as? NSString {
            cloud_score = cloudtemp as String
        }
        if let idtemp = dicionario["id"] as? NSString {
            id = idtemp as String
        }
    }
}
