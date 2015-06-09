//
//  NASAPassou.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/8/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import Foundation

class NASAPassou : NSObject {

    var resultados: NSMutableArray? = nil
    
    init(dados: NSMutableData) {
        super.init()
        
        var dicionario = NSJSONSerialization.JSONObjectWithData(dados,
            options: NSJSONReadingOptions.AllowFragments,
            error:nil) as? NSDictionary
        
        resultados = (dicionario!["results"] as? NSMutableArray)!
        

    }
    
    func retornaData(dado: NSDictionary) -> String {
        var data: NSDate? = nil
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        data = dateFormatter.dateFromString(dado["date"] as! String)
        
        dateFormatter.dateFormat = "dd/MM/YYYY hh:mm"
        return dateFormatter.stringFromDate(data!)
    }
}
