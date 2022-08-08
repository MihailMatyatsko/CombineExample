//
//  UIViewController+Extensions.swift
//  CombineExample
//
//  Created by Matyatsko Mihail on 22.07.2022.
//

import UIKit

extension UIViewController {
    
    func addKeyboardObserver(willShowSelector: Selector, willHideSelector: Selector) {
        NotificationCenter.default.addObserver(
            self,
            selector: willShowSelector,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: willHideSelector,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
}
