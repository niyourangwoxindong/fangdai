//
//  CombinationView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CombinationView.h"

@implementation CombinationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
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
        _zuhemoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(225*BOScreenW/750, 106*BOScreenH/1334, 300*BOScreenW/750, 55*BOScreenH/1334)];
        _zuhemoneyLabel.text = @"0";
        [_zuhemoneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:26]];
        _zuhemoneyLabel.textColor = [UIColor colorWithHexString:@"#ff5a00" alpha:1];
        _zuhemoneyLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:_zuhemoneyLabel];
        
        //首付总车款(元)  支付利息(元)  还款总额(元)
        NSArray *interestArr = @[@"每月递减(元)",@"支付利息(元)",@"还款总额(元)",@"0",@"0",@"0"];
        for (int i = 0; i < 6; i ++)
        {
            int k = i%3;
            int j = i/3;
            UILabel *interestLabel = [[UILabel alloc]initWithFrame:CGRectMake(23*BOScreenW/750 + k*(200*BOScreenW/750+52*BOScreenW/750), 190*BOScreenH/1334 + j*(30*BOScreenH/1334+23*BOScreenH/1334), 200*BOScreenW/750, 40*BOScreenH/1334)];
            interestLabel.tag = 800+i;
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
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 388*BOScreenH/1334, BOScreenW, 600*BOScreenH/1334)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        NSArray *carArr = @[@"贷款年限",@"还款方式",@"商业贷款金额(万)",@"公积金贷款金额(万)",@"商业贷款利率(%)",@"公积金贷款利率(%)"];
        for (int i = 0 ; i < 6; i ++)
        {
            UILabel *carLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 35*BOScreenH/1334 + i*(30*BOScreenH/1334+70*BOScreenH/1334), 295*BOScreenW/750, 30*BOScreenH/1334)];
            carLabel.text = carArr[i];
            [carLabel setFont:[UIFont systemFontOfSize:14]];
            carLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            [bgView addSubview:carLabel];
        }
        //细线
        for (int i = 0; i < 5; i ++)
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
//        _zuhearrowLabel = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 35*BOScreenH/1334 + 0*100*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
//        _zuhearrowLabel.text = @"5年";
//        _zuhearrowLabel.textAlignment = NSTextAlignmentRight;
//        [_zuhearrowLabel setFont:[UIFont systemFontOfSize:14]];
//        _zuhearrowLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
//        [bgView addSubview:_zuhearrowLabel];
//        
//        //年限按钮
//        _zuhearrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _zuhearrowButton.frame = CGRectMake(0, 0, BOScreenW, 100*BOScreenH/1334);
//        [bgView addSubview:_zuhearrowButton];
        //年限
        _zhnianxianSegmentCon = [[UISegmentedControl alloc] initWithItems:@[@"5", @"10",@"15",@"20",@"25",@"30"]];
        _zhnianxianSegmentCon.frame = CGRectMake(204*BOScreenW/750, 21*BOScreenH/1334, 516*BOScreenW/750, 58*BOScreenH/1334);
        _zhnianxianSegmentCon.selectedSegmentIndex = 0;
        _zhnianxianSegmentCon.tintColor = [UIColor colorWithHexString:@"#4697fb" alpha:1];
        [bgView addSubview:_zhnianxianSegmentCon];
        
        //活期 和 定期
        _zuheperiodSegmentCon = [[UISegmentedControl alloc] initWithItems:@[@"等额本息", @"等额本金"]];
        _zuheperiodSegmentCon.frame = CGRectMake(460*BOScreenW/750, 121*BOScreenH/1334, 260*BOScreenW/750, 58*BOScreenH/1334);
        if (iPhone5)
        {
            _zuheperiodSegmentCon.frame = CGRectMake(440*BOScreenW/750, 121*BOScreenH/1334, 280*BOScreenW/750, 58*BOScreenH/1334);
        }
        _zuheperiodSegmentCon.selectedSegmentIndex = 0;
        _zuheperiodSegmentCon.tintColor = [UIColor colorWithHexString:@"#4697fb" alpha:1];
        [bgView addSubview:_zuheperiodSegmentCon];

        //请输入金额
        _zuhesyinputTextF = [[UITextField alloc]initWithFrame:CGRectMake(400*BOScreenW/750, 235*BOScreenH/1334, 320*BOScreenW/750, 30*BOScreenH/1334)];
        _zuhesyinputTextF.placeholder = @"请输入金额";
        _zuhesyinputTextF.keyboardType = UIKeyboardTypeNumberPad;
        _zuhesyinputTextF.textAlignment = NSTextAlignmentRight;
        _zuhesyinputTextF.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _zuhesyinputTextF.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:_zuhesyinputTextF];
        UIToolbar *kbToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard)];
        kbToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneItem];
        _zuhesyinputTextF.inputAccessoryView = kbToolbar;

        
        //请输入金额
        _zuhejjinputsTextF = [[UITextField alloc]initWithFrame:CGRectMake(400*BOScreenW/750, 335*BOScreenH/1334, 320*BOScreenW/750, 30*BOScreenH/1334)];
        _zuhejjinputsTextF.placeholder = @"请输入金额";
        _zuhejjinputsTextF.keyboardType = UIKeyboardTypeNumberPad;
        _zuhejjinputsTextF.textAlignment = NSTextAlignmentRight;
        _zuhejjinputsTextF.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _zuhejjinputsTextF.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:_zuhejjinputsTextF];
        UIToolbar *kbToolbars = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *doneItems = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboards)];
        kbToolbars.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneItems];
        _zuhejjinputsTextF.inputAccessoryView = kbToolbars;
        
        //4.75的箭头
        UIImageView *arrowsImage = [[UIImageView alloc] initWithFrame:CGRectMake(705*BOScreenW/750, 435*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        arrowsImage.image = [UIImage imageNamed:@"common_goto"];
        [bgView addSubview:arrowsImage];
        
        //4.75
        _zuhearrowsLabel = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 435*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
        _zuhearrowsLabel.text = @"4.75";
        _zuhearrowsLabel.textAlignment = NSTextAlignmentRight;
        [_zuhearrowsLabel setFont:[UIFont systemFontOfSize:14]];
        _zuhearrowsLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [bgView addSubview:_zuhearrowsLabel];
        
        //利率按钮
        _zuhesyLilvButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _zuhesyLilvButton.frame = CGRectMake(0, 400*BOScreenH/1334, BOScreenW, 100*BOScreenH/1334);
        [bgView addSubview:_zuhesyLilvButton];
        
        //2.75的箭头
        UIImageView *arrowsImages = [[UIImageView alloc] initWithFrame:CGRectMake(705*BOScreenW/750, 535*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        arrowsImages.image = [UIImage imageNamed:@"common_goto"];
        [bgView addSubview:arrowsImages];
        
        //2.75
        _zuhearrowsLabels = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 535*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
        _zuhearrowsLabels.text = @"2.75";
        _zuhearrowsLabels.textAlignment = NSTextAlignmentRight;
        [_zuhearrowsLabels setFont:[UIFont systemFontOfSize:14]];
        _zuhearrowsLabels.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [bgView addSubview:_zuhearrowsLabels];

        //利率按钮
        _zuhejjlilvButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _zuhejjlilvButton.frame = CGRectMake(0, 500*BOScreenH/1334, BOScreenW, 100*BOScreenH/1334);
        [bgView addSubview:_zuhejjlilvButton];
        
        //买车后手头紧？点我看看
        UIButton *pointButton = [UIButton buttonWithType:UIButtonTypeCustom];
        pointButton.frame = CGRectMake(135*BOScreenW/750, 1028*BOScreenH/1334, 480*BOScreenW/750, 0*BOScreenH/1334);
        [pointButton setTitle:@"买房后手头紧？点我看看" forState:UIControlStateNormal];
        [pointButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        pointButton.titleLabel.font  = [UIFont systemFontOfSize:15];
        pointButton.backgroundColor = [UIColor colorWithHexString:@"#ffa238" alpha:1];
        pointButton.layer.cornerRadius = 20;
        if (iPhone6P)
        {
            pointButton.layer.cornerRadius = 23;
        }
        if (iPhone5)
        {
            pointButton.layer.cornerRadius = 17;
        }
        pointButton.layer.masksToBounds = YES;
        [self addSubview:pointButton];
    }
    return self;
}
- (void)closeKeyboard
{
    [_zuhesyinputTextF resignFirstResponder];
}
- (void)closeKeyboards
{
    [_zuhejjinputsTextF resignFirstResponder];
}
@end
