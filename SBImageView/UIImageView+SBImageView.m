//
//  UIImageView+SBImageView.m
//  SBImageViewDemo
//
//  Created by 孙士博 on 2018/9/20.
//  Copyright © 2018年 com.Instagram. All rights reserved.
//

#import "UIImageView+SBImageView.h"

@implementation UIImageView (SBImageView)

- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholder
{
    self.image = [UIImage imageNamed:placeholder];
    
    self.tag = url;
    
    if (url) {
        NSURL *imageURL = [[NSURL alloc] initWithString:url];
        SBImageDownloader *imageDownloader = [SBImageDownloader sharedImageDownloader];
        [imageDownloader downloadImageWithURL:imageURL complete:^(UIImage *image, NSError *error, NSString *returnUrl){
            
            if (image && [self.tag isEqualToString:returnUrl]) {
                self.image = image;
            }else{
                NSLog(@"error when download:%@",error);
            }
        }];
    }
}


@end
