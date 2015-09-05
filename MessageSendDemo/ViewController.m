//
//  ViewController.m
//  MessageSendDemo
//
//  Created by Demon_Yao on 9/5/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *person = [[Person alloc] init];
    [person instanceMethod_run];
}

@end
