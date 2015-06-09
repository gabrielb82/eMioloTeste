//
//  ViewController.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/4/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, SendJSONDelegate, NSURLConnectionDelegate {
    
    @IBOutlet weak var email: UITextField?
    @IBOutlet weak var senha: UITextField?
    @IBOutlet weak var imagemFundo: UIImageView?
    @IBOutlet weak var botaoLogin: UIButton?
    
    var sendJsonObject: sendJSON?
    var jsonIndicatorView: ActivityIndicator?
    
    var usuarioLogado: Usuario?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        email!.delegate = self
        senha!.delegate = self
        
        
        var tapscreen : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:"dismissKeyboard:")
        
        self.view.addGestureRecognizer(tapscreen)
        
        BlurViewEffect(view: imagemFundo!, BlurEffectStyle: .Dark)
        
        botaoLogin!.layer.cornerRadius = 5.0
        botaoLogin!.clipsToBounds = true
        botaoLogin!.layer.borderWidth = 0.5
        botaoLogin!.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func dismissKeyboard(recognizer:UITapGestureRecognizer) {
        email!.resignFirstResponder()
        senha!.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func signIn(sender: AnyObject) {
        senha?.resignFirstResponder()
        var resposta:NSDictionary = ["email":email!.text, "senha":senha!.text]
        
        var postMensagem : NSMutableArray? = NSMutableArray()
        postMensagem?.addObject(resposta)
        sendJsonObject = sendJSON()
        sendJsonObject!.delegate = self
        sendJsonObject!.parametros = postMensagem!
        sendJsonObject!.url = "http://www.cappriola.net/site/emiolo/login.php"
        sendJsonObject!.preparaJSON()
        
        jsonIndicatorView = ActivityIndicator(container: self.view!, posicion: .Center, style: UIActivityIndicatorViewStyle.White)
    }
    
    func didReturnSuccessMessage(sucesso: Bool) {
        jsonIndicatorView?.stopAnimation()
        if sucesso == true {
            var dict = (sendJsonObject?.json?[0] as? NSDictionary)
            usuarioLogado = Usuario(dicionario: dict!)
            
            var userdefault = NSUserDefaults.standardUserDefaults()
            
            userdefault.setValue(usuarioLogado?.idusuario, forKey: "idusuario")
            userdefault.setValue(usuarioLogado?.nome, forKey: "nome")
            userdefault.setValue(usuarioLogado?.email, forKey: "email")
            userdefault.setValue(usuarioLogado?.senha, forKey: "senha")
            
            performSegueWithIdentifier("LogarSegue", sender: self)
        }
        else {
            var alert = UIAlertController(title: "Erro ao logar", message: "Verifique login e senha se estão corretos.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }


}

