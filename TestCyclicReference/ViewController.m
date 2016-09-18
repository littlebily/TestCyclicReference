//
//  ViewController.m
//  TestCyclicReference
//
//  Created by Bolu on 16/9/15.
//  Copyright © 2016年 Bolu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *array1;
//@property (nonatomic, strong) NSArray *array2;
//@property (nonatomic, weak) NSArray *array2;
@property (nonatomic, unsafe_unretained) NSArray *array2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //循环引用，用Instruments的Leaks可以检测出来，里面还有图说明
    /*
    NSMutableArray *firstArray = [NSMutableArray array];
    NSMutableArray *secondArray = [NSMutableArray array];
    [firstArray addObject:secondArray];
    [secondArray addObject:firstArray];
     */

    [self test];
}

- (void)test
{
    self.array1 = [[NSArray alloc] initWithObjects:@"1", nil];
    //self.array1 = [NSArray arrayWithObjects:@"1", nil];//如果用的是这行的话array2的值就不为null，原因暂时未知，待后面考究
    
    self.array2 = self.array1;
    self.array1 = nil;
    
    //用unsafe_unretained会这里crash，因为array2变成了野指针
    NSLog(@"test array2 = %@", self.array2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
