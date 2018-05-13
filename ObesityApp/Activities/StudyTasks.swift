/*
Copyright (c) 2015, Apple Inc. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1.  Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2.  Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3.  Neither the name of the copyright holder(s) nor the names of any contributors
may be used to endorse or promote products derived from this software without
specific prior written permission. No license is granted to the trademarks of
the copyright holders even if such marks are included in this software.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import ResearchKit
import HealthKit


struct StudyTasks {
    
    static let microphoneTask: ORKOrderedTask = {
        let intendedUseDescription = "Everyone's voice has unique characteristics."
        let speechInstruction = "After the countdown, say Aaaaaaaaaaah for as long as you can. You'll have 10 seconds."
        let shortSpeechInstruction = "Say Aaaaaaaaaaah for as long as you can."
        
        return ORKOrderedTask.audioTask(withIdentifier: "AudioTask", intendedUseDescription: intendedUseDescription, speechInstruction: speechInstruction, shortSpeechInstruction: shortSpeechInstruction, duration: 10, recordingSettings: nil, checkAudioLevel: false, options: ORKPredefinedTaskOption.excludeAccelerometer)
    }()
    
    static let tappingTask: ORKOrderedTask = {
        let intendedUseDescription = "Finger tapping is a universal way to communicate."
        
        return ORKOrderedTask.twoFingerTappingIntervalTask(withIdentifier: "TappingTask", intendedUseDescription: intendedUseDescription, duration: 10, handOptions: .both, options: ORKPredefinedTaskOption())
    }()
    
    static let trailmakingTask: ORKOrderedTask = {
        let intendedUseDescription = "Tests visual attention and task switching"
        
        return ORKOrderedTask.trailmakingTask(withIdentifier: "TrailmakingTask", intendedUseDescription: intendedUseDescription, trailmakingInstruction: nil, trailType: .B, options: ORKPredefinedTaskOption())
    }()
    
    
    static let surveyTask: ORKOrderedTask = {
    
        var steps = [ORKStep]()
        var form1Questions = [ORKFormItem]()
        var form2Questions = [ORKFormItem]()
        var form3Questions = [ORKFormItem]()
        var form4Questions = [ORKFormItem]()
        var form5Questions = [ORKFormItem]()
        var form6Questions = [ORKFormItem]()
        var form7Questions = [ORKFormItem]()
        var form8Questions = [ORKFormItem]()
        var form9Questions = [ORKFormItem]()
        //var genders = [ORKTextChoice]()
        let other = ORKTextChoice(text: "Other", detailText: nil, value: "other" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
        
        //Beginning of: Instruction step
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "Test Survey"
        instructionStep.text = "This survey is pretty involved. \nPlease take the time to answer all questions. \nCollecting detailed information helps us produce accurate results."
        steps += [instructionStep]
        //End of: Instruction step
        
        //Creation of the first form
        let form1 = ORKFormStep(identifier: "form1", title: "First Form", text: "Please answer the following questions")
        form1.isOptional = false;
        //
        
        
        //Healthkit test!
        
        var format = ORKHealthKitQuantityTypeAnswerFormat(quantityType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!, unit: HKUnit.meter(), style: ORKNumericAnswerStyle.decimal)
        var format1 = ORKHealthKitQuantityTypeAnswerFormat(quantityType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!, unit: HKUnit.gram(), style: ORKNumericAnswerStyle.decimal)
//        form1Questions += [ORKFormItem(identifier: "HealthKit", text: "HEALTHKITBITCH!", answerFormat: myFormat)]
//        ORKAnswerFormat *genderFormat =
//            [ORKHealthKitCharacteristicTypeAnswerFormat
//                answerFormatWithCharacteristicType:
//                [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex]];
//        [items addObject:
//            [[ORKFormItem alloc] initWithIdentifier:kGenderItemIdentifier
//            text:@"Gender"
//            answerFormat:genderFormat];
        
        
        //
//        let tableStep = TableStep(identifier: "TableStep")
//        steps += [tableStep]
        //
        

        
        //Beginning of: Weight question
        let sectionTitle = ORKFormItem(sectionTitle: "General information")
        form1Questions += [sectionTitle]
        
        form1Questions += [ORKFormItem(identifier: "healthKitHeight", text: "HealthKit   HEIGHT", answerFormat: format)]
        form1Questions += [ORKFormItem(identifier: "healthKitMass", text: "HealthKit     WEIGHT", answerFormat: format1)]
        
        
        let weightAnswerFormat = ORKWeightAnswerFormat(measurementSystem: ORKMeasurementSystem.metric, numericPrecision: ORKNumericPrecision.low)
        let weightQuestionText = "Enter your weight (in kilograms): "
        let weightQuestion = ORKFormItem(identifier: "weightQuestion", text: weightQuestionText, answerFormat: weightAnswerFormat, optional: false)
        weightQuestion.placeholder = "Add weight"
        form1Questions += [weightQuestion]
        //End of: Weight question
        
        //Beginning of: Height question
        //let heightAnswerFormat = ORKHeightAnswerFormat(measurementSystem: ORKMeasurementSystem(rawValue: 1)!)
        let heightAnswerFormat = ORKHeightAnswerFormat(measurementSystem: ORKMeasurementSystem.metric, defaultHeight: 150)
        let heightQuestionText = "Enter your height (in centimeters): "
        let heightQuestion = ORKFormItem(identifier: "heightQuestion", text: heightQuestionText, answerFormat: heightAnswerFormat, optional: false)
        heightQuestion.placeholder = "Add height"
        form1Questions += [heightQuestion]
        //End of: Height question
        
        //Beginning of: Waist circumference question
        let waistCicrumQuestionText = "Enter your waist circumference (in centimeters): "
        let waistAnswerFormat = ORKHeightAnswerFormat(measurementSystem: ORKMeasurementSystem.metric, defaultHeight: 84)
        
        let waistCicrumQuestion = ORKFormItem(identifier: "waistCircumQuestion", text: waistCicrumQuestionText, answerFormat: waistAnswerFormat, optional: false)
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
        //    let male = ORKTextChoice(text: "Male", detailText: nil, value: "Male" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
        //    genders += [male]
        //    let female = ORKTextChoice(text: "Female", detailText: nil, value: "Female" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
        //    genders += [female]
        //
        //    let genderAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: genders)
        //    let genderQuestionText = "Gender: "
        //    let genderQuestion = ORKFormItem(identifier: "genderQuestion", text: genderQuestionText, answerFormat: genderAnswerFormat, optional: false)
        //    form1Questions += [genderQuestion]
        //    //End of: Gender question
        
        //Gender with images
        var imageChoices = [ORKImageChoice]()
        let image = ORKImageChoice(normalImage: #imageLiteral(resourceName: "male-1") as UIImage, selectedImage: #imageLiteral(resourceName: "male-1") as UIImage, text: "Male", value: "male" as NSCoding & NSCopying & NSObjectProtocol)
        imageChoices += [image]
        
        
        
        let heart = ORKImageChoice(normalImage: #imageLiteral(resourceName: "female-1") as UIImage, selectedImage: #imageLiteral(resourceName: "female-1") as UIImage, text: "Female", value: "female" as NSCoding & NSCopying & NSObjectProtocol)
        imageChoices += [heart]
        let genderWithImages = ORKImageChoiceAnswerFormat(imageChoices: imageChoices, style: ORKChoiceAnswerStyle.singleChoice, vertical: false)
        let genderWithImagesQuestion = ORKFormItem(identifier: "genderWithImages", text: "What is your gender", answerFormat: genderWithImages)
        genderWithImagesQuestion.isOptional = false
        form1Questions += [genderWithImagesQuestion]
        
        //Martial question with images:
        var maritalStatus = [ORKImageChoice]()
        let single = ORKImageChoice(normalImage: #imageLiteral(resourceName: "single-1") as UIImage, selectedImage: #imageLiteral(resourceName: "single-1") as UIImage, text: "Single", value: "single" as NSCoding & NSCopying & NSObjectProtocol)
        maritalStatus += [single]
        
        let married = ORKImageChoice(normalImage: #imageLiteral(resourceName: "married") as UIImage, selectedImage: #imageLiteral(resourceName: "married") as UIImage, text: "Married", value: "married" as NSCoding & NSCopying & NSObjectProtocol)
        maritalStatus += [married]
        
        let divorced = ORKImageChoice(normalImage: #imageLiteral(resourceName: "divorced-1") as UIImage, selectedImage: #imageLiteral(resourceName: "divorced-1") as UIImage, text: "Divorced", value: "divorced" as NSCoding & NSCopying & NSObjectProtocol)
        maritalStatus += [divorced]
        
        let maritalStatusAnswerFormat = ORKImageChoiceAnswerFormat(imageChoices: maritalStatus, style: ORKChoiceAnswerStyle.singleChoice, vertical: false)
        let maritalStatusQuestion = ORKFormItem(identifier: "maritalState", text: "What is your marital state", answerFormat: maritalStatusAnswerFormat)
        maritalStatusQuestion.isOptional = false
        form1Questions += [maritalStatusQuestion]
        //
        
        //Adding the first form to steps
        form1.formItems = form1Questions
        steps += [form1]
        //End of adding first form to steps
//        
//        //    //Beginning of: Nationality question
//        let nationalityAnswerFormat = ORKLocationAnswerFormat()
//        nationalityAnswerFormat.useCurrentLocation = false
//        
//        let nationalityQuestion = ORKQuestionStep(identifier: "nationalityQuestion", title: "Nationality", text: "What is your nationality?", answer: nationalityAnswerFormat)
//        nationalityQuestion.placeholder = "Emirati"
//        nationalityQuestion.isOptional = false
//        steps += [nationalityQuestion]
//        //    //Ending of: Nationality question
//        
//        //nationality from text
//        
//        //
//
//        
////        //Creation of the second form
////        let form2 = ORKFormStep(identifier: "form2", title: "Second Form", text: "Please answer the following questions")
////        //End of creating second form
////
////        //    //Beginning of: Marital status question
////        //    var maritalStatus = [ORKTextChoice]()
////        //    let single = ORKTextChoice(text: "Single", detailText: nil, value: "Single" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
////        //    let married = ORKTextChoice(text: "Married", detailText: nil, value: "Married" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
////        //    let divorced = ORKTextChoice(text: "Divorced", detailText: nil, value: "Divorced" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
////        //    maritalStatus += [single]
////        //    maritalStatus += [married]
////        //    maritalStatus += [divorced]
////        //
////        //    let maritalStatusAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: maritalStatus)
////        //    let maritalStatusQuestionText = "Your marital status: "
////        //    let maritalStatusQuestion = ORKFormItem(identifier: "maritalStatusQuestion", text: maritalStatusQuestionText, answerFormat: maritalStatusAnswerFormat, optional: false)
////        //    form2Questions += [maritalStatusQuestion]
////        //    //Ending of: Marital status question
////
////
////
//////        //Beginning of: Mobile number question
//////        let mobileNumberAnswerFormat = ORKNumericAnswerFormat(style: ORKNumericAnswerStyle.integer)
//////        let mobileNumberQuestionText = "Please provide your mobile number: "
//////        let mobileNumberQuestion = ORKFormItem(identifier: "mobileNumberQuestion", text: mobileNumberQuestionText, answerFormat: mobileNumberAnswerFormat, optional: false)
//////        mobileNumberQuestion.placeholder = "1234567891"
//////        form2Questions += [mobileNumberQuestion]
//////        //End of: Mobile number question
////
////        form2.formItems = form2Questions
////        form2.isOptional = false
////        steps += [form2]
//        
//        //Form3
//        let form3 = ORKFormStep(identifier: "form3", title: "Third Form", text: "Please answer the following questions")
//        form3.isOptional = false
//        //
//        
//        //City Question
//        var uaeEmirates = [ORKTextChoice]()
//        let ad = ORKTextChoice(text: "Abu Dhabi", detailText: nil, value: "ad" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        uaeEmirates += [ad]
//        let aj = ORKTextChoice(text: "Ajman", detailText: nil, value: "aj" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        uaeEmirates += [aj]
//        let fu = ORKTextChoice(text: "Fujairah", detailText: nil, value: "fu" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        uaeEmirates += [fu]
//        let shj = ORKTextChoice(text: "Sharjah", detailText: nil, value: "shj" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        uaeEmirates += [shj]
//        let dxb = ORKTextChoice(text: "Dubai", detailText: nil, value: "dxb" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        uaeEmirates += [dxb]
//        let rak = ORKTextChoice(text: "Ras al-Khaimah", detailText: nil, value: "rak" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        uaeEmirates += [rak]
//        let aq = ORKTextChoice(text: "Umm al-Qaiwain", detailText: nil, value: "aq" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        uaeEmirates += [aq]
//        
//        let cityAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: uaeEmirates)
//        let cityQuestionText = "Your city of residence: "
//        let cityQuestion = ORKFormItem(identifier: "cityQuestion", text: cityQuestionText, answerFormat: cityAnswerFormat, optional: false)
//        form3Questions += [cityQuestion]
//        //
//        
//        //City type
//        var cityType = [ORKTextChoice]()
//        let urban = ORKTextChoice(text: "Urban", detailText: nil, value: "urban" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        cityType += [urban]
//        let rural = ORKTextChoice(text: "Rural", detailText: nil, value: "rural" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        cityType += [rural]
//        
//        let cityTypeAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: cityType)
//        let cityTypeQuestionText = "City type: "
//        let cityTypeQuestion = ORKFormItem(identifier: "cityTypeQuestion", text: cityTypeQuestionText, answerFormat: cityTypeAnswerFormat, optional: false)
//        form3Questions += [cityTypeQuestion]
//        //
//        
//        //Education Level
//        var eduLevelImgChoices = [ORKImageChoice]()
//        let primary = ORKImageChoice(normalImage: #imageLiteral(resourceName: "education") as UIImage, selectedImage: #imageLiteral(resourceName: "education") as UIImage, text: "Primary School", value: "primary" as NSCoding & NSCopying & NSObjectProtocol)
//        imageChoices += [image]
//        let secondary = ORKImageChoice(normalImage: #imageLiteral(resourceName: "education") as UIImage, selectedImage: #imageLiteral(resourceName: "education") as UIImage, text: "Secondary School", value: "secondary" as NSCoding & NSCopying & NSObjectProtocol)
//        
//        let bachelor = ORKImageChoice(normalImage: #imageLiteral(resourceName: "education") as UIImage, selectedImage: #imageLiteral(resourceName: "education") as UIImage, text: "Bachelor Degree", value: "bachelor" as NSCoding & NSCopying & NSObjectProtocol)
//        
//        let postgrad = ORKImageChoice(normalImage: #imageLiteral(resourceName: "education") as UIImage, selectedImage: #imageLiteral(resourceName: "education") as UIImage, text: "Postgraduate Degree", value: "postGrad" as NSCoding & NSCopying & NSObjectProtocol)
//        
//        eduLevelImgChoices += [primary,secondary,bachelor,postgrad]
//        
//        let eduLevelWithImagesAnswerFormat = ORKImageChoiceAnswerFormat(imageChoices: eduLevelImgChoices, style: ORKChoiceAnswerStyle.singleChoice, vertical: false)
//        
//        let eduLevelItem = ORKFormItem(identifier: "EduLevel", text: "Please choose your most recent degree", answerFormat: eduLevelWithImagesAnswerFormat, optional: false)
//        
//        form3Questions += [eduLevelItem]
//        //
//        
//        //Household income
//        var incomeChoices = [ORKImageChoice]()
//        
//        let _10k = ORKImageChoice(normalImage: #imageLiteral(resourceName: "moneybills"), selectedImage: #imageLiteral(resourceName: "moneybills"), text: "Less than 10k dirhams", value: 0 as NSCoding & NSCopying & NSObjectProtocol)
//        
//        let _10to20k = ORKImageChoice(normalImage: #imageLiteral(resourceName: "moneysack"), selectedImage: #imageLiteral(resourceName: "moneysack"), text: "Between 10k and 20k dirhams", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
//        
//        let _20k = ORKImageChoice(normalImage: #imageLiteral(resourceName: "treasurechest"), selectedImage: #imageLiteral(resourceName: "treasurechest"), text: "More than 20k dirhams", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
//        
//        incomeChoices += [_10k, _10to20k, _20k]
//        
//        let incomeWithImagesAnswerFormat = ORKImageChoiceAnswerFormat(imageChoices: incomeChoices, style: ORKChoiceAnswerStyle.singleChoice, vertical: false)
//        
//        let incomeItem = ORKFormItem(identifier: "Income", text: "Houshold Income", answerFormat: incomeWithImagesAnswerFormat, optional: false)
//        
//        form3Questions += [incomeItem]
//        
//        //
//        
//        form3.formItems = form3Questions
//        steps += [form3]
//        
//        //Education level
////        var eduLevel = [ORKTextChoice]()
////        let primarySchool = ORKTextChoice(text: "Primary School", detailText: nil, value: "primarySchool" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
////        let highSchool = ORKTextChoice(text: "Highschool", detailText: nil, value: "highSchool" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
////        let bsc = ORKTextChoice(text: "Bachelor Degree", detailText: nil, value: "bsc" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
////        let postGrad = ORKTextChoice(text: "Postgraduate Degree", detailText: nil, value: "postGrad" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
////        eduLevel += [primarySchool,highSchool,bsc,postGrad]
////
////        let educationLevelAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: eduLevel)
////        let educationLevelTitle = "Education Level"
////        let educationLevelQuestionText = "What is your latest educational degree: "
////        let educationLevelQuestion = ORKQuestionStep(identifier: "educationLevelQuestion", title: educationLevelTitle, text: educationLevelQuestionText, answer: educationLevelAnswerFormat)
////        educationLevelQuestion.isOptional = false
////        steps += [educationLevelQuestion]
//        //
//        
//        //Education Level as imageChoice
//        
//        
//        
////        let eduLevelQuestion = ORKQuestionStep(identifier: "EduLevel", title: "Education Level", text: "Please choose your most recent degree", answer: eduLevelWithImagesAnswerFormat)
////        eduLevelQuestion.isOptional = false
////        steps += [eduLevelQuestion]
////        
//        //
//        
//        
////        //MARK: Form4
////        //Form 4: Mobile and internet usage
////        let form4 = ORKFormStep(identifier: "form4", title: "Form #4", text: "Please answer the following questions")
////        form4.isOptional = false
////        //
////        
////        //Mobile Phone usage
////        var mobileUsage = [ORKTextChoice]()
////        let lessOneYear = ORKTextChoice(text: "Less than 1 year", detailText: nil, value: "lessOneYear" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
////        let moreTwoYears = ORKTextChoice(text: "More than 2 years and less than 5 years", detailText: nil, value: "moreTwoYears" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
////        let moreFiveYears = ORKTextChoice(text: "More than 5 years", detailText: nil, value: "moreFiveYears" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
////        mobileUsage += [lessOneYear, moreTwoYears, moreFiveYears]
////        
////        let mobileUsageAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: mobileUsage)
////        let mobileUsageQuestionText = "How long have you been using mobile phones: "
////        let mobileUsageQuestion = ORKFormItem(identifier: "mobileUsageQuestion", text: mobileUsageQuestionText, answerFormat: mobileUsageAnswerFormat, optional: false)
////        form4Questions += [mobileUsageQuestion]
////        //
////        
////        //Internet usage
////        let internetUsageAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
////        let internetUsageQuestionText = "Do you use the internet? "
////        let internetUsageQuestion = ORKFormItem(identifier: "internetUsageQuestion", text: internetUsageQuestionText, answerFormat: internetUsageAnswerFormat, optional: false)
////        form4Questions += [internetUsageQuestion]
////        //
////        
////        //Internet usage duration
////        let internetYearsAnswerFormat = ORKNumericAnswerFormat.integerAnswerFormat(withUnit: "Years")
////        let internetYearsQuestionText = "If you answered yes to the previous question, for how many years have you been using the internet? "
////        let internetYearsQuestion = ORKFormItem(identifier: "internetYearsQuestion", text: internetYearsQuestionText, answerFormat: internetYearsAnswerFormat, optional: true)
////        form4Questions += [internetYearsQuestion]
////        //
////        
////        form4.formItems = form4Questions
////        steps += [form4]
//    
//        //MARK: Form 5
//        //Form5: Medical history form
//        let form5 = ORKFormStep(identifier: "form5", title: "Form #5", text: "Personal Medical History")
//        form5.isOptional = false
//        //
//        
//        //Heart diseases
//        let heartDiseaseAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let heartDiseaseQuestionText = "Do you suffer from any heart disease?"
//        let heartDiseaseQuestion = ORKFormItem(identifier: "heartDiseaseQuestion", text: heartDiseaseQuestionText, answerFormat: heartDiseaseAnswerFormat, optional: false)
//        form5Questions += [heartDiseaseQuestion]
//        //
//        
//        //Hypertension
//        let hypertensionAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let hypertensionQuestionText = "Do you suffer from hypertension?"
//        let hypertensionQuestion = ORKFormItem(identifier: "hypertensionQuestion", text: hypertensionQuestionText, answerFormat: hypertensionAnswerFormat, optional: false)
//        form5Questions += [hypertensionQuestion]
//        //
//        
//        //Diabetes
//        let diabetesAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let diabetesQuestionText = "Do you suffer from diabetes?"
//        let diabetesQuestion = ORKFormItem(identifier: "diabetesQuestion", text: diabetesQuestionText, answerFormat: diabetesAnswerFormat, optional: false)
//        form5Questions += [diabetesQuestion]
//        //
//        
//        //Psychological determinates
//        var moodChoices = [ORKTextChoice]()
//        let normal = ORKTextChoice(text: "Normal", detailText: "I feel healthy and normal", value: "normal" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let depressed = ORKTextChoice(text: "Depressed", detailText: "I feel depressed", value: "depressed" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let mania = ORKTextChoice(text: "Mania", detailText: "I very excited and euphoric all the time", value: "mania" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        moodChoices += [depressed, normal, mania]
//        
//        let moodAnswerFormat = ORKTextScaleAnswerFormat(textChoices: moodChoices, defaultIndex: 1, vertical: false)
//        let moodQuestionText = "How would you describe your current psychological state?"
//        let moodQuestion = ORKFormItem(identifier: "modeQuestion", text: moodQuestionText, answerFormat: moodAnswerFormat, optional: false)
//        form5Questions += [moodQuestion]
//        //
//        
//        //Stress level
//        let stressAnswerFormat = ORKBooleanAnswerFormat(yesString: "High", noString: "Normal")
//        let stressQuestionText = "How would you describe your current stress level?"
//        let stressQuestion = ORKFormItem(identifier: "stressQuestion", text: stressQuestionText, answerFormat: stressAnswerFormat, optional: false)
//        form5Questions += [stressQuestion]
//        //
//        
//        //Back/joint pain
//        let backJointAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let backJointQuestionText = "Do you suffer from back or joint pain?"
//        let backJointQuestion = ORKFormItem(identifier: "backJointQuestion", text: backJointQuestionText, answerFormat: backJointAnswerFormat, optional: false)
//        form5Questions += [backJointQuestion]
//        //
//        
//        //Cancer
//        let cancerAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let cancerQuestionText = "Do you suffer from cancer?"
//        let cancerQuestion = ORKFormItem(identifier: "cancerQuestion", text: cancerQuestionText, answerFormat: cancerAnswerFormat, optional: false)
//        form5Questions += [cancerQuestion]
//        //
//        
//        //Skin infection
//        let skinInfectionAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let skinInfectionQuestionText = "Do you suffer from any skin infection?"
//        let skinInfectionQuestion = ORKFormItem(identifier: "skinInfectionQuestion", text: skinInfectionQuestionText, answerFormat: skinInfectionAnswerFormat, optional: false)
//        form5Questions += [skinInfectionQuestion]
//        //
//        
//        //Thyroid
//        let thyroidAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let thyroidQuestionText = "Do you suffer from any thyroid disorder like Hypo/Hyperthyroidism?"
//        let thyroidQuestion = ORKFormItem(identifier: "thyroidQuestion", text: thyroidQuestionText, answerFormat: thyroidAnswerFormat, optional: false)
//        form5Questions += [thyroidQuestion]
//        //
//        
//        //Fertility
//        let fertilityAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let fertilityQuestionText = "Do you suffer from fertility issues?"
//        let fertilityQuestion = ORKFormItem(identifier: "fertilityQuestion", text: fertilityQuestionText, answerFormat: fertilityAnswerFormat, optional: false)
//        form5Questions += [fertilityQuestion]
//        //
//        
//        //Quality of sleep section
//        let sleepTitle = ORKFormItem(sectionTitle: "Quality of sleep")
//        form5Questions += [sleepTitle]
//        //
//        
//        //snoring
//        let snoringAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let snoringQuestionText = "Do you snore?"
//        let snoringQuestion = ORKFormItem(identifier: "snoringQuestion", text: snoringQuestionText, answerFormat: snoringAnswerFormat, optional: false)
//        form5Questions += [snoringQuestion]
//        //
//        
//        //morning headache
//        let morningHeadacheAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let morningHeadacheQuestionText = "Do you suffer from morning headache?"
//        let morningHeadacheQuestion = ORKFormItem(identifier: "morningHeadacheQuestion", text: morningHeadacheQuestionText, answerFormat: morningHeadacheAnswerFormat, optional: false)
//        form5Questions += [morningHeadacheQuestion]
//        //
//        
//        //insomnia
//        let insomniaAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let insomniaQuestionText = "Do you suffer from insomnia (difficulty of falling asleep)?"
//        let insomniaQuestion = ORKFormItem(identifier: "insomniaQuestion", text: insomniaQuestionText, answerFormat: insomniaAnswerFormat, optional: false)
//        form5Questions += [insomniaQuestion]
//        //
//        
//        //d.    Narcolepsy
//        let narcolepsyAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let narcolepsyQuestionText = "Do you suffer from narcolepsy (sudden sleep attacks at work or school)?"
//        let narcolepsyQuestion = ORKFormItem(identifier: "narcolepsyQuestion", text: narcolepsyQuestionText, answerFormat: narcolepsyAnswerFormat, optional: false)
//        form5Questions += [narcolepsyQuestion]
//        //
//        
//        //End of form5 on medical history
//        form5.formItems = form5Questions
//        steps += [form5]
//        //
//        
//        //MARK: Form 6
//        //Form6: Family medical history
//        let form6 = ORKFormStep(identifier: "form6", title: "Form #6", text: "Family Medical History")
//        form6.isOptional = false
//        //
//        
//        //family heart diseases
//        let familyHeartDiseaseAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let familyHeartDiseaseQuestionText = "Do you have any family member who suffers from heart disease(s)?"
//        let familyHeartDiseaseQuestion = ORKFormItem(identifier: "familyHeartDiseaseQuestion", text: familyHeartDiseaseQuestionText, answerFormat: familyHeartDiseaseAnswerFormat, optional: false)
//        form6Questions += [familyHeartDiseaseQuestion]
//        //
//        
//        //family hypertension
//        let familyHypertensionAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let familyHypertensionQuestionText = "Do you have any family member who suffers from hypertension?"
//        let familyHypertensionQuestion = ORKFormItem(identifier: "familyHypertensionQuestion", text: familyHypertensionQuestionText, answerFormat: familyHypertensionAnswerFormat, optional: false)
//        form6Questions += [familyHypertensionQuestion]
//        //
//        
//        //family diabetes
//        let familyDiabetesAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let familyDiabetesQuestionText = "Do you have any family member who suffers from diabetes?"
//        let familyDiabetesQuestion = ORKFormItem(identifier: "familyDiabetesQuestion", text: familyDiabetesQuestionText, answerFormat: familyDiabetesAnswerFormat, optional: false)
//        form6Questions += [familyDiabetesQuestion]
//        //
//        
//        //family cancer
//        let familyCancerAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let familyCancerQuestionText = "Do you have any family member who suffers from cancer?"
//        let familyCancerQuestion = ORKFormItem(identifier: "familyCancerQuestion", text: familyCancerQuestionText, answerFormat: familyCancerAnswerFormat, optional: false)
//        form6Questions += [familyCancerQuestion]
//        //
//        
//        //family thyroid
//        let familyThyroidAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let familyThyroidQuestionText = "Do you have any family member who suffers from a thyroid condition?"
//        let familyThyroidQuestion = ORKFormItem(identifier: "familyThyroidQuestion", text: familyThyroidQuestionText, answerFormat: familyThyroidAnswerFormat, optional: false)
//        form6Questions += [familyThyroidQuestion]
//        //
//        
//        //End of form6 on family medical history
//        form6.formItems = form6Questions
//        steps += [form6]
//        //
//        
//        //MARK: Form 7
//        //Form7: Current/Prior diet
//        let form7 = ORKFormStep(identifier: "form7", title: "Form #7", text: "Current/Prior Diet")
//        form7.isOptional = false
//        //
//        
//        //Section describe your diet
//        let dietTitle = ORKFormItem(sectionTitle: "Describe your current diet")
//        form7Questions += [dietTitle]
//        //
//        
//        //carbs
//        let carbsAnswerFormat = ORKBooleanAnswerFormat(yesString: "High", noString: "Low")
//        let carbsQuestionText = "Your carbohydrates consumption is:"
//        let carbsQuestion = ORKFormItem(identifier: "carbsQuestion", text: carbsQuestionText, answerFormat: carbsAnswerFormat, optional: false)
//        form7Questions += [carbsQuestion]
//        //
//        
//        //fat
//        let fatAnswerFormat = ORKBooleanAnswerFormat(yesString: "High", noString: "Low")
//        let fatQuestionText = "Your fat consumption is:"
//        let fatQuestion = ORKFormItem(identifier: "fatQuestion", text: fatQuestionText, answerFormat: fatAnswerFormat, optional: false)
//        form7Questions += [fatQuestion]
//        //
//        
//        //protein
//        let proteinAnswerFormat = ORKBooleanAnswerFormat(yesString: "High", noString: "Low")
//        let proteinQuestionText = "Your protein consumption is:"
//        let proteinQuestion = ORKFormItem(identifier: "proteinQuestion", text: proteinQuestionText, answerFormat: proteinAnswerFormat, optional: false)
//        form7Questions += [proteinQuestion]
//        //
//        
//        //fibers
//        let fibersAnswerFormat = ORKBooleanAnswerFormat(yesString: "High", noString: "Low")
//        let fibersQuestionText = "Your fibers consumption is:"
//        let fibersQuestion = ORKFormItem(identifier: "fibersQuestion", text: fibersQuestionText, answerFormat: fibersAnswerFormat, optional: false)
//        form7Questions += [fibersQuestion]
//        //
//        
//        //Followed a diet question
//        let dietAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
//        let dietQuestionText = "Have you ever followed a diet?"
//        let dietQuestion = ORKFormItem(identifier: "dietQuestion", text: dietQuestionText, answerFormat: dietAnswerFormat, optional: false)
//        form7Questions += [dietQuestion]
//        //
//        
//        //followed a diet
//        var dietStyles = [ORKTextChoice]()
//        let lowCarb = ORKTextChoice(text: "Low carbs", detailText: nil, value: "lowCarb" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let lowFat = ORKTextChoice(text: "Low fat", detailText: nil, value: "lowFat" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let calorieCounting = ORKTextChoice(text: "Calorie counting", detailText: nil, value: "calorieCounting" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let portionControl = ORKTextChoice(text: "Portion control", detailText: nil, value: "portionControl" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        dietStyles += [lowCarb, lowFat, calorieCounting, portionControl, other]
//        
//        let dietFollowedAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: dietStyles)
//        let dietFollowedQuestionText = "If you answered yes to the previous question, what type of diet did you follow? "
//        let dietFollowedQuestion = ORKFormItem(identifier: "dietFollowedQuestion", text: dietFollowedQuestionText, answerFormat: dietFollowedAnswerFormat, optional: false)
//        form7Questions += [dietFollowedQuestion]
//        //
//        
//        //water intake
//        var waterAmount = [ORKTextChoice]()
//        let lowAmount = ORKTextChoice(text: "1 Liter", detailText: nil, value: "lowAmount" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let mediumAmount = ORKTextChoice(text: "2 Liters", detailText: nil, value: "mediumAmount" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let largeAmount = ORKTextChoice(text: "3 Liters", detailText: nil, value: "largeAmount" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        waterAmount += [lowAmount, mediumAmount, largeAmount]
//        
//        let waterIntakeAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: waterAmount)
//        let waterIntakeQuestionText = "How much water do you drink each day?"
//        let waterIntakeQuestion = ORKFormItem(identifier: "waterIntakeQuestion", text: waterIntakeQuestionText, answerFormat: waterIntakeAnswerFormat, optional: false)
//        form7Questions += [waterIntakeQuestion]
//        //
//        
//        //End of form7 on Current/Prior diet
//        form7.formItems = form7Questions
//        steps += [form7]
//        //
//        
//        //MARK: Form 8
//        //Form8: Social/Behavioural
//        let form8 = ORKFormStep(identifier: "form8", title: "Form #8", text: "Social/Behavioral")
//        form8.isOptional = false
//        //
//        
//        //Eat outside/home
//        let eatPlaceAnswerFormat = ORKBooleanAnswerFormat(yesString: "Outside", noString: "Home")
//        let eatPlaceQuestionText = "Do you usually eat outside or at home?"
//        let eatPlaceQuestion = ORKFormItem(identifier: "eatPlaceQuestion", text: eatPlaceQuestionText, answerFormat: eatPlaceAnswerFormat, optional: false)
//        form8Questions += [eatPlaceQuestion]
//        //
//        
//        //Eat alone/with a group
//        let eatWithAnswerFormat = ORKBooleanAnswerFormat(yesString: "Alone", noString: "With a group")
//        let eatWithQuestionText = "Do you usually eat alone or with a group?"
//        let eatWithQuestion = ORKFormItem(identifier: "eatWithQuestion", text: eatWithQuestionText, answerFormat: eatWithAnswerFormat, optional: false)
//        form8Questions += [eatWithQuestion]
//        //
//        
//        //End of form8 on Current/Prior diet
//        form8.formItems = form8Questions
//        steps += [form8]
//        //
//        
//        //MARK: Form 9
//        //Form9: Physical activity
//        let form9 = ORKFormStep(identifier: "form9", title: "Form #9", text: "Physical Activity")
//        form9.isOptional = false
//        //
//        
//        //Leisure time physical activity
//        var activities = [ORKTextChoice]()
//        let walking = ORKTextChoice(text: "Walking", detailText: nil, value: "walking" as NSCoding & NSCopying & NSObjectProtocol, exclusive: false)
//        let dancing = ORKTextChoice(text: "Dancing", detailText: nil, value: "dancing" as NSCoding & NSCopying & NSObjectProtocol, exclusive: false)
//        let gardening = ORKTextChoice(text: "Gardening", detailText: nil, value: "gardening" as NSCoding & NSCopying & NSObjectProtocol, exclusive: false)
//        let hiking = ORKTextChoice(text: "Hiking", detailText: nil, value: "hiking" as NSCoding & NSCopying & NSObjectProtocol, exclusive: false)
//        let swimming = ORKTextChoice(text: "Swimming", detailText: nil, value: "swimming" as NSCoding & NSCopying & NSObjectProtocol, exclusive: false)
//        activities += [walking, dancing, gardening, hiking, swimming]
//        
//        let leisureActivityAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.multipleChoice, textChoices: activities)
//        let leisureActivityQuestionText = "How much water do you drink each day?"
//        let leisureActivityQuestion = ORKFormItem(identifier: "leisureActivityQuestion", text: leisureActivityQuestionText, answerFormat: leisureActivityAnswerFormat, optional: false)
//        form9Questions += [leisureActivityQuestion]
//        //
//        
//        //section
//        let transportationTitle = ORKFormItem(sectionTitle: "Transportation")
//        form9Questions += [transportationTitle]
//        //
//        
//        //transportation
//        var transportationMeans = [ORKTextChoice]()
//        let walkTransportation = ORKTextChoice(text: "Walking", detailText: nil, value: "walkTransportation" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let cycling = ORKTextChoice(text: "Cycling", detailText: nil, value: "cycling" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let driving = ORKTextChoice(text: "Driving", detailText: nil, value: "driving" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        transportationMeans += [walkTransportation, cycling, driving]
//        
//        let transportationAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: transportationMeans)
//        let transportationQuestionText = "What is your main mode of transporation?"
//        let transportationQuestion = ORKFormItem(identifier: "transportationQuestion", text: transportationQuestionText, answerFormat: transportationAnswerFormat, optional: false)
//        form9Questions += [transportationQuestion]
//        //
//        
//        //section
//        let occupationTitle = ORKFormItem(sectionTitle: "Occupation")
//        form9Questions += [occupationTitle]
//        //
//        
//        //Occupation
//        var occupationType = [ORKTextChoice]()
//        let office = ORKTextChoice(text: "Office", detailText: nil, value: "office" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let manual = ORKTextChoice(text: "Manual labor", detailText: nil, value: "manual" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let mixed = ORKTextChoice(text: "Mixed", detailText: nil, value: "mixed" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        occupationType += [office, manual, mixed]
//        
//        let occupationTypeAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: occupationType)
//        let occupationTypeQuestionText = "How would you describe your occupation?"
//        let occupationTypeQuestion = ORKFormItem(identifier: "occupationTypeQuestion", text: occupationTypeQuestionText, answerFormat: occupationTypeAnswerFormat, optional: false)
//        form9Questions += [occupationTypeQuestion]
//        //
//        
//        //Exercise
//        let exerciseTitle = ORKFormItem(sectionTitle: "Exercise")
//        form9Questions += [exerciseTitle]
//        //
//        
//        //Exercise
//        var exercisePeriods = [ORKTextChoice]()
//        let onceWeek = ORKTextChoice(text: "Once a week", detailText: nil, value: "onceWeek" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let twoToFour = ORKTextChoice(text: "2 to 4 days a week", detailText: nil, value: "twoToFour" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        let fiveToSeven = ORKTextChoice(text: "5 to 7 days a week", detailText: nil, value: "fiveToSeven" as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
//        exercisePeriods += [onceWeek, twoToFour, fiveToSeven]
//        
//        let exerciseFrequencyAnswerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: exercisePeriods)
//        let exerciseFrequencyQuestionText = "In a typical week, how many days do you exercise?"
//        let exerciseFrequencyQuestion = ORKFormItem(identifier: "exerciseFrequencyQuestion", text: exerciseFrequencyQuestionText, answerFormat: exerciseFrequencyAnswerFormat, optional: false)
//        form9Questions += [exerciseFrequencyQuestion]
//        //
//        
//        //Exercise Duration
//        let exerciseDurationAnswerFormat = ORKTimeIntervalAnswerFormat(defaultInterval: 15, step: 10)
//        let exerciseDurationQuestionText = "What is the duration of your exercise?"
//        let exerciseDurationQuestion = ORKFormItem(identifier: "exerciseDurationQuestion", text: exerciseDurationQuestionText, answerFormat: exerciseDurationAnswerFormat, optional: false)
//        form9Questions += [exerciseDurationQuestion]
//        
//        //
//        
//        //End of form9 on Current/Prior diet
//        form9.formItems = form9Questions
//        steps += [form9]
//        //
        
        //
        let reviewStep = ORKReviewStep(identifier: "ReviewStep")
        reviewStep.excludeInstructionSteps = true
        steps += [reviewStep]
        
        //
        
        let completionStep = ORKCompletionStep(identifier: "SummaryStep")
        completionStep.title = "Thank you!"
        completionStep.text = "Thank you for taking the time to finish the survey. Have a good day! 😊"
        steps += [completionStep]
        
        return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
    }()

//    static let surveyTask: ORKOrderedTask = {
//        var steps = [ORKStep]()
//        
//        // Instruction step
//        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
//        instructionStep.title = "Knoweledge of the Universe Survey"
//        instructionStep.text = "Please answer these 6 questions to the best of your ability. It's okay to skip a question if you don't know the answer."
//        
//        steps += [instructionStep]
//        
//        // Quest question using text choice
//        let questQuestionStepTitle = "Which of the following is not a planet?"
//        let textChoices = [
//            ORKTextChoice(text: "Saturn", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//            ORKTextChoice(text: "Uranus", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//            ORKTextChoice(text: "Pluto", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//            ORKTextChoice(text: "Mars", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
//        ]
//        let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
//        let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
//        
//        steps += [questQuestionStep]
//        
//        // Name question using text input
//        let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 25)
//        nameAnswerFormat.multipleLines = false
//        let nameQuestionStepTitle = "What do you think the next comet that's discovered should be named?"
//        let nameQuestionStep = ORKQuestionStep(identifier: "NameQuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
//        
//        steps += [nameQuestionStep]
//        
//        let shapeQuestionStepTitle = "Which shape is the closest to the shape of Messier object 101?"
//        let shapeTuples = [
//            (UIImage(named: "square")!, "Square"),
//            (UIImage(named: "pinwheel")!, "Pinwheel"),
//            (UIImage(named: "pentagon")!, "Pentagon"),
//            (UIImage(named: "circle")!, "Circle")
//        ]
//        let imageChoices : [ORKImageChoice] = shapeTuples.map {
//            return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1 as NSCoding & NSCopying & NSObjectProtocol)
//        }
//        let shapeAnswerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: imageChoices)
//        let shapeQuestionStep = ORKQuestionStep(identifier: "ImageChoiceQuestionStep", title: shapeQuestionStepTitle, answer: shapeAnswerFormat)
//        
//        steps += [shapeQuestionStep]
//        
//        // Date question
//        let today = NSDate()
//        let dateAnswerFormat =  ORKAnswerFormat.dateAnswerFormat(withDefaultDate: nil, minimumDate: today as Date, maximumDate: nil, calendar: nil)
//        let dateQuestionStepTitle = "When is the next solar eclipse?"
//        let dateQuestionStep = ORKQuestionStep(identifier: "DateQuestionStep", title: dateQuestionStepTitle, answer: dateAnswerFormat)
//        
//        steps += [dateQuestionStep]
//        
//        // Boolean question
//        let booleanAnswerFormat = ORKBooleanAnswerFormat()
//        let booleanQuestionStepTitle = "Is Venus larger than Saturn?"
//        let booleanQuestionStep = ORKQuestionStep(identifier: "BooleanQuestionStep", title: booleanQuestionStepTitle, answer: booleanAnswerFormat)
//        
//        steps += [booleanQuestionStep]
//        
//        // Continuous question
//        let continuousAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 150, minimumValue: 30, defaultValue: 20, step: 10, vertical: false, maximumValueDescription: "Objects", minimumValueDescription: " ")
//        let continuousQuestionStepTitle = "How many objects are in Messier's catalog?"
//        let continuousQuestionStep = ORKQuestionStep(identifier: "ContinuousQuestionStep", title: continuousQuestionStepTitle, answer: continuousAnswerFormat)
//        
//        steps += [continuousQuestionStep]
//        
//        // Summary step
//        
//        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
//        summaryStep.title = "Thank you."
//        summaryStep.text = "We appreciate your time."
//        
//        steps += [summaryStep]
//        
//        return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
//    }()
}
