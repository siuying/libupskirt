//
//  MDAppDelegate.h
//  MDEditor
//
//  Created by Tulakshana on 15/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MDAppDelegate : UIResponder <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;

    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
