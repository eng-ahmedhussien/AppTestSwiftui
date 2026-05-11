//
//  File.swift
//  
//
//  Created by Khaled Mahmoud Saad on 04/03/2023.
//

import Foundation
import UIKit
import MOLH
import VFEAssets
import CryptoKit

public enum VFFontType: String {
    case lite = "lightFont"
    case regular = "regularFont"
    case bold = "boldFont"
    case extraBold = "extraBoldFont"

}

extension String {
    
    /// Returns a localized version of the string using NSLocalizedString.
    public var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    /// Returns a string representation of a double value, removing decimals if not needed.
    public var cleanValue: String {
        guard let doubleValue = Double(self) else {
            return self
        }
        if doubleValue.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", doubleValue)
        } else {
            return String(format: "%.2f", doubleValue)
        }
    }
    
    /// Returns a string representation of a double value, removing decimals if not needed (duplicate of cleanValue).
    public var cleanDoubleValue: String {
        guard let doubleValue = Double(self) else {
            return self
        }
        if doubleValue.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", doubleValue)
        } else {
            return String(format: "%.2f", doubleValue)
        }
    }
    
    /// Validates if the string is a valid Egyptian mobile number (010/011/012/015).
    public var isValidMobileNumber:Bool{
        let msisdnRegEx = "^01[0125][0-9]{8}$"
        let msisdnTest = NSPredicate(format: "SELF MATCHES %@", msisdnRegEx)
        return msisdnTest.evaluate(with: self)
    }
    
    /// Returns a localized version of the string using NSLocalizedString (function form).
    public func localize() -> String {
        return NSLocalizedString(self,comment: self)
    }
    
    /// Returns a sanitized version of the string, removing unwanted characters.
    public func sanitizedString() -> String {
           let cleanedString = self.replacedArabicDigitsWithEnglish
           if let regex = try? NSRegularExpression(pattern:"[^\\p{L}\\p{N}\\p{Zs}\\p{P}]", options: []) {
               let range = NSRange(location: 0, length: cleanedString.utf16.count)
               return regex.stringByReplacingMatches(in: cleanedString, options: [], range: range, withTemplate: "")
           }
           return cleanedString
       }
    
    /// Returns the character at the specified index.
    public subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    /// Returns the string at the specified index.
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    /// Returns the substring in the specified range.
    public subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    /// Prepares a mobile number string by normalizing and converting Arabic digits to English.
    public func prepMsisdn() -> String {
        var msisdn = self.editMobileNumber()
        // Convert Arabic MSISDN to English
        let arabicNumbers = ["٠": "0",
                             "١": "1",
                             "٢": "2",
                             "٣": "3",
                             "٤": "4",
                             "٥": "5",
                             "٦": "6",
                             "٧": "7",
                             "٨": "8",
                             "٩": "9"]
        for (key, value) in arabicNumbers {
            msisdn = msisdn.replacingOccurrences(of: key, with: value)
        }
        return msisdn
    }
    
    public func containsWhitespace(_ text: String) -> Bool {
        return text.rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }
    
    /// Converts the string to an integer value, handling Arabic numerals and removing currency suffix.
    public var intValue : Int {
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        var result = self
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        result = result.replacingOccurrences(of: " \("SAR".localized)", with:"" )
        if result.isEmpty {
            return 0
        }
        return Int(result) ?? 0
    }
    
    /// Converts the string to a boolean value, supporting common representations.
    public var boolValue: Bool {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return false
        }
    }
    
    /// Converts the string to a float value, handling Arabic numerals and removing currency suffix.
    public var floatValue : Float {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        
        var result = self
        
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        result = result.replacingOccurrences(of: " \("SAR".localized)", with:"" )
        if result.isEmpty {
            return 0
        }
        
        return (result as NSString).floatValue
    }
    
    /// Edits a mobile number string by normalizing prefixes and formatting.
    public func editMobileNumber() -> String {
        
        var msisdn = self.replacingOccurrences(of: " ", with: "")
        
        if msisdn.hasPrefix("2") {
            msisdn = "+\(msisdn)"
        }
        
        if msisdn.hasPrefix("+2") {
            msisdn = msisdn.replacingOccurrences(of: "+2", with: "")
        }
        
        if msisdn.hasPrefix("002") {
            let lowerBound = msisdn.index(msisdn.startIndex, offsetBy: 3)
            msisdn = String(msisdn[lowerBound...])
        }
        
        if msisdn.hasPrefix("1") {
            msisdn.insert("0", at: msisdn.startIndex)
        }
        
        return msisdn
    }
    
    /// Converts English digits in the string to Arabic numerals.
    public var arabicPhoneNumber: String {
        
        let arr = ["٩","٨","٧","٦","٥","٤","٣","٢","١","٠"]
        let engArr = ["9","8","7","6","5","4","3","2","1","0"]
        var result = self
        
        for int in 0...9 {
            result = result.replacingOccurrences(of: engArr[int], with:String(arr[int]) )
        }
        
        return result
    }
    
    /// Converts Arabic numerals in the string to English digits.
    public var englishPhoneNumber: String {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        
        var result = self
        
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        
        return result
    }
    
    /// Returns the phone number localized to the current language (Arabic or English).
    public var localizeNumber: String {
        
        if MOLHLanguage.isArabic() {
            return arabicPhoneNumber
        } else {
            return englishPhoneNumber
        }
    }
    
    /// Returns an NSAttributedString with the system font.
    public var regular: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Bold string.
//    public var bold: NSAttributedString {
//        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.vodafoneRg(ofSize: UIFont.systemFontSize)])
//    }
    
    /// Underlined string
    public var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// Strikethrough string.
    public var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    /// Italic string.
    public var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    
    public var containsAlphabets: Bool {
        //Checks if all the characters inside the string are alphabets
        let set = CharacterSet.letters
        return self.utf16.contains {
            guard let unicode = UnicodeScalar($0) else { return false }
            return set.contains(unicode)
        }
    }
    
    public func toDate(format :String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let locale = MOLHLanguage.isArabic() ? "ar" :"US_POSIX"
        dateFormatter.locale = Locale(identifier: locale) // set locale to reliable US_POSIX
        let dateFromString:Date = dateFormatter.date(from: self) ?? Date()
        return dateFromString
    }
    
    public func toDateWithFormat(_ format: String) -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        //Specify Format of String to Parse
        dateFormatter.dateFormat = format
        //Parse into NSDate
        let dateFromString: Date = dateFormatter.date(from: self) ?? Date()
        //Return Parsed Date
        return dateFromString
    }
    
    public var withoutSpecialCharacters: String {
        return self.components(separatedBy: "/").joined(separator: "")
    }
    
    public func getFormattedDate(from oldFormat: String = "yyyy-MM-dd", to newFormat: String) -> String {
        // convert to date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldFormat
        let date = dateFormatter.date(from: self)
        
        guard let date = date else { return self }
        
        // convert date to formatted string
        dateFormatter.dateFormat = newFormat
        dateFormatter.locale = Locale(identifier: MOLHLanguage.currentLocaleIdentifier())
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    public func toHijriDateWithFormat(_ format: String) -> String {
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = format

        let gregorianDate = dateFormatter.date(from: self) ?? Date()
        
        let islamicCalendar = Calendar(identifier: .islamicUmmAlQura)
        let year = islamicCalendar.component(.year, from: gregorianDate)
        let month = islamicCalendar.component(.month, from: gregorianDate)
        let day = islamicCalendar.component(.day, from: gregorianDate)
        
        return "\(year) - \(month) - \(day)"
    }
    
    public func getParameter(_ param: String) -> String? {
          let urlComponents = self.components(separatedBy: "&")

          for keyValuePair in urlComponents {
              let pairComponents = keyValuePair.components(separatedBy: "=")

              if pairComponents.count == 2 {
                  let key = pairComponents[0].removingPercentEncoding
                  let value = pairComponents[1].removingPercentEncoding

                  if key == param {
                      return value
                  }
              }
          }

          return nil
      }
    
    public func isValidPhoneNumber() -> String? {
        var phoneNumber = self
        let formatter = NumberFormatter()
        let locale = Locale(identifier: "EN")
        formatter.locale = locale
        let newNum = formatter.number(from: phoneNumber)
        
        if let newNum = newNum {
            phoneNumber = "\(newNum)"
        }
        
        phoneNumber = phoneNumber.components(separatedBy: CharacterSet.whitespaces).joined()
        
        if phoneNumber.count == 11 {
            if phoneNumber.hasPrefix("01") {
                return phoneNumber
            } else {
                return nil
            }
        } else if phoneNumber.count < 10 {
            return nil
        } else if phoneNumber.count == 10 {
            if phoneNumber.hasPrefix("10") || phoneNumber.hasPrefix("11") || phoneNumber.hasPrefix("12") || phoneNumber.hasPrefix("15") {
                return "0\(phoneNumber)"
            } else {
                return nil
            }
        } else if phoneNumber.count > 11 && (phoneNumber.hasPrefix("00201") || phoneNumber.hasPrefix("+201") || phoneNumber.hasPrefix("201")) {
            if phoneNumber.hasPrefix("00201") {
                phoneNumber = phoneNumber.substring(from: phoneNumber.index(phoneNumber.startIndex, offsetBy: 3))
            } else if phoneNumber.hasPrefix("+201") {
                phoneNumber = phoneNumber.substring(from: phoneNumber.index(phoneNumber.startIndex, offsetBy: 2))
            } else if phoneNumber.hasPrefix("201") {
                phoneNumber = phoneNumber.substring(from: phoneNumber.index(phoneNumber.startIndex, offsetBy: 1))
            }
            
            if phoneNumber.count == 11 {
                return phoneNumber
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    public var isValid: Bool {
        return !self.isEmpty
    }
    
    // MARK: - To be used when having a localized String with one or more parameters
    public func getLocalizedFormattedString(arguments: [CVarArg]) -> String {
        let localizedString = NSLocalizedString(self, comment: "")
        return String(format: localizedString, arguments: arguments)
    }

}
//Add methods for ANA-Vodafone
extension String {
    public var decodeUnicode: String {
         let result = self
         let tempStr = NSString(string: result).replacingOccurrences(of: "\\u", with: "\\U").replacingOccurrences(of: "\"", with: "\\\"")
         let quotedStr = "\"\(tempStr)\""
         let data = quotedStr.data(using: .utf8)
         
         let decodedString = try? PropertyListSerialization.propertyList(from: data ?? Data(), options: [], format: nil) as? String ?? ""
         
         return decodedString ?? ""
     }
    
    
    public func fromByteStringToMegaStringWithoutDecimals() -> String {
        if let byte = Double(self) {
            let mega = byte / 1024 / 1024
            return String(format: "%d", Int(mega))
        }
        return ""
    }
    
    /// check if string contains arabic number or letters
      public var isContainsArabic: Bool {
          let arabicRegex = "[\u{0600}-\u{06FF}\u{0660}-\u{0669}]"
          let range = self.range(of: arabicRegex, options: .regularExpression)
          return range != nil
      }
    
    public func fromByteStringToMegaString() -> String {
        if let byte = Double(self) {
            let mega = byte / 1024 / 1024
            return String(format: "%.2f", mega)
        }
        return ""
    }

    public func convertToAttributedString(
        withSize size: CGFloat,
        andLineSpacing lineSpacing: CGFloat = 5,
        andColor color: UIColor = UIColor.black,
        andFontType fontType: VFFontType? = .regular,
        andAlignment alignment: NSTextAlignment = .center,
        isUnderlined: Bool = false
    ) -> NSMutableAttributedString {

        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        var attributes = [NSAttributedString.Key.font: UIFont(name: fontType?.rawValue.localize() ?? "regularFont", size: size) as Any, NSAttributedString.Key.foregroundColor: color]
        if isUnderlined {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    public var isEnglishLettersOrNumbers: Bool {
        let englishRegEx = "^[A-Za-z0-9]+$"
        let englishTest = NSPredicate(format:"SELF MATCHES %@", englishRegEx)
        return englishTest.evaluate(with: self)
    }
    
    public func makeAttributedStrForOneLine(title: String,
                                     titleColor: UIColor = .black,
                                     titleSize: CGFloat = 14,
                                     boldTitle: String,
                                     boldTitleColor: UIColor = .black,
                                     boldTitleSize: CGFloat = 18) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: VFLanguageHandler.sharedInstance.vfString(forKey: "regularFont"),
                                                                   size: titleSize) as Any, NSAttributedString.Key.foregroundColor: titleColor]
        let boldTitleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: boldTitleSize),
                                   NSAttributedString.Key.foregroundColor: boldTitleColor]
        
        var titleStr = NSMutableAttributedString()
        titleStr = NSMutableAttributedString(string: "\(title) ", attributes: titleAttributes)
        
        let boldTitleStr = NSAttributedString(string: boldTitle, attributes: boldTitleAttributes)
        titleStr.append(boldTitleStr)
        
        return titleStr
    }
    
    public func makeAttributedStr(bold: Bool, color:UIColor, fontSize:CGFloat,font:UIFont? = nil) -> NSMutableAttributedString {
        
        var defaultFont = font
        
        if font == nil {
            let fontName = (bold) ? "boldFont" : "regularFont"
            defaultFont = UIFont(name: VFLanguageHandler.sharedInstance.vfString(forKey: fontName) , size: fontSize)
        }

        let titleAttributes = [NSAttributedString.Key.font: defaultFont as Any, NSAttributedString.Key.foregroundColor: color]
        
        var titleStr = NSMutableAttributedString()
        titleStr = NSMutableAttributedString(string: "\(self) ", attributes: titleAttributes)
        
        return titleStr
    }
    
    public func makeAttributedStrWithCenterAlignment(
        bold: Bool,
        color: UIColor,
        fontSize: CGFloat,
        font: UIFont? = nil
    ) -> NSMutableAttributedString {
        var defaultFont = font
        if font == nil {
            let fontName = bold ? VFEFontWeight.bold : VFEFontWeight.regular
            defaultFont = UIFont.VFEFont(ofSize: fontSize, weight: fontName)
        }

        // Create paragraph style with center alignment
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        // Set up attributes
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: defaultFont as Any,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]

        // Create and return the attributed string
        let titleStr = NSMutableAttributedString(
            string: "\(self) ",
            attributes: titleAttributes
        )

        return titleStr
    }

    
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9",
                   "٫":"."]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    public var replacedEnglishDigitsWithArabic: String {
        var str = self
        let map = ["0": "٠",
                   "1": "١",
                   "2": "٢",
                   "3": "٣",
                   "4": "٤",
                   "5": "٥",
                   "6": "٦",
                   "7": "٧",
                   "8": "٨",
                   "9": "٩",
                   ".":"٫"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    public var moneyFormat : String {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        let intVal = (self as NSString).integerValue
        let nsvalue = NSNumber(integerLiteral: intVal )
        let formattedTipAmount = formatter.string(from: nsvalue)
        return formattedTipAmount!
    }
    
    public func convertStringDigitsByLanguage() -> String {
        
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            self.replacedEnglishDigitsWithArabic
        } else {
            self.replacedArabicDigitsWithEnglish
        }
        
    }
    
    public func validateContact() -> String {
        var number = self
        number = number.replacingOccurrences(of: "+2", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "+", with: "")
        
        if number.starts(with: "002") {
            
            number = number.getSubstring(startIndexOffset: 3, endIndexOffset: 0)
        } else if number.starts(with: "201") {
            number =
            number.getSubstring(startIndexOffset: 1, endIndexOffset: 0)
        } else if number.starts(with:"00") || number.starts(with:"02") || number.starts(with:"202") {
            number = number.getSubstring( startIndexOffset: 2, endIndexOffset: 0)
        }
        return number
    }
    
    public func getSubstring(startIndexOffset:Int,endIndexOffset:Int) -> String {
        let str = self
        let start = str.index(str.startIndex, offsetBy: startIndexOffset)
        let end = str.index(str.endIndex, offsetBy: endIndexOffset)
        let range = start..<end
        let subStr = str[range]
        return subStr.description
    }
    
    public var withoutSpaces: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            return match.range.length == self.utf16.count
        }
        return false
    }
    
    public func toGregorianDate() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self) ?? Date()
        //Return Parsed Date
        return dateFromString
    }
    
    public var cleanNumberString :String{
        let cleanedString = (self.components(separatedBy: CharacterSet(charactersIn: "0123456789+١٢٣٤٥٦٧٨٩٠").inverted).joined(separator: ""))
        
        let str = cleanedString.replacingOccurrences(of: "+2", with: "")
        
        let str2 = str.replacingOccurrences(of: "+", with: "")
        
        var mystr = str2
        
        if (str2.count ) > 3 {
            mystr = (str2 as NSString?)?.substring(to: 3) ?? str2
            if (mystr == "002") {
                mystr = (str2 as NSString?)?.substring(from: 3) ?? str2
                return mystr
            }
            mystr = (str2 as NSString?)?.substring(to: 2) ?? str2
            if (mystr == "20") {
                mystr = (str2 as NSString?)?.substring(from: 1) ?? str2
                return mystr
            }
            return str2
        }
        return str2
        
    }
    
    public var isArabicNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩","٫"]
        return Set(self).isSubset(of: nums)
    }
    
    public var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    public func convertStringtoEnglish() -> String {
        var finalString: String = self
        finalString = finalString.replacingOccurrences(of: "٠", with: "0")
        finalString = finalString.replacingOccurrences(of: "١", with: "1")
        finalString = finalString.replacingOccurrences(of: "٢", with: "2")
        finalString = finalString.replacingOccurrences(of: "٣", with: "3")
        finalString = finalString.replacingOccurrences(of: "٤", with: "4")
        finalString = finalString.replacingOccurrences(of: "٥", with: "5")
        finalString = finalString.replacingOccurrences(of: "٦", with: "6")
        finalString = finalString.replacingOccurrences(of: "٧", with: "7")
        finalString = finalString.replacingOccurrences(of: "٨", with: "8")
        finalString = finalString.replacingOccurrences(of: "٩", with: "9")
        return finalString
    }
    
    public func convertStringtoArabic() -> String {
        var finalString: String = self
        finalString = finalString.replacingOccurrences(of: "0", with: "٠")
        finalString = finalString.replacingOccurrences(of: "1", with: "١")
        finalString = finalString.replacingOccurrences(of: "2", with: "٢")
        finalString = finalString.replacingOccurrences(of: "3", with: "٣")
        finalString = finalString.replacingOccurrences(of: "4", with: "٤")
        finalString = finalString.replacingOccurrences(of: "5", with: "٥")
        finalString = finalString.replacingOccurrences(of: "6", with: "٦")
        finalString = finalString.replacingOccurrences(of: "7", with: "٧")
        finalString = finalString.replacingOccurrences(of: "8", with: "٨")
        finalString = finalString.replacingOccurrences(of: "9", with: "٩")
        return finalString
    }
    
    public func convertDateString(fromFormat sourceFormat : String!, toFormat desFormat : String!) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = desFormat
        if date != nil {
            return dateFormatter.string(from: date!)
        }
        return self
    }
    
    public func convertDateStringArEn(fromFormat sourceFormat : String, toFormat desFormat : String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = sourceFormat
        
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        
        let localeId = MOLHLanguage.isArabic() ? "ar" :"US_POSIX"
        dateFormatter.locale = Locale(identifier: localeId)
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = desFormat
        
        return dateFormatter.string(from: date)
    }
    
    public var isDouble: Bool { return Double(self) != nil }

    public func fromSecondsStringToMinutesString() -> String {
        if let seconds = Int(self) {
            return "\(seconds / 60)"
        }
        return ""
    }
    
    public var isValidMsisdn: Bool {
        let msisdnRegEx = "^01[0-9]{9}$"
        let msisdnTest = NSPredicate(format:"SELF MATCHES %@", msisdnRegEx)
        return msisdnTest.evaluate(with: self)
    }
    
    public func hashedCreditCard() -> String {
        return "**** **** **** " + self.suffix(4)
    }
    
    public func toDateOnly() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self) ?? Date()
        //Return Parsed Date
        return dateFromString
    }
    
    public var didContainArabicCharacters: Bool {
        if self.range(of: "\\p{Arabic}", options: .regularExpression) != nil {
            return true
        } else {
            return false
        }
    }
    
    public func attributedTextWithImage(image: String) -> NSMutableAttributedString {
        /// create an NSMutableAttributedString that we'll append everything to
        let fullString = NSMutableAttributedString(string: self)
        /// create our NSTextAttachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage.VFEImage(named: image)
        imageAttachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
        /// wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: imageAttachment)
        /// add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(NSMutableAttributedString(string: "  "))
        fullString.append(image1String)
        
        return fullString
    }
    
    public func hasBaseUrl() -> Bool {
        var string = self
        return (string.contains("http") || string.contains("www."))
    }
    
    public func getIndexInt(of char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
    
    public func trimSpaceAndUniqueCharactersForMsisdn() -> String {
        self.replacingOccurrences(of: "+2", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "+", with: "")
    }
    public  func isLandline() -> Bool {
        var isLandline = false
        
        if (self.count == 9 || self.count == 10 || self.count == 11) && !self.hasPrefix("010") && !self.hasPrefix("011") && !self.hasPrefix("012") && !self.hasPrefix("015") && !self.hasPrefix("2010") && !self.hasPrefix("2011") && !self.hasPrefix("2012") && !self.hasPrefix("2015")  {
            isLandline = true
        }
        
        return isLandline
        
    }
    public  func jsonToArray<T:Codable>() -> [T] {
        guard let data = Data(base64Encoded: self) else { return [] }
        guard let val = try? JSONDecoder().decode([T].self, from: data) else { return [] }
        return val
    }
    
    public  func checkRegularExpression(pattern:String,mutableAttributedString:NSMutableAttributedString)->NSMutableAttributedString{
        let range = self.range(of: pattern, options: .regularExpression)
        if let range = range {
            let modifiedText = self.replacingCharacters(in: range, with: mutableAttributedString.string)
            let rangeToReplace = modifiedText.range(of:mutableAttributedString.string)
            if let rangeToReplace = rangeToReplace {
                let nsRange = NSRange(rangeToReplace, in: modifiedText)
                let attributedString = NSMutableAttributedString(string: modifiedText)
                attributedString.replaceCharacters(in: nsRange, with: mutableAttributedString)
                return attributedString
            }
        }
        return NSMutableAttributedString(string: self)

    }
    
    public func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    public mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    public func substring(fromIndex : Int,count : Int) -> String{
        let startIndex = self.index(self.startIndex, offsetBy: fromIndex)
        let endIndex = self.index(self.startIndex, offsetBy: fromIndex + count)
        let range = startIndex..<endIndex
        return String(self[range])
    }
    
    public func fromMinutesToDurationString()-> String {
        let valueInDouble: Double = Double(self) ?? 0.0
        let totalMinutes:Int = Int(valueInDouble)
        let minutes:Int = (totalMinutes) % 60
        let hours:Int = totalMinutes / 60
        return String(format: "%02ld : %02ld : %02ld",hours, minutes, 0)
    }
    
    public func isValidRegex(regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func removeTrailingZeros() -> String {
        guard let number = Double(self) else { return self }
        
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(number))
        } else {
            return self
        }
    }
    
    public func formattedWithBullets(separator: String = "$") -> NSAttributedString {
        let bullet = "• "
        let bulletIndent = 10.0 // Adjust as needed
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = bulletIndent
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.paragraphSpacing = 4
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        // Automatically adjust text alignment and direction for the current language
        if MOLHLanguage.isArabic() {
            paragraphStyle.alignment = .right
            paragraphStyle.baseWritingDirection = .rightToLeft
        }else{
            paragraphStyle.alignment = .left
            paragraphStyle.baseWritingDirection = .leftToRight
        }
        
        let attributedString = NSMutableAttributedString()
        let items = self.split(separator: Character(separator)).map { $0.trimmingCharacters(in: .whitespaces) }
        
        for (index, item) in items.enumerated() {
            let bulletLine = "\(bullet)\(item)"
            let bulletAttributedString = NSAttributedString(
                string: bulletLine,
                attributes: [
                    .paragraphStyle: paragraphStyle,
                    .font: UIFont.systemFont(ofSize: 16), // Customize font
                    .foregroundColor: UIColor.label // Adjust text color for dark/light mode
                ]
            )
            attributedString.append(bulletAttributedString)
            
            if index != items.count - 1 {
                attributedString.append(NSAttributedString(string: "\n"))
            }
        }
        
        return attributedString
    }
    
    public func formatMsisdnStartWithTwo() -> String {
        // Remove any spaces or special characters first
        var number = self.replacingOccurrences(of: " ", with: "")
        
        // Handle +20 prefix
        if number.hasPrefix("+20") {
            number = String(number.dropFirst(3))
        }
        
        // Handle 0020 prefix
        if number.hasPrefix("0020") {
            number = String(number.dropFirst(4))
        }
        
        // Handle if it already starts with 2
        if number.hasPrefix("2") {
            return number
        }
        
        // Add 2 if it starts with 0
        if number.hasPrefix("0") {
            return "2" + number
        }
        
        //1012345678
        if number.hasPrefix("1") && number.count == 10{
            return "20" + number
        }
        
        // Default case: add 2 prefix
        return "2" + number
    }

    /// Converts an HTML-like string to an attributed string with specific formatting.
    /// - Parameter fontSize: The font size for the text.
    /// - Returns: An attributed string with bold and link styling.
    public func convertHTMLToAttributedString(fontSize: CGFloat) -> NSAttributedString {
        let boldPattern = "<b>(.*?)</b>"
        let linkPattern = "<link>(.*?)</link>"
        
        // Combine patterns for matching
        let combinedPattern = "\(boldPattern)|\(linkPattern)"
        guard let regex = try? NSRegularExpression(pattern: combinedPattern, options: []) else {
            return NSAttributedString(string: self)
        }
        
        let attributedString = NSMutableAttributedString()
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        var currentLocation = 0
        
        for match in matches {
            let matchRange = match.range
            let matchString = (self as NSString).substring(with: matchRange)
            
            // Append plain text before the match
            if matchRange.location > currentLocation {
                let plainText = (self as NSString).substring(with: NSRange(location: currentLocation, length: matchRange.location - currentLocation))
                attributedString.append(plainAttributedString(for: plainText, fontSize: fontSize))
            }
            
            // Process specific tags
            if let tagType = TagType(from: matchString) {
                attributedString.append(tagType.process(matchString, fontSize: fontSize))
            }
            
            currentLocation = matchRange.location + matchRange.length
        }
        
        // Append any remaining text after the last match
        if currentLocation < self.utf16.count {
            let remainingText = (self as NSString).substring(from: currentLocation)
            attributedString.append(plainAttributedString(for: remainingText, fontSize: fontSize))
        }
        
        return attributedString
    }
    /// Returns a plain text attributed string with default styling.
     func plainAttributedString(for text: String, fontSize: CGFloat) -> NSAttributedString {
        NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.VFEFont(ofSize: fontSize, weight: .regular),
                .foregroundColor: UIColor.VFENeutral6
            ]
        )
    }
    
    public func replacingPlaceholders(with values: [String: String]) -> String {
        var newString = self
        for (key, value) in values {
            let placeholder = "$\(key)"
            newString = newString.replacingOccurrences(of: placeholder, with: value)
        }
        return newString
    }
    
    public func convertPaymentStringToEnglish() -> String {
        var finalString  = self.convertStringtoEnglish()
        finalString = self.replacingOccurrences(of: "٫", with: ".")
        return finalString
    }
    
    public func toDays() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        guard let date = inputFormatter.date(from: self) else { return self }
        
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: currentDate),
            to: calendar.startOfDay(for: date)
        )
        
        guard let days = components.day else { return self }
        return "\(days)"
    }
    
    public func localizeDigits() -> String {
        let isArabic = MOLHLanguage.isArabic()
        return isArabic ? self.replacedEnglishDigitsWithArabic : self
    }
    
    var autoFormatted: String {
        return self.convertStringDigitsByLanguage()
    }
    
    public func convertDateFormat() -> String {
        let inputDateFormat = "yyyy-MM-dd HH:mm:ss"
        var outputDateFormat = ""
        if MOLHLanguage.isArabic() {
            outputDateFormat = "yyyy/MM/dd"
        }else{
            outputDateFormat = "dd/MM/yyyy"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputDateFormat
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    /// Remove white spaces - non numeric characters
    public func getCleanPhoneNumber() -> String {
        return self.filter { $0.isNumber }
    }
    
    public func replacingHTMLBoldWithAttributedString(
        withSize size: CGFloat,
        withColor: UIColor? = nil,
        AndAlignment alignment: NSTextAlignment = MOLHLanguage.isArabic() ? .right : .left
    ) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let pattern = "<b>(.*?)</b>"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(
                in: self,
                options: [],
                range: NSRange(location: 0, length: self.utf16.count)
            )
            
            let defaultFont = UIFont.VFEFont(ofSize: size, weight: .regular)
            attributedString.addAttributes([.font: defaultFont], range: NSRange(location: 0, length: attributedString.length))
            
            for match in matches.reversed() {
                guard let nsRange = Range(match.range(at: 1), in: self) else { continue }
                
                let boldText = String(self[nsRange])
                let boldFont = UIFont.VFEFont(ofSize: size, weight: .bold)
                var boldAttributes: [NSAttributedString.Key: Any] = [.font: boldFont]
                if let color = withColor {
                    boldAttributes[.foregroundColor] = color
                }
                
                // Replace the full match range (with <b> tags) with bold text
                if let fullRange = Range(match.range, in: self) {
                    attributedString.replaceCharacters(
                        in: NSRange(fullRange, in: self),
                        with: NSAttributedString(string: boldText, attributes: boldAttributes)
                    )
                }
            }
            
            // Apply text alignment
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = alignment
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        } catch {
            return NSAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: size)])
        }
        
        return attributedString
    }
    
    public func replacePTWithEGP() -> String {
        let formattedPriceString: String
        if let priceDouble = Double(self) {
            let dividedPrice = priceDouble / 100
            formattedPriceString = dividedPrice.cleanValue
        } else {
            formattedPriceString = self
        }
        return formattedPriceString
    }
    
    public func convertHTMLToAttributedStringWithUnderlinedLink(text: String,fontSize: CGFloat, color: UIColor = .VFEOnSurface) -> NSAttributedString {
        let boldPattern = "<b>(.*?)</b>"
        let linkPattern = "<link>(.*?)</link>"
        
        // Combine patterns for matching
        let combinedPattern = "\(boldPattern)|\(linkPattern)"
        guard let regex = try? NSRegularExpression(pattern: combinedPattern, options: []) else {
            return NSAttributedString(string: text)
        }
        
        let attributedString = NSMutableAttributedString()
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        var currentLocation = 0
        
        for match in matches {
            let matchRange = match.range
            let matchString = (text as NSString).substring(with: matchRange)
            
            // Append plain text before the match
            if matchRange.location > currentLocation {
                let plainText = (text as NSString).substring(with: NSRange(location: currentLocation, length: matchRange.location - currentLocation))
                attributedString.append(plainAttributedString(for: plainText, fontSize: fontSize))
            }
            
            // Process specific tags
            if let tagType = TagType(from: matchString) {
                attributedString.append(tagType.processUnderlinedLink(matchString, fontSize: fontSize, color: color))
            }
            
            currentLocation = matchRange.location + matchRange.length
        }
        
        // Append any remaining text after the last match
        if currentLocation < text.utf16.count {
            let remainingText = (text as NSString).substring(from: currentLocation)
            attributedString.append(plainAttributedString(for: remainingText, fontSize: fontSize))
        }
        
        return attributedString
    }
}

// MARK: - Tag Type
fileprivate enum TagType {
    case bold
    case link
    
    init?(from matchString: String) {
        if matchString.hasPrefix("<b>") {
            self = .bold
        } else if matchString.hasPrefix("<link>") {
            self = .link
        } else {
            return nil
        }
    }
    
    /// Processes the matched string based on the tag type.
    func process(_ matchString: String, fontSize: CGFloat) -> NSAttributedString {
        switch self {
        case .bold:
            let text = matchString.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
            return NSAttributedString(
                string: text,
                attributes: [.font: UIFont.VFEFont(ofSize: fontSize, weight: .bold)]
            )
            
        case .link:
            let text = matchString.replacingOccurrences(of: "<link>", with: "").replacingOccurrences(of: "</link>", with: "").trimmingCharacters(in: .whitespaces)
            if let url = URL(string: "http://\(text)") {
                return NSAttributedString(
                    string: text,
                    attributes: [.link: url, .foregroundColor: UIColor.VFERed]
                )
            } else {
                return NSAttributedString(
                    string: text,
                    attributes: [.foregroundColor: UIColor.VFERed]
                )
            }
        }
    }
    
    func processUnderlinedLink(_ matchString: String, fontSize: CGFloat, color: UIColor) -> NSAttributedString {
        switch self {
        case .bold:
            let text = matchString.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
            return NSAttributedString(
                string: text,
                attributes: [.font: UIFont.VFEFont(ofSize: fontSize, weight: .bold),
                             .foregroundColor: color]
            )
            
        case .link:
            let text = matchString.replacingOccurrences(of: "<link>", with: "").replacingOccurrences(of: "</link>", with: "").trimmingCharacters(in: .whitespaces)
                return NSAttributedString(
                    string: text,
                    attributes: [.underlineStyle:  NSUnderlineStyle.single.rawValue,
                                 .font: UIFont.VFEFont(ofSize: fontSize, weight: .bold),
                                 .foregroundColor: color]
                )
             
        }
    }
}

// used for objective c
@objc extension NSString {
    public var replacedArabicDigitsWithEnglish: NSString {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9",
                   "٫":"."]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) as NSString }
        return str
    }
    
}

extension String {
    
    public func extractInitials(maxLetters: Int = 1) -> String {
        let zwnj = "\u{200C}"
        let words = self
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }

        let initials = words.prefix(maxLetters).compactMap { word -> String? in
            guard let firstChar = word.first else { return nil }
            return firstChar.isASCII ? String(firstChar).uppercased() : String(firstChar)
        }

        return initials.joined(separator: zwnj)
    }
    
    public func fromMegaStringToGigaStringWithOutDecimals() -> String {
        if let mega = Double(self) {
            let giga = mega / 1024
            return String(format: "%.0f", giga)
        }
        return ""
    }
    
    public func convertToMonthAndYear() -> (month: String?, year: String?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month, .year], from: date)
            
            if let month = components.month, let year = components.year {
                let monthString = String(format: "%02d", month)
                let yearString = String(year % 100)
                return (monthString, yearString)
            }
        }
        
        return (nil, nil)
    }
    
    public func isValidDate(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let locale = MOLHLanguage.isArabic() ? "ar" :"en_US_POSIX"
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.date(from: self) != nil
    }
    
    public func formatToTwoDecimalPlaces() -> String {
        guard let number = Double(self) else { return self }
        
        if abs(number - floor(number)) < 0.0000001 {
            return String(format: "%.0f", number)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: number)) ?? self
    }
    
    public func toFormattedDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.number(from: self)?.doubleValue
    }
    
    public func getFormattedPrice() -> String {
        return MOLHLanguage.isArabic() ? "\(self.convertStringDigitsByLanguage()) \("EGP".localized)" : "\("EGP".localized) \(self.convertStringDigitsByLanguage())"
    }

    public func isDate() -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        return formatter.date(from: self) != nil
    }
    
    public func trimmingLeadingSpaces() -> String {
        return self.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
    }
    
    public var containsSpecialCharacters: Bool {
        let pattern = "[^a-zA-Z0-9\\s\u{0600}-\u{06FF}]"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        if let regex = regex {
            let range = NSRange(location: 0, length: self.count)
            return regex.firstMatch(in: self, options: [], range: range) != nil
        }
        
        return false
    }
    
    public var trimmingTrailingSpaces: String {
        guard let lastNonWhitespaceIndex = self.lastIndex(where: { !$0.isWhitespace }) else {
            return self
        }
        
        return String(self.prefix(upTo: self.index(after: lastNonWhitespaceIndex)))
    }
    
    public func containsConsecutiveRepeatedCharacter(minLength: Int = 2) -> Bool {
        let pattern = "(.)\\1{\(minLength - 1),}"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: self.utf16.count)
        let matches = regex.matches(in: self, options: [], range: range)
        return matches.count > 0
    }
    
    
    public func containsSequentialPattern(minLength: Int = 2) -> Bool {
        if self.count < minLength {
            return false
        }

        for i in 0...(self.count - minLength) {
            var increasing = true
            var decreasing = true

            for j in 1..<minLength {
                let currentIndex = self.index(self.startIndex, offsetBy: i + j)
                let previousIndex = self.index(self.startIndex, offsetBy: i + j - 1)
                
                if let prevAssciValue = self[previousIndex].asciiValue {
                    if self[currentIndex].asciiValue != prevAssciValue + 1 {
                        increasing = false
                    }
                    if self[currentIndex].asciiValue != prevAssciValue - 1 {
                        decreasing = false
                    }
                } else {
                    return false
                }
            }

            if increasing || decreasing {
                return true
            }
        }

        return false

    }
    
    /// Converts date string from "yyyy-MM-dd HH:mm:ss" format to localized format
    /// English: "25th Aug 2025", Arabic: "٢٥ أغسطس ٢٠٢٥"
    public func toFormattedDate(
        from format: String = "yyyy-MM-dd HH:mm:ss",
        and haveSuffix: Bool = true
    ) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = format
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: self) else {
            return self
        }
        
        let locale = MOLHLanguage.isArabic() ? "ar" : "en_US_POSIX"
        
        if locale == "ar" {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMMM yyyy"
            outputFormatter.locale = Locale(identifier: "ar")
            return outputFormatter.string(from: date).localizeDigits()
        } else {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            
            let suffix: String
            switch day {
            case 1, 21, 31: suffix = "st"
            case 2, 22: suffix = "nd"
            case 3, 23: suffix = "rd"
            default: suffix = "th"
            }
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM yyyy"
            monthFormatter.locale = Locale(identifier: "en_US_POSIX")
            let monthYear = monthFormatter.string(from: date)
            
            return haveSuffix ? "\(day)\(suffix) \(monthYear)" : "\(day) \(monthYear)"
        }
    }
    
}

extension String {
    public func aesGCMDecrypt(base64Key: String) -> String? {
        guard let combinedData = Data(base64Encoded: self) else {
            return nil
        }

        guard let keyData = Data(base64Encoded: base64Key) else {
            return nil
        }

        let key = SymmetricKey(data: keyData)

        do {
            let sealedBox = try AES.GCM.SealedBox(combined: combinedData)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

extension String {
    public var cleanDecryptedValue: String? {
        return self.components(separatedBy: ",").first
    }
}

extension String {
    
    /// Convert date in an to specific formate with specific `Local`.
    /// - Parameters:
    ///   - inputDateFormate: the preferred input formate
    ///   - outputDateFormate: the preferred output formate
    ///   - local: the preferred local
    /// - Returns: converted date with preferred local  numbers
    public func convertToSpecificLocal(
        inputDateFormate: String = "yyyy-MM-dd",
        outputDateFormate: String = "dd-MM-yyyy",
        local: Locale = Locale(identifier: "ar")
    ) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputDateFormate
        inputFormatter.locale = Locale(identifier: "en_US")
        
        guard let date = inputFormatter.date(from: self) else { return "" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputDateFormate
        outputFormatter.locale = local
        
        let arabicDate = outputFormatter.string(from: date)
        
        return arabicDate.replacedEnglishDigitsWithArabic
    }
}
