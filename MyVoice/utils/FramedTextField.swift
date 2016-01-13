//
//  FramedTextField.swift
//  MyVoice
//
//  Created by PB014 on 07/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class FramedTextField: UITextField {
    
    @IBInspectable var linesWidth: CGFloat = 1.0 { didSet{ drawLines() } }
    
    @IBInspectable var linesColor: UIColor = UIColor.blackColor() { didSet{ drawLines() } }
    
    @IBInspectable var leftLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var rightLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var bottomLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var topLine: Bool = false { didSet{ drawLines() } }
    
    
    
    func drawLines() {
        
        if bottomLine {
            add(CGRectMake(0.0, frame.size.height - linesWidth, frame.size.width, linesWidth))
        }
        
        if topLine {
            add(CGRectMake(0.0, 0.0, frame.size.width, linesWidth))
        }
        
        if rightLine {
            add(CGRectMake(frame.size.width - linesWidth, 0.0, linesWidth, frame.size.height))
        }
        
        if leftLine {
            add(CGRectMake(0.0, 0.0, linesWidth, frame.size.height))
        }
        
    }
    
    typealias Line = CGRect
    private func add(line: Line) {
        let border = CALayer()
        border.frame = line
        border.backgroundColor = linesColor.CGColor
        layer.addSublayer(border)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawLines()
    }
    
}