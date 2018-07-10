//
//  ViewController.m
//  XFSearchEqualSuper
//
//  Created by xiefei on 2018/7/10.
//  Copyright © 2018年 xiefei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    
    [view1 addSubview:view2];
    [view1 addSubview:view3];
    
    [self.view addSubview:view1];

    [self searchClass1:[ViewController class] andClass:[UIView class]];

    [self searchClass2:[ViewController class] andClass:[UIView class]];
    
    [self searchSuperView1:view2 andClass:view3];

    [self searchSuperView2:view1 andClass:view3];
    // Do any additional setup after loading the view, typically from a nib.
}

// 获取所有父类
- (NSArray *)superClasses:(Class)class {
    if (class == nil) {
        return @[];
    }
    NSMutableArray *result = [NSMutableArray array];
    while (class != nil) {
        [result addObject:class];
        class = [class superclass];
    }
    return [result copy];
}

// 获取所有父视图
- (NSArray *)superView:(UIView *)subView {
    if (subView == nil) {
        return @[];
    }
    NSMutableArray *result = [NSMutableArray array];
    while (subView != nil) {
        subView = [subView superview];
        if (subView != nil) {
            [result addObject:subView];
        }
    }
    return [result copy];
}
#pragma search common class
- (Class)searchClass1:(Class)classA andClass:(Class)classB {
    NSArray *arr1 = [self superClasses:classA];
    NSArray *arr2 = [self superClasses:classB];
    __block Class classResult = nil;
    [arr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (NSUInteger j = 0; j < arr2.count; ++j) {
            if (obj == arr2[j]) {
                classResult = obj;
                NSLog(@"Common Class_=%@",[obj description]);
                *stop = YES;
            }
        }
    }];
    return classResult;
}

- (Class)searchClass2:(Class)classA andClass:(Class)classB{
    NSArray *arr1 = [self superClasses:classA];
    NSArray *arr2 = [self superClasses:classB];
    NSSet *set = [NSSet setWithArray:arr2];
    __block Class classResult = nil;

    [arr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([set containsObject:obj]) {
            NSLog(@"Common Class_=%@",[obj description]);
            classResult = obj;
            *stop = YES;
        }
    }];
    return classResult;
}

#pragma search common superview

- (UIView *)searchSuperView1:(UIView *)viewA andClass:(UIView *)viewB {
    NSArray *arr1 = [self superView:viewA];
    NSArray *arr2 = [self superView:viewB];
    __block UIView * classResult = nil;
    [arr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (NSUInteger j = 0; j < arr2.count; ++j) {
            if (obj == arr2[j]) {
                classResult = obj;
                NSLog(@"Common SuperView=%@",[obj description]);
                *stop = YES;
            }
        }
    }];
    return classResult;
}

- (UIView *)searchSuperView2:(UIView *)viewA andClass:(UIView *)viewB {
    NSArray *arr1 = [self superView:viewA];
    NSArray *arr2 = [self superView:viewB];
    NSSet *set = [NSSet setWithArray:arr2];
    __block UIView *  classResult = nil;
    
    [arr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([set containsObject:obj]) {
            NSLog(@"Common SuperView=%@",[obj description]);
            classResult = obj;
            *stop = YES;
        }
    }];
    return classResult;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
