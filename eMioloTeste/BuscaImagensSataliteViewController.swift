//
//  BuscaImagensSataliteViewController.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/8/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import UIKit
import CoreLocation

class BuscaImagensSataliteViewController: UIViewController, UITextFieldDelegate, NSURLConnectionDelegate, UINavigationControllerDelegate, GetLocationDelegate {
    
    @IBOutlet weak var latitude: UITextField?
    @IBOutlet weak var longitude: UITextField?

    @IBOutlet weak var menuButton: UIBarButtonItem?
    
    var getLocal = getLocation()
    
    func didUpdateLocation(message: NSString, placemark: CLPlacemark) {
        latitude?.text = placemark.location.coordinate.latitude.description
        longitude?.text = placemark.location.coordinate.longitude.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocal.delegate = self
        
        var tapscreen : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:"dismissKeyboard:")
        self.view.addGestureRecognizer(tapscreen)
        
        if self.revealViewController() != nil {
            self.menuButton!.target = self.revealViewController()
            self.menuButton!.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 200
        }
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 200
    }
    
    func dismissKeyboard(recognizer:UITapGestureRecognizer) {
        latitude!.resignFirstResponder()
        longitude!.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func buscar(sender: AnyObject) {
        
        performSegueWithIdentifier("VisualizaFotoSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var visualizaFoto = segue.destinationViewController as! VisualizaFotoSateliteViewController
        visualizaFoto.latitude = latitude!.text
        visualizaFoto.longitude = longitude!.text
        //self.navigationController?.pushViewController(editaUsuario, animated: true)
        
    }
}
