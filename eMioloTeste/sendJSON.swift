//
//  sendJSON.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/4/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import Foundation

@objc protocol SendJSONDelegate{
    optional func didReturnSuccessMessage(sucesso: Bool)
}

class sendJSON : NSObject, NSURLConnectionDelegate {
    
    var delegate:SendJSONDelegate?
    var sucesso: Bool = false
    var parametros: NSMutableArray? = NSMutableArray()
    var url: String?
    var json: NSMutableArray? = NSMutableArray()
    
    override init () {
        
        super.init()
  
        
    }
    
    func preparaJSON() {
        var request = NSMutableURLRequest(URL: NSURL(string: self.url!)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        //var params:NSMutableArray = respostas
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(self.parametros!, options: NSJSONWritingOptions.PrettyPrinted, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var strData = NSString()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            //println("Response: \(response)")
            strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            println("Body: \(strData)")
            var err: NSError?
            self.json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSMutableArray
            
            if strData == "erro" {
                self.sucesso = false
            }
            else {
                self.sucesso = true
            }
            self.delegate?.didReturnSuccessMessage!(self.sucesso)
        })
        
        task.resume()
        
    }

}