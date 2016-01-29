//
//  HMImageGridCell.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/29.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMImageGridCell.h"

@interface HMImageGridCell()
@property (nonatomic) NSBundle *imageBundle;
@property (nonatomic) UIButton *selectedButton;
@end

@implementation HMImageGridCell

#pragma mark - 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    CGFloat offsetX = self.bounds.size.width - self.selectedButton.bounds.size.width;
    self.selectedButton.frame = CGRectOffset(self.selectedButton.bounds, offsetX, 0);
}

#pragma mark - 监听方法
- (void)clickSelectedButton {
    _selectedButton.selected = !_selectedButton.selected;
    
    _selectedButton.transform = CGAffineTransformMakeScale(0.2, 0.2);
    [UIView animateWithDuration:0.25
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _selectedButton.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         [self.delegate imageGridCell:self didSelected:_selectedButton.selected];
                     }];
}

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)selectedButton {
    if (_selectedButton == nil) {
        _selectedButton = [[UIButton alloc] init];
        
        UIImage *normalImage = [UIImage imageNamed:@"check_box_default"
                                          inBundle:self.imageBundle
                     compatibleWithTraitCollection:nil];
        [_selectedButton setImage:normalImage forState:UIControlStateNormal];
        UIImage *selectedImage = [UIImage imageNamed:@"check_box_right"
                                            inBundle:self.imageBundle
                       compatibleWithTraitCollection:nil];
        [_selectedButton setImage:selectedImage forState:UIControlStateSelected];
        [_selectedButton sizeToFit];
        
        [_selectedButton addTarget:self action:@selector(clickSelectedButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_selectedButton];
    }
    return _selectedButton;
}

- (NSBundle *)imageBundle {
    if (_imageBundle == nil) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:@"FFImagePicker.bundle" withExtension:nil];
        
        _imageBundle = [NSBundle bundleWithURL:url];
    }
    return _imageBundle;
}

@end