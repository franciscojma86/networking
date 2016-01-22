//
//  TestObject.m
//  NetworkingDemo
//
//  Created by Francisco Magdaleno on 1/22/16.
//  Copyright © 2016 franciscojma86. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

+ (NSArray *)testObjectsFromArray:(NSArray *)objects {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *objectInfo in objects) {
        TestObject *object = [TestObject testObjectWithInfo:objectInfo];
        [result addObject:object];
    }
    return result;
}

+ (TestObject *)testObjectWithInfo:(NSDictionary *)info {
    TestObject *testObject = [[TestObject alloc]init];
    [testObject setName:info[@"name"]];
    [testObject setTestObjectID:info[@"objectId"]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [testObject setCreatedAt:[formatter dateFromString:info[@"createdAt"]]];
    
    return testObject;
}

@end
