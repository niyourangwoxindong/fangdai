//
//  BusinessView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BusinessView.h"

@implementation BusinessView

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
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(225*BOScreenW/750, 106*BOScreenH/1334, 300*BOScreenW/750, 55*BOScreenH/1334)];
        _moneyLabel.text = @"0";
        [_moneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:26]];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"#ff5a00" alpha:1];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:_moneyLabel];
        
        //首付总车款(元)  支付利息(元)  还款总额(元)
        NSArray *interestArr = @[@"每月递减(元)",@"支付利息(元)",@"还款总额(元)",@"0",@"0",@"0"];
        for (int i = 0; i < 6; i ++)
        {
            int k = i%3;
            int j = i/3;
            UILabel *interestLabel = [[UILabel alloc]initWithFrame:CGRectMake(23*BOScreenW/750 + k*(200*BOScreenW/750+52*BOScreenW/750), 190*BOScreenH/1334 + j*(30*BOScreenH/1334+23*BOScreenH/1334), 200*BOScreenW/750, 40*BOScreenH/1334)];
            interestLabel.text = interestArr[i];
            interestLabel.tag = 600+i;
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
        
        NSArray *carArr = @[@"贷款年限",@"还款方式",@"商业贷款金额(万)",@"商业贷款利率(%)"];
        for (int i = 0 ; i < 4; i ++)
        {
            UILabel *carLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 35*BOScreenH/1334 + i*(30*BOScreenH/1334+70*BOScreenH/1334), 260*BOScreenW/750, 30*BOScreenH/1334)];
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
//        //30年
//        _arrowLabel = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 35*BOScreenH/1334 + 0*100*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
//        _arrowLabel.text = @"5年";
//        _arrowLabel.textAlignment = NSTextAlignmentRight;
//        [_arrowLabel setFont:[UIFont systemFontOfSize:14]];
//        _arrowLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
//        [bgView addSubview:_arrowLabel];
//        //贷款年限的按钮
//        _yearButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _yearButton.frame = CGRectMake(0, 0, BOScreenW, 100*BOScreenH/1334);
//        [bgView addSubview:_yearButton];
        
        //年限
        _nianxianSegmentCon = [[UISegmentedControl alloc] initWithItems:@[@"5", @"10",@"15",@"20",@"25",@"30"]];
        _nianxianSegmentCon.frame = CGRectMake(204*BOScreenW/750, 21*BOScreenH/1334, 516*BOScreenW/750, 58*BOScreenH/1334);
        _nianxianSegmentCon.selectedSegmentIndex = 0;
        _nianxianSegmentCon.tintColor = [UIColor colorWithHexString:@"#4697fb" alpha:1];
        [bgView addSubview:_nianxianSegmentCon];
        
        //活期 和 定期
        _periodSegmentCon = [[UISegmentedControl alloc] initWithItems:@[@"等额本息", @"等额本金"]];
        _periodSegmentCon.frame = CGRectMake(460*BOScreenW/750, 121*BOScreenH/1334, 260*BOScreenW/750, 58*BOScreenH/1334);
        if (iPhone5)
        {
            _periodSegmentCon.frame = CGRectMake(440*BOScreenW/750, 121*BOScreenH/1334, 280*BOScreenW/750, 58*BOScreenH/1334);
        }
        _periodSegmentCon.selectedSegmentIndex = 0;
        _periodSegmentCon.tintColor = [UIColor colorWithHexString:@"#4697fb" alpha:1];
        [bgView addSubview:_periodSegmentCon];
        
        //请输入金额
        _inputTextF = [[UITextField alloc]initWithFrame:CGRectMake(400*BOScreenW/750, 235*BOScreenH/1334, 320*BOScreenW/750, 30*BOScreenH/1334)];
        _inputTextF.placeholder = @"请输入金额";
        _inputTextF.textAlignment = NSTextAlignmentRight;
        _inputTextF.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _inputTextF.font = [UIFont systemFontOfSize:14];
        _inputTextF.keyboardType = UIKeyboardTypeNumberPad;
        [bgView addSubview:_inputTextF];
        UIToolbar *kbToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard)];
        kbToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneItem];
        _inputTextF.inputAccessoryView = kbToolbar;
        
        //4.75的箭头
        UIImageView *arrowsImage = [[UIImageView alloc] initWithFrame:CGRectMake(705*BOScreenW/750, 335*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        arrowsImage.image = [UIImage imageNamed:@"common_goto"];
        [bgView addSubview:arrowsImage];
        
        //4.75
        _arrowsLabel = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 335*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
        _arrowsLabel.text = @"4.75";
        _arrowsLabel.textAlignment = NSTextAlignmentRight;
        [_arrowsLabel setFont:[UIFont systemFontOfSize:14]];
        _arrowsLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [bgView addSubview:_arrowsLabel];
        
        //商业贷款利率的按钮
        _syllbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _syllbutton.frame = CGRectMake(0, 300*BOScreenH/1334, BOScreenW, 100*BOScreenH/1334);
        [bgView addSubview:_syllbutton];
        
        //买车后手头紧？点我看看
        _pointButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pointButton.frame = CGRectMake(135*BOScreenW/750, 828*BOScreenH/1334, 480*BOScreenW/750, 80*BOScreenH/1334);
        [_pointButton setTitle:@"买房后手头紧？点我看看" forState:UIControlStateNormal];
        [_pointButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _pointButton.titleLabel.font  = [UIFont systemFontOfSize:15];
        _pointButton.backgroundColor = [UIColor colorWithHexString:@"#ffa238" alpha:1];
        _pointButton.layer.cornerRadius = 20;
        if (iPhone6P)
        {
            _pointButton.layer.cornerRadius = 23;
        }
        if (iPhone5)
        {
            _pointButton.layer.cornerRadius = 17;
        }
        _pointButton.layer.masksToBounds = YES;
        [self addSubview:_pointButton];
    }
    return self;
}
- (void)closeKeyboard
{
    [_inputTextF resignFirstResponder];
}
@end
