//
//  NYHBaseTableCell.h
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/21.
//  Copyright © 2019 NYH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYHBaseModel;

NS_ASSUME_NONNULL_BEGIN

@interface NYHBaseTableCell : UITableViewCell

@property (nonatomic, strong) NYHBaseModel *baseModel;

@end

NS_ASSUME_NONNULL_END
