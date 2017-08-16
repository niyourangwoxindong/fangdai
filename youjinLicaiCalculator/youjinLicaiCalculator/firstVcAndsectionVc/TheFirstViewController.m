//
//  TheFirstViewController.m
//  youjinLicaiCalculator
//
//  Created by 柚今科技01 on 2017/6/21.
//  Copyright © 2017年 柚今科技01. All rights reserved.
//

#import "TheFirstViewController.h"
#import "BusinessView.h"
#import "AccumulationView.h"
#import "CombinationView.h"
#import "TheLatestTableViewController.h"
#import "PickerviewsView.h"
#import "MortgageModel.h"

@interface TheFirstViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (nonatomic ,strong)BusinessView *busiView;//商业贷款的View
@property (nonatomic ,strong)AccumulationView *accView;//公积金贷款的View
@property (nonatomic ,strong)CombinationView *comView;//组合贷款的View
@property (nonatomic ,strong)PickerviewsView *pickerView;
//商业贷款
@property (nonatomic ,strong)NSMutableArray *nianxianArr;//贷款年限的数据
@property (nonatomic ,strong)NSMutableArray *sylilvArr;//商业贷款利率
@property (nonatomic ,copy)NSString *jilustring;//记录是在那个按钮进去的
@property (nonatomic ,copy)NSString *daikuannianxian;//贷款年限
@property (nonatomic ,copy)NSString *daikuanlilv;//贷款利率
@property (nonatomic ,copy)NSString *dengebenxi;//等额本息等额本金
@property (nonatomic ,copy)NSString *dayulilvzhekou;//接受大于五年利率计算的值
@property (nonatomic ,copy)NSString *dengyulilvzhekou;//接受等于五年利率计算的值

//公积金贷款
@property (nonatomic ,strong)NSMutableArray *jijinLilvArr;//利率
@property (nonatomic ,copy)NSString *jijindaikuannianxian;//贷款年限
@property (nonatomic ,copy)NSString *jijindaikuanlilv;//贷款利率
@property (nonatomic ,copy)NSString *jijindengebenxi;//等额本息等额本金
@property (nonatomic ,copy)NSString *jjdayulilvzhekou;//接受大于五年利率计算的值
@property (nonatomic ,copy)NSString *jjdengyulilvzhekou;//接受等于五年利率计算的值

//组合贷款
@property (nonatomic ,copy)NSString *zuhedaikuannianxian;//贷款年限
@property (nonatomic ,copy)NSString *zuhesydaikuanlilv;//商业贷款利率
@property (nonatomic ,copy)NSString *zuhejjdaikuanlilv;//公积金贷款利率
@property (nonatomic ,copy)NSString *zuhedengebenxi;//等额本息等额本金
@property (nonatomic ,copy)NSString *zhsydayulilvzhekou;//接受大于五年利率计算的值
@property (nonatomic ,copy)NSString *zhsydengyulilvzhekou;//接受等于五年利率计算的值
@property (nonatomic ,copy)NSString *zhjjdayulilvzhekou;//接受大于五年利率计算的值
@property (nonatomic ,copy)NSString *zhjjdengyulilvzhekou;//接受等于五年利率计算的值

//记录是5年还是以上
@property (nonatomic ,copy)NSString *sywunian;
@property (nonatomic ,copy)NSString *jjwunian;
@property (nonatomic ,copy)NSString *zhwunian;

@end

@implementation TheFirstViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStairViewDidLoadUINavigationBarTintColor];
    [self createRightBarButtonItemWithTitle:@"利率表" withMethod:@selector(rightButtonClick)];
    
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
//    self.title = @"理财计算";
    self.navigationItem.title = @"房贷计算器";
//    self.tabBarItem.title = @"车贷计算";
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;//控制整个功能是否启用
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _nianxianArr = [[NSMutableArray alloc]initWithObjects:@"5",@"10",@"15",@"20",@"25",@"30", nil];
    _sylilvArr = [[NSMutableArray alloc]initWithObjects:@"基础利率",@"9.5折",@"9折",@"8.8折",@"8.5折",@"8.3折",@"8折",@"7折",@"1.05倍",@"1.1倍",@"1.2倍",@"1.3倍", nil];
    _jijinLilvArr = [[NSMutableArray alloc]initWithObjects:@"基础利率",@"1.1倍", nil];
    //商业贷款
    _daikuannianxian = @"5";
    _daikuanlilv = @"4.75";
    _dengebenxi = @"1";
    
    _dengyulilvzhekou = @"4.75";
    _dayulilvzhekou = @"4.90";
    //公积金贷款
    _jijindaikuannianxian = @"5";
    _jijindaikuanlilv = @"2.75";
    _jijindengebenxi = @"1";
    
    _jjdayulilvzhekou = @"3.25";
    _jjdengyulilvzhekou = @"2.75";
    //组合贷款
    _zuhedaikuannianxian = @"5";
    _zuhesydaikuanlilv = @"4.75";
    _zuhejjdaikuanlilv = @"2.75";
    _zuhedengebenxi = @"1";
    
    _zhsydayulilvzhekou = @"4.90";
    _zhsydengyulilvzhekou = @"4.75";
    _zhjjdayulilvzhekou = @"3.25";
    _zhjjdengyulilvzhekou = @"2.75";
    
    //公积金贷款的View
    _accView = [[AccumulationView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _accView.jijininputTextF.delegate = self;
    [_accView.jjnianxianSegmentCon addTarget:self action:@selector(jjnianxianSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//贷款年限
    //    [_accView.jijinNianbutton addTarget:self action:@selector(jijinNianbuttonClick) forControlEvents:UIControlEventTouchUpInside];//贷款年限
    [_accView.jijinlilvbutton addTarget:self action:@selector(jijinlilvbuttonClick) forControlEvents:UIControlEventTouchUpInside];//贷款利率
    [_accView.jijinperiodSegmentCon addTarget:self action:@selector(jijinperiodSegmentConItem:) forControlEvents:UIControlEventValueChanged];//等额本息等额本金
    [_accView.pointButtonsss addTarget:self action:@selector(pointButtonsssClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_accView];
    
    //组合贷款的View
    _comView = [[CombinationView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _comView.zuhesyinputTextF.delegate = self;
    _comView.zuhejjinputsTextF.delegate = self;
    [_comView.zhnianxianSegmentCon addTarget:self action:@selector(zhnianxianSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//贷款年限
    //    [_comView.zuhearrowButton addTarget:self action:@selector(zuhearrowButtonClick) forControlEvents:UIControlEventTouchUpInside];//贷款年限
    [_comView.zuhesyLilvButton addTarget:self action:@selector(zuhesyLilvButtonClick) forControlEvents:UIControlEventTouchUpInside];//商业利率
    [_comView.zuhejjlilvButton addTarget:self action:@selector(zuhejjlilvButtonClick) forControlEvents:UIControlEventTouchUpInside];//公积金利率
    [_comView.zuheperiodSegmentCon addTarget:self action:@selector(zuheperiodSegmentConItem:) forControlEvents:UIControlEventValueChanged];//等额本息等额本金
    [self.view addSubview:_comView];
    
    //商业贷款的View
    _busiView = [[BusinessView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _busiView.inputTextF.delegate = self;
    [_busiView.nianxianSegmentCon addTarget:self action:@selector(nianxianSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//贷款年限
    //    [_busiView.yearButton addTarget:self action:@selector(yearButtonClick) forControlEvents:UIControlEventTouchUpInside];//贷款年限的点击事件
    [_busiView.syllbutton addTarget:self action:@selector(syllbuttonClick) forControlEvents:UIControlEventTouchUpInside];//贷款利率
    [_busiView.periodSegmentCon addTarget:self action:@selector(periodSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//等额本息等额本金
    [_busiView.pointButton addTarget:self action:@selector(pointButtonsssClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_busiView];
    
    //商业贷款  积金贷款  组合贷款的背景View
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenH, 80*BOScreenH/1334)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    [self.view addSubview:bgView];
    //商业贷款  积金贷款  组合贷款
    UISegmentedControl *segmentCon = [[UISegmentedControl alloc] initWithItems:@[@"商业贷款", @"公积金贷款",@"组合贷款"]];
    segmentCon.frame = CGRectMake(74*BOScreenW/750, 4*BOScreenH/1334, 602*BOScreenW/750, 58*BOScreenH/1334);
    segmentCon.selectedSegmentIndex = 0;
    segmentCon.tintColor = [UIColor whiteColor];
    [segmentCon addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];//添加响应方法
    [bgView addSubview:segmentCon];
    
    //pickerview
    _pickerView = [[PickerviewsView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    [_pickerView.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];//取消按钮的点击事件
    [_pickerView.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];//确定按钮的点击事件
    //    [self.navigationController.view addSubview:_pickerView];
    [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
    _pickerView.hidden = YES;
    //添加手势单击事件
    UITapGestureRecognizer *Gess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GesClicks:)];
    Gess.delegate = self;
    Gess.numberOfTapsRequired = 1;
    [_pickerView addGestureRecognizer:Gess];
}
#pragma mark --- 买车后手头紧？点我看看 de点击事件
- (void)pointButtonsssClick
{
    NSString  *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d",1232500861];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
#pragma mark  取消确定按钮点击事件
- (void)cancelButtonClick
{
    _pickerView.hidden = YES;
}
- (void)sureButtonClick
{
    NSLog(@"choose%@",_pickerView.chooseString);
    //    if ([_jilustring  isEqual: @"111"])
    //    {
    //        if (_pickerView.chooseString == nil)
    //        {
    //        }else
    //        {
    ////            _busiView.arrowLabel.text = [NSString stringWithFormat:@"%@年",_pickerView.chooseString];
    //            if ([_pickerView.chooseString integerValue] > 5)
    //            {
    //                _sywunian = @"dayuwunian";
    //                _busiView.arrowsLabel.text = @"4.90";
    //                _daikuanlilv = _busiView.arrowsLabel.text;
    //            }else
    //            {
    //                _sywunian = @"dengyuwunian";
    //                _busiView.arrowsLabel.text = @"4.75";
    //                _daikuanlilv = _busiView.arrowsLabel.text;
    //            }
    //            _daikuannianxian = _pickerView.chooseString;
    //        }
    //    }
    if ([_jilustring  isEqual: @"222"])
    {
        if (_pickerView.chooseString == nil)
        {
            if ([_sywunian isEqualToString:@"dayuwunian"])
            {
                _busiView.arrowsLabel.text = @"4.90";
                _dayulilvzhekou = _busiView.arrowsLabel.text;
                _dengyulilvzhekou = @"4.75";
            }else
            {
                _busiView.arrowsLabel.text = @"4.75";
                _dengyulilvzhekou = _busiView.arrowsLabel.text;
                _dayulilvzhekou = @"4.90";
            }
        }else
        {
            if ([_pickerView.chooseString isEqualToString:@"基础利率"])
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    _busiView.arrowsLabel.text = @"4.90";
                    _dayulilvzhekou = _busiView.arrowsLabel.text;
                    _dengyulilvzhekou = @"4.75";
                }else
                {
                    _busiView.arrowsLabel.text = @"4.75";
                    _dengyulilvzhekou = _busiView.arrowsLabel.text;
                    _dayulilvzhekou = @"4.90";
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.05倍"])
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.90*1.05];
                    _dayulilvzhekou = _busiView.arrowsLabel.text;
                    _dengyulilvzhekou = [NSString stringWithFormat:@"%.3f",4.90*1.05];
                }else
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.05];
                    _dengyulilvzhekou = _busiView.arrowsLabel.text;
                    _dayulilvzhekou = [NSString stringWithFormat:@"%.3f",4.90*1.05];
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.1倍"])
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.90*1.1];
                    _dayulilvzhekou = _busiView.arrowsLabel.text;
                    _dengyulilvzhekou = [NSString stringWithFormat:@"%.3f",4.75*1.1];
                }else
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.1];
                    _dengyulilvzhekou = _busiView.arrowsLabel.text;
                    _dayulilvzhekou = [NSString stringWithFormat:@"%.3f",4.90*1.1];
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.2倍"])
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.90*1.2];
                    _dayulilvzhekou = _busiView.arrowsLabel.text;
                    _dengyulilvzhekou = [NSString stringWithFormat:@"%.3f",4.75*1.2];
                }else
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.2];
                    _dengyulilvzhekou = _busiView.arrowsLabel.text;
                    _dayulilvzhekou = [NSString stringWithFormat:@"%.3f",4.90*1.2];
                }
            }
            else if ([_pickerView.chooseString isEqualToString:@"1.3倍"])
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.90*1.3];
                    _dayulilvzhekou = _busiView.arrowsLabel.text;
                    _dengyulilvzhekou = [NSString stringWithFormat:@"%.3f",4.75*1.3];
                }else
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.3];
                    _dengyulilvzhekou = _busiView.arrowsLabel.text;
                    _dayulilvzhekou = [NSString stringWithFormat:@"%.3f",4.90*1.3];;
                }
            }else
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    NSArray *newArray = [_pickerView.chooseString componentsSeparatedByString:@"折"];
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",0.49*[newArray[0]floatValue]];
                    _dayulilvzhekou = _busiView.arrowsLabel.text;
                    _dengyulilvzhekou = [NSString stringWithFormat:@"%.3f",0.475*[newArray[0]floatValue]];
                }else
                {
                    NSArray *newArray = [_pickerView.chooseString componentsSeparatedByString:@"折"];
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",0.475*[newArray[0]floatValue]];
                    _dengyulilvzhekou = _busiView.arrowsLabel.text;
                    _dayulilvzhekou = [NSString stringWithFormat:@"%.3f",0.49*[newArray[0]floatValue]];
                }
            }
            
            _daikuanlilv = _busiView.arrowsLabel.text;
        }
    }
    //    if ([_jilustring  isEqual: @"333"])
    //    {
    //        if (_pickerView.chooseString == nil)
    //        {
    //        }else
    //        {
    //            _accView.jijinarrowLabel.text = [NSString stringWithFormat:@"%@年",_pickerView.chooseString];
    //            _jijindaikuannianxian = _pickerView.chooseString;
    //
    //            if ([_pickerView.chooseString integerValue] > 5)
    //            {
    //                _jjwunian = @"jjdayuwunian";
    //                _accView.jijinarrowsLabel.text = @"3.25";
    //                _jijindaikuanlilv = _accView.jijinarrowsLabel.text;
    //            }else
    //            {
    //                _jjwunian = @"jjdengyuwunian";
    //                _accView.jijinarrowsLabel.text = @"2.75";
    //                _jijindaikuanlilv = _accView.jijinarrowsLabel.text;
    //            }
    //        }
    //    }
    if ([_jilustring  isEqual: @"444"])
    {
        if (_pickerView.chooseString == nil)
        {
            if ([_jjwunian isEqualToString:@"jjdayuwunian"])
            {
                _accView.jijinarrowsLabel.text = @"3.25";
                _jjdayulilvzhekou = _accView.jijinarrowsLabel.text;
                _jjdengyulilvzhekou = @"2.75";
            }else
            {
                _accView.jijinarrowsLabel.text = @"2.75";
                _jjdayulilvzhekou = @"3.25";
                _jjdengyulilvzhekou = _accView.jijinarrowsLabel.text;
            }
        }else
        {
            if ([_pickerView.chooseString isEqualToString:@"基础利率"])
            {
                if ([_jjwunian isEqualToString:@"jjdayuwunian"])
                {
                    _accView.jijinarrowsLabel.text = @"3.25";
                    _jjdayulilvzhekou = _accView.jijinarrowsLabel.text;
                    _jjdengyulilvzhekou = @"2.75";
                }else
                {
                    _accView.jijinarrowsLabel.text = @"2.75";
                    _jjdayulilvzhekou = @"3.25";
                    _jjdengyulilvzhekou = _accView.jijinarrowsLabel.text;
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.1倍"])
            {
                if ([_jjwunian isEqualToString:@"jjdayuwunian"])
                {
                    _accView.jijinarrowsLabel.text = [NSString stringWithFormat:@"%.3f",3.25*1.1];
                    _jjdayulilvzhekou = _accView.jijinarrowsLabel.text;
                    _jjdengyulilvzhekou = [NSString stringWithFormat:@"%.3f",2.75*1.1];
                }else
                {
                    _accView.jijinarrowsLabel.text = [NSString stringWithFormat:@"%.3f",2.75*1.1];
                    _jjdayulilvzhekou = [NSString stringWithFormat:@"%.3f",3.25*1.1];
                    _jjdengyulilvzhekou = _accView.jijinarrowsLabel.text;
                }
            }
            _jijindaikuanlilv = _accView.jijinarrowsLabel.text;
        }
    }
    //    if ([_jilustring  isEqual: @"555"])
    //    {
    //        if (_pickerView.chooseString == nil)
    //        {
    //        }else
    //        {
    //            _comView.zuhearrowLabel.text = [NSString stringWithFormat:@"%@年",_pickerView.chooseString];
    //            _zuhedaikuannianxian = _pickerView.chooseString;
    //
    //            if ([_pickerView.chooseString integerValue] > 5)
    //            {
    //                _zhwunian = @"zhdayewunian";
    //                _comView.zuhearrowsLabel.text = @"4.90";
    //                _zuhesydaikuanlilv = _comView.zuhearrowsLabel.text;
    //                _comView.zuhearrowsLabels.text = @"3.25";
    //                _zuhejjdaikuanlilv = _comView.zuhearrowsLabels.text;
    //            }else
    //            {
    //                _zhwunian = @"zhdengyuwunian";
    //                _comView.zuhearrowsLabel.text = @"4.75";
    //                _zuhesydaikuanlilv = _comView.zuhearrowsLabel.text;
    //                _comView.zuhearrowsLabels.text = @"2.75";
    //                _zuhejjdaikuanlilv = _comView.zuhearrowsLabels.text;
    //            }
    //
    //        }
    //    }
    if ([_jilustring  isEqual: @"666"])
    {
        if (_pickerView.chooseString == nil)
        {
            if ([_zhwunian isEqualToString:@"zhdayewunian"])
            {
                _comView.zuhearrowsLabel.text = @"4.90";
                _zhsydayulilvzhekou = _comView.zuhearrowsLabel.text;
                _zhsydengyulilvzhekou = @"4.75";
            }else
            {
                _comView.zuhearrowsLabel.text = @"4.75";
                _zhsydayulilvzhekou = @"4.90";
                _zhsydengyulilvzhekou = _comView.zuhearrowsLabel.text;
            }
        }else
        {
            if ([_pickerView.chooseString isEqualToString:@"基础利率"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabel.text = @"4.90";
                    _zhsydayulilvzhekou = _comView.zuhearrowsLabel.text;
                    _zhsydengyulilvzhekou = @"4.75";
                }else
                {
                    _comView.zuhearrowsLabel.text = @"4.75";
                    _zhsydayulilvzhekou = @"4.90";
                    _zhsydengyulilvzhekou = _comView.zuhearrowsLabel.text;
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.05倍"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.9*1.05];
                    _zhsydayulilvzhekou = _comView.zuhearrowsLabel.text;
                    _zhsydengyulilvzhekou = [NSString stringWithFormat:@"%.3f",4.75*1.05];
                }else
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.05];
                    _zhsydayulilvzhekou = [NSString stringWithFormat:@"%.3f",4.9*1.05];
                    _zhsydengyulilvzhekou = _comView.zuhearrowsLabel.text;
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.1倍"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.9*1.1];
                    _zhsydayulilvzhekou = _comView.zuhearrowsLabel.text;
                    _zhsydengyulilvzhekou = [NSString stringWithFormat:@"%.3f",4.75*1.1];
                }else
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.1];
                    _zhsydayulilvzhekou = [NSString stringWithFormat:@"%.3f",4.9*1.1];
                    _zhsydengyulilvzhekou = _comView.zuhearrowsLabel.text;
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.2倍"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.9*1.2];
                    _zhsydayulilvzhekou = _comView.zuhearrowsLabel.text;
                    _zhsydengyulilvzhekou = [NSString stringWithFormat:@"%.3f",4.75*1.2];
                }else
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.2];
                    _zhsydayulilvzhekou = [NSString stringWithFormat:@"%.3f",4.9*1.2];
                    _zhsydengyulilvzhekou = _comView.zuhearrowsLabel.text;
                }
            }
            else if ([_pickerView.chooseString isEqualToString:@"1.3倍"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.9*1.3];
                    _zhsydayulilvzhekou = _comView.zuhearrowsLabel.text;
                    _zhsydengyulilvzhekou = [NSString stringWithFormat:@"%.3f",4.75*1.3];
                }else
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.3];
                    _zhsydayulilvzhekou = [NSString stringWithFormat:@"%.3f",4.9*1.3];
                    _zhsydengyulilvzhekou = _comView.zuhearrowsLabel.text;
                }
            }else
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    NSArray *newArray = [_pickerView.chooseString componentsSeparatedByString:@"折"];
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",0.49*[newArray[0] floatValue]];
                    _zhsydayulilvzhekou = _comView.zuhearrowsLabel.text;
                    _zhsydengyulilvzhekou = [NSString stringWithFormat:@"%.3f",0.475*[newArray[0] floatValue]];
                }else
                {
                    NSArray *newArray = [_pickerView.chooseString componentsSeparatedByString:@"折"];
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",0.475*[newArray[0] floatValue]];
                    _zhsydayulilvzhekou = [NSString stringWithFormat:@"%.3f",0.49*[newArray[0] floatValue]];
                    _zhsydengyulilvzhekou = _comView.zuhearrowsLabel.text;
                }
                
            }
            _zuhesydaikuanlilv = _comView.zuhearrowsLabel.text;
        }
    }
    if ([_jilustring  isEqual: @"777"])
    {
        if (_pickerView.chooseString == nil)
        {
            if ([_zhwunian isEqualToString:@"zhdayewunian"])
            {
                _comView.zuhearrowsLabels.text = @"3.25";
                _zhjjdayulilvzhekou = _comView.zuhearrowsLabels.text;
                _zhjjdengyulilvzhekou = @"2.75";
            }else
            {
                _comView.zuhearrowsLabels.text = @"2.75";
                _zhjjdayulilvzhekou = @"3.25";
                _zhjjdengyulilvzhekou = _comView.zuhearrowsLabels.text;
            }
        }else
        {
            if ([_pickerView.chooseString isEqualToString:@"基础利率"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabels.text = @"3.25";
                    _zhjjdayulilvzhekou = _comView.zuhearrowsLabels.text;
                    _zhjjdengyulilvzhekou = @"2.75";
                }else
                {
                    _comView.zuhearrowsLabels.text = @"2.75";
                    _zhjjdayulilvzhekou = @"3.25";
                    _zhjjdengyulilvzhekou = _comView.zuhearrowsLabels.text;
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.1倍"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabels.text = [NSString stringWithFormat:@"%.3f",3.25*1.1];
                    _zhjjdayulilvzhekou = _comView.zuhearrowsLabels.text;
                    _zhjjdengyulilvzhekou = [NSString stringWithFormat:@"%.3f",2.75*1.1];
                }else
                {
                    _comView.zuhearrowsLabels.text = [NSString stringWithFormat:@"%.3f",2.75*1.1];
                    _zhjjdayulilvzhekou = [NSString stringWithFormat:@"%.3f",3.25*1.1];
                    _zhjjdengyulilvzhekou = _comView.zuhearrowsLabels.text;
                }
            }
            _zuhejjdaikuanlilv = _comView.zuhearrowsLabels.text;
        }
    }
    
    
    
    _pickerView.chooseString = nil;
    _pickerView.hidden = YES;
    
    //房贷计算器的接口
    [self sytextfieldiskong];
    //公积金贷款的接口
    [self gjjtextfieldiskong];
    //组合贷款的接口
    [self zhtextfieldiskong];
}
#pragma mark --商业贷款的点击事件处理
#pragma mar--贷款年限的点击事件
- (void)nianxianSegmentConSelectItem:(UISegmentedControl *)sender
{
    NSString *myTitle = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];//读取标题
    if ([myTitle isEqualToString:@"5"])
    {
        _sywunian = @"dengyuwunian";
        //        _busiView.arrowsLabel.text = @"4.75";
        _busiView.arrowsLabel.text = _dengyulilvzhekou;
        _daikuanlilv = _busiView.arrowsLabel.text;
    }else
    {
        _sywunian = @"dayuwunian";
        //        _busiView.arrowsLabel.text = @"4.90";
        _busiView.arrowsLabel.text = _dayulilvzhekou;
        _daikuanlilv = _busiView.arrowsLabel.text;
    }
    _daikuannianxian = myTitle;
    //房贷计算器的接口
    [self sytextfieldiskong];
}
//- (void)yearButtonClick
//{
//    [_busiView.inputTextF resignFirstResponder];
//    _pickerView.hidden = NO;
//    _jilustring = @"111";
//    _pickerView.titleLabel.text = @"贷款年限(年)";
//    _pickerView.number = _nianxianArr;
//    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
//    [_pickerView.payPicView reloadAllComponents];
//}
- (void)syllbuttonClick
{
    [_busiView.inputTextF resignFirstResponder];
    _pickerView.hidden = NO;
    _jilustring = @"222";
    _pickerView.titleLabel.text = @"商业贷款利率(%)";
    _pickerView.number = _sylilvArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
#pragma mark---商业贷款  积金贷款  组合贷款的点击事件
- (void)selectItem:(UISegmentedControl *)sender
{
    [self.view endEditing:YES];
    if (sender.selectedSegmentIndex == 0)
    {
        _comView.hidden = YES;
        _accView.hidden = YES;
        _busiView.hidden = NO;
    }
    if (sender.selectedSegmentIndex == 1)
    {
        _accView.hidden = NO;
        _busiView.hidden = YES;
        _comView.hidden = YES;
    }
    if (sender.selectedSegmentIndex == 2)
    {
        _comView.hidden = NO;
        _busiView.hidden = YES;
        _accView.hidden = YES;
    }
}
#pragma mark---利率表的点击事件---
- (void)rightButtonClick
{
    TheLatestTableViewController *lateVc = [[TheLatestTableViewController alloc]init];
    lateVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lateVc animated:YES];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---单击手势的方法---
- (void)GesClicks:(UITapGestureRecognizer *)sender
{
    _pickerView.hidden = YES;
}
#pragma mark---单击手势的代理---
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:_pickerView.buttonView] || [touch.view isDescendantOfView:_pickerView.payPicView])
    {
        return NO;
    }
    return YES;
}
#pragma mark---商业贷款 接口和输入框代理---
//房贷计算器的接口
- (void)fangdaijiekou
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"type"] = @"1";
    parameters[@"money"] = [NSString stringWithFormat:@"%f",[_busiView.inputTextF.text floatValue]*10000];
    parameters[@"money_t"] = @"0";
    parameters[@"years"] = _daikuannianxian;
    parameters[@"apr"] = _daikuanlilv;
    parameters[@"apr_t"] = @"0";
    parameters[@"daikuan_type"] = _dengebenxi;
    [manager POST:[NSString stringWithFormat:@"%@Common/jisuanqiFangdai",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            MortgageModel *model = [MortgageModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            _busiView.moneyLabel.text = model.max;
            UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:603];
            dijianLabel.text = model.dijian;
            UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:604];
            lixiLabel.text = model.lixi;
            UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:605];
            zongeLabel.text = model.sum;
        }
        else
        {
            _busiView.moneyLabel.text = @"0";
            UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:603];
            dijianLabel.text = @"0";
            UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:604];
            lixiLabel.text = @"0";
            UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:605];
            zongeLabel.text = @"0";
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---输入框 键盘开始响应 和 结束响应时的代理-----
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _busiView.inputTextF)
    {
        [UIView animateWithDuration:0.30f animations:^{
            _busiView.frame = CGRectMake(0, 80*BOScreenH/1334 - 80*BOScreenH/1334, BOScreenW, BOScreenH);
            if (iPhone6P)
            {
                _busiView.frame = CGRectMake(0, 80*BOScreenH/1334 - 30*BOScreenH/1334, BOScreenW, BOScreenH);
            }
            if (iPhone5)
            {
                _busiView.frame = CGRectMake(0, 80*BOScreenH/1334 - 180*BOScreenH/1334, BOScreenW, BOScreenH);
            }
        }];
    }
    if (textField == _accView.jijininputTextF)
    {
        [UIView animateWithDuration:0.30f animations:^{
            _accView.frame = CGRectMake(0, 80*BOScreenH/1334 - 80*BOScreenH/1334, BOScreenW, BOScreenH);
            if (iPhone6P)
            {
                _accView.frame = CGRectMake(0, 80*BOScreenH/1334 - 30*BOScreenH/1334, BOScreenW, BOScreenH);
            }
            if (iPhone5)
            {
                _accView.frame = CGRectMake(0, 80*BOScreenH/1334 - 180*BOScreenH/1334, BOScreenW, BOScreenH);
            }
        }];
    }
    if (textField == _comView.zuhesyinputTextF)
    {
        [UIView animateWithDuration:0.30f animations:^{
            _comView.frame = CGRectMake(0, 80*BOScreenH/1334 - 80*BOScreenH/1334, BOScreenW, BOScreenH);
            if (iPhone6P)
            {
                _comView.frame = CGRectMake(0, 80*BOScreenH/1334 - 30*BOScreenH/1334, BOScreenW, BOScreenH);
            }
            if (iPhone5)
            {
                _comView.frame = CGRectMake(0, 80*BOScreenH/1334 - 180*BOScreenH/1334, BOScreenW, BOScreenH);
            }
        }];
        
    }
    if (textField == _comView.zuhejjinputsTextF)
    {
        [UIView animateWithDuration:0.30f animations:^{
            _comView.frame = CGRectMake(0, 80*BOScreenH/1334 - 180*BOScreenH/1334, BOScreenW, BOScreenH);
            if (iPhone6P)
            {
                _comView.frame = CGRectMake(0, 80*BOScreenH/1334 - 130*BOScreenH/1334, BOScreenW, BOScreenH);
            }
            if (iPhone5)
            {
                _comView.frame = CGRectMake(0, 80*BOScreenH/1334 - 280*BOScreenH/1334, BOScreenW, BOScreenH);
            }
        }];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _busiView.inputTextF)
    {
        
        //键盘的下落
        [UIView animateWithDuration:0.30f animations:^{
            _busiView.frame = CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH);
        }];
        
        [self sytextfieldiskong];
        
        //公积金传值操作
        _accView.jijininputTextF.text = _busiView.inputTextF.text;
        [self gjjtextfieldiskong];
        //组合传值操作
        if ([_busiView.inputTextF.text integerValue]/2 == 0)
        {
            if (_busiView.inputTextF.text.length > 0)
            {
                _comView.zuhesyinputTextF.text = [NSString stringWithFormat:@"%ld",(long)[_busiView.inputTextF.text integerValue]/2];
                _comView.zuhejjinputsTextF.text = [NSString stringWithFormat:@"%ld",(long)[_busiView.inputTextF.text integerValue]/2];
            }else
            {
                _comView.zuhesyinputTextF.text = nil;
                _comView.zuhejjinputsTextF.text = nil;
            }
        }else
        {
            _comView.zuhesyinputTextF.text = [NSString stringWithFormat:@"%ld",(long)[_busiView.inputTextF.text integerValue]/2];
            _comView.zuhejjinputsTextF.text = [NSString stringWithFormat:@"%ld",(long)[_busiView.inputTextF.text integerValue]/2];
        }
        [self zhtextfieldiskong];
    }
    
    if (textField == _accView.jijininputTextF)
    {
        [UIView animateWithDuration:0.30f animations:^{
            _accView.frame = CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH);
        }];
        
        [self gjjtextfieldiskong];
        
        //商业传值操作
        _busiView.inputTextF.text = _accView.jijininputTextF.text;
        [self sytextfieldiskong];
        //组合传值操作
        if ([_accView.jijininputTextF.text integerValue]/2 == 0)
        {
            if (_accView.jijininputTextF.text.length > 0)
            {
                _comView.zuhesyinputTextF.text = [NSString stringWithFormat:@"%ld",(long)[_accView.jijininputTextF.text integerValue]/2];
                _comView.zuhejjinputsTextF.text = [NSString stringWithFormat:@"%ld",(long)[_accView.jijininputTextF.text integerValue]/2];
            }else
            {
                _comView.zuhesyinputTextF.text = nil;
                _comView.zuhejjinputsTextF.text = nil;
            }
        }else
        {
            _comView.zuhesyinputTextF.text = [NSString stringWithFormat:@"%ld",(long)[_accView.jijininputTextF.text integerValue]/2];
            _comView.zuhejjinputsTextF.text = [NSString stringWithFormat:@"%ld",(long)[_accView.jijininputTextF.text integerValue]/2];
        }
        [self zhtextfieldiskong];
    }
    
    if (textField == _comView.zuhesyinputTextF || _comView.zuhejjinputsTextF)
    {
        [UIView animateWithDuration:0.30f animations:^{
            _comView.frame = CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH);
        }];
        
        [self zhtextfieldiskong];
    }
}
//等额本息等额本金的点击事件
- (void)periodSegmentConSelectItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _dengebenxi = @"1";
    } else
    {
        _dengebenxi = @"2";
    }
    [self sytextfieldiskong];
}


#pragma mark---公积金贷款---
- (void)jjnianxianSegmentConSelectItem:(UISegmentedControl *)sender
{
    NSString *myTitle = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];//读取标题
    if ([myTitle isEqualToString:@"5"])
    {
        _jjwunian = @"jjdengyuwunian";
        //        _accView.jijinarrowsLabel.text = @"2.75";
        _accView.jijinarrowsLabel.text = _jjdengyulilvzhekou;
        
        _jijindaikuanlilv = _accView.jijinarrowsLabel.text;
    }else
    {
        _jjwunian = @"jjdayuwunian";
        //        _accView.jijinarrowsLabel.text = @"3.25";
        _accView.jijinarrowsLabel.text = _jjdayulilvzhekou;
        _jijindaikuanlilv = _accView.jijinarrowsLabel.text;
    }
    _jijindaikuannianxian = myTitle;
    //公积金贷款的接口
    [self gjjtextfieldiskong];
}
////贷款年限的点击事件
//- (void)jijinNianbuttonClick
//{
//    [_accView.jijininputTextF resignFirstResponder];
//    _pickerView.hidden = NO;
//    _jilustring = @"333";
//    _pickerView.titleLabel.text = @"贷款年限(年)";
//    _pickerView.number = _nianxianArr;
//    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
//    [_pickerView.payPicView reloadAllComponents];
//}
//贷款利率的点击事件
- (void)jijinlilvbuttonClick
{
    [_accView.jijininputTextF resignFirstResponder];
    _pickerView.hidden = NO;
    _jilustring = @"444";
    _pickerView.titleLabel.text = @"公积金贷款利率(%)";
    _pickerView.number = _jijinLilvArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
//公积金贷款的接口
- (void)jijinfangdaijiekou
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"type"] = @"2";
    parameters[@"money"] = [NSString stringWithFormat:@"%f",[_accView.jijininputTextF.text floatValue]*10000];
    parameters[@"money_t"] = @"0";
    parameters[@"years"] = _jijindaikuannianxian;
    parameters[@"apr"] = _jijindaikuanlilv;
    parameters[@"apr_t"] = @"0";
    parameters[@"daikuan_type"] = _jijindengebenxi;
    [manager POST:[NSString stringWithFormat:@"%@Common/jisuanqiFangdai",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            MortgageModel *model = [MortgageModel mj_objectWithKeyValues:responseObject[@"data"]];
            _accView.jijinmoneyLabel.text = model.max;
            UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:703];
            dijianLabel.text = model.dijian;
            UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:704];
            lixiLabel.text = model.lixi;
            UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:705];
            zongeLabel.text = model.sum;
        }
        else
        {
            _accView.jijinmoneyLabel.text = @"0";
            UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:703];
            dijianLabel.text = @"0";
            UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:704];
            lixiLabel.text = @"0";
            UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:705];
            zongeLabel.text = @"0";
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//等额本息等额本金的点击事件
- (void)jijinperiodSegmentConItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _jijindengebenxi = @"1";
    } else
    {
        _jijindengebenxi = @"2";
    }
    [self gjjtextfieldiskong];
}

#pragma mark -- 组合贷款------------------
- (void)zhnianxianSegmentConSelectItem:(UISegmentedControl *)sender
{
    NSString *myTitle = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];//读取标题
    if ([myTitle isEqualToString:@"5"])
    {
        _zhwunian = @"zhdengyuwunian";
        //        _comView.zuhearrowsLabel.text = @"4.75";
        _comView.zuhearrowsLabel.text = _zhsydengyulilvzhekou;
        _zuhesydaikuanlilv = _comView.zuhearrowsLabel.text;
        //        _comView.zuhearrowsLabels.text = @"2.75";
        _comView.zuhearrowsLabels.text = _zhjjdengyulilvzhekou;
        _zuhejjdaikuanlilv = _comView.zuhearrowsLabels.text;
    }else
    {
        _zhwunian = @"zhdayewunian";
        //        _comView.zuhearrowsLabel.text = @"4.90";
        _comView.zuhearrowsLabel.text = _zhsydayulilvzhekou;
        _zuhesydaikuanlilv = _comView.zuhearrowsLabel.text;
        //        _comView.zuhearrowsLabels.text = @"3.25";
        _comView.zuhearrowsLabels.text = _zhjjdayulilvzhekou;
        _zuhejjdaikuanlilv = _comView.zuhearrowsLabels.text;
    }
    _zuhedaikuannianxian = myTitle;
    //组合贷款的接口
    [self zhtextfieldiskong];
}

//贷款年限的点击事件
//- (void)zuhearrowButtonClick
//{
//    [self.view endEditing:YES];
//    _pickerView.hidden = NO;
//    _jilustring = @"555";
//    _pickerView.titleLabel.text = @"贷款年限(年)";
//    _pickerView.number = _nianxianArr;
//    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
//    [_pickerView.payPicView reloadAllComponents];
//}
//商业利率的点击事件
- (void)zuhesyLilvButtonClick
{
    [self.view endEditing:YES];
    _pickerView.hidden = NO;
    _jilustring = @"666";
    _pickerView.titleLabel.text = @"商业贷款利率(%)";
    _pickerView.number = _sylilvArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
//公积金利率的点击事件
- (void)zuhejjlilvButtonClick
{
    [self.view endEditing:YES];
    _pickerView.hidden = NO;
    _jilustring = @"777";
    _pickerView.titleLabel.text = @"公积金贷款利率(%)";
    _pickerView.number = _jijinLilvArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
//组合贷款的接口
- (void)zuhefangdaijiekou
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"type"] = @"3";
    parameters[@"money"] = [NSString stringWithFormat:@"%f",[_comView.zuhesyinputTextF.text floatValue]*10000];
    parameters[@"money_t"] = [NSString stringWithFormat:@"%f",[_comView.zuhejjinputsTextF.text floatValue]*10000];
    parameters[@"years"] = _zuhedaikuannianxian;
    parameters[@"apr"] = _zuhesydaikuanlilv;
    parameters[@"apr_t"] = _zuhejjdaikuanlilv;
    parameters[@"daikuan_type"] = _zuhedengebenxi;
    [manager POST:[NSString stringWithFormat:@"%@Common/jisuanqiFangdai",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            MortgageModel *model = [MortgageModel mj_objectWithKeyValues:responseObject[@"data"]];
            _comView.zuhemoneyLabel.text = model.max;
            UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:803];
            dijianLabel.text = model.dijian;
            UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:804];
            lixiLabel.text = model.lixi;
            UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:805];
            zongeLabel.text = model.sum;
        }
        else
        {
            _comView.zuhemoneyLabel.text = @"0";
            UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:803];
            dijianLabel.text = @"0";
            UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:804];
            lixiLabel.text = @"0";
            UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:805];
            zongeLabel.text = @"0";
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//等额本息等额本金的点击事件
- (void)zuheperiodSegmentConItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _zuhedengebenxi = @"1";
    } else
    {
        _zuhedengebenxi = @"2";
    }
    [self zhtextfieldiskong];
}
#pragma mark  --- 商业贷款判断输入框是否为空-------------
- (void)sytextfieldiskong
{
    if (_busiView.inputTextF.text.length>0)
    {
        if (tokenString)
        {
            [self fangdaijiekou];
        }else
        {
            //得到token
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"app_id"] = @"2";
            parameters[@"secret"] = @"2e1eec48cae70a2c3bd8b1f2f2e177ea";
            [manager POST:[NSString stringWithFormat:@"%@Auth/accessToken",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"at"] forKey:@"access_token"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self fangdaijiekou];
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"token请求失败没有网络%@",error);
             }];
        }
    }else
    {
        NSLog(@"请输入金额");
        _busiView.moneyLabel.text = @"0";
        UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:603];
        dijianLabel.text = @"0";
        UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:604];
        lixiLabel.text = @"0";
        UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:605];
        zongeLabel.text = @"0";
    }
}
#pragma mark  --- 公积金贷款判断输入框是否为空-------------
- (void)gjjtextfieldiskong
{
    if (_accView.jijininputTextF.text.length>0)
    {
        if (tokenString)
        {
            [self jijinfangdaijiekou];
        }else
        {
            //得到token
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"app_id"] = @"2";
            parameters[@"secret"] = @"2e1eec48cae70a2c3bd8b1f2f2e177ea";
            [manager POST:[NSString stringWithFormat:@"%@Auth/accessToken",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"at"] forKey:@"access_token"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self jijinfangdaijiekou];
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"token请求失败没有网络%@",error);
             }];
        }
    }else
    {
        NSLog(@"请输入金额");
        _accView.jijinmoneyLabel.text = @"0";
        UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:703];
        dijianLabel.text = @"0";
        UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:704];
        lixiLabel.text = @"0";
        UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:705];
        zongeLabel.text = @"0";
    }
}
#pragma mark  --- 组合款判断输入框是否为空-------------
- (void)zhtextfieldiskong
{
    //组合贷款
    if (_comView.zuhesyinputTextF.text.length>0&&_comView.zuhejjinputsTextF.text.length>0)
    {
        if (tokenString)
        {
            [self zuhefangdaijiekou];
        }else
        {
            //得到token
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"app_id"] = @"2";
            parameters[@"secret"] = @"2e1eec48cae70a2c3bd8b1f2f2e177ea";
            [manager POST:[NSString stringWithFormat:@"%@Auth/accessToken",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"at"] forKey:@"access_token"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self zuhefangdaijiekou];
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"token请求失败没有网络%@",error);
             }];
        }
    }else
    {
        _comView.zuhemoneyLabel.text = @"0";
        UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:803];
        dijianLabel.text = @"0";
        UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:804];
        lixiLabel.text = @"0";
        UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:805];
        zongeLabel.text = @"0";
    }
}
@end
