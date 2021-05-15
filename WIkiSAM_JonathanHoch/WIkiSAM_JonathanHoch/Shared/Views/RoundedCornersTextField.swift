//
//  RoundedCornersTextField.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 14/05/2021.
//

import UIKit

class RoundedCornersTextField: UITextField {
    
    private let insetX: CGFloat = 20
    private let insetY: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    // change placeholder text color
    override var placeholder: String? {
        didSet {
            guard let tmpText = placeholder else {
                self.attributedPlaceholder = NSAttributedString(string: "")
                return
            }
            
            let textRange = NSMakeRange(0, tmpText.count)
            let attributedText = NSMutableAttributedString(string: tmpText)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor , value: UIColor.gray, range: textRange)
            
            self.attributedPlaceholder = attributedText
        }
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    private func initialize() {
        clipsToBounds = true
        backgroundColor = .clear
        textColor = .secondaryLabel
        borderStyle = .roundedRect
        tintColor = .gray // Carrot (I beam cursor) color
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 15
        clearsOnBeginEditing = false
        clearButtonMode = .whileEditing
        spellCheckingType = .no
        autocorrectionType = .no
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
}
