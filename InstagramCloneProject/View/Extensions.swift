
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


extension TextField {
    func extensionTextFieldView(roundedCornes: CGFloat, hexString: String, colorScheme: ColorScheme) -> some View {
        self
            .padding()
            .background(Color(UIColor(hexString: colorScheme == .dark ? "262626": "DFDFDF")))
            .cornerRadius(roundedCornes)
            .foregroundColor(colorScheme == .dark ? Color(UIColor(hexString: "DFDFDF")) : .black)
            .autocapitalization(.none) 
        
        
    }
}
