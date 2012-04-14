//
//  LOCFacebookManager.h
//  FacebookPics
//
//  Created by Erick Camacho on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Facebook.h"

@protocol LOCFacebookManagerDelegate <NSObject>

@optional

- (void)didLoginToFacebook;

- (void)didNotLoginToFacebook;

- (void)didLogout;

- (void)didPostPhoto;

- (void)didFoundUserData:(NSDictionary *)userData;

- (void)didFoundContacts:(NSArray *)contacts;

- (void)errorInFBRequest:(NSString *)error;

@end

@interface LOCFacebookManager : NSObject <FBSessionDelegate, FBRequestDelegate>

@property (nonatomic, strong) Facebook *facebook;

@property (nonatomic, weak) id<LOCFacebookManagerDelegate> delegate;

+ (id)sharedInstance;

- (void)loginWithFacebook;

- (void)logoutFromFacebook;

- (void)requestUserData;

- (void)postPhoto:(NSMutableDictionary *)photoParams;

- (void)getContacts;


@end

