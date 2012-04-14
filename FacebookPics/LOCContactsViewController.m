//
//  LOCContactsViewController.m
//  FacebookPics
//
//  Created by Erick Camacho on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LOCContactsViewController.h"

#import "UIImageView+WebCache.h"

@interface LOCContactsViewController ()

@property (nonatomic, strong) NSArray *contacts;

- (void)requestFBContacts;

@end

@implementation LOCContactsViewController

@synthesize spinner;
@synthesize tableView = _tableView;
@synthesize contacts = _contacts;


- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.spinner startAnimating];
  [self requestFBContacts];  
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)requestFBContacts
{  
  LOCFacebookManager *facebookManager = [LOCFacebookManager sharedInstance];
  [facebookManager setDelegate:self];
  [facebookManager getContacts];
}

#pragma mark - LOCFacebookManagerDelegate methods
- (void)didFoundContacts:(NSArray *)contacts
{
  [self.spinner stopAnimating];
  self.contacts = contacts;
  [self.tableView reloadData];
}

- (void)errorInFBRequest:(NSString *)error
{
  [self.spinner stopAnimating];
  NSLog(@"error %@", error);
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ocurrió un error" 
                                                  message:@"Inténtalo de nuevo" 
                                                 delegate:nil 
                                        cancelButtonTitle:@"OK" 
                                        otherButtonTitles:nil];
  [alert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{  
  return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"FBContactCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  NSDictionary *contact = [self.contacts objectAtIndex:indexPath.row];
  [cell.textLabel setText:[contact objectForKey:@"name"]];
  NSString *contactAvatarUrl = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture", 
                                [contact objectForKey:@"id"]];

  [cell.imageView setImageWithURL:[NSURL URLWithString:contactAvatarUrl] 
                 placeholderImage:[UIImage imageNamed:@"camera.png"]];
//  [cell.imageView setImage:[UIImage imageNamed:@"camera.png"]];
  return cell;
}


- (IBAction)close:(id)sender
{
  [self dismissModalViewControllerAnimated:YES];
}
@end
