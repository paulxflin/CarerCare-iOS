//
//  stepController.swift
//  steps
//
//  Created by Mac Mini on 12/28/19.
//  Copyright © 2019 Mac Mini. All rights reserved.
//  Contributors: Paul, Lishen

import UIKit
import HealthKit
import UserNotifications

// This is the view controller where a lot of nudges are written (Paul)
class stepController: UIViewController {
    let defaults = UserDefaults.standard
    
    let healthStore = HKHealthStore()
    
    
    @IBOutlet weak var lbStep: UILabel!
    @IBOutlet weak var btUpdate: UIButton!
    
    //ln 24-30 Set up VC and get permissions to read steps from Healthkit (Paul)
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.lbStep.text = "None"
        let readType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        healthStore.requestAuthorization(toShare: [], read: [readType]) { _, _ in }
    }
    
    //ln 33-50 function to get step since start of today (Lishen)
    func getStepsCount(forSpecificDate:Date,completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore.execute(query)
    }
    
    //ln 53-59 get steps between a given date range (Paul)
    func getCountStepUsingStatisticsQuery(from start: Date, to end: Date, completion handler: @escaping (HKStatisticsQuery, HKStatistics?, Error?) -> Void) {
        let type = HKSampleType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
        
        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum, completionHandler: handler)
        healthStore.execute(query)
    }
    
    //ln 62-73 add the notification for when user haven't moved for 2 days, and display 5 seconds after function is called (usually through background fetch) (Paul)
    func inactiveNotify() {
        let content = UNMutableNotificationContent()
        content.title = "Haven't moved 2 days"
        content.subtitle = "You haven't moved for 2 days"
        content.body = "Would you like to tell friends you're ok?"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "inactive", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    //ln 76-87 add notification for where users haven't reached their 1000 steps a day goal. Display 5 seconds after notifiaction is called (Paul)
    func tooLazyNotify(_ steps: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Less than 1000 Steps, Current: " + String(steps)
        content.subtitle = "You haven't reached daily walking goal today"
        content.body = "Remember to find time today to take a walk!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "tooLazy", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    //ln 90-101 add notification for where users haven't made calls for a week. Display 5 seconds after notification is called (Paul)
    func noCallsNotify() {
        let content = UNMutableNotificationContent()
        content.title = "Haven't called anyone for a week"
        content.subtitle = "You haven't made any calls for a week"
        content.body = "Would you like to phone a friend?"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "noCalls", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    //ln 104-133 add notification with choices for when wellbeing score should be rated by user, display 10 seconds after notifications is called, but commented out sections shows how to add notification for a specific date and time to repeat (Paul)
    func weeklyNotify() {
        let yes = UNNotificationAction(identifier: "yes", title: "Yes", options: .foreground)
        let no = UNNotificationAction(identifier: "no", title: "No", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "myCategory", actions: [yes, no], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        let content = UNMutableNotificationContent()
        content.title = "Your Predicted Wellbeing Score is..."
        content.body = "Is this accurate?"
        content.categoryIdentifier = "myCategory"
        content.badge = 1
        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 20
//        dateComponents.minute = 49
//        // Weekday 1 - 7 corresponds to Sunday, Monday, ... , Saturday
//        dateComponents.weekday = 3
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "weekly", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        //Debugging: Prints the notifications currently in NotificationCenter
        //center.getPendingNotificationRequests {(requestArray) in print(requestArray)}
    }
    
    //ln 136-179 function that is called usually from app delegate bg fetch, to set up notifications if conditions are met.
    func nudge(){
        // TODO: Check whether user has been inactive for past two days and send off notification
        let now = Date()
        let twoDaysAgo = Date(timeIntervalSinceNow: -2*24*60*60)
        getCountStepUsingStatisticsQuery(from: twoDaysAgo, to: now) { (query, statistics, error) in
            DispatchQueue.main.async {
                if let value = statistics?.sumQuantity()?.doubleValue(for: .count()) {
                    let twoDaysSteps = Int(value)
                    print("fetched two day steps: " + String(twoDaysSteps))
                    if twoDaysSteps < 10 {
                        self.inactiveNotify()
                        //Debugging Prints
                        print("haven't moved for 2 days")
                        print("2 Days Steps: " + String(twoDaysSteps))
                    }
                }
            }
        }
        
        let todayStart = Calendar.current.startOfDay(for: now)
        getCountStepUsingStatisticsQuery(from: todayStart, to: now) { (query, statistics, error) in
            DispatchQueue.main.async {
                if let value = statistics?.sumQuantity()?.doubleValue(for: .count()) {
                    let todaySteps = Int(value)
                    print("fetched today steps: " + String(todaySteps))
                    if todaySteps < 1000 {
                        self.tooLazyNotify(todaySteps)
                        print("haven't taken 1000 steps in a day")
                        print("Today Steps: " + String(todaySteps))
                    }
                }
            }
        }
        
        if defaults.integer(forKey: "totalCalls") == 0 {
            noCallsNotify()
        }
        //This is always called from bg fetch now, but in future when prepared for deployment, and no longer primarily for demo purposes, should be called once repeatably, and automatically updated every Sunday.
        weeklyNotify()
        
        //Calling this here to periodically refresh this week steps, to prevent the async bug.
        getThisWeekSteps()
        //Debugging: Note that the Async execute makes the execution non-sequential
        print("fetched")
    }
    
    //ln 183-193 gets the past 7 day's steps, and stores it (Paul)
    func getThisWeekSteps(){
        let now = Date()
        let oneWeekAgo = Date(timeIntervalSinceNow: -7*24*60*60)
        getCountStepUsingStatisticsQuery(from: oneWeekAgo, to: now) { (query, statistics, error) in
            if let value = statistics?.sumQuantity()?.doubleValue(for: .count()) {
                let oneWeekSteps = Int(value)
                print("fetched one week steps: " + String(oneWeekSteps))
                self.defaults.set(oneWeekSteps, forKey: "oneWeekSteps")
            }
        }
    }
    
    //ln 196-209 get steps since last Sunday, useful for home page display.
    func getStepsSinceLastSunday() {
        let now = Date()
        let cal = Calendar(identifier: .gregorian)
        let comp = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        let lastSunday = cal.date(from: comp)!
        getCountStepUsingStatisticsQuery(from: lastSunday, to: now) { (query, stats, error) in
            if let value = stats?.sumQuantity()?.doubleValue(for: .count()) {
                let stepsSinceSunday = Int(value)
                print("stepsSinceSunday: " + String(stepsSinceSunday))
                self.defaults.set(stepsSinceSunday, forKey: "oneWeekSteps")
            }
            
        }
    }
    
    
    @IBAction func btPressed(_ sender: Any) {
        self.getStepsCount(forSpecificDate: Date()) { (steps) in
            DispatchQueue.main.async(execute: {
                self.lbStep.text =  "\(steps)"
            })
        }
    }
}
