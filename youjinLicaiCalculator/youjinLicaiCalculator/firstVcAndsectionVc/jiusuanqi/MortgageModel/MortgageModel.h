//
//  MortgageModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MortgageModel : NSObject
@property (nonatomic ,copy)NSString *max;//最高月供
@property (nonatomic ,copy)NSString *dijian;//每月递减
@property (nonatomic ,copy)NSString *lixi;//支付利息
@property (nonatomic ,copy)NSString *sum;//总还款额
@end
