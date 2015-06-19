//
//  ViewController.swift
//  RockBox
//
//  Created by SN on 15/6/15.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Most conservative guess. We'll set them later.
    var maxX : CGFloat = 320
    var maxY : CGFloat = 320
    let boxSize : CGFloat = 30.0
    var boxes : Array<UIView> = []
    var animator:UIDynamicAnimator?
    let gravity = UIGravityBehavior()
    let collider = UICollisionBehavior()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maxX = super.view.bounds.size.width - boxSize
        maxY = super.view.bounds.size.height - boxSize
//        addBox(CGRectMake(100, 100, 30, 30))
        createAnimatorStuff()
        generateBoxes()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat(arc4random()%100000)/100000
        let green = CGFloat(arc4random()%100000)/100000
        let blue = CGFloat(arc4random()%100000)/100000
        
        return UIColor(red: red, green: green, blue: blue, alpha: 0.85)
    }

    func doesNotCollide(testRect: CGRect) -> Bool {
        for box in boxes {
            var viewRect = box.frame
            if CGRectIntersectsRect(testRect, viewRect) {
                return false
            }
        }
        return true
    }
    
    func randomFrame() -> CGRect {
        var guess = CGRectMake(9, 9, 9, 9)
        
        do {
        
        let guessX = CGFloat(arc4random()) % maxX
        let guessY = CGFloat(arc4random()) % maxY
        guess = CGRectMake(guessX, guessY, boxSize, boxSize)
        
        }while(!doesNotCollide(guess))
        return guess
    }
    
    
    func addBox(location: CGRect, color: UIColor) -> UIView {
        let newBox = UIView(frame: location)
        newBox.backgroundColor = color

        view.addSubview(newBox)
        addBoxBehaviors(newBox)
        
        boxes.append(newBox)

        return newBox
    }
    
    func generateBoxes() {
        for i in 0...15 {
            var frame = randomFrame()
            var color = randomColor()
            var newBox = addBox(frame, color: color)
        }
    }
    
    func createAnimatorStuff() {
        animator = UIDynamicAnimator(referenceView:self.view)
        
        collider.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collider)
        

        gravity.gravityDirection = CGVectorMake(0, 0.8)
        animator?.addBehavior(gravity)
    }

    
    func addBoxBehaviors(box: UIView) {
        gravity.addItem(box)
        collider.addItem(box)
    }
    
    
    
    

}

