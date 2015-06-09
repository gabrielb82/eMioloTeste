//
//  VisualisaFotoSateliteViewController.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/8/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import UIKit
import CoreLocation

class VisualizaFotoSateliteViewController: UIViewController, UITextFieldDelegate, NSURLConnectionDelegate, UINavigationControllerDelegate, RunJSONDelegate {
    
    @IBOutlet weak var dataFoto: UILabel?
    @IBOutlet weak var foto: UIImageView?
    
    var latitude: String?
    var longitude: String?
    
    var getJSON: runJSON?
    var parsedObject: NSMutableArray? = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        getJSON = runJSON(urlPath: "https://api.nasa.gov/planetary/earth/imagery?lon=\(longitude!)&lat=\(latitude!)&cloud_score=True&api_key=OCl0TWsRIwkIY5r0yuDLYdirCQAoahHhNBTynGmm")
        getJSON?.delegate = self
    }
    
    func didReturnMessage(parsedObject: NSMutableArray, data: NSMutableData) {
        
        self.parsedObject = parsedObject
        
        var fotoSatelite: FotoSatelite?
        
        var dicionario = NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions.AllowFragments,
            error:nil) as? NSDictionary
        
        
        fotoSatelite = FotoSatelite(dicionario: dicionario!)
        
        let url = NSURL(string: fotoSatelite!.url!)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        if data != nil {
            foto!.image = UIImage(data: data!)
        }
        
        var dtFoto: NSDate? = nil
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dtFoto = dateFormatter.dateFromString(fotoSatelite!.data!)
        
        dateFormatter.dateFormat = "dd/MM/YYYY hh:mm"
        dataFoto?.text = "* foto tirada em \(dateFormatter.stringFromDate(dtFoto!))"
        
    }
    
    @IBAction func voltar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
