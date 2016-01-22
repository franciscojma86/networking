//
//  AddObjectVC.h
//  NetworkingDemo
//
//  Created by Francisco Magdaleno on 1/22/16.
//  Copyright © 2016 franciscojma86. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddObjectVC;
@protocol AddObjectVCDelegate <NSObject>

- (void)addObjectVCDidAddEntry:(AddObjectVC *)sender;

@end

@interface AddObjectVC : UIViewController

@property (nonatomic,weak) id<AddObjectVCDelegate>delegate;

@end
