//
//  DetailViewController.swift
//  wheatherapp
//
//  Created by Marcus Nilsson on 2020-02-18.
//  Copyright © 2020 Marcus Nilsson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var apiIcon: UIImageView!
    @IBOutlet weak var infoLableOne: UILabel!
    @IBOutlet weak var infoLableTwo: UILabel!
    @IBOutlet weak var infoLableThree: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextView!
    
    
    //gets city from segue
    var specCity = ""
    var urlCity = ""
    var animator: UIDynamicAnimator!
    var gravity: UIDynamicBehavior!
    var collision: UICollisionBehavior!
    
    //url weather icon
    var baseImageURL = "http://openweathermap.org/img/wn/"
    var imageCode = ""
    var imageFormat = "@2x.png"
    
    // specific information variables
    var sTemp: Float = 0.0
    var sMaxTemp: Float = 0.0
    var sDescription = ""
    var ae = "ae"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // byter ut Ä mot ae i url
        urlCity = specCity.replacingOccurrences(of: "ä", with: "ae", options: .literal, range: nil)
        citylbl.text = "VäderInformation om "+specCity
        
        
        loadSpecificWeather()
    }
    func loadSpecificWeather(){
        
        // Api anrop
        var wheather = weatherAPI()
        wheather.city = specCity
        
        wheather.getWeather(city: urlCity){(result) in
        switch result{
            case.success(let jsonData):
                
                //Om datan kommer tebax som den ska så sätts den till olika properties i main thred
                DispatchQueue.main.async {
                    self.imageCode = jsonData.weather[0].icon
                    self.sTemp = jsonData.main.temp
                    self.sMaxTemp = jsonData.main.temp_max
                    self.sDescription = jsonData.weather[0].description
                    self.loadDetails()
            }
            case.failure(let error):
                
                //Om datan inte hämtas som den ska så får man en ett felmedelande
                DispatchQueue.main.async {
                    self.sDescription = error.localizedDescription
                    self.showError()
                }
            }
        }

    }
    func showError(){
        self.infoLableOne.text = "Något gick fel \(sDescription)"
    }
    func loadDetails(){
        print("in loadDetails")
        self.infoLableOne.text = "Idag är det \(sDescription) i \(specCity)"
        self.infoLableTwo.text = "Temperaturen är \(sTemp) °C"
        self.infoLableThree.text = "Max Temperaturen i \(specCity) idag är \(sMaxTemp)"
        loadImage()
        
    }
    func loadImage(){
        print("in load image")
        let fullImageUrl = (self.baseImageURL)+(self.imageCode)+(self.imageFormat)
            if let url = URL(string:fullImageUrl){
                
            do{
                let data = try Data(contentsOf: url)
                self.apiIcon.image = UIImage(data: data)
            }catch let error{
                print("Error: \(error.localizedDescription)")
            }
        }
        
        UIView.animate(withDuration: 2.0, animations: {
            self.apiIcon.transform = CGAffineTransform(rotationAngle: 20)
        }) { (_) in
            UIView.animate(withDuration: 2.0){
              self.apiIcon.transform = CGAffineTransform(rotationAngle: 0)
            }
            
        }
    }
    func recomendation(){
        if sTemp < 10.0 {
            self.textField.text = "Du bör använda jacka och kanske till och med en huvudbodnad"
        }
        else if(sTemp <= 17.9 || sDescription == "broken clouds"){
            self.textField.text = "En jacka är att rekomendera om du skall gå ut idag"
        }
        else if(sTemp > 18){
            self.textField.text = "Idag behöver du ingen jacka, men en tröja är ju aldrig fel att ha med sig om man ska ut"
        }
        
    }
        //shows recomendation and activates UIDynamics
    @IBAction func buttonClick(_ sender: Any) {
        recomendation()
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [textField])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [textField])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
    }
}
