//
//  MainViewController.swift
//  GetReady
//
//  Created by Eldon Chan on 9/1/16.
//  Copyright © 2016 Eldon. All rights reserved.
//

import UIKit
import CoreLocation
import HTPressableButton

class MainViewController: UIViewController, CLLocationManagerDelegate {
    let shared = DataStore.sharedDataStore
    
    var weatherImageView = UIImageView()
    var temperatureLabel = UILabel()
    var locationLabel = UILabel()
    var weatherLabel = UILabel()
    var outlookLabel = UILabel()
    var whatToBringLabel = UILabel()
    var reminderLabel = UILabel()
    var reminderLabel2 = UILabel()
    var reminderImageView = UIImageView()
    var hourlyConditions = [WeatherInfo]()
    var hourlyScrollView = UIScrollView()
    var perHourImageView1 = UIImageView()
    var perHourImageView2 = UIImageView()
    var perHourImageView3 = UIImageView()
    var perHourImageView4 = UIImageView()
    var perHourImageView5 = UIImageView()
    var perHourImageView6 = UIImageView()
    var perHourImageView7 = UIImageView()
    var perHourImageView8 = UIImageView()
    var perHourImageView9 = UIImageView()
    var perHourImageView10 = UIImageView()
    var perHourImageView11 = UIImageView()
    var perHourImageView12 = UIImageView()
    var perHourLabel1 = UILabel()
    var perHourLabel2 = UILabel()
    var perHourLabel3 = UILabel()
    var perHourLabel4 = UILabel()
    var perHourLabel5 = UILabel()
    var perHourLabel6 = UILabel()
    var perHourLabel7 = UILabel()
    var perHourLabel8 = UILabel()
    var perHourLabel9 = UILabel()
    var perHourLabel10 = UILabel()
    var perHourLabel11 = UILabel()
    var perHourLabel12 = UILabel()
    let locationButton = UIButton()
    var locationManager = CLLocationManager()
    
    var city = String()
    var state = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupLayout()
        view.backgroundColor = UIColor.grayColor()
        
    }
    
    override func viewWillAppear(animated: Bool) {

        
//        print("WILL APPEAR \(self.shared.currentInfo.city)")
        APIClient.getWeather { (responseData) in
            
//            print("RESPONSE :: \(responseData)")
            
            NSOperationQueue.mainQueue().addOperationWithBlock({    
            
                let location = self.shared.currentInfo
                var temp = String()
                
                if let tempNum = responseData["current_observation"]!["temp_f"] as? Double
                {
                    let newNum = Double(round(100*tempNum)/100)
                    temp = "\(newNum)"
                }
                
                let condition = responseData["current_observation"]!["weather"] as! String
                self.temperatureLabel.text = "\(temp) F"
                self.locationLabel.text = "\(location.city), \(location.state)"
                self.weatherLabel.text = responseData["current_observation"]!["weather"] as? String
                
//                print ("WTFcity: \(location.city)")
//                print ("WTFstate: \(location.state)")
                
                switch condition {
                case "Rain":
                    self.weatherImageView.image = UIImage(named: "rain")
                case "Chance of Rain":
                    self.weatherImageView.image = UIImage(named: "rain-2")
                case "Thunderstorm":
                    self.weatherImageView.image = UIImage(named: "storm")
                case "Chance of a Thunderstorm":
                    self.weatherImageView.image = UIImage(named: "storm")
                case "Light Drizzle Mist":
                    self.weatherImageView.image = UIImage(named: "rain-1")
                case "Light Showers Rain":
                    self.weatherImageView.image = UIImage(named: "rain-1")
                case "Light Rain":
                    self.weatherImageView.image = UIImage(named: "rain-2")
                case "Partly Cloudy":
                    self.weatherImageView.image = UIImage(named: "cloud-2")!
                case "Mostly Cloudy":
                    self.weatherImageView.image = UIImage(named: "cloud-2")!
                default :
                    self.weatherImageView.image = UIImage(named: "sun")
                }

                
            })
        }
        
        APIClient.getHourlyWeather { (responseData) in
            
//            print("RESPONSE HOURLY \(responseData)")
            NSOperationQueue.mainQueue().addOperationWithBlock({
       
                let hourly = responseData["hourly_forecast"] as! [AnyObject]
                
                self.hourlyConditions.removeAll()
                
                for (index,_) in hourly.enumerate() {
                    
                    var weather = WeatherInfo()
//                    print (hourly[index]["condition"])
//                    print (hourly[index]["FCTTIME"]!!["civil"])
                    let condition = hourly[index]["condition"] as! String
                    let time = hourly[index]["FCTTIME"]!!["civil"] as! String
                    
                    weather.condition = condition
                    weather.time = time
                    
                    self.hourlyConditions.append(weather)
                }
                
                
            })
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
        
                self.perHourImageView1.image = self.checkWeather(self.hourlyConditions[0])
                self.perHourImageView2.image = self.checkWeather(self.hourlyConditions[1])
                self.perHourImageView3.image = self.checkWeather(self.hourlyConditions[2])
                self.perHourImageView4.image = self.checkWeather(self.hourlyConditions[3])
                self.perHourImageView5.image = self.checkWeather(self.hourlyConditions[4])
                self.perHourImageView6.image = self.checkWeather(self.hourlyConditions[5])
                self.perHourImageView7.image = self.checkWeather(self.hourlyConditions[6])
                self.perHourImageView8.image = self.checkWeather(self.hourlyConditions[7])
                self.perHourImageView9.image = self.checkWeather(self.hourlyConditions[8])
                self.perHourImageView10.image = self.checkWeather(self.hourlyConditions[9])
                self.perHourImageView11.image = self.checkWeather(self.hourlyConditions[10])
                self.perHourImageView12.image = self.checkWeather(self.hourlyConditions[11])
                
                self.perHourLabel1.text = self.hourlyConditions[0].time
                self.perHourLabel2.text = self.hourlyConditions[1].time
                self.perHourLabel3.text = self.hourlyConditions[2].time
                self.perHourLabel4.text = self.hourlyConditions[3].time
                self.perHourLabel5.text = self.hourlyConditions[4].time
                self.perHourLabel6.text = self.hourlyConditions[5].time
                self.perHourLabel7.text = self.hourlyConditions[6].time
                self.perHourLabel8.text = self.hourlyConditions[7].time
                self.perHourLabel9.text = self.hourlyConditions[8].time
                self.perHourLabel10.text = self.hourlyConditions[9].time
                self.perHourLabel11.text = self.hourlyConditions[10].time
                self.perHourLabel12.text = self.hourlyConditions[11].time
            })
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                
                var willRain = false
                
                for (index,weather) in self.hourlyConditions.enumerate() {
                    
                    if index < 12 {
                        if weather.condition.containsString("Rain") || weather.condition.containsString("Thunderstorm") {
                            willRain = true
                        }

                    }
                    
                }
                
                if willRain {
                    self.reminderLabel.text = "It might rain, bring an umbrella!"
                    self.reminderImageView.image = UIImage(named: "umbrella")
                }
                    
                else {
                    self.reminderLabel.text = "It will be beautiful all day!"
                    self.reminderImageView.image = UIImage(named: "sunglasses")
                }
            })
        

        }
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLayout() {
        
//        view.addSubview(locationButton)
//        locationButton.translatesAutoresizingMaskIntoConstraints = false
//        locationButton.setImage(UIImage(named:"cog" ), forState: .Normal)
//        locationButton.addTarget(self, action: #selector(locationButtonTapped), forControlEvents: .TouchUpInside)
//        locationButton.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 40).active = true
//        locationButton.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -20).active = true
//        locationButton.heightAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.075).active = true
//        locationButton.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.075).active = true
        
        view.addSubview(weatherImageView)
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: -80).active = true
        weatherImageView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 60).active = true
        weatherImageView.heightAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.30).active = true
        weatherImageView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.30).active = true
        
        view.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.textColor = UIColor.whiteColor()
        temperatureLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        temperatureLabel.topAnchor.constraintEqualToAnchor(weatherImageView.topAnchor, constant: 10).active = true
        temperatureLabel.leftAnchor.constraintEqualToAnchor(weatherImageView.rightAnchor, constant: 20).active = true
        
        
        view.addSubview(weatherLabel)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.textColor = UIColor.whiteColor()
        weatherLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        weatherLabel.topAnchor.constraintEqualToAnchor(temperatureLabel.bottomAnchor, constant: 0).active = true
        weatherLabel.centerXAnchor.constraintEqualToAnchor(temperatureLabel.centerXAnchor).active = true
        
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textColor = UIColor.whiteColor()
        locationLabel.topAnchor.constraintEqualToAnchor(weatherLabel.bottomAnchor, constant: 0).active = true
        locationLabel.centerXAnchor.constraintEqualToAnchor(weatherLabel.centerXAnchor).active = true
        
        view.addSubview(outlookLabel)
        outlookLabel.translatesAutoresizingMaskIntoConstraints = false
        outlookLabel.textColor = UIColor.whiteColor()
        outlookLabel.text = "Get Ready"
        outlookLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        outlookLabel.topAnchor.constraintEqualToAnchor(locationLabel.bottomAnchor, constant: 50).active = true
        outlookLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        
        view.addSubview(reminderLabel)
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        reminderLabel.textColor = UIColor.whiteColor()
        reminderLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        reminderLabel.topAnchor.constraintEqualToAnchor(outlookLabel.bottomAnchor, constant: 10).active = true
        reminderLabel.centerXAnchor.constraintEqualToAnchor(outlookLabel.centerXAnchor).active = true
        
        view.addSubview(reminderImageView)
        reminderImageView.translatesAutoresizingMaskIntoConstraints = false
        reminderImageView.topAnchor.constraintEqualToAnchor(reminderLabel.bottomAnchor, constant: 10).active = true
        reminderImageView.centerXAnchor.constraintEqualToAnchor(reminderLabel.centerXAnchor).active = true
        reminderImageView.heightAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.20).active = true
        reminderImageView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.20).active = true
        
        view.addSubview(hourlyScrollView)
        hourlyScrollView.translatesAutoresizingMaskIntoConstraints = false
        hourlyScrollView.backgroundColor = UIColor.clearColor()
        hourlyScrollView.contentSize = CGSize(width: 1065, height: 100)
        hourlyScrollView.showsHorizontalScrollIndicator = false
        hourlyScrollView.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.20).active = true
        hourlyScrollView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -20).active = true
        hourlyScrollView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        hourlyScrollView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView1)
        perHourImageView1.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView1.topAnchor.constraintEqualToAnchor(hourlyScrollView.topAnchor, constant: 5).active = true
        perHourImageView1.heightAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.2).active = true
        perHourImageView1.leftAnchor.constraintEqualToAnchor(hourlyScrollView.leftAnchor, constant: 5).active = true
        perHourImageView1.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.2).active = true
        
        hourlyScrollView.addSubview(perHourLabel1)
        perHourLabel1.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel1.textColor = UIColor.whiteColor()
        perHourLabel1.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel1.topAnchor.constraintEqualToAnchor(perHourImageView1.bottomAnchor, constant: 5).active = true
        perHourLabel1.centerXAnchor.constraintEqualToAnchor(perHourImageView1.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView2)
        perHourImageView2.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView2.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView2.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView2.leftAnchor.constraintEqualToAnchor(perHourImageView1.rightAnchor, constant: 5).active = true
        perHourImageView2.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel2)
        perHourLabel2.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel2.textColor = UIColor.whiteColor()
        perHourLabel2.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel2.topAnchor.constraintEqualToAnchor(perHourImageView2.bottomAnchor, constant: 5).active = true
        perHourLabel2.centerXAnchor.constraintEqualToAnchor(perHourImageView2.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView3)
        perHourImageView3.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView3.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView3.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView3.leftAnchor.constraintEqualToAnchor(perHourImageView2.rightAnchor, constant: 5).active = true
        perHourImageView3.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel3)
        perHourLabel3.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel3.textColor = UIColor.whiteColor()
        perHourLabel3.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel3.topAnchor.constraintEqualToAnchor(perHourImageView3.bottomAnchor, constant: 5).active = true
        perHourLabel3.centerXAnchor.constraintEqualToAnchor(perHourImageView3.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView4)
        perHourImageView4.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView4.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView4.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView4.leftAnchor.constraintEqualToAnchor(perHourImageView3.rightAnchor, constant: 5).active = true
        perHourImageView4.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel4)
        perHourLabel4.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel4.textColor = UIColor.whiteColor()
        perHourLabel4.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel4.topAnchor.constraintEqualToAnchor(perHourImageView4.bottomAnchor, constant: 5).active = true
        perHourLabel4.centerXAnchor.constraintEqualToAnchor(perHourImageView4.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView5)
        perHourImageView5.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView5.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView5.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView5.leftAnchor.constraintEqualToAnchor(perHourImageView4.rightAnchor, constant: 5).active = true
        perHourImageView5.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel5)
        perHourLabel5.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel5.textColor = UIColor.whiteColor()
        perHourLabel5.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel5.topAnchor.constraintEqualToAnchor(perHourImageView5.bottomAnchor, constant: 5).active = true
        perHourLabel5.centerXAnchor.constraintEqualToAnchor(perHourImageView5.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView6)
        perHourImageView6.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView6.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView6.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView6.leftAnchor.constraintEqualToAnchor(perHourImageView5.rightAnchor, constant: 5).active = true
        perHourImageView6.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel6)
        perHourLabel6.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel6.textColor = UIColor.whiteColor()
        perHourLabel6.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel6.topAnchor.constraintEqualToAnchor(perHourImageView6.bottomAnchor, constant: 5).active = true
        perHourLabel6.centerXAnchor.constraintEqualToAnchor(perHourImageView6.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView7)
        perHourImageView7.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView7.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView7.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView7.leftAnchor.constraintEqualToAnchor(perHourImageView6.rightAnchor, constant: 5).active = true
        perHourImageView7.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel7)
        perHourLabel7.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel7.textColor = UIColor.whiteColor()
        perHourLabel7.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel7.topAnchor.constraintEqualToAnchor(perHourImageView7.bottomAnchor, constant: 5).active = true
        perHourLabel7.centerXAnchor.constraintEqualToAnchor(perHourImageView7.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView8)
        perHourImageView8.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView8.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView8.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView8.leftAnchor.constraintEqualToAnchor(perHourImageView7.rightAnchor, constant: 5).active = true
        perHourImageView8.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel8)
        perHourLabel8.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel8.textColor = UIColor.whiteColor()
        perHourLabel8.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel8.topAnchor.constraintEqualToAnchor(perHourImageView8.bottomAnchor, constant: 5).active = true
        perHourLabel8.centerXAnchor.constraintEqualToAnchor(perHourImageView8.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView9)
        perHourImageView9.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView9.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView9.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView9.leftAnchor.constraintEqualToAnchor(perHourImageView8.rightAnchor, constant: 5).active = true
        perHourImageView9.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel9)
        perHourLabel9.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel9.textColor = UIColor.whiteColor()
        perHourLabel9.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel9.topAnchor.constraintEqualToAnchor(perHourImageView9.bottomAnchor, constant: 5).active = true
        perHourLabel9.centerXAnchor.constraintEqualToAnchor(perHourImageView9.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView10)
        perHourImageView10.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView10.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView10.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView10.leftAnchor.constraintEqualToAnchor(perHourImageView9.rightAnchor, constant: 5).active = true
        perHourImageView10.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel10)
        perHourLabel10.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel10.textColor = UIColor.whiteColor()
        perHourLabel10.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel10.topAnchor.constraintEqualToAnchor(perHourImageView10.bottomAnchor, constant: 5).active = true
        perHourLabel10.centerXAnchor.constraintEqualToAnchor(perHourImageView10.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView11)
        perHourImageView11.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView11.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView11.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView11.leftAnchor.constraintEqualToAnchor(perHourImageView10.rightAnchor, constant: 5).active = true
        perHourImageView11.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel11)
        perHourLabel11.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel11.textColor = UIColor.whiteColor()
        perHourLabel11.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel11.topAnchor.constraintEqualToAnchor(perHourImageView11.bottomAnchor, constant: 5).active = true
        perHourLabel11.centerXAnchor.constraintEqualToAnchor(perHourImageView11.centerXAnchor).active = true
        
        hourlyScrollView.addSubview(perHourImageView12)
        perHourImageView12.translatesAutoresizingMaskIntoConstraints = false
        perHourImageView12.topAnchor.constraintEqualToAnchor(perHourImageView1.topAnchor).active = true
        perHourImageView12.heightAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        perHourImageView12.leftAnchor.constraintEqualToAnchor(perHourImageView11.rightAnchor, constant: 5).active = true
        perHourImageView12.widthAnchor.constraintEqualToAnchor(perHourImageView1.widthAnchor).active = true
        
        hourlyScrollView.addSubview(perHourLabel12)
        perHourLabel12.translatesAutoresizingMaskIntoConstraints = false
        perHourLabel12.textColor = UIColor.whiteColor()
        perHourLabel12.font = UIFont(name: "HelveticaNeue", size: 12)
        perHourLabel12.topAnchor.constraintEqualToAnchor(perHourImageView12.bottomAnchor, constant: 5).active = true
        perHourLabel12.centerXAnchor.constraintEqualToAnchor(perHourImageView12.centerXAnchor).active = true

        
    }
    
    func checkWeather(weather: WeatherInfo) -> UIImage {
        
        switch weather.condition {
            
        case "Rain":
            return UIImage(named: "rain")!
        case "Chance of Rain":
            return UIImage(named: "rain-2")!
        case "Thunderstorm":
            return UIImage(named: "storm")!
        case "Chance of a Thunderstorm":
            return UIImage(named: "storm")!
        case "Light Drizzle Mist":
            return UIImage(named: "rain-1")!
        case "Light Showers Rain":
            return UIImage(named: "rain-1")!
        case "Light Rain":
            return UIImage(named: "rain-2")!
        case "Partly Cloudy":
            return UIImage(named: "cloud-2")!
        case "Mostly Cloudy":
            return UIImage(named: "cloud-2")!
        default :
            return UIImage(named: "sun")!
        }
    }


}

