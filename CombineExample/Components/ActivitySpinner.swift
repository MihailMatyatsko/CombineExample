//
//  ActivitySpinner.swift
//  CombineExample
//
//  Created by Matyatsko Mihail on 22.07.2022.
//

import UIKit

class ActivitySpinnerView: UIView {
    
    var spinner = UIActivityIndicatorView(style: .medium)
    
    func setupView() {
        self.backgroundColor = .clear
        spinner.color = .red
        spinner.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func showIndicator() {
        spinner.startAnimating()
        self.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func hideIndicator() {
        if spinner.isAnimating {
            spinner.stopAnimating()
        }
        if self.subviews.contains(spinner) {
            spinner.removeFromSuperview()
        }
    }
    
}
