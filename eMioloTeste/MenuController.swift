//
//  MenuController.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/5/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import UIKit

import CoreLocation

class MenuController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var logout: UIButton?
    @IBOutlet weak var nome: UILabel?
    @IBOutlet weak var foto: UIImageView?
    
    var usuario: Usuario?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var userdefault = NSUserDefaults.standardUserDefaults()
        
        
        nome?.text = (userdefault.valueForKey("nome") as! String)
        
        foto!.layer.cornerRadius = foto!.frame.size.width / 2
        foto!.clipsToBounds = true
        foto!.layer.borderWidth = 1.0
        foto!.layer.borderColor = UIColor.whiteColor().CGColor
        
        var idusuario = (userdefault.valueForKey("idusuario") as! String)
        let url = NSURL(string: "http://www.cappriola.net/site/emiolo/imagens/\(idusuario).jpg")
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        if data != nil {
            foto!.image = UIImage(data: data!)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            println("deu")
        }
    }
    
    @IBAction func logOut(sender: AnyObject) {
        
        var logoutAlert = UIAlertController(title: "Log Out", message: "Deseja realmente deslogar?", preferredStyle: UIAlertControllerStyle.Alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Não", style: .Default, handler: nil))
        
        logoutAlert.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction!) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        presentViewController(logoutAlert, animated: true, completion: nil)
        
        
    }
    
}