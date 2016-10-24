//
//  Person.h
//  单元测试
//
//  Created by 张江东 on 16/10/24.
//  Copyright © 2016年 58kuaipai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger age;

+ (instancetype)personWithDict:(NSDictionary *)dict;

///  异步加载个人记录
+ (void)loadPersonAsync:(void (^)(Person *person))completion;

@end
