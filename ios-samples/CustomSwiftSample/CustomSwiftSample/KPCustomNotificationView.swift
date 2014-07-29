//
//  KPCustomNotificationView.swift
//  CustomSwiftSample
//
//  Created by Sahil Verma on 7/28/14.
//  Copyright (c) 2014 kiip. All rights reserved.
//

import Foundation

class KPCustomNotificationView : KPNotificationView {

    // properties describing the custom notification view.
    var background : UIImage
    var titleFont : UIFont
    var messageFont : UIFont
    var titleRect : CGRect
    var messageRect : CGRect

    let HEIGHT : CGFloat = 46

    init() {
        titleFont = UIFont(name:"HelveticaNeue-Bold", size: 12)
        messageFont = UIFont(name:"HelveticaNeue-Medium", size: 12)
        var backgroundColor = UIColor.clearColor()
        background = UIImage(named:"button.png")
        titleRect = CGRect()
        messageRect = CGRect()
        super.init(frame: CGRectZero)
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
    }

    override func didMoveToSuperview() {
        if self.superview == nil {
            return
        }
        self.frame = CGRectMake(0, 0, CGRectGetWidth(self.superview.bounds), HEIGHT)
        titleRect = CGRectMake(65, 7, CGRectGetWidth(self.bounds) - 65 - 20 - 10, titleFont.lineHeight)
        messageRect = CGRectMake(65, 24, CGRectGetWidth(self.bounds) - 65 - 10, messageFont.lineHeight)
    }

    override func drawRect(rect: CGRect) -> Void {

        var notification:KPNotification = self.poptart.notification

        // background
        background.drawInRect(self.bounds)

        // Icon
        notification.icon.drawInRect(CGRectMake(5, 2, 55, 42))

        // Title
        var attrs = NSMutableDictionary()
        attrs.setValue(titleFont, forKey:NSFontAttributeName)
        // TODO
        //attrs.setValue(NSLineBreakMode.ByTruncatingTail, forKey:lineBreakMode)

        UIColor.whiteColor().set()
        notification.title.drawInRect(titleRect, withAttributes: attrs)
        
        // Message
        notification.message.drawInRect(messageRect, withAttributes: attrs)
    }
}