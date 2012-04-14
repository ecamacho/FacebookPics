//
//  LOCAppDelegate.m
//  FacebookPics
//
//  Created by Erick Camacho on 23/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LOCAppDelegate.h"

#import "LOCFacebookManager.h"

@implementation LOCAppDelegate 

@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  

  return YES;
  
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
  LOCFacebookManager *facebookManager = [LOCFacebookManager sharedInstance];
  [facebookManager loadTokenFromUserDefaults];
  [[facebookManager facebook] extendAccessTokenIfNeeded];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
  LOCFacebookManager *facebookManager = [LOCFacebookManager sharedInstance];
  return [facebookManager.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url 
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  LOCFacebookManager *facebookManager = [LOCFacebookManager sharedInstance];
  return [facebookManager.facebook handleOpenURL:url];
}


@end
