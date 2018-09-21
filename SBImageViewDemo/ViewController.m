//
//  ViewController.m
//  SBImageViewDemo
//
//  Created by 孙士博 on 2018/9/20.
//  Copyright © 2018年 com.Instagram. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor redColor]];;
    UIImageView *imageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 300, 300)];
    [self.view addSubview:imageVIew];
    [imageVIew setImageWithURL:@"https://www.google.com.au/images/branding/googlelogo/2x/googlelogo_light_color_272x92dp.png" placeholderImage:@"demo.jpeg"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
