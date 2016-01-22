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

//Reference to the object creation task, so we can cancel it if needed
@property (nonatomic,strong) NSURLSessionDataTask *saveTask;

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
    self.navigationController.navigationBar.translucent = NO;
    self.nameTextField = [[UITextField alloc] init];
    [self.nameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.nameTextField.placeholder = @"Enter a name";
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.nameTextField];
    [self.view alignSubview:self.nameTextField
                     offset:40.0
                 multiplier:1.0
                      edges:ConstraintEdgesLeft | ConstraintEdgesRight | ConstraintEdgesTop
                      apply:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self isMovingFromParentViewController]) {
        //cancel operation if "back" is pressed
        if (self.saveTask) [self.saveTask cancel];
    }
}


- (void)savePressed {
    UIBarButtonItem *saveButton = self.navigationItem.rightBarButtonItem;
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *loading = [[UIBarButtonItem alloc]initWithCustomView:spinner];
    self.navigationItem.rightBarButtonItem = loading;

    NSDictionary *params = @{@"name":self.nameTextField.text};
    
    //if there is a running task, cancel it first
    if (self.saveTask) [self.saveTask cancel];
    self.saveTask = [[NetworkingClient sharedClient] dataTaskWithMethod:POST
                                                   path:@"classes/TestObject"
                                                   body:params
                                       successDataBlock:nil
                                       successJSONBlock:^(id json) {
                                           self.navigationItem.rightBarButtonItem = saveButton;
                                           NSLog(@"JSON RESPONSE %@",json);
                                           [self.delegate addObjectVCDidAddEntry:self];
                                       } failure:^(NSString *errorMessage, BOOL cancelled) {
                                           self.navigationItem.rightBarButtonItem = saveButton;
                                           if (!cancelled) {
                                               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                              message:errorMessage
                                                                                                       preferredStyle:UIAlertControllerStyleAlert];
                                               UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                                                                      style:UIAlertActionStyleCancel
                                                                                                    handler:nil];
                                               [alert addAction:cancelButton];
                                               [self presentViewController:alert animated:YES completion:nil];

                                           }

                                       }];

}

@end
