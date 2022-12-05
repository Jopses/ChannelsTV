import UIKit

struct DefaultColorPalette: ColorPalette {

    private init() { }

    static let primary: UIColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2196078431, alpha: 1) // #343438
    static let primaryVariant: UIColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.2078431373, alpha: 1) // #313135
    static let secondary: UIColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8745098039, alpha: 0.403093957) // #D1D5DF
    static let secondaryVariant: UIColor = #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 1) // #0077FF
    static let background: UIColor = #colorLiteral(red: 0.137254902, green: 0.1411764706, blue: 0.1529411765, alpha: 1) // #232427
    static let surface: UIColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2784313725, alpha: 1) // #404247
    static let error: UIColor = #colorLiteral(red: 0.9411764706, green: 0.137254902, blue: 0.2705882353, alpha: 1) // #F02345

    static let onPrimary: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // #FFFFFF
    static let onSecondary: UIColor = #colorLiteral(red: 0.5607843137, green: 0.5647058824, blue: 0.5921568627, alpha: 1) // #8F9097
    static let onBackground: UIColor = #colorLiteral(red: 0.1019607843, green: 0.1098039216, blue: 0.137254902, alpha: 1) // #1A1C23
    static let onSurface: UIColor = #colorLiteral(red: 0.9137254902, green: 0.9176470588, blue: 0.937254902, alpha: 1) // #E9EAEF
    static let onError: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // #FFFFFF

}
