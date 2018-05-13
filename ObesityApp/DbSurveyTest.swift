//
//  DbSurveyTest.swift
//  ObesityApp
//
//  Created by Mohammed Al Ameen on 4/8/18.
//  Copyright © 2018 uos. All rights reserved.
//

import Foundation
import ResearchKit

public var DbSurveyTask: ORKOrderedTask {
    var steps = [ORKStep]()
    var form1Questions = [ORKFormItem]()
    var genders = [ORKTextChoice]()
    
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Test Survey"
    instructionStep.text = "This survey is pretty involved. \nPlease take the time to answer all questions. \nCollecting detailed information helps us produce accurate results."
    steps += [instructionStep]
    //End of: Instruction step
    
    
    
    

    //Creation of the first form
    let form1 = ORKFormStep(identifier: "form1", title: "First Form", text: "Please answer the following questions")
    //

    //Beginning of: Weight question
    let sectionTitle = ORKFormItem(sectionTitle: "General information")
    form1Questions += [sectionTitle]

    let weightAnswerFormat = ORKWeightAnswerFormat(measurementSystem: ORKMeasurementSystem.metric, numericPrecision: ORKNumericPrecision.low)
    let weightQuestionText = "Enter your weight (in kilograms): "
    let weightQuestion = ORKFormItem(identifier: "weightQuestion", text: weightQuestionText, answerFormat: weightAnswerFormat, optional: false)

    weightQuestion.placeholder = "Add weight"
    form1Questions += [weightQuestion]
    //End of: Weight question

//    //Beginning of: Height question
//    let heightAnswerFormat = ORKHeightAnswerFormat(measurementSystem: ORKMeasurementSystem(rawValue: 1)!)
//    let heightQuestionText = "Enter your height (in centimeters): "
//    let heightQuestion = ORKFormItem(identifier: "heightQuestion", text: heightQuestionText, answerFormat: heightAnswerFormat, optional: false)
//    heightQuestion.placeholder = "Add height"
//
//    form1Questions += [heightQuestion]
//    //End of: Height question

//    //Beginning of: Waist circumference question
//    //let waistCircumAnswerFormat = ORKNumericAnswerFormat.integerAnswerFormat(withUnit: "Cm")
//    let waistCicrumQuestionText = "Enter your waist circumference (in centimeters): "
//    let waistCicrumQuestion = ORKFormItem(identifier: "waistCircumQuestion", text: waistCicrumQuestionText, answerFormat: heightAnswerFormat, optional: false)
//    waistCicrumQuestion.placeholder = "Add waist circumference"
//    form1Questions += [waistCicrumQuestion]
//    //End of: Waist circumference question

    //Beginning of: Date of birth question
    let defaultDate = Date()
    let userCalendar = Calendar.current
    let firstLandPhoneCallDateComponents = DateComponents(calendar: nil,
                                                          timeZone: nil,
                                                          era: nil,
                                                          year: 1900,
                                                          month: 1,
                                                          day: 1,
                                                          hour: nil,
                                                          minute: nil,
                                                          second: nil,
                                                          nanosecond: nil,
                                                          weekday: nil,
                                                          weekdayOrdinal: nil,
                                                          quarter: nil,
                                                          weekOfMonth: nil,
                                                          weekOfYear: nil,
                                                          yearForWeekOfYear: nil)

    let minDate = userCalendar.date(from: firstLandPhoneCallDateComponents)!

    let dobAnswerFormat = ORKDateAnswerFormat(style: ORKDateAnswerStyle.date, defaultDate: defaultDate, minimumDate: minDate, maximumDate: defaultDate, calendar: Calendar.current)
    let dobQuestionText = "Date of birth: "
    let dobQuestion = ORKFormItem(identifier: "dobQuestion", text: dobQuestionText, answerFormat: dobAnswerFormat, optional: false)
    dobQuestion.placeholder = "Add date of birth"
    form1Questions += [dobQuestion]
    //Ending of: Date of birth question

    //Beginning of: Gender question
    let male = ORKTextChoice(text: "Male", detailText: nil, value: "Male" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    genders += [male]
    let female = ORKTextChoice(text: "Female", detailText: nil, value: "Female" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    genders += [female]

    //Internet usage
    let genderAnswerFormat = ORKBooleanAnswerFormat(yesString: "Male", noString: "Female")
    let genderQuestionText = "Gender"
    let genderQuestion = ORKFormItem(identifier: "genderQuestion", text: genderQuestionText, answerFormat: genderAnswerFormat, optional: false)
    //

//    let genderAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: genders)
//    let genderQuestionText = "Gender: "
//    let genderQuestion = ORKFormItem(identifier: "genderQuestion", text: genderQuestionText, answerFormat: genderAnswerFormat, optional: false)
    form1Questions += [genderQuestion]
    //End of: Gender question

    //Adding the first form to steps
    form1.formItems = form1Questions
    steps += [form1]
    //End of adding first form to steps
    
    var reviewStep = ORKReviewStep(identifier: "ReviewStep")
    reviewStep.excludeInstructionSteps = true
    steps += [reviewStep]
    
    return ORKOrderedTask(identifier: "DbSurveyTask", steps: steps)
}
