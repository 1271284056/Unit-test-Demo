//
//  PersonTests.m
//  单元测试
//
//  Created by 张江东 on 16/10/24.
//  Copyright © 2016年 58kuaipai. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTests : XCTestCase

@end

@implementation PersonTests
///  一次单元测试开始前的准备工作，可以设置全局变量

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

///  一次单元测试结束前的销毁工作
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 苹果的单元测试是串行的
 setUp
 testXXX1
 testXXX2
 testXXX3
 tearDown
 中间不会等待异步的回调完成
 */
///  测试异步加载 Person
- (void)testLoadPersonAsync {
    // Xcode 6.0 开始解决 `Expectation` 预期
    XCTestExpectation *expectation = [self expectationWithDescription:@"异步加载 Person"];
    [Person loadPersonAsync:^(Person *person) {
        NSLog(@"%@", person.name);
        // 标注预期达成
        [expectation fulfill];
    }];
    // 等待 10s 期望预期达成
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

/**
 1. 单元测试是以代码测试代码
 2. 红灯／绿灯迭代开发
 3. 在日常开发中，数据大部分来自于网络，很难出现`所有的`边界数据！如果没有测试所有条件就上架
 在运行时造成闪退！
 4. 自己建立`测试用例(使用的例子数据，专门检查边界点)`
 5. 单元测试不是靠 NSLog 来测试，NSLog 是程序员用眼睛看的笨办法。
 使用 `断言` 来测试的，提前预判条件必须满足！
 
 测试新建 Person 模型
 
 扩展：为什么有些公司讨厌单元测试！因为`代码覆盖度`不好确认！
 
 提示：
 1. 不是所有的方法都需要测试
 例如：私有方法不需要测试！只有暴露在 .h 中的方法需要测试！面向对象有一个原则：开闭原则！
 2. 所有跟 UI 有关的都不需要测试，也不好测试！
 MVVM，把 `小的业务逻辑` 代码封装出来！变成可以测试的代码，让程序更加健壮！
 3. 一般而言，代码的覆盖度大概在 50% ~ 70%
 */
- (void)testNewPerson {
    [self checkPersonWithDict:@{@"name": @"zhang", @"age": @20}];
    [self checkPersonWithDict:@{@"name": @"zhang"}];
    [self checkPersonWithDict:@{}];
    [self checkPersonWithDict:@{@"name": @"zhang", @"age": @20, @"title": @"boss"}];
    [self checkPersonWithDict:@{@"name": @"zhang", @"age": @200, @"title": @"boss"}];
    [self checkPersonWithDict:@{@"name": @"zhang", @"age": @-1, @"title": @"boss"}];
    
    // 到目前为止 Person 的 工厂方法测试完成！
}

///  根据字典检查新建的 Person 信息
- (void)checkPersonWithDict:(NSDictionary *)dict {
    
    Person *person = [Person personWithDict:dict];
    
    NSLog(@"%@", person);
    
    // 获取字典信息
    NSString *name = dict[@"name"];
    NSInteger age = [dict[@"age"] integerValue];
    
    
    
    // 1. 检查名称
    XCTAssert([name isEqualToString:person.name] || person.name == nil, @"姓名不一致");
    
    // 2. 检查年龄
    if (person.age > 0 && person.age < 130) {
        XCTAssert(age == person.age, @"年龄不正确");
    } else {
        XCTAssert(person.age == 0, @"年龄超限");
    }
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

// Performance 性能！
/*
 相同的代码重复执行 10 次，统计计算时间，平均时间！
 
 性能测试代码一旦写好，可以随时测试！
 */
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        // 将需要测量执行时间的代码放在此处！
        NSTimeInterval start = CACurrentMediaTime();
        
        
        
        for (int i = 0; i < 10000; i++) {
            [Person personWithDict:@{@"name": @"zhang", @"age": @20}];
        }
        
        NSLog(@"%f", CACurrentMediaTime() - start);
    }];
}


@end
