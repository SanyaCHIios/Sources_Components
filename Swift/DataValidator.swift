import UIKit

typealias ValidatorRespoce = (valid:Bool, error:String?)

enum ValidatinType:String {
    case  email, password, name
}

enum ValidatinError:Error {
    case emptyEmail
    case emailNotValid
    
    case passCharCount
    case passUpperRequered
    case passNumberRequered
    
    case nameRequered
    
    var localizedDescription: String {
        switch self {
        case .emptyEmail:
            return NSLocalizedString("Email requered", comment: "")
        case .passCharCount:
            return NSLocalizedString("Password requered", comment: "")
        case .passUpperRequered:
            return NSLocalizedString("passUpperRequered", comment: "")
        case .passNumberRequered:
            return NSLocalizedString("At least one number", comment: "")
        case .nameRequered:
            return NSLocalizedString("Name is requered", comment: "")
        case .emailNotValid:
            return NSLocalizedString("Email not valid", comment: "")
        }
    }
}

class DataValidator: NSObject {
    private var validationDict:Dictionary<String, Any> = [:]
    
    //! Constructor
    
    func addToValidation<T>(value:T,type:String){
        validationDict.updateValue(value, forKey: type)
    }
    
    //! Validation
    //! Expand if need more validation
    
    func validation() -> ValidatorRespoce {
        //if let dict = validationDict {
        if validationDict.keys.count == 0 {
            return (true, nil)
        }
        for key in validationDict.keys {
            let type = ValidatinType(rawValue: key)!
            switch type{
            
            case .email:
                let (stat, error) = email(email: validationDict[key] as? String)
                if error != nil {
                    return (stat, error)
                }
            case .password:
                let (stat, error) = password(password: validationDict[key] as? String)
                if error != nil {
                    return (stat, error)
                }
            case .name:
                let (stat, error) = name(name: validationDict[key] as? String)
                if error != nil {
                    return (stat, error)
                }
//            default:
//                continue
            }
        }
        return (true, nil)
    }
    
    //! Validation methods
    
    func password(password:String?) -> ValidatorRespoce {
        var error:String? = nil
        
        guard let password_bind = password else {
            error = ValidatinError.passCharCount.localizedDescription
            return (false, error)
        }
        
        if password_bind.count < 1 {
            error = ValidatinError.passCharCount.localizedDescription
            return (false, error)
        }
        
//        let uppers = CharacterSet.uppercaseLetters
//        let lowers = CharacterSet.lowercaseLetters
//        let digits = CharacterSet.decimalDigits
//
//        var upper = false
//        var lower = false
//        var digit = false
//
//        password_bind.unicodeScalars.forEach {
//            if uppers.contains($0) {
//                upper = true
//            }
//            if lowers.contains($0) {
//                lower = true
//            }
//            if digits.contains($0) {
//                digit = true
//            }
//        }
//
//        if upper == false {
//            error = ValidatinError.passUpperRequered.localizedDescription
//            return (false, error)
//        }
//
//        if lower == false {
//            error = ValidatinError.passUpperRequered.localizedDescription
//            return (false, error)
//        }
//
//        if digit == false {
//            error = ValidatinError.passNumberRequered.localizedDescription
//            return (false, error)
//        }
        
        return (true, nil)
    }
    
    func name(name:String?) -> ValidatorRespoce {
        var error:String? = nil
        
        guard let name_bind = name else {
            error = ValidatinError.nameRequered.localizedDescription
            return (false, error)
        }
        
        if name_bind.count == 0 {
            error = ValidatinError.nameRequered.localizedDescription
            return (false, error)
        }
        
        return (true, error)
    }
    
    func email(email:String?) -> ValidatorRespoce {
        var error:String? = nil
        
        guard let email_bind = email else {
            error = ValidatinError.emailNotValid.localizedDescription
            return (false, error)
        }
        
        if email_bind.count == 0 {
            error = ValidatinError.emailNotValid.localizedDescription
            return (false, error)
        }
        
        return (true, nil)
    }
}
