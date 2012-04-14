//
//  LOCFacebookManager.m
//  FacebookPics
//
//  Created by Erick Camacho on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LOCFacebookManager.h"

#import "LOCConstants.h"

@interface LOCFacebookManager ()
{
  BOOL photoPosted;
  BOOL userRequested;
  BOOL contactsRequested;
}

- (void)loginWithFacebook;

@end

@implementation LOCFacebookManager

@synthesize facebook = _facebook;
@synthesize delegate = _delegate;

+ (id)sharedInstance
{
  static LOCFacebookManager *instance = nil;
  if (!instance) {
    instance = [[[self class] alloc] init];

  }
  return instance;
}

- (id)init
{
  self = [super init];
  if (self) {
    self.facebook = [[Facebook alloc] initWithAppId:LOC_FB_APP_ID andDelegate:self];

  }
  return self;
}

- (void)loginWithFacebook
{
  if ([self.facebook isSessionValid]) {
    [self fbDidLogin];
  } else {
    NSArray *facebookPermissions = [NSArray arrayWithObject:@"publish_stream"];
    [self.facebook authorize:facebookPermissions];
  }
  
}

- (void)logoutFromFacebook
{
  [self.facebook logout];
}

- (void)requestUserData
{
  userRequested = YES;
  [self.facebook requestWithGraphPath:@"me" andDelegate:self];
}


- (void)postPhoto:(NSMutableDictionary *)photoParams
{
  photoPosted = YES;
  [self.facebook requestWithGraphPath:[NSString stringWithFormat:@"/me/photos?access_token=%@", self.facebook.accessToken]
                            andParams:photoParams andHttpMethod:@"POST" andDelegate:self];
}

- (void)getContacts
{
  contactsRequested = YES;
  [self.facebook requestWithGraphPath:@"me/friends" andDelegate:self];
}

#pragma mark FBSession delegate methods
- (void)fbDidLogin
{
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[self.facebook accessToken] forKey:@"FBAccessTokenKey"];
  [defaults setObject:[self.facebook expirationDate] forKey:@"FBExpirationDateKey"];
  [defaults synchronize];
  
  if ([self.delegate respondsToSelector:@selector(didLoginToFacebook)]) {
    [self.delegate didLoginToFacebook];
  }  
}



- (void)fbDidNotLogin:(BOOL)cancelled
{
  NSLog(@"fbDidNotLogin");
  if ([self.delegate respondsToSelector:@selector(didNotLoginToFacebook)]) {
    [self.delegate didNotLoginToFacebook];
  }
}

- (void)fbDidLogout
{
  NSLog(@"logged out from FB");
  if ([self.delegate respondsToSelector:@selector(didLogout)]) {
    [self.delegate didLogout];
  }
}

- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt
{
  NSLog(@"method not implemented");
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
  [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
  [defaults synchronize];
  [self fbDidLogin];
}


- (void)fbSessionInvalidated
{
  NSLog(@"method not implemented");
  [self fbDidNotLogin:NO];
}


- (void)request:(FBRequest *)request didLoad:(id)result 
{
  NSLog(@"request returns %@",result);  
  if (photoPosted) {
    photoPosted = NO;
    if ([self.delegate respondsToSelector:@selector(didPostPhoto)]) {
      [self.delegate didPostPhoto];
    }
  } else if (userRequested) {
    userRequested = NO;
    if ([self.delegate respondsToSelector:@selector(didFoundUserData:)]) {
      [self.delegate didFoundUserData:result];
    }
  } else if( contactsRequested ) {
    contactsRequested = NO;
    if ([self.delegate respondsToSelector:@selector(didFoundContacts:)]) {
      NSArray *friends = [result objectForKey:@"data"];
      [self.delegate didFoundContacts:friends];
    }
  }
    
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
  photoPosted = NO;
  userRequested = NO;
  contactsRequested = NO;
  if ([self.delegate respondsToSelector:@selector(errorInFBRequest:)]) {
    [self.delegate errorInFBRequest:[error description]];
  }
}


@end
