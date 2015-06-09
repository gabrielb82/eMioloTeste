//
//  EditarUsuarioViewController.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/8/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import UIKit
import MobileCoreServices

class EditarUsuarioViewController: UIViewController, UITextFieldDelegate, SendJSONDelegate, NSURLConnectionDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nome: UITextField?
    @IBOutlet weak var email: UITextField?
    @IBOutlet weak var senha: UITextField?
    @IBOutlet weak var fotoPerfil: UIImageView?
    @IBOutlet weak var menuButton: UIBarButtonItem?
    
    var sendJsonteste: sendJSON?
    var jsonIndicatorView: ActivityIndicator?
    
    var usuario: Usuario?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var tapscreen : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:"dismissKeyboard:")
        self.view.addGestureRecognizer(tapscreen)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 200
        
        self.fotoPerfil?.layer.cornerRadius = self.fotoPerfil!.frame.size.width / 2
        self.fotoPerfil?.clipsToBounds = true
        self.fotoPerfil?.layer.borderWidth = 1.0
        self.fotoPerfil?.layer.borderColor = UIColor.whiteColor().CGColor
        
        nome?.text = usuario!.nome
        email?.text = usuario!.email
        senha?.text = usuario!.senha
        
        var idusuario = usuario!.idusuario
        let url = NSURL(string: "http://www.cappriola.net/site/emiolo/imagens/\(idusuario!).jpg")
        let data = NSData(contentsOfURL: url!)
        fotoPerfil?.image = UIImage(data: data!)

    }
    
    func dismissKeyboard(recognizer:UITapGestureRecognizer) {
        email!.resignFirstResponder()
        senha!.resignFirstResponder()
        nome!.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func tiraFoto(sender: AnyObject) {
        
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.mediaTypes = [kUTTypeImage as NSString]
        imagePicker.allowsEditing = false
        
        self.presentViewController(imagePicker, animated: true,
            completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        // Code here to work with media
        
        let foto = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        fotoPerfil?.image = foto
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func salvarUsuario(sender: AnyObject) {
        var salvarConfirm = UIAlertController(title: "Salvar", message: "Deseja realmente salvar essas informações?", preferredStyle: UIAlertControllerStyle.Alert)
        
        salvarConfirm.addAction(UIAlertAction(title: "Não", style: .Default, handler: nil))
        
        salvarConfirm.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction!) in
            let data = UIImageJPEGRepresentation(self.fotoPerfil!.image, 0.5)
            let encodedImage = data.base64EncodedStringWithOptions(.allZeros)
            var dicionarioUsuario:NSDictionary = ["email":self.email!.text, "senha":self.senha!.text, "nome":self.nome!.text, "imagem": encodedImage]
            let novoUsuario = Usuario(dicionario: dicionarioUsuario)
            novoUsuario.foto = self.fotoPerfil!.image
            novoUsuario.update()
        }))
        
        presentViewController(salvarConfirm, animated: true, completion: nil)
    }
    
    @IBAction func voltar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
}

