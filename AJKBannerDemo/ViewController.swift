//
//  ViewController.swift
//  AJKBannerDemo
//
//  Created by AJK on 08/04/2017.
//  Copyright © 2017 AJK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorsSegment: UISegmentedControl!
    @IBOutlet var RGBRedLabel: UILabel!
    @IBOutlet var RGBGreenLabel: UILabel!
    @IBOutlet var RGBBlueLabel: UILabel!
    @IBOutlet var customRBGViewHeightConstraint: NSLayoutConstraint!
    
    var selectedColor: AJKBannerBGColor = .red {
        didSet {
            adjustRBGViewHeightConstraint()
        }
    }
    var selectedAnimationType: AJKBannerAnimation = .linear
    var selectedDirection: AJKBannerDirection = .left
    
    var selectedRed: CGFloat = 0 {
        didSet {
            RGBRedLabel.text = "Red: \(selectedRed)"
            setCustomBannerBGColor()
        }
    }
    var selectedGreen: CGFloat = 0 {
        didSet {
            RGBGreenLabel.text = "Green: \(selectedGreen)"
            setCustomBannerBGColor()
        }
    }
    var selectedBlue: CGFloat = 0 {
        didSet {
            RGBBlueLabel.text = "Blue: \(selectedBlue)"
            setCustomBannerBGColor()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        colorsSegment.selectedSegmentIndex = 0
        adjustRBGViewHeightConstraint()
    }
    
    fileprivate func adjustRBGViewHeightConstraint() {
        if colorsSegment.selectedSegmentIndex == 5 {
            customRBGViewHeightConstraint.constant = 57
        } else {
            customRBGViewHeightConstraint.constant = 0
        }
        self.view.layoutIfNeeded()
    }
    
    fileprivate func setCustomBannerBGColor() {
        selectedColor = .custom(red: selectedRed/255, green: selectedGreen/255, blue: selectedBlue/255)
    }
    
    @IBAction func colorChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedColor = .red
            break
        case 1:
            selectedColor = .green
            break
        case 2:
            selectedColor = .blue
            break
        case 3:
            selectedColor = .yellow
            break
        case 4:
            selectedColor = .orange
            break
        case 5:
            setCustomBannerBGColor()
            break
        default:
            break
        }
    }
    
    @IBAction func RGBRedValueChanged(_ sender: UIStepper) {
        selectedRed = CGFloat(sender.value)
    }
    
    @IBAction func RGBGreenValueChanged(_ sender: UIStepper) {
        selectedGreen = CGFloat(sender.value)
    }
    
    @IBAction func RGBBlueValueChanged(_ sender: UIStepper) {
        selectedBlue = CGFloat(sender.value)
    }
    
    @IBAction func animationTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedAnimationType = .linear
            break
        case 1:
            selectedAnimationType = .springy
            break
        default:
            break
        }
    }
    
    @IBAction func directionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedDirection = .left
            break
        case 1:
            selectedDirection = .right
            break
        case 2:
            selectedDirection = .down
            break
        default:
            break
        }
    }
    
    @IBAction func showBanner(_ sender: UIButton) {
        
        var color = UIColor.white
        if selectedColor.color() == AJKBannerBGColor.yellow.color() {
            color = UIColor.black
        }
        
        var imageType: AJKBannerImage = .thumb
        let random = arc4random() % 4
        switch random {
        case 0:
            imageType = .thumb
        case 1:
            imageType = .checkmark
        case 2:
            imageType = .exclamation
        case 3:
            imageType = .cross
        default:
            imageType = .thumb
        }
        
        AJKBanner.addBanner(title: "Upload Complete",
                            message: "image.png has been uploaded successfully! What would you like to do now man? huh?",
                            bannerColor: selectedColor,
                            direction: selectedDirection,
                            animation: selectedAnimationType,
                            textColor: color,
                            imageType: imageType,
                            imageTint: color)
    }
}

