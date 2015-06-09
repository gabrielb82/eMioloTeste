//
//  NasaPassouTableViewController.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/8/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import UIKit

import CoreLocation

class NasaPassouTableViewController: UITableViewController, UITableViewDelegate, NSURLConnectionDelegate, RunJSONDelegate, GetLocationDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var getJSON: runJSON?
    var parsedObject: NSMutableArray? = NSMutableArray()
    
    var getLocal = getLocation()
    
    var nasaPassou: NASAPassou?
    
    func didUpdateLocation(message: NSString, placemark: CLPlacemark) {
        
        let doisAnosAtras = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitYearForWeekOfYear, value: -2, toDate: NSDate(), options: NSCalendarOptions.WrapComponents)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        getJSON = runJSON(urlPath: "https://api.nasa.gov/planetary/earth/assets?lon=\(placemark.location.coordinate.longitude)&lat=\(placemark.location.coordinate.latitude)&begin=\(dateFormatter.stringFromDate(doisAnosAtras!))&api_key=OCl0TWsRIwkIY5r0yuDLYdirCQAoahHhNBTynGmm")
        getJSON?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocal.delegate = self
        
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
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("CellNASAPassou") as? UITableViewCell
        
        if let data = nasaPassou?.resultados?[indexPath.row] as? NSDictionary {
            cell.textLabel?.text = nasaPassou!.retornaData(data)
        }
        
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nasaPassou != nil {
            return nasaPassou!.resultados!.count
        }
        else {
            return 0
        }
    }
    
    func didReturnMessage(parsedObject: NSMutableArray, data: NSMutableData) {
        
        self.parsedObject = parsedObject
        
        nasaPassou = NASAPassou(dados: data)
        
        self.tableView.reloadData()
        
    }
    
}
