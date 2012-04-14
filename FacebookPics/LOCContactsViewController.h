//
//  LOCContactsViewController.h
//  FacebookPics
//
//  Created by Erick Camacho on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LOCFacebookManager.h"

@interface LOCContactsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, 
LOCFacebookManagerDelegate>

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)close:(id)sender;

@end
