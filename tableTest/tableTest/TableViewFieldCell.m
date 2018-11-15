//
//  TableViewFieldCell.m
//  tableTest
//
//  Created by 科pro on 2018/10/19.
//  Copyright © 2018年 palmble. All rights reserved.
//

#import "TableViewFieldCell.h"
#import "UITextField+IndexPath.h"

@implementation TableViewFieldCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField =[[UITextField alloc]initWithFrame:CGRectMake(18, 5, 200, 34)];
        [self.contentView addSubview:_textField];
    }
    return self;
}
- (void)setTitleString:(NSString *)string andDataString:(NSString *)dataString andIndexPath:(NSIndexPath *)indexPath{
    // 核心代码
    self.textField.indexPath = indexPath;
    self.textField.text = dataString;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
