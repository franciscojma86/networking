//
//  ViewController.m
//  NetworkingDemo
//
//  Created by Francisco Magdaleno on 1/21/16.
//  Copyright © 2016 franciscojma86. All rights reserved.
//

#import "TestObjectsVC.h"
#import "AddObjectVC.h"
#import "TestObject.h"

#import "NetworkingClient.h"

@interface TestObjectsVC () <AddObjectVCDelegate>

//This will be the tableView datasource
@property (nonatomic,strong) NSArray *testObjects;

@end

@implementation TestObjectsVC 

static  NSString *const cellIdentifier = @"objectCell";

//TODO: Add object deletion feature 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Test Objects";
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                           target:self
                                                                           action:@selector(showAddVC)];
    self.navigationItem.rightBarButtonItem = button;
    [self callObjects];
    [self.refreshControl addTarget:self
                            action:@selector(callObjects)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)setTestObjects:(NSArray *)testObjects {
    if (_testObjects != testObjects) {
        _testObjects = testObjects;
        [self.tableView reloadData];
    }
}

#pragma mark -Networking calls
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
                                           NSArray *results = json[@"results"];
                                           self.testObjects = [TestObject testObjectsFromArray:results];
                                           [self.refreshControl endRefreshing];
                                       } failure:^(NSString *errorMessage, BOOL cancelled) {
                                           self.navigationItem.rightBarButtonItem = addButton;
                                           [self.refreshControl endRefreshing];
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

#pragma mark -Show VCS
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

#pragma mark -Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:cellIdentifier];
    }
    TestObject *object = self.testObjects[indexPath.row];
    [cell.textLabel setText:object.name];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [cell.detailTextLabel setText:[formatter stringFromDate:object.createdAt]];

    return cell;
}

@end
