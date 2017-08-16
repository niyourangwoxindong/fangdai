//
//  AccumulationView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccumulationView : UIView
//@property (nonatomic ,strong)UIButton *jijinNianbutton;//贷款年限
@property (nonatomic ,strong)UISegmentedControl *jjnianxianSegmentCon;//贷款年限
@property (nonatomic ,strong)UIButton *jijinlilvbutton;//贷款利率
@property (nonatomic ,strong)UITextField *jijininputTextF;////请输入金额
//@property (nonatomic ,strong)UILabel *jijinarrowLabel;//5年
@property (nonatomic ,strong)UILabel *jijinarrowsLabel;//2.75
@property (nonatomic ,strong)UISegmentedControl *jijinperiodSegmentCon;//等额本息等额本金
@property (nonatomic ,strong)UILabel *jijinmoneyLabel;//月供金额
@property (nonatomic ,strong)UIButton *pointButtonsss;//买车后手头紧？点我看看
@end
