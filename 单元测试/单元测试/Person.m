//
//  Person.m
//  单元测试
//
//  Created by 张江东 on 16/10/24.
//  Copyright © 2016年 58kuaipai. All rights reserved.
//

#import "Person.h"

@implementation Person
+ (instancetype)personWithDict:(NSDictionary *)dict {
    Person *obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    if (obj.age <= 0 || obj.age >= 130) {
        obj.age = 0;
    }
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (void)loadPersonAsync:(void (^)(Person *))completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0),  ^{
        [NSThread sleepForTimeInterval:1.0];
        
        Person *person = [Person personWithDict:@{@"name": @"z", @"age": @5}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(person);
            }
        });
    });
}


@end
