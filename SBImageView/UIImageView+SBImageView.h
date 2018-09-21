//
//  UIImageView+SBImageView.h
//  SBImageViewDemo
//
//  Created by 孙士博 on 2018/9/20.
//  Copyright © 2018年 com.Instagram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBImageDownloader.h"

@interface UIImageView (SBImageView)
@property NSString *tag;

- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholder ;

@end
