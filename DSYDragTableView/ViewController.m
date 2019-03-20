//
//  ViewController.m
//  DSYDragTableView
//
//  Created by 邓石阳 on 2019/3/20.
//  Copyright © 2019 邓石阳. All rights reserved.
//

#import "ViewController.h"
#import "PayOrders.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_payOrderAry; //商品数组
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //添加tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(-30, 64, self.view.frame.size.width+30, self.view.frame.size.height-64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //取数据
    NSArray *ary = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PayOrder" ofType:@"plist"]];
    
    //把数据存到模型对象中，然后把对象存到数组中
    _payOrderAry = [NSMutableArray array];
    for (int i=0; i<ary.count; i++) {
        PayOrders *payOrder = [PayOrders ordersWithDic:ary[i]];
        [_payOrderAry addObject:payOrder];
    }
    [_tableView setEditing:YES animated:YES];
}

#pragma mark 数据源  返回有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _payOrderAry.count;
}

#pragma mark 每行显示内容
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idPayOrder = @"order";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idPayOrder];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idPayOrder];
    }
    PayOrders *orders = _payOrderAry[indexPath.row];
    cell.textLabel.text = orders.name;
    return cell;
}

#pragma mark 选中行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark 选择编辑模式，添加模式很少用,默认是删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

#pragma mark 排序 当移动了某一行时候会调用
//编辑状态下，只要实现这个方法，就能实现拖动排序
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 取出要拖动的模型数据
    PayOrders *orders = _payOrderAry[sourceIndexPath.row];
    //删除之前行的数据
    [_payOrderAry removeObject:orders];
    // 插入数据到新的位置
    [_payOrderAry insertObject:orders atIndex:destinationIndexPath.row];
}

- (IBAction)switchChange:(UISwitch *)sender {
    if([sender isOn]){
        NSLog(@"turn on");
        [_tableView setEditing:YES animated:NO];
        _tableView.hidden = NO;
    }else{
        NSLog(@"turned off");
        _tableView.hidden = YES;
        [_tableView setEditing:NO animated:YES];
    }
}

@end
