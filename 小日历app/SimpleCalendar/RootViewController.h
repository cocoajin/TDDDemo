//
//  RootViewController.h
//  SimpleCalendar
//
//  Created by jinkeke@techshino.com on 14-7-30.
//  Copyright (c) 2014年 www.techshino.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

{
    /**
     //webView 小日历；简洁版
     //https://github.com/zzyss86/LunarCalendar
     //要手机访问 http://tuijs.com
     
     */
    UIWebView *webCalendar;
    
    UIView *loadingView;
}



/**
   iOS 算法版日历
 https://github.com/cyrusleung/CYLunarCalendar
 
 */
@end
