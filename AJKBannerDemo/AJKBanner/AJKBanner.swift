//
//  AJKBanner.swift
//  AJKBannerDemo
//
//  Created by AJK on 08/04/2017.
//  Copyright © 2017 AJK. All rights reserved.
//

import UIKit

enum AJKBannerDirection {
    case left
    case right
    case down
}

enum AJKBannerAnimation {
    case linear
    case springy
}

enum AJKBannerBGColor {
    case red
    case green
    case yellow
    case blue
    case orange
    case custom(red: CGFloat, green: CGFloat, blue: CGFloat)
    func color() -> UIColor {
        switch self {
        case .red:      return UIColor(red: 170/255, green: 0, blue: 0, alpha: 1)
        case .green:    return UIColor(red: 0, green: 128/255, blue: 0, alpha: 1)
        case .yellow:   return UIColor(red: 1, green: 1, blue: 40/255, alpha: 1)
        case .blue:     return UIColor(red: 0, green: 64/255, blue: 128/255, alpha: 1)
        case .orange:   return UIColor(red: 1, green: 128/255, blue: 0, alpha: 1)
        case .custom(let cred, let cgreen, let cblue):
            return UIColor(red: cred, green: cgreen, blue: cblue, alpha: 1)
        }
    }
}

enum AJKBannerImage {
    case thumb
    case checkmark
    case exclamation
    case cross
    func uiimage() -> UIImage {
        switch self {
        case .thumb:
            return UIImage(named: "success-thumb.png")!
        case .checkmark:
            return UIImage(named: "success-checkmark.png")!
        case .exclamation:
            return UIImage(named: "error-exclamation.png")!
        case .cross:
            return UIImage(named: "error-cross.png")!
        }
    }
}

fileprivate enum AJKBannerLabelType {
    case title
    case message
}

class AJKBanner: UIView {
    
    fileprivate static let AJKBannerWidth: CGFloat = UIScreen.main.bounds.size.width
    fileprivate static let AJKBannerHeight: CGFloat = 96.0
    
    fileprivate let mainStackView = UIStackView()
    fileprivate let innerStackView = UIStackView()
    
    static func addBanner(title: String,
                          message: String,
                          bannerColor: AJKBannerBGColor,
                          titleFontName: String? = nil,
                          messageFontName: String? = nil,
                          textColor: UIColor,
                          imageType: AJKBannerImage,
                          imageTint: UIColor) {
        
        addBanner(title: title,
                  message: message,
                  bannerColor: bannerColor,
                  direction: .down,
                  titleFontName: titleFontName,
                  messageFontName: messageFontName,
                  textColor: textColor,
                  imageType: imageType,
                  imageTint: imageTint)
    }
    
    static func addBanner(title: String,
                          message: String,
                          bannerColor: AJKBannerBGColor,
                          direction: AJKBannerDirection,
                          titleFontName: String? = nil,
                          messageFontName: String? = nil,
                          textColor: UIColor,
                          imageType: AJKBannerImage,
                          imageTint: UIColor) {
        
        addBanner(title: title,
                  message: message,
                  bannerColor: bannerColor,
                  direction: direction,
                  animation: .linear,
                  titleFontName: titleFontName,
                  messageFontName: messageFontName,
                  textColor: textColor,
                  imageType: imageType,
                  imageTint: imageTint)
    }
    
    static func addBanner(title: String,
                          message: String,
                          bannerColor: AJKBannerBGColor,
                          direction: AJKBannerDirection,
                          animation: AJKBannerAnimation,
                          titleFontName: String? = nil,
                          messageFontName: String? = nil,
                          textColor: UIColor,
                          imageType: AJKBannerImage,
                          imageTint: UIColor) {
        
        
        // creating a new banner
        let banner = AJKBanner(frame: CGRect(x: 0,
                                             y: 0,
                                             width: AJKBannerWidth,
                                             height: AJKBannerHeight))
        
        // setting background color
        banner.backgroundColor = bannerColor.color()
        
        // configure stack view
        banner.configureStackView()
        
        // add image view
        banner.addImageView(imageType: imageType, tint: imageTint)
        
        // adding labels to banner
        banner.addLabels(title: title,
                         message: message,
                         titleFontName: titleFontName,
                         messageFontName: messageFontName,
                         textColor: textColor)
        
        // calculating animation frame as per direction
        var currentFrame = banner.frame
        var finalFrame = banner.frame
        switch direction {
        case .left:
            currentFrame.origin.x = AJKBannerWidth
            banner.frame = currentFrame
            finalFrame.origin.x = 0
            break
        case .right:
            currentFrame.origin.x = -AJKBannerWidth
            banner.frame = currentFrame
            finalFrame.origin.x = 0
            break
        case .down:
            currentFrame.origin.y = -AJKBannerHeight
            banner.frame = currentFrame
            finalFrame.origin.y = 0
            break
        }
        
        // adding banner to window
        UIApplication.shared.keyWindow?.addSubview(banner)
        
        // block of code to be executed when making the banner disappear
        let bannerDisappearBlock = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                UIView.animate(withDuration: 0.5, animations: {
                    banner.alpha = 0
                }, completion: { (complete) in
                    banner.removeFromSuperview()
                })
            })
        }
        
        // perform actual animation
        switch animation {
        case .linear:
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                banner.frame = finalFrame
            }, completion: { (complete) in
                bannerDisappearBlock()
            })
            break
        case .springy:
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                banner.frame = finalFrame
            }) { (complete) in
                bannerDisappearBlock()
            }
            break
        }
    }
}

extension AJKBanner {
    
    private var xOffset: CGFloat {
        return 8.0
    }
    private var defaultTitleFontSize: CGFloat {
        return 16.0
    }
    private var defaultMessageFontSize: CGFloat {
        return 13.0
    }
    private var defaultImageSize: CGFloat {
        return 48.0
    }
    private var defaultTitleFontName: String {
        return "AvenirNext-DemiBold"
    }
    private var defaultMessageFontName: String {
        return "AvenirNext-Regular"
    }
    
    fileprivate func configureStackView() {
        self.mainStackView.axis = .horizontal
        self.mainStackView.alignment = .top
        self.mainStackView.distribution = .fillProportionally
        self.mainStackView.spacing = 10
        self.mainStackView.backgroundColor = UIColor.clear
        self.mainStackView.frame = CGRect(x: xOffset,
                                 y: self.frame.origin.y + UIApplication.shared.statusBarFrame.size.height + 5,
                                 width: self.frame.size.width,
                                 height: self.frame.size.height - UIApplication.shared.statusBarFrame.size.height)
        self.addSubview(self.mainStackView)
    }
    
    fileprivate func addImageView(imageType: AJKBannerImage, tint: UIColor) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: defaultImageSize, height: defaultImageSize))
        imageView.image = imageType.uiimage()
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = tint
        imageView.contentMode = .scaleAspectFit
        self.mainStackView.addArrangedSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: defaultImageSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: defaultImageSize).isActive = true
    }
    
    fileprivate func addLabels(title: String,
                               message: String,
                               titleFontName: String? = nil,
                               messageFontName: String? = nil,
                               textColor: UIColor) {
        
        let titleLabel = makeLabel(text: title, fontName: titleFontName ?? defaultTitleFontName, fontSize: defaultTitleFontSize, type: .title, textColor: textColor)
        let messageLabel = makeLabel(text: message, fontName: messageFontName ?? defaultMessageFontName, fontSize: defaultMessageFontSize, type: .message, textColor: textColor)
        
        innerStackView.axis = .vertical
        innerStackView.alignment = .leading
        innerStackView.distribution = .fill
        innerStackView.spacing = 3
        innerStackView.backgroundColor = UIColor.clear
        innerStackView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: self.mainStackView.frame.size.width - defaultImageSize,
                                      height: self.mainStackView.frame.size.height)
        mainStackView.addArrangedSubview(innerStackView)
        
        innerStackView.addArrangedSubview(titleLabel)
        innerStackView.addArrangedSubview(messageLabel)
    }
    
    fileprivate func makeLabel(text: String,
                               fontName: String,
                               fontSize: CGFloat,
                               type: AJKBannerLabelType,
                               textColor: UIColor) -> UILabel {
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: self.innerStackView.frame.size.width - xOffset, height: 999)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = textColor
        label.font = UIFont(name: fontName, size: fontSize)
        label.text = text
        label.sizeToFit()
        return label
    }
}
