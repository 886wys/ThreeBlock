//
//  ViewController.m
//  ThreeBlock
//
//  Created by 王永顺 on 2018/5/9.
//  Copyright © 2018年 EasonWang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     block的分类
     1:NSGlobalBlock data区
     2:NSMallocBlock 堆(引用外部变量)
     3:NSStackBlock  栈
     */
    
    //1、NSGlobalBlock
    void (^block)(void) = ^{
        NSLog(@"NSGlobalBlock");
    };
    
    NSLog(@"%@",block);
    
    
    //NSMallocBlock
    //== ====>copy 栈===>堆 ref
    int a = 10;
    void (^block1)(void) = ^{
        
        NSLog(@"%d",a);
        NSLog(@"block");
    };
    NSLog(@"%@",block1);
    
    
    //NSStackBlock
    NSLog(@"%@",^{
        
        NSLog(@"%d",a);
    });
    
    
    [self checkBlock];
}


- (void)checkBlock {
    
    //修改外部变量
    // __block 把观察到的变量由栈copy到堆
    
    //前0x7fff5d34dc88  16进制
    //后0x604000038d38
    //中0x604000038d38
    
    //栈  空间比较小  2M  1024*1024 = 2*10^6
    
    __block int b = 10;
    
    NSLog(@"前%p",&b);
    
    void (^block2)(void) = ^{
        
        NSLog(@"中%p",&b);
        
        b += 10;
        NSLog(@"%d",b);
        //        NSLog(@"block");
    };
    
    NSLog(@"后%p",&b);
    
    block2();
    
    NSLog(@"%@",block2);//NSMallocBlock
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
