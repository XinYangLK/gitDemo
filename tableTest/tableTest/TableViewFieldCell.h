//
//  TableViewFieldCell.h
//  tableTest
//
//  Created by 科pro on 2018/10/19.
//  Copyright © 2018年 palmble. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewFieldCell : UITableViewCell
@property (nonatomic, strong) UITextField *textField;
- (void)setTitleString:(NSString *)string andDataString:(NSString *)dataString andIndexPath:(NSIndexPath *)indexPath;

@end
