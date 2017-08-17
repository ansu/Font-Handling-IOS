//: Generic Font - Hanlding Fonts generic and simpler way

import UIKit


struct Font {
    
    enum StandardSize:Double {
        case h1 = 20.0
        case h2 = 18.0
        case h3 = 16.0
    }
    
    
    
    enum FontName : String {
        case RobotoBlack            = "Roboto-Black"
        case RobotoBlackItalic      = "Roboto-BlackItalic"
        case RobotoBold             = "Roboto-Bold"
        case RobotoBoldItalic       = "Roboto-BoldItalic"
    }
    
    enum FontSize {
        case Standard(StandardSize)
        case Custom(Double)
        var value:Double {
            switch  self {
            case .Standard(let size):
                return size.rawValue
            case .Custom(let size):
                return size
            }
        }
    
    }
    
    enum FontType {
        case installed(FontName)
        case custom(String)
        case system
        case systemBold
        
    }
    
    var type: FontType
    var size: FontSize
    
    static let global = "abc"
    
    init(_ type:FontType, size:FontSize){
        self.type = type
        self.size = size
    }
}


extension Font {
    var instance: UIFont {
    var instanceFont: UIFont!
    switch type {
    case .custom(let fontName):
        guard let font =  UIFont(name: fontName, size: CGFloat(size.value)) else {
            fatalError("\(fontName) font is not installed, make sure it is added in Info.plist and logged with Utility.logAllAvailableFonts()")
        }
        instanceFont = font
    case .installed(let fontName):
        guard let font =  UIFont(name: fontName.rawValue, size: CGFloat(size.value)) else {
            fatalError("\(fontName.rawValue) font is not installed, make sure it is added in Info.plist and logged with Utility.logAllAvailableFonts()")
        }
        instanceFont = font
    case .system:
        instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
    case .systemBold:
        instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
    }
        return instanceFont
    }
}

class Utility {
    /// Logs all available fonts from iOS SDK and installed custom font
    class func logAllAvailableFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}

//Usage:
let system = Font(.systemBold, size: .Standard(.h1)).instance
let custom = Font(.custom("Helvetica-Light"), size: .Custom(13.0)).instance
print(system.fontName)
print(custom.fontName)
