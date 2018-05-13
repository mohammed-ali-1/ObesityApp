//
//  OnboardingViewController.swift
//  ObesityApp
//
//  Created by Mohammed Al Ameen on 4/14/18.
//  Copyright © 2018 uos. All rights reserved.
//

import UIKit
import ResearchKit

class OnboardingViewController: UIViewController {
    // MARK: IB actions
    
    @IBAction func joinButtonTapped(_ sender: UIButton) {
        let consentDocument = ConsentDocument()
        let consentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
        
        let healthDataStep = HealthDataStep(identifier: "Health")
        
        let signature = consentDocument.signatures!.first!
        
        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
        
        reviewConsentStep.text = "Review the consent form."
        reviewConsentStep.reasonForConsent = "Consent to join the Developer Health Research Study."
        
        let passcodeStep = ORKPasscodeStep(identifier: "Passcode")
        passcodeStep.text = "Now you will create a passcode to identify yourself to the app and protect access to information you've entered."
        let registrationOptions: ORKRegistrationStepOption = [.includeGivenName, .includeFamilyName, .includeGender, .includeDOB, .includePhoneNumber]
        
        let registrationStep = ORKRegistrationStep(identifier: "Registration", title: "Register", text: "Please register to join the study", options: registrationOptions)
        
        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = "Welcome aboard."
        completionStep.text = "Thank you for joining this study."
        
        let orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, reviewConsentStep,
                                                                     registrationStep,
                                                                     healthDataStep, passcodeStep, completionStep])
        let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
        taskViewController.delegate = self
        
        present(taskViewController, animated: true, completion: nil)
    }
}

extension OnboardingViewController : ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
//            print(taskViewController.result.stepResult(forStepIdentifier: "Registration")!)
            let signUpResults = taskViewController.result.stepResult(forStepIdentifier: "Registration")
            let jsonDict = NSMutableDictionary()
            var fullName = ""
            for stepResult in [signUpResults!] as [ORKStepResult] {
                
                for result in stepResult.results! {
                    
                    switch result.identifier {
                    case "ORKRegistrationFormItemEmail", "ORKRegistrationFormItemPassword", "ORKRegistrationFormItemPhoneNumber":
                        let key = result.identifier
                        let value = (result as! ORKTextQuestionResult).textAnswer!
                        jsonDict.setValue(value, forKey: key)
                    break
                    case "ORKRegistrationFormItemDOB":
                        let dob = (result as! ORKDateQuestionResult).dateAnswer
                        let formatter = DateFormatter()
                        formatter.setLocalizedDateFormatFromTemplate("yyyy");
                        let dobString = formatter.string(from: dob!)
                        let dobInt = Int(dobString)!
                        jsonDict.setValue(dobInt, forKey: "dob")
                    break
                    case "ORKRegistrationFormItemGender":
                        let key = result.identifier
                        let genderAnswer = (result as! ORKChoiceQuestionResult).choiceAnswers
                        jsonDict.setValue(genderAnswer?[0], forKey: key)
                        
                    break
                    case "ORKRegistrationFormItemGivenName", "ORKRegistrationFormItemFamilyName":
                        fullName += (result as! ORKTextQuestionResult).textAnswer!
                        jsonDict.setValue((result as! ORKTextQuestionResult).textAnswer!, forKey: result.identifier)
                        if result.identifier == "ORKRegistrationFormItemGivenName"{
                            UserDefaults.standard.set((result as! ORKTextQuestionResult).answer, forKey: "firstName")
                        } else if result.identifier == "ORKRegistrationFormItemFamilyName" {
                            UserDefaults.standard.set((result as! ORKTextQuestionResult).answer, forKey: "lastName")
                        }
                    break
                    default: break
                    }
                }
            }
            jsonDict.setValue(fullName, forKey: "fullName")
            //  jsonDict.setValue(taskViewController.taskRunUUID, forKey: "UUID")
//            print(jsonDict)
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict)
            
            let url = URL(string: "http://mohdalameen.ddns.net:5985/users")
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
                let responseDict = responseJSON as! NSDictionary
                let id = responseDict.value(forKey: "id")
                let ok = responseDict.value(forKey: "ok") as! Bool
                if (id != nil) &&  ok {
                    UserDefaults.standard.set(id, forKey: "recordId")
                }
                
                //            if (UserDefaults.standard.string(forKey: "couchDB_id") == nil){
                //
                //                UserDefaults.standard.set((responseDict.value(forKey: "id")) as! String, forKey: "couchDB_id")
                //            }
                
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }
            
            task.resume()
            
            performSegue(withIdentifier: "unwindToStudy", sender: nil)
            
        case .discarded, .failed, .saved:
            dismiss(animated: true, completion: nil)
        }
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, viewControllerFor step: ORKStep) -> ORKStepViewController? {
        if step is HealthDataStep {
            let healthStepViewController = HealthDataStepViewController(step: step)
            return healthStepViewController
        }
        
        return nil
    }
}

