//
//  AddObjectVC.m
//  NetworkingDemo
//
//  Created by Francisco Magdaleno on 1/22/16.
//  Copyright © 2016 franciscojma86. All rights reserved.
//

#import "AddObjectVC.h"
#import "NetworkingClient.h"
#import "UIView+Autolayout.h"

@interface AddObjectVC ()

@property (nonatomic,strong) UITextField *nameTextField;

@end

@implementation AddObjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(savePressed)];
    self.navigationItem.rightBarButtonItem = saveButton;
    //Create the textview
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.nameTextField = [[UITextField alloc] init];
    [self.nameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.nameTextField.placeholder = @"Enter a name";
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.nameTextField];
    
    [self.view alignSubView:self.nameTextField centers:ConstraintCentersY
                      apply:YES];
    [self.view alignSubview:self.nameTextField
                     offset:40.0
                 multiplier:1.0
                      edges:ConstraintEdgesLeft | ConstraintEdgesRight
                      apply:YES];
}


- (void)savePressed {
    UIBarButtonItem *saveButton = self.navigationItem.rightBarButtonItem;
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *loading = [[UIBarButtonItem alloc]initWithCustomView:spinner];
    self.navigationItem.rightBarButtonItem = loading;

    NSDictionary *params = @{@"name":self.nameTextField.text};
    [[NetworkingClient sharedClient] dataTaskWithMethod:POST
                                                   path:@"classes/TestObject"
                                                   body:params
                                       successDataBlock:nil
                                       successJSONBlock:^(id json) {
                                           self.navigationItem.rightBarButtonItem = saveButton;
                                           NSLog(@"JSON RESPONSE %@",json);
                                           [self.delegate addObjectVCDidAddEntry:self];
                                       } failure:^(NSString *errorMessage, BOOL cancelled) {
                                           self.navigationItem.rightBarButtonItem = saveButton;
                                           NSLog(@"ERROR %@ CANCELLED %d", errorMessage,cancelled);
                                       }];

}

@end
