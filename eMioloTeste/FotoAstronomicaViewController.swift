//
//  FotoAstronomicaViewController.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/8/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import UIKit
import CoreLocation

class FotoAstronomicaViewController: UIViewController, UITextFieldDelegate, NSURLConnectionDelegate, UINavigationControllerDelegate, RunJSONDelegate {
    
    @IBOutlet weak var tituloFoto: UILabel?
    @IBOutlet weak var descricao: UITextView?
    @IBOutlet weak var foto: UIImageView?

    @IBOutlet weak var menuButton: UIBarButtonItem?
    
    var getJSON: runJSON?
    var parsedObject: NSMutableArray? = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            self.menuButton!.target = self.revealViewController()
            self.menuButton!.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 200
        }
        
        getJSON = runJSON(urlPath: "https://api.nasa.gov/planetary/apod?concept_tags=True&api_key=OCl0TWsRIwkIY5r0yuDLYdirCQAoahHhNBTynGmm")
        getJSON?.delegate = self
    }
    
    func didReturnMessage(parsedObject: NSMutableArray, data: NSMutableData) {
        
        self.parsedObject = parsedObject
        
        var fotoAstronomica: FotoAstronomica? = FotoAstronomica(dados: data)
        
        
        
        let url = NSURL(string: fotoAstronomica!.url!)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        if data != nil {
            foto!.image = UIImage(data: data!)
        }
        
        tituloFoto?.text = fotoAstronomica!.title
        descricao?.text = fotoAstronomica!.explanation
        
    }
    
}
