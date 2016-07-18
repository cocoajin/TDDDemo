//
//  ViewController.m
//  DESSS
//
//  Created by jinkeke@techshino.com on 16/6/13.
//  Copyright © 2016年 www.techshino.com. All rights reserved.
//

#import "ViewController.h"
#import "AskTaoBBCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *allDataArray;
    int selectTheIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *listTable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *theBBStr = @"名称sep 宠物成长sep 血量成长sep 法力成长sep 速度成长sep 物攻成长sep 法攻成长sep COT 青蛙sep 135～225sep 50～70sep 50～70sep 25～35sep -10～10sep 20～40sep COT 蛇sep 140～230sep 40～60sep 30～50sep 35～45sep 45～65sep -10～10sep COT 松鼠sep 135～225sep 40～60sep 25～45sep 35～45sep 45～65sep -10～10sep COT 兔子sep 140～230sep 55～75sep 50～70sep 25～35sep -10～10sep 20～40sep COT 山猫sep 150～240sep 45～65sep 40～60sep 35～45sep -10～10sep 40～60sep COT 狐狸sep 150～240sep 40～60sep 40～60sep 40～50sep -10～10sep 40～60sep COT 猴子sep 150～240sep 40～60sep 30～50sep 40～50sep 50～70sep -10～10sep COT 野狗sep 150～240sep 45～65sep 30～50sep 35～45sep 50～70sep -10～10sep COT 桃精sep 160～250sep 40～60sep 60～80sep 40～50sep -10～10sep 30～50sep COT 柳鬼sep 160～250sep 40～60sep 60～80sep 40～50sep -10～10sep 30～50sep COT 白猿sep 170～260sep 65～85sep 30～50sep 25～35sep 60～80sep -10～10sep COT 鹰sep 170～260sep 35～55sep 60～80sep 45～55sep -10～10sep 40～60sep COT 海龟sep 185～275sep 75～95sep 40～60sep 40～50sep -10～10sep 40～60sep COT 蝙蝠sep 175～265sep 40～60sep 65～85sep 40～50sep -10～10sep 40～60sep COT 蟒sep 185～275sep 55～75sep 60～80sep 40～50sep -10～10sep 40～60sep COT 僵尸sep 185～275sep 65～85sep 30～50sep 40～50sep 60～80sep -10～10sep COT 狼sep 190～280sep 55～75sep 30～50sep 50～60sep 65～85sep -10～10sep COT 老虎sep 190～280sep 75～95sep 30～50sep 30～40sep 65～85sep -10～10sep COT 鬼火萤sep 190～280sep 40～60sep 65～85sep 55～65sep -10～10sep 40～60sep COT 乌龙sep 210～300sep 60～80sep 65～85sep 50～60sep -10～10sep 45～65sep COT 花妖sep 200～290sep 55～75sep 60～80sep 50～60sep -10～10sep 45～65sep COT 炎龙sep 210～300sep 60～80sep 65～85sep 50～60sep -10～10sep 45～65sep COT 鱼人sep 200～290sep 55～75sep 65～85sep 45～55sep -10～10sep 45～65sep COT 冰龙sep 210～300sep 60～80sep 65～85sep 50～60sep -10～10sep 45～65sep COT 地裂兽sep 205～295sep 65～85sep 60～80sep 45～55sep -10～10sep 45～65sep COT 巨蜥sep 215～305sep 90～110sep 65～85sep 25～35sep 0～20sep 35～55sep COT 石魔sep 215～305sep 85～105sep 30～50sep 35～45sep 75～95sep -10～10sep COT 青龙sep 210～300sep 60～80sep 65～85sep 50～60sep -10～10sep 45～65sep COT 金头陀sep 205～295sep 60～80sep 30～50sep 45～55sep 80～100sep -10～10sep COT 黄龙sep 210～300sep 60～80sep 65～85sep 50～60sep -10～10sep 45～65sep COT 火鸦sep 210～300sep 50～70sep 65～85sep 55～65sep -10～10sep 50～70sep COT 屈魂sep 220～310sep 65～85sep 65～85sep 50～60sep -10～10sep 50～70sep COT 怨鬼sep 220～310sep 65～85sep 65～85sep 50～60sep -10～10sep 50～70sep COT 粉衣仙子sep 225～315sep 80～100sep 30～50sep 45～55sep 80～100sep -10～10sep COT 电精sep 230～320sep 75～95sep 50～70sep 65～75sep -10～10sep 50～70sep COT 青衣仙子sep 225～315sep 60～80sep 70～90sep 55～65sep -10～10sep 50～70sep COT 雨兽sep 230～320sep 80～100sep 55～75sep 55～65sep -10～10sep 50～70sep COT 黄衣仙子sep 225～315sep 60～80sep 70～90sep 55～65sep -10～10sep 50～70sep COT 风怪sep 230～320sep 75～95sep 50～70sep 60～70sep -10～10sep 55～75sep COT 红衣仙子sep 225～315sep 60～80sep 70～90sep 55～65sep -10～10sep 50～70sep COT 虹妖sep 230～320sep 70～90sep 30～50sep 60～70sep 80～100sep -10～10sep COT 紫衣仙子sep 225～315sep 60～80sep 70～90sep 55～65sep -10～10sep 50～70sep COT 雪女sep 230～320sep 80～100sep 55～75sep 55～65sep -10～10sep 50～70sep COT 蓝衣仙子sep 225～315sep 60～80sep 70～90sep 55～65sep -10～10sep 50～70sep COT 云兽sep 230～320sep 90～110sep 30～50sep 40～50sep 80～100sep -10～10sep COT 白衣仙子sep 225～315sep 70～90sep 30～50sep 55～65sep 80～100sep -10～10sep COT 雷怪sep 230～320sep 75～95sep 45～65sep 60～70sep -10～10sep 60～80";
    
    NSArray *levelOne = [theBBStr componentsSeparatedByString:@"COT"];
    allDataArray = [NSArray arrayWithArray:[levelOne subarrayWithRange:NSMakeRange(1, levelOne.count-1)]];
    
    //Test
//    NSString *titleSTR = [allDataArray objectAtIndex:0];
//    NSArray *titleArr = [titleSTR componentsSeparatedByString:@"sep"];
//    NSLog(@"%@",titleSTR);
//    
//    NSArray *bbAtr1 = [titleSTR componentsSeparatedByString:@"sep"];
//    NSString *bb1AT = [bbAtr1 objectAtIndex:6];
//    NSArray *bbDT1 = [bb1AT componentsSeparatedByString:@"～"];
//    NSString *cmpO1 = bbDT1[1];
//    NSLog(@"%@",cmpO1);

    
    self.listTable.dataSource = self;
    self.listTable.rowHeight = 118.0f;
    selectTheIndex = 1000;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tapSortAction:(id)sender {
    
    UISegmentedControl *segCTL = (UISegmentedControl *)sender;
    selectTheIndex = (int )segCTL.selectedSegmentIndex;
    NSComparator theCompt;
    switch (segCTL.selectedSegmentIndex) {
        case 0:
        {
            theCompt = [self comparatorByBBDetail:6];
        }
            break;
            
        case 1:
        {
            theCompt = [self comparatorByBBDetail:5];
        }
            break;
            
        case 2:
        {
            theCompt = [self comparatorByBBDetail:4];
        }
            break;
            
        case 3:
        {
            theCompt = [self comparatorByBBDetail:2];
        }
            break;
            
        case 4:
        {
            theCompt = [self comparatorByBBDetail:3];
        }
            break;
            
        case 5:
        {
            theCompt = [self comparatorByBBDetail:1];
        }
            break;
            
        default:
            break;
    }
    
    NSArray *sortedArrys = [allDataArray sortedArrayUsingComparator:theCompt];
    allDataArray = [NSArray arrayWithArray:sortedArrys];
    [self.listTable reloadData];
    
}

- (NSComparator )comparatorByBBDetail:(int )dtIndex
{
    NSComparator theCompt = ^(NSString *obj1, NSString *obj2){
        NSArray *bbAtr1 = [obj1 componentsSeparatedByString:@"sep"];
        NSArray *bbAtr2 = [obj2 componentsSeparatedByString:@"sep"];
        NSString *bb1AT = [bbAtr1 objectAtIndex:dtIndex];
        NSString *bb2AT = [bbAtr2 objectAtIndex:dtIndex];
        NSArray *bbDT1 = [bb1AT componentsSeparatedByString:@"～"];
        NSArray *bbDT2 = [bb2AT componentsSeparatedByString:@"～"];
        NSString *cmpO1 = bbDT1[1];
        NSString *cmpO2 = bbDT2[1];
        if ([cmpO1 integerValue] < [cmpO2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([cmpO1 integerValue] > [cmpO2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    return theCompt;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *theTitle = [allDataArray objectAtIndex:section];
    NSArray *bbArry = [theTitle componentsSeparatedByString:@"sep"];
    return [bbArry objectAtIndex:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return allDataArray.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *identifier= @"AKBBCell";
    AskTaoBBCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AskTaoBBCell"  owner:self options:nil] lastObject];
    }
    
    NSString *theBBStr = [allDataArray objectAtIndex:indexPath.section];
    NSArray *bbArry = [theBBStr componentsSeparatedByString:@"sep"];
    cell.apAtack.text = bbArry[6];
    cell.adAtack.text = bbArry[5];
    cell.speedUP.text = bbArry[4];
    cell.hpUP.text = bbArry[2];
    cell.lpUP.text = bbArry[3];
    cell.sumUP.text = bbArry[1];
    
    [self setSelectColor:@[cell.apAtack,cell.adAtack,cell.speedUP,cell.hpUP,cell.lpUP,cell.sumUP]];


    return cell;

    
}

- (void)setSelectColor:(NSArray *)cellLBArr
{
    
    for (int i = 0; i < cellLBArr.count; i++) {
        UILabel *theLB = [cellLBArr objectAtIndex:i];
        theLB.textColor = [UIColor blackColor];
        if (i==selectTheIndex) {
            theLB.textColor = [UIColor orangeColor];
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
