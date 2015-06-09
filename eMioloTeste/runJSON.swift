//
//  runJSON.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/4/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//


import Foundation

@objc protocol RunJSONDelegate{
    optional func didReturnMessage(parsedObject: NSMutableArray, data: NSMutableData)
}

class runJSON : NSObject, NSURLConnectionDelegate {
    
    var dados: NSMutableData = NSMutableData()
    var parsedObject: NSMutableArray = NSMutableArray()
    var delegate:RunJSONDelegate?
    
    init (urlPath: String) {
        
        super.init()
        
        var request: NSURLRequest = NSURLRequest(URL: NSURL(string: urlPath)!)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
        
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.dados = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.dados.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        var err: NSError?
        
        var retorno = NSJSONSerialization.JSONObjectWithData(self.dados,
            options: NSJSONReadingOptions.AllowFragments,
            error:&err) as? NSMutableArray
        
        if retorno != nil {
            parsedObject = retorno!
        }
        
        self.delegate?.didReturnMessage!(parsedObject, data: self.dados)
        
    }
    
        
    
}
