//
//  ProfileImageView.swift
//  edX
//
//  Created by Michael Katz on 9/17/15.
//  Copyright (c) 2015 edX. All rights reserved.
//

import UIKit

@IBDesignable
class ProfileImageView: UIImageView {
    
    var borderWidth: CGFloat = 1.0
    var borderColor: UIColor?

    private func setup() {
        var borderStyle = OEXStyles.sharedStyles().profileImageViewBorder(borderWidth)
        if borderColor != nil {
            borderStyle = BorderStyle(cornerRadius: borderStyle.cornerRadius, width: borderStyle.width, color: borderColor)
        }
        applyBorderStyle(borderStyle)
        backgroundColor = OEXStyles.sharedStyles().profileImageBorderColor()
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init (frame: CGRect) {
        super.init(frame: frame)
        let bundle = NSBundle(forClass: self.dynamicType)
        image = UIImage(named: "avatarPlaceholder", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        let bundle = NSBundle(forClass: self.dynamicType)
        image = UIImage(named: "avatarPlaceholder", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
    }
    
}
