//
//  ViewController.m
//  NetworkingDemo
//
//  Created by Francisco Magdaleno on 1/21/16.
//  Copyright © 2016 franciscojma86. All rights reserved.
//

#import "ViewController.h"
#import "AddObjectVC.h"

#import "NetworkingClient.h"

@interface ViewController () <AddObjectVCDelegate>

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                           target:self
                                                                           action:@selector(showAddVC)];
    self.navigationItem.rightBarButtonItem = button;
    [self callObjects];
    [self.refreshControl addTarget:self
                            action:@selector(callObjects)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)callObjects {
    
    UIBarButtonItem *addButton = self.navigationItem.rightBarButtonItem;
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *loading = [[UIBarButtonItem alloc]initWithCustomView:spinner];
    self.navigationItem.rightBarButtonItem = loading;
    
    [[NetworkingClient sharedClient] dataTaskWithMethod:GET
                                                   path:@"classes/TestObject"
                                                   body:nil
                                       successDataBlock:nil
                                       successJSONBlock:^(id json) {
                                           self.navigationItem.rightBarButtonItem = addButton;
                                           NSLog(@"JSON RESPONSE %@",json);
                                           [self.refreshControl endRefreshing];
                                       } failure:^(NSString *errorMessage, BOOL cancelled) {
                                           self.navigationItem.rightBarButtonItem = addButton;
                                           NSLog(@"ERROR %@ CANCELLED %d", errorMessage,cancelled);
                                           [self.refreshControl endRefreshing];
                                       }];
}


- (void)showAddVC {
    AddObjectVC *controller = [[AddObjectVC alloc]init];
    [controller setDelegate:self];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -Add Object VC delegate
- (void)addObjectVCDidAddEntry:(AddObjectVC *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self callObjects];
}

@end
