//
//  KPCustomNotificationView.swift
//  KiipSwiftSample
//
//  Copyright © 2018 Kiip. All rights reserved.
//

import UIKit
import KiipSDK


//Example of creating your custom notificaation view
class KPCustomNotificationView: KPNotificationView {
    
    var background: UIImage?
    var titleFont: UIFont?
    var titleRect = CGRect.zero
    var messageFont: UIFont?
    var messageRect = CGRect.zero
    
    let HEIGHT : CGFloat = 46
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleWidth
        
        backgroundColor = UIColor.red
        background = UIImage(named: "button")?.stretchableImage(withLeftCapWidth: 6, topCapHeight: 6)
        
        if let aSize = UIFont(name: "AvenirNext-DemiBold", size: 12) {
            titleFont = aSize
        }
        
        messageFont = UIFont(name: "AvenirNext-Medium", size: 12)
        
        // Fallbacks
        #if false
        if !titleFont {
            if let aSize = UIFont(name: "HelveticaNeue-Bold", size: 11) as? UIFont {
                titleFont = aSize
            }
        }
        #endif
        if (messageFont != nil) {
            messageFont = UIFont(name: "HelveticaNeue-Medium", size: 11)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToSuperview() {
        frame = CGRect(x: 0, y: 0, width: (superview?.bounds.width)!, height: HEIGHT)
        titleRect = CGRect(x: 65, y: 7, width: bounds.width - 65 - 20 - 10, height: (titleFont?.lineHeight)!)
        messageRect = CGRect(x: 65, y: 23, width: bounds.width - 65 - 10, height: (messageFont?.lineHeight)!)
    }
    
    
    override func draw(_ rect: CGRect) {
        let notification: KPNotification? = poptart.notification
        
        // Background
        background?.draw(in: bounds)
        
        // Icon
        notification?.icon.draw(in: CGRect(x: 5, y: 2, width: 55, height: 42))
        
        // Title
        UIColor.white.set()
        notification?.title.draw(in: titleRect, withAttributes: [kCTFontAttributeName as NSAttributedStringKey : titleFont!])
        
        //    NSDictionary *dictionary = @{ NSFontAttributeName: self.titleFont, NS_ENUM_AVAILABLE: UILineBreakModeTailTruncation};
        //    [notification.title drawInRect:self.titleRect withAttributes:dictionary];
        
        // Message
        UIColor.white.set()
        notification?.message.draw(in: messageRect, withAttributes: [kCTFontAttributeName as NSAttributedStringKey : messageFont!])
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
