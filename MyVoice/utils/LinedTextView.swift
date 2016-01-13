//
//  LinedTextView.swift
//  MyVoice
//
//  Created by PB014 on 08/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class LinedTextView: UITextView {
    
    @IBInspectable var linesWidth: CGFloat = 1.0 { didSet{ drawLines() } }
    
    @IBInspectable var linesColor: UIColor = UIColor.lightGrayColor() { didSet{ drawLines() } }
    
    
    
    func drawLines() {

    add(CGRectMake(0.0, frame.size.height - linesWidth, frame.size.width, linesWidth))
        
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
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
      
        
        let screen = self.window!.screen ?? UIScreen.mainScreen()
        let lineWidth = 1.0 / screen.scale;
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(context, lineWidth);
        
            CGContextBeginPath(context);
            CGContextSetStrokeColorWithColor(context, linesColor.CGColor);
            
            // Create un-mutated floats outside of the for loop.
            // Reduces memory access.
            let baseOffset = self.textContainerInset.top + self.font!.descender + 2;
            let screenScale = UIScreen.mainScreen().scale;
            let boundsX = self.bounds.origin.x;
            let boundsWidth = self.bounds.size.width;
            
            // Only draw lines that are visible on the screen.
            // (As opposed to throughout the entire view's contents)
            let firstVisibleLine = Int(max(1, (self.contentOffset.y / self.font!.lineHeight)));
        let lastVisibleLine = Int(ceilf(Float(self.contentOffset.y + self.bounds.size.height) / Float(self.font!.lineHeight)));
        
         for line in firstVisibleLine...lastVisibleLine {
                let linePointY = ((baseOffset) + ((self.font!.lineHeight) * CGFloat(line)));
                // Rounding the point to the nearest pixel.
                // Greatly reduces drawing time.
                let roundedLinePointY = round(linePointY * screenScale) / screenScale;
                CGContextMoveToPoint(context, boundsX, roundedLinePointY);
                CGContextAddLineToPoint(context, boundsWidth, roundedLinePointY);
            }
            CGContextClosePath(context);
            CGContextStrokePath(context);
        
    }
    
}