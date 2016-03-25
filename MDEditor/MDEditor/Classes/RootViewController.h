//
//  RootViewController.h
//  MDEditor
//
//  Created by Tulakshana on 15/06/2012.
//  Copyright (c) 2012 Eugein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIWebViewDelegate>{
    UITextView *textView;
    UIWebView *webView;
    UIButton *btnToggle;
}

@end
