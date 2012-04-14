//
//  LOCViewController.h
//  FacebookPics
//
//  Created by Erick Camacho on 23/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LOCFacebookManager.h"

@interface LOCViewController : UIViewController <LOCFacebookManagerDelegate>

- (IBAction)loginInFB:(id)sender;

@end
