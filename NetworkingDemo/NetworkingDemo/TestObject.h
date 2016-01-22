//
//  TestObject.h
//  NetworkingDemo
//
//  Created by Francisco Magdaleno on 1/22/16.
//  Copyright © 2016 franciscojma86. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObject : NSObject

@property (nonatomic,strong) NSString *testObjectID;
@property (nonatomic,strong) NSDate *createdAt;
@property (nonatomic,strong) NSString *name;

+ (NSArray *)testObjectsFromArray:(NSArray *)objects;
+ (TestObject *)testObjectWithInfo:(NSDictionary *)info;
@end
