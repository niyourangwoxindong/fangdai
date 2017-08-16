//
//  AccumulationView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "AccumulationView.h"

@implementation AccumulationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        
        //月供的背景view
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 320*BOScreenH/1334)];
        topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:topView];
        //每月月供
        UILabel *paymentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(225*BOScreenW/750, 50*BOScreenH/1334, 300*BOScreenW/750, 30*BOScreenH/1334)];
        paymentsLabel.text = @"最高月供(元)";
        paymentsLabel.font = [UIFont systemFontOfSize:14];
        paymentsLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        paymentsLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:paymentsLabel];
        //月供金额
        _jijinmoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(225*BOScreenW/750, 106*BOScreenH/1334, 300*BOScreenW/750, 55*BOScreenH/1334)];
        _jijinmoneyLabel.text = @"0";
        [_jijinmoneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:26]];
        _jijinmoneyLabel.textColor = [UIColor colorWithHexString:@"#ff5a00" alpha:1];
        _jijinmoneyLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:_jijinmoneyLabel];
        
        //首付总车款(元)  支付利息(元)  还款总额(元)
        NSArray *interestArr = @[@"每月递减(元)",@"支付利息(元)",@"还款总额(元)",@"0",@"0",@"0"];
        for (int i = 0; i < 6; i ++)
        {
            int k = i%3;
            int j = i/3;
            UILabel *interestLabel = [[UILabel alloc]initWithFrame:CGRectMake(23*BOScreenW/750 + k*(200*BOScreenW/750+52*BOScreenW/750), 190*BOScreenH/1334 + j*(30*BOScreenH/1334+23*BOScreenH/1334), 200*BOScreenW/750, 40*BOScreenH/1334)];
            interestLabel.tag = 700+i;
            interestLabel.text = interestArr[i];
            interestLabel.font = [UIFont systemFontOfSize:12];
            interestLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            interestLabel.textAlignment = NSTextAlignmentCenter;
            [topView addSubview:interestLabel];
            if (i==3 || i==4 || i==5)
            {
                [interestLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
            }
        }
        
        //在下方输入贷款信息
        UILabel *resultsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 339*BOScreenH/1334, 720*BOScreenW/750, 30*BOScreenH/1334)];
        resultsLabel.text = @"在下方输入贷款信息";
        [resultsLabel setFont:[UIFont systemFontOfSize:13]];
        resultsLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [self addSubview:resultsLabel];
        
        //底部的白色view
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 388*BOScreenH/1334, BOScreenW, 400*BOScreenH/1334)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        NSArray *carArr = @[@"贷款年限",@"还款方式",@"公积金贷款金额(万)",@"公积金贷款利率(%)"];
        for (int i = 0 ; i < 4; i ++)
        {
            UILabel *carLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 35*BOScreenH/1334 + i*(30*BOScreenH/1334+70*BOScreenH/1334), 295*BOScreenW/750, 30*BOScreenH/1334)];
            carLabel.text = carArr[i];
            [carLabel setFont:[UIFont systemFontOfSize:14]];
            carLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            [bgView addSubview:carLabel];
        }
        //细线
        for (int i = 0; i < 3; i ++)
        {
            UIView *lineView= [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 99*BOScreenH/1334 + i*100*BOScreenH/1334, 720*BOScreenW/750, 1*BOScreenH/1334)];
            lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
            [bgView addSubview:lineView];
        }
        
//        //5年的箭头
//        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(705*BOScreenW/750, 35*BOScreenH/1334 + 0*100*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
//        arrowImage.image = [UIImage imageNamed:@"common_goto"];
//        [bgView addSubview:arrowImage];
//        
//        //5年
//        _jijinarrowLabel = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 35*BOScreenH/1334 + 0*100*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
//        _jijinarrowLabel.text = @"5年";
//        _jijinarrowLabel.textAlignment = NSTextAlignmentRight;
//        [_jijinarrowLabel setFont:[UIFont systemFontOfSize:14]];
//        _jijinarrowLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
//        [bgView addSubview:_jijinarrowLabel];
//        
//        //贷款年限的按钮
//        _jijinNianbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _jijinNianbutton.frame = CGRectMake(0, 0, BOScreenW, 100*BOScreenH/1334);
//        [bgView addSubview:_jijinNianbutton];
        //年限
        _jjnianxianSegmentCon = [[UISegmentedControl alloc] initWithItems:@[@"5", @"10",@"15",@"20",@"25",@"30"]];
        _jjnianxianSegmentCon.frame = CGRectMake(204*BOScreenW/750, 21*BOScreenH/1334, 516*BOScreenW/750, 58*BOScreenH/1334);
        _jjnianxianSegmentCon.selectedSegmentIndex = 0;
        _jjnianxianSegmentCon.tintColor = [UIColor colorWithHexString:@"#4697fb" alpha:1];
        [bgView addSubview:_jjnianxianSegmentCon];

        //活期 和 定期
        _jijinperiodSegmentCon = [[UISegmentedControl alloc] initWithItems:@[@"等额本息", @"等额本金"]];
        _jijinperiodSegmentCon.frame = CGRectMake(460*BOScreenW/750, 121*BOScreenH/1334, 260*BOScreenW/750, 58*BOScreenH/1334);
        if (iPhone5)
        {
            _jijinperiodSegmentCon.frame = CGRectMake(440*BOScreenW/750, 121*BOScreenH/1334, 280*BOScreenW/750, 58*BOScreenH/1334);
        }
        _jijinperiodSegmentCon.selectedSegmentIndex = 0;
        _jijinperiodSegmentCon.tintColor = [UIColor colorWithHexString:@"#4697fb" alpha:1];
        [bgView addSubview:_jijinperiodSegmentCon];
        
        //请输入金额
        _jijininputTextF = [[UITextField alloc]initWithFrame:CGRectMake(400*BOScreenW/750, 235*BOScreenH/1334, 320*BOScreenW/750, 30*BOScreenH/1334)];
        _jijininputTextF.placeholder = @"请输入金额";
        _jijininputTextF.keyboardType = UIKeyboardTypeNumberPad;
        _jijininputTextF.textAlignment = NSTextAlignmentRight;
        _jijininputTextF.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _jijininputTextF.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:_jijininputTextF];
        UIToolbar *kbToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard)];
        kbToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneItem];
        _jijininputTextF.inputAccessoryView = kbToolbar;
        
        //4.75的箭头
        UIImageView *arrowsImage = [[UIImageView alloc] initWithFrame:CGRectMake(705*BOScreenW/750, 335*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        arrowsImage.image = [UIImage imageNamed:@"common_goto"];
        [bgView addSubview:arrowsImage];
        
        //2.75
        _jijinarrowsLabel = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 335*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
        _jijinarrowsLabel.text = @"2.75";
        _jijinarrowsLabel.textAlignment = NSTextAlignmentRight;
        [_jijinarrowsLabel setFont:[UIFont systemFontOfSize:14]];
        _jijinarrowsLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [bgView addSubview:_jijinarrowsLabel];
        
        //贷款年限的按钮
        _jijinlilvbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _jijinlilvbutton.frame = CGRectMake(0, 300*BOScreenH/1334, BOScreenW, 100*BOScreenH/1334);
        [bgView addSubview:_jijinlilvbutton];
        //买车后手头紧？点我看看
        _pointButtonsss = [UIButton buttonWithType:UIButtonTypeCustom];
        _pointButtonsss.frame = CGRectMake(135*BOScreenW/750, 828*BOScreenH/1334, 480*BOScreenW/750, 80*BOScreenH/1334);
        [_pointButtonsss setTitle:@"买房后手头紧？点我看看" forState:UIControlStateNormal];
        [_pointButtonsss setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _pointButtonsss.titleLabel.font  = [UIFont systemFontOfSize:15];
        _pointButtonsss.backgroundColor = [UIColor colorWithHexString:@"#ffa238" alpha:1];
        _pointButtonsss.layer.cornerRadius = 20;
        if (iPhone6P)
        {
            _pointButtonsss.layer.cornerRadius = 23;
        }
        if (iPhone5)
        {
            _pointButtonsss.layer.cornerRadius = 17;
        }
        _pointButtonsss.layer.masksToBounds = YES;
        [self addSubview:_pointButtonsss];

    }
    return self;
}
- (void)closeKeyboard
{
    [_jijininputTextF resignFirstResponder];
}
@end
