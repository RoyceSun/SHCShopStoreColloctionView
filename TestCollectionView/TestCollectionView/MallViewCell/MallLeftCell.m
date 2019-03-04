//
//  MallLeftCell.m
//  TestCollectionView
//
//  Created by 孙海琛 on 2019/1/21.
//  Copyright © 2019年 孙海琛. All rights reserved.
//

#import "MallLeftCell.h"
@interface MallLeftCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation MallLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createUI];
}
- (void)createUI{
    self.backgroundColor=[UIColor grayColor];
}
- (void)setTitStr:(NSString *)titStr
{
    _titStr = titStr;
    _titleLab.text = titStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//        self.backgroundColor = [UIColor yellowColor];
//    }else{
//        self.backgroundColor = [UIColor grayColor];
//    }
}

@end
