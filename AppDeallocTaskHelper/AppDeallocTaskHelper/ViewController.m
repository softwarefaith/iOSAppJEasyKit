//
//  ViewController.m
//  AppDeallocTaskHelper
//
//  Created by 蔡杰 on 2018/1/4.
//  Copyright © 2018年 蔡杰. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+AppDeallocTaskMonitor.h"

@interface t1 : NSObject

@end

@implementation t1


-(void)dealloc {
    
    NSLog(@"我t1没了");
}

@end

@interface t : NSObject

@property(nonatomic, strong) t1 *t11;

@end

@implementation t

-(instancetype)init {
    self = [super init];
    if (self) {
        _t11 = [[t1 alloc] init];
    }
    return self;
}
-(void)dealloc {
    
    NSLog(@"我没了");
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    t  *minitor = [[t  alloc] init];
    NSLog(@"---syn ");
    [minitor asynAddDeallocTask:^(__unsafe_unretained id object, NSUInteger identifier) {
        NSLog(@"syn = %@",@(identifier));
        
    }];
    
    minitor = nil;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
