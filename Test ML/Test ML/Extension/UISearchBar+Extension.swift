//
//  UISearchBar+Extension.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 15/11/21.
//
import UIKit

extension UISearchBar {
    
    //Extension para cambiar los colores de los elementos del UISearchController
    public func setNewcolor(color: UIColor) {
        
        barTintColor = color
        
        if #available(iOS 13.0, *) {
            
            if let glassIconView = searchTextField.leftView as? UIImageView {
                glassIconView.tintColor = color
            }
            
            if let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton {
                
                if let img3 = clearButton.image(for: .highlighted) {
                    clearButton.isHidden = false
                    let tintedClearImage = img3.withTintColor(color)
                    clearButton.setImage(tintedClearImage, for: .normal)
                    clearButton.setImage(tintedClearImage, for: .highlighted)
                } else {
                    clearButton.isHidden = true
                }
            }
            
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: color]
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Buscar", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            
        }
    }
}

