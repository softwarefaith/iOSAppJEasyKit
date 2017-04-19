//
//  ViewController.m
//  FrameLayout
//
//  Created by 蔡杰 on 2017/4/17.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LayoutMethodsExtention.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(120, 120, 100, 100)];
    view0.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view0];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(120, 120, 100, 100)];
    view1.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:view1];
    
    
    
   // [view1 bottom:20 FromView:view0];
    
   // [view1 left:20 FromView:view0];
    
   // [view1 right:20 FromView:view0];
    
   // [view1 bottom:20 FromView:view0];
   // [view1 top:20 FromView:view0];
    
   [view1 fromTheTop:20 ofView:view0];
    
  //  [view1 top:20 FromView:view0];
  //  [view1 fromTheLeft:20 ofView:view0];
    
    
//[view1 left:20 FromView:view0];
    
  //  [view1 fromTheLeft:20 ofView:view0];
    
    //[view1 right:20 FromView:view0];
    
    // [view1 fromTheRight:20 ofView:view0];
    
    //[view1 top:20 FromView:view0];
    
  //  [view1 bottom:20 FromView:view0];
    
    //[view1 fromTheTop:20 ofView:view0];
    
   // [view1 fromTheBottom:20 ofView:view0];
    
    NSLog(@"view1 = %@",NSStringFromCGRect(view1.frame));

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
