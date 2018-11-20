//
//  ViewController.m
//  SwitfOC
//
//  Created by ztzn on 2018/10/9.
//  Copyright © 2018年 ztzn. All rights reserved.
//

#import "ViewController.h"
#import "LineChartsController.h"
#import "PieChartsController.h"
#import "BarChartsController.h"
#import "HorizontalBarChartController.h"
#import "RadarChartController.h"
#import "BubbleChartController.h"
#import "ModelController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *cell_array;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = NO;
    cell_array = [NSArray arrayWithObjects:@"折线",@"饼状图",@"柱状图",@"横向图",@"雷达图",@"散点图",@"Model",  nil];
    [self.view addSubview:tableview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cell_array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"tableview";
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (_cell == nil) {
        _cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    for (UIView *view in _cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    _cell.textLabel.text = cell_array[indexPath.row];
    return _cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            LineChartsController *linevc = [[LineChartsController alloc]init];
            linevc.title = @"折线";
            [self.navigationController pushViewController:linevc animated:YES];
        }
            break;
            case 1:
        {
            PieChartsController *controll = [[PieChartsController alloc]init];
            controll.title = @"饼状图";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
        case 2:
        {
            BarChartsController *controll = [[BarChartsController alloc]init];
            controll.title = @"柱状图";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
            case 3:
        {
            HorizontalBarChartController *controll = [[HorizontalBarChartController alloc]init];
            controll.title = @"横向图";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
            case 4:
        {
            RadarChartController *controll = [[RadarChartController alloc]init];
            controll.title = @"雷达图";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
        case 5:{
            BubbleChartController *controll = [[BubbleChartController alloc]init];
            controll.title = @"散点图";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
        default:
        {
            ModelController *controll = [[ModelController alloc]init];
            controll.title = @"测试";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
    }
}
@end
