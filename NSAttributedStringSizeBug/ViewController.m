//
//  ViewController.m
//  NSAttributedStringSizeBug
//
//  Created by dacaiguoguo on 2020/7/9.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *testLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *testLabelHeightLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat labelWitdh = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft; //对齐
    paraStyle.firstLineHeadIndent = labelWitdh*2/3; //首行缩进
    paraStyle.tailIndent = 0.0f; //行尾缩进
    paraStyle.lineSpacing = 2.0f; //行间距
    UIFont *font = [UIFont systemFontOfSize:15];
    NSDictionary *att = @{NSParagraphStyleAttributeName: paraStyle,
                          NSFontAttributeName: font,
                          NSForegroundColorAttributeName: [UIColor darkTextColor]};
//    NSString *testContent = @"首行缩进 测试首行缩进 测试测测试首行缩进 测试测首行缩进 测试首行缩进 测试测测试首行缩进 测试测";
    NSString *testContent = @"首行缩进 测试首行缩进 测试";
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:testContent attributes:att];
    CGRect rect = [attrText boundingRectWithSize:CGSizeMake(labelWitdh, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGFloat nameHeight = ceilf(CGRectGetHeight(rect));
    self.testLabel.attributedText = attrText;
    self.testLabel.layer.borderWidth = .5;
    NSLog(@"%lf", nameHeight);
    self.testLabelHeightLayout.constant = nameHeight;

//  NSAttributedString 高度计算的陷阱：当原来的文本只有一行的时候，不会因为首行缩进变成两行
}


@end