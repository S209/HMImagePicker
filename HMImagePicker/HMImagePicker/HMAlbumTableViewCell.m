//
//  HMAlbumTableViewCell.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMAlbumTableViewCell.h"
#import "HMAlbum.h"

@implementation HMAlbumTableViewCell

#pragma mark - 构造函数
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.numberOfLines = 0;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.contentView.bounds;
    CGFloat iconMargin = 8.0;
    CGFloat iconWH = rect.size.height - 2 * iconMargin;
    
    self.imageView.frame = CGRectMake(iconMargin, iconMargin, iconWH, iconWH);
    
    CGFloat labelMargin = 12.0;
    CGFloat labelX = iconMargin + iconWH + labelMargin;
    CGFloat labelW = rect.size.width - labelX - labelMargin;
    self.textLabel.frame = CGRectMake(labelX, iconMargin, labelW, iconWH);
}

#pragma mark - 设置数据
- (void)setAlbum:(HMAlbum *)album {
    _album = album;
    
    self.textLabel.attributedText = album.desc;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 设置 resizeMode 可以按照指定大小缩放图像
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    [[PHImageManager defaultManager]
     requestImageForAsset:album.fetchResult.lastObject
     // TODO: 设置加载图像尺寸
     targetSize:CGSizeMake(600, 600)
     contentMode:PHImageContentModeAspectFill
     options:options
     resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
         self.imageView.image = result;
         NSLog(@"%@", result);
     }];
}

@end
