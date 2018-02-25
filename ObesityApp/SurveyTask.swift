//
//  SurveyTask.swift
//  ObesityApp
//
//  Created by Mohammed Al Ameen on 2/24/18.
//  Copyright © 2018 uos. All rights reserved.
//

import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    var form1Questions = [ORKFormItem]()
    var form2Questions = [ORKFormItem]()
    var form3Questions = [ORKFormItem]()
    var form4Questions = [ORKFormItem]()
    var form5Questions = [ORKFormItem]()
    var genders = [ORKTextChoice]()
    
    //Beginning of: Instruction step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Test Survey"
    instructionStep.text = "This survey is pretty involved. \nPlease take the time to answer all questions. \nCollecting detailed information helps us produce accurate results."
    steps += [instructionStep]
    //End of: Instruction step
    
    //Creation of the first form
    let form1 = ORKFormStep(identifier: "form1", title: "First Form", text: "Please answer the following questions")
    
    //Beginning of: Weight question
    let sectionTitle = ORKFormItem(sectionTitle: "General information")
    form1Questions += [sectionTitle]
    
    let weightAnswerFormat = ORKWeightAnswerFormat(measurementSystem: ORKMeasurementSystem.metric, numericPrecision: ORKNumericPrecision.low)
    let weightQuestionText = "Enter your weight (in kilograms): "
    let weightQuestion = ORKFormItem(identifier: "weightQuestion", text: weightQuestionText, answerFormat: weightAnswerFormat, optional: false)
    weightQuestion.placeholder = "Add weight"
    form1Questions += [weightQuestion]
     //End of: Weight question
    
    //Beginning of: Height question
    let heightAnswerFormat = ORKHeightAnswerFormat(measurementSystem: ORKMeasurementSystem(rawValue: 1)!)
    let heightQuestionText = "Enter your height (in centimeters): "
    let heightQuestion = ORKFormItem(identifier: "heightQuestion", text: heightQuestionText, answerFormat: heightAnswerFormat, optional: false)
    heightQuestion.placeholder = "Add height"
    form1Questions += [heightQuestion]
    //End of: Height question
    
    //Beginning of: Waist circumference question
    //let waistCircumAnswerFormat = ORKNumericAnswerFormat.integerAnswerFormat(withUnit: "Cm")
    let waistCicrumQuestionText = "Enter your waist circumference (in centimeters): "
    let waistCicrumQuestion = ORKFormItem(identifier: "waistCircumQuestion", text: waistCicrumQuestionText, answerFormat: heightAnswerFormat, optional: false)
    waistCicrumQuestion.placeholder = "Add waist circumference"
    form1Questions += [waistCicrumQuestion]
    //End of: Waist circumference question
    
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
    
    let genderAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: genders)
    let genderQuestionText = "Gender: "
    let genderQuestion = ORKFormItem(identifier: "genderQuestion", text: genderQuestionText, answerFormat: genderAnswerFormat, optional: false)
    form1Questions += [genderQuestion]
    //End of: Gender question
    
    //Adding the first form to steps
    form1.formItems = form1Questions
    steps += [form1]
    //End of adding first form to steps
    
    //Creation of the second form
     let form2 = ORKFormStep(identifier: "form2", title: "Second Form", text: "Please answer the following questions")
    //End of creating second form
    
    //Beginning of: Marital status question
    var maritalStatus = [ORKTextChoice]()
    let single = ORKTextChoice(text: "Single", detailText: nil, value: "Single" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    let married = ORKTextChoice(text: "Married", detailText: nil, value: "Married" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    let divorced = ORKTextChoice(text: "Divorced", detailText: nil, value: "Divorced" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    maritalStatus += [single]
    maritalStatus += [married]
    maritalStatus += [divorced]
    
    let maritalStatusAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: maritalStatus)
    let maritalStatusQuestionText = "Your marital status: "
    let maritalStatusQuestion = ORKFormItem(identifier: "maritalStatusQuestion", text: maritalStatusQuestionText, answerFormat: maritalStatusAnswerFormat, optional: false)
    form2Questions += [maritalStatusQuestion]
    //Ending of: Marital status question
    
    //Beginning of: Mobile number question
    let mobileNumberAnswerFormat = ORKNumericAnswerFormat(style: ORKNumericAnswerStyle.integer)
    let mobileNumberQuestionText = "Please provide your mobile number: "
    let mobileNumberQuestion = ORKFormItem(identifier: "mobileNumberQuestion", text: mobileNumberQuestionText, answerFormat: mobileNumberAnswerFormat, optional: false)
    mobileNumberQuestion.placeholder = "1234567891"
    form2Questions += [mobileNumberQuestion]
    //End of: Mobile number question
    
    form2.formItems = form2Questions
    steps += [form2]
    
    //Beginning of: Nationality question
    let nationalityAnswerFormat = ORKLocationAnswerFormat()
    let nationalityQuestionText = "What is your nationality? "
    let nationalityQuestion = ORKQuestionStep(identifier: "nationalityQuestion", title: "Nationality", text: "What is your nationality?", answer: nationalityAnswerFormat)
    nationalityQuestion.placeholder = "Iraq"
    steps += [nationalityQuestion]
    //Ending of: Nationality question
    
    //Form3
    let form3 = ORKFormStep(identifier: "form3", title: "Third Form", text: "Please answer the following questions")
    //
    
    //City Question
    var uaeEmirates = [ORKTextChoice]()
    let ad = ORKTextChoice(text: "Abu Dhabi", detailText: nil, value: "ad" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    uaeEmirates += [ad]
    let aj = ORKTextChoice(text: "Ajman", detailText: nil, value: "aj" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    uaeEmirates += [aj]
    let fu = ORKTextChoice(text: "Fujairah", detailText: nil, value: "fu" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    uaeEmirates += [fu]
    let shj = ORKTextChoice(text: "Sharjah", detailText: nil, value: "shj" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    uaeEmirates += [shj]
    let dxb = ORKTextChoice(text: "Dubai", detailText: nil, value: "dxb" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    uaeEmirates += [dxb]
    let rak = ORKTextChoice(text: "Ras al-Khaimah", detailText: nil, value: "rak" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    uaeEmirates += [rak]
    let aq = ORKTextChoice(text: "Umm al-Qaiwain", detailText: nil, value: "aq" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    uaeEmirates += [aq]
    
    let cityAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: uaeEmirates)
    let cityQuestionText = "Your city of residence: "
    let cityQuestion = ORKFormItem(identifier: "cityQuestion", text: cityQuestionText, answerFormat: cityAnswerFormat, optional: false)
    form3Questions += [cityQuestion]
    //
    
    //City type
    var cityType = [ORKTextChoice]()
    let urban = ORKTextChoice(text: "Urban", detailText: nil, value: "urban" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    cityType += [urban]
    let rural = ORKTextChoice(text: "Rural", detailText: nil, value: "rural" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    cityType += [rural]
    
    let cityTypeAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: cityType)
    let cityTypeQuestionText = "City type: "
    let cityTypeQuestion = ORKFormItem(identifier: "cityTypeQuestion", text: cityTypeQuestionText, answerFormat: cityTypeAnswerFormat, optional: false)
    form3Questions += [cityTypeQuestion]
    //
    
    form3.formItems = form3Questions
    steps += [form3]
   
    //Education level
    var eduLevel = [ORKTextChoice]()
    let primarySchool = ORKTextChoice(text: "Primary School", detailText: nil, value: "primarySchool" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    let highSchool = ORKTextChoice(text: "Highschool", detailText: nil, value: "highSchool" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    let bsc = ORKTextChoice(text: "Bachelor Degree", detailText: nil, value: "bsc" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    let postGrad = ORKTextChoice(text: "Postgraduate Degree", detailText: nil, value: "postGrad" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    eduLevel += [primarySchool,highSchool,bsc,postGrad]
    
    let educationLevelAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: eduLevel)
    let educationLevelTitle = "Education Level"
    let educationLevelQuestionText = "What is your latest educational degree: "
    let educationLevelQuestion = ORKQuestionStep(identifier: "educationLevelQuestion", title: educationLevelTitle, text: educationLevelQuestionText, answer: educationLevelAnswerFormat)
    steps += [educationLevelQuestion]
    //
    
    
    //Form 4: Mobile and internet usage
    let form4 = ORKFormStep(identifier: "form4", title: "From #4", text: "Please answer the following questions")
    //
    
    //Mobile Phone usage
    var mobileUsage = [ORKTextChoice]()
    let lessOneYear = ORKTextChoice(text: "Less than 1 year", detailText: nil, value: "lessOneYear" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    let moreTwoYears = ORKTextChoice(text: "More than 2 years and less than 5 years", detailText: nil, value: "moreTwoYears" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    let moreFiveYears = ORKTextChoice(text: "More than 5 years", detailText: nil, value: "moreFiveYears" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    mobileUsage += [lessOneYear, moreTwoYears, moreFiveYears]
    
    let mobileUsageAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: mobileUsage)
    let mobileUsageQuestionText = "How long have you been using mobile phones: "
    let mobileUsageQuestion = ORKFormItem(identifier: "mobileUsageQuestion", text: mobileUsageQuestionText, answerFormat: mobileUsageAnswerFormat, optional: false)
    form4Questions += [mobileUsageQuestion]
    //
    
    //Internet usage
    let internetUsageAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
    let internetUsageQuestionText = "Do you use the internet? "
    let internetUsageQuestion = ORKFormItem(identifier: "internetUsageQuestion", text: internetUsageQuestionText, answerFormat: internetUsageAnswerFormat, optional: false)
    form4Questions += [internetUsageQuestion]
    //
    
    //Internet usage duration
    let internetYearsAnswerFormat = ORKNumericAnswerFormat.integerAnswerFormat(withUnit: "Years")
    let internetYearsQuestionText = "If you answered yes to the previous question, for how many years have you been using the internet? "
    let internetYearsQuestion = ORKFormItem(identifier: "internetYearsQuestion", text: internetYearsQuestionText, answerFormat: internetYearsAnswerFormat, optional: false)
    form4Questions += [internetYearsQuestion]
    //
    
    form4.formItems = form4Questions
    steps += [form4]
    
    //Household income
    var incomeBrackets = [ORKTextChoice]()
    let lowIncome = ORKTextChoice(text: "Less than 10k dirhams", detailText: nil, value: "lowIncome" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    let middleIncome = ORKTextChoice(text: "More than 10k and less than 20k dirhams", detailText: nil, value: "middleIncome" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    let highIncome = ORKTextChoice(text: "More than 20k dirhams", detailText: nil, value: "highIncome" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    incomeBrackets += [lowIncome, middleIncome, highIncome]
    
    let householdIncomeAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: incomeBrackets)
    let householdIncomeQuestionTitle = "Household Income"
    let householdIncomeQuestionText = "What is your total household income? "
    let houseHoldIncomeQuestion = ORKQuestionStep(identifier: "houseHoldIncomeQuestion", title: householdIncomeQuestionTitle, text: householdIncomeQuestionText, answer: householdIncomeAnswerFormat)
    steps += [houseHoldIncomeQuestion]
    //
    
    //Form5: Medical history form
    let form5 = ORKFormStep(identifier: "form5", title: "From #5", text: "Please answer the following questions")
    //
    
    //Heart diseases
    let heartDiseaseAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
    let heartDiseaseQuestionText = "Do you suffer from any heart disease?"
    let heartDiseaseQuestion = ORKFormItem(identifier: "heartDiseaseQuestion", text: heartDiseaseQuestionText, answerFormat: heartDiseaseAnswerFormat, optional: false)
    form5Questions += [heartDiseaseQuestion]
    //
    
    //Hypertension
    let hypertensionAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
    let hypertensionQuestionText = "Do you suffer from hypertension?"
    let hypertensionQuestion = ORKFormItem(identifier: "hypertensionQuestion", text: hypertensionQuestionText, answerFormat: hypertensionAnswerFormat, optional: false)
    form5Questions += [hypertensionQuestion]
    //
    
    //Diabetes
    let diabetesAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
    let diabetesQuestionText = "Do you suffer from diabetes?"
    let diabetesQuestion = ORKFormItem(identifier: "diabetesQuestion", text: diabetesQuestionText, answerFormat: diabetesAnswerFormat, optional: false)
    form5Questions += [hypertensionQuestion]
    //
    
    //Psychological determinates
    
    //
    
    //End of form5 on medical history
    form5.formItems = form5Questions
    steps += [form5]
    //
    
    let completionStep = ORKCompletionStep(identifier: "SummaryStep")
    completionStep.title = "Thank you!"
    completionStep.text = "Thank you for taking the time to finish the survey. Have a good day! 😊"
    steps += [completionStep]
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}

