//
//  Usuario.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/5/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import Foundation

class Usuario : NSObject {
    
    var idusuario: String?
    var nome: String?
    var email: String?
    var senha: String?
    var imagem: String?
    var foto: UIImage?
    
    var sendJsonteste: sendJSON?
    
    init(dicionario: NSDictionary) {
        super.init()
        
        if let idusuariotemp = dicionario["idusuario"] as? NSString {
            idusuario = idusuariotemp as String
        }
        if let nometemp = dicionario["nome"] as? NSString {
            nome = nometemp as String
        }
        if let emailtemp = dicionario["email"] as? NSString {
            email = emailtemp as String
        }
        if let senhatemp = dicionario["senha"] as? NSString {
            senha = senhatemp as String
        }
        if let fotoEncodedtemp = dicionario["imagem"] as? NSString {
            imagem = fotoEncodedtemp as String
        }

    }
    
    func salvar() -> Bool {
        var postMensagem : NSMutableArray? = NSMutableArray()
        var dicionarioUsuario:NSDictionary = ["email":self.email!, "senha":self.senha!, "nome":self.nome!, "imagem": self.imagem!]
        postMensagem?.addObject(dicionarioUsuario)
        //sendJsonteste = sendJSON(parametros: postMensagem!, url: "http://www.cappriola.net/site/emiolo/salvaUsuario.php")
        
        return sendJsonteste!.sucesso
    }
    
    func update() -> Bool {
        var postMensagem : NSMutableArray? = NSMutableArray()
        var dicionarioUsuario:NSDictionary = ["email":self.email!, "senha":self.senha!, "nome":self.nome!, "imagem": self.imagem!, "idusuario": self.idusuario!]
        postMensagem?.addObject(dicionarioUsuario)
        //sendJsonteste = sendJSON(parametros: postMensagem!, url: "http://www.cappriola.net/site/emiolo/updateUsuario.php")
        
        return sendJsonteste!.sucesso
    }
}
