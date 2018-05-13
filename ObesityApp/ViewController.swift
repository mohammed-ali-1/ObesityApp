//
//  ViewController.swift
//  ObesityApp
//
//  Created by Mohammed Al Ameen on 2/24/18.
//  Copyright © 2018 uos. All rights reserved.
//

import UIKit
import ResearchKit
import Foundation

class ViewController: UIViewController, ORKTaskViewControllerDelegate {
    
    var savedRestorationData : Data?
    var savedTask : ORKTask?
    
    
    func taskViewControllerSupportsSaveAndRestore(_ taskViewController: ORKTaskViewController) -> Bool {
        return taskViewController.task?.identifier == SurveyTask.identifier
    }
    
    func taskViewController(
        _ taskViewController: ORKTaskViewController,
        didFinishWith reason: ORKTaskViewControllerFinishReason,
        error: Error?) {
        
        
        
//        if (UserDefaults.standard.string(forKey: "couchDB_id") != nil){
//            jsonDict.setValue((UserDefaults.standard.string(forKey: "couchDB_id")), forKey: "_id")
//        }

        //print(taskResult!)
        if (reason == .completed){
            print("The survey was cacelled!")
        }
        if (reason == ORKTaskViewControllerFinishReason.completed){
            let taskResult = taskViewController.result.results
            let jsonDict:NSMutableDictionary = NSMutableDictionary()
            
            for stepResults in taskResult! as! [ORKStepResult]
            {
                print("---")
                for result in stepResults.results!
                {
                    
                    if result.identifier == "weightQuestion"
                    {
                        let ident = result.identifier
                        print (ident)
                        let weightQuestionResult = result as! ORKNumericQuestionResult
                        let weight = weightQuestionResult.answer!
                        print(weight)
                        jsonDict.setValue(weight, forKey: ident)
                    }
                    if result.identifier == "heightQuestion"
                    {
                        let ident = result.identifier
                        print (ident)
                        let heightQuestionResult = result as! ORKNumericQuestionResult
                        let height = heightQuestionResult.answer!
                        print(height)
                        jsonDict.setValue(height, forKey: ident )
                    }
                    if result.identifier == "waistCircumQuestion"
                    {
                        let ident = result.identifier
                        print (ident)
                        let circumQuestionResult = result as! ORKNumericQuestionResult
                        let circum = circumQuestionResult.answer!
                        print(circum)
                        jsonDict.setValue(circum, forKey: ident)
                    }
                    if result.identifier == "dobQuestion"
                    {
                        let ident = result.identifier
                        print (ident)
                        let dobQuestionResult = result as! ORKDateQuestionResult
                        let dob = dobQuestionResult.answer!
                        print(dob)
                        let formatter:DateFormatter = DateFormatter();
                        formatter.setLocalizedDateFormatFromTemplate("yyyy");
                        let dobString:String = formatter.string(from: dob as! Date);
                        let dobInt:Int = Int(dobString)!
                        jsonDict.setValue(dobInt, forKey: ident)
                    }
                    if result.identifier == "genderQuestion"
                    {
                        let ident = result.identifier
                        print (ident)
                        let genderQuestionResult = result as! ORKBooleanQuestionResult
                        let genderAnswer = genderQuestionResult.answer! as! Bool
                        let gender = genderAnswer ? "Male" : "Female"
                        print(gender)
                         jsonDict.setValue(gender, forKey: ident)
                    }
                }
            }
        
            
            print(jsonDict)
            
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict)
            
            let url = URL(string: "http://mohdalameen.ddns.net:5985/survey_results")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }

            task.resume()
        }
        else if reason == .saved {
            savedTask = taskViewController.task
            savedRestorationData = taskViewController.restorationData
            UserDefaults.standard.set(true, forKey: "Survey_Saved")
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        //UserDefaults.standard.removeObject(forKey: "couchDB_id")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func DbSurveyTest(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: DbSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func consentClicked(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func surveyClicked(_ sender: UIButton) {
        if savedRestorationData != nil && savedTask != nil && UserDefaults.standard.bool(forKey: "Survey_Saved"){
            UserDefaults.standard.removeObject(forKey: "Survey_Saved")
            UserDefaults.standard.set(false, forKey: "Survey_Saved")
            let taskViewController = ORKTaskViewController(task: savedTask, restorationData: savedRestorationData, delegate: self)
            present(taskViewController, animated: true, completion: nil)
        } else {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
        }
    }
    
    
}

