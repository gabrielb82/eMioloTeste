//
//  ListaUsuariosController.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/5/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import UIKit

import CoreLocation

class ListaUsuariosController: UITableViewController, UITableViewDelegate, NSURLConnectionDelegate, RunJSONDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var getJSON: runJSON?
    var parsedObject: NSMutableArray? = NSMutableArray()
    
    var usuarioSelecionado: Usuario?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var footer : UIView = UIView()
        footer.frame = CGRectZero
        self.tableView.tableFooterView = footer
        self.tableView.delegate = self
        
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.layoutMargins = UIEdgeInsetsZero;
        
        var footerRespostas : UIView = UIView()
        footerRespostas.frame = CGRectZero
        self.tableView.tableFooterView = footerRespostas
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 200
        }
        
        self.tableView.reloadData()
        
        getJSON = runJSON(urlPath: "http://www.cappriola.net/site/emiolo/buscaUsuarios.php")
        getJSON?.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            println("deu")
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ListaUsuariosCellController! = tableView.dequeueReusableCellWithIdentifier("Cell") as? ListaUsuariosCellController
        
        var usuario: Usuario?
        
        if let user = self.parsedObject?[indexPath.row] as? NSDictionary {
            usuario = Usuario(dicionario: user)
        }
        
        var idusuario = usuario!.idusuario
        let url = NSURL(string: "http://www.cappriola.net/site/emiolo/imagens/\(idusuario!).jpg")
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        if data != nil {
            cell.foto.image = UIImage(data: data!)
        }
        
        cell.foto.layer.cornerRadius = cell.foto!.frame.size.width / 2
        cell.foto.clipsToBounds = true
        cell.foto.layer.borderWidth = 1.0
        cell.foto.layer.borderColor = UIColor.whiteColor().CGColor
        
        cell.nome?.text = usuario!.nome
        cell.email?.text = usuario!.email
        
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if parsedObject != nil {
            return parsedObject!.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if let user = self.parsedObject?[indexPath.row] as? NSDictionary {
            self.usuarioSelecionado = Usuario(dicionario: user)
        }
        performSegueWithIdentifier("EditarUsuarioSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var editaUsuario = segue.destinationViewController as! EditarUsuarioViewController
        editaUsuario.usuario = usuarioSelecionado
        self.navigationController?.pushViewController(editaUsuario, animated: true)
        
    }
    
    func didReturnMessage(parsedObject: NSMutableArray, data: NSMutableData) {
        
        self.parsedObject = parsedObject
        
        self.tableView.reloadData()
        
    }
    
}
