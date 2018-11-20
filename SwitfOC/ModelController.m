//
//  ModelController.m
//  SwitfOC
//
//  Created by ztzn on 2018/10/16.
//  Copyright © 2018年 ztzn. All rights reserved.
//

#import "ModelController.h"
#import "SwitfOC-Bridging-Header.h"
@interface ModelController ()<ChartViewDelegate>
@property (nonatomic ,strong)LineChartView *chartView;
@end

@implementation ModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _chartView = [[LineChartView alloc]init];
    self.chartView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-100);
    _chartView.delegate = self;
    [self.view addSubview:_chartView];
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = YES;
    _chartView.drawGridBackgroundEnabled = NO;
    
    // x-axis limit line
    ChartLimitLine *llXAxis = [[ChartLimitLine alloc] initWithLimit:10.0 label:@"Index 10"];
    llXAxis.lineWidth = 4.0;
    llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
    llXAxis.labelPosition = ChartLimitLabelPositionRightBottom;
    llXAxis.valueFont = [UIFont systemFontOfSize:10.f];
    
    //[_chartView.xAxis addLimitLine:llXAxis];
    
    _chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
    _chartView.xAxis.gridLineDashPhase = 0.f;
    
    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:150.0 label:@"Upper Limit"];
    ll1.lineWidth = 4.0;
    ll1.lineDashLengths = @[@5.f, @5.f];
    ll1.labelPosition = ChartLimitLabelPositionRightTop;
    ll1.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:-30.0 label:@"Lower Limit"];
    ll2.lineWidth = 4.0;
    ll2.lineDashLengths = @[@5.f, @5.f];
    ll2.labelPosition = ChartLimitLabelPositionRightBottom;
    ll2.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    [leftAxis removeAllLimitLines];
    [leftAxis addLimitLine:ll1];
    [leftAxis addLimitLine:ll2];
    leftAxis.axisMaximum = 200.0;
    leftAxis.axisMinimum = -50.0;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
    _chartView.rightAxis.enabled = NO;
    
    //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
    //[_chartView.viewPortHandler setMaximumScaleX: 2.f];
    
//    BalloonMarker *marker = [[BalloonMarker alloc]
//                             initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                             font: [UIFont systemFontOfSize:12.0]
//                             textColor: UIColor.whiteColor
//                             insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
//    marker.chartView = _chartView;
//    marker.minimumSize = CGSizeMake(80.f, 40.f);
//    _chartView.marker = marker;
    
    _chartView.legend.form = ChartLegendFormLine;
    [self setData];
//    [self setDataCount:15 range:20];
}
- (void)setData{
    int count = 15;
    double range = 20;
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range / 2.0;
        double val = (double) (arc4random_uniform(mult)) + 50;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    for (int i = 0; i < count - 1; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 450;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    for (int i = 0; i < count; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 500;
        [yVals3 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    LineChartDataSet *set1 = nil, *set2 = nil, *set3 = nil;
    
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set2 = (LineChartDataSet *)_chartView.data.dataSets[1];
        set3 = (LineChartDataSet *)_chartView.data.dataSets[2];
        set1.values = yVals1;
        set2.values = yVals2;
        set3.values = yVals3;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
        [set1 setCircleColor:UIColor.whiteColor];
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 65/255.0;
        set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set1.drawCircleHoleEnabled = NO;
        
        set2 = [[LineChartDataSet alloc] initWithValues:yVals2 label:@"DataSet 2"];
        set2.axisDependency = AxisDependencyRight;
        [set2 setColor:UIColor.redColor];
        [set2 setCircleColor:UIColor.whiteColor];
        set2.lineWidth = 2.0;
        set2.circleRadius = 3.0;
        set2.fillAlpha = 65/255.0;
        set2.fillColor = UIColor.redColor;
        set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set2.drawCircleHoleEnabled = NO;
        
        set3 = [[LineChartDataSet alloc] initWithValues:yVals3 label:@"DataSet 3"];
        set3.axisDependency = AxisDependencyRight;
        [set3 setColor:UIColor.yellowColor];
        [set3 setCircleColor:UIColor.whiteColor];
        set3.lineWidth = 2.0;
        set3.circleRadius = 3.0;
        set3.fillAlpha = 65/255.0;
        set3.fillColor = [UIColor.yellowColor colorWithAlphaComponent:200/255.f];
        set3.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set3.drawCircleHoleEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        [dataSets addObject:set3];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.whiteColor];
        [data setValueFont:[UIFont systemFontOfSize:9.f]];
        
        _chartView.data = data;
    }
}
- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yVals1 = [NSMutableArray array];
    NSMutableArray *yVals2 = [NSMutableArray array];
    
    for (int i = 0; i < count; i++)
    {
        double val = arc4random_uniform(range) + 50;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    for (int i = 0; i < count; i++)
    {
        double val = arc4random_uniform(range) + 450;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    LineChartDataSet *set1 = nil;
    LineChartDataSet *set2 = nil;
    
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set2 = (LineChartDataSet *)_chartView.data.dataSets[1];
        set1.values = yVals1;
        set2.values = yVals2;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[UIColor colorWithRed:255/255.0 green:241/255.0 blue:46/255.0 alpha:1.0]];
        set1.drawCirclesEnabled = NO;
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 1.0;
        set1.drawFilledEnabled = YES;
        set1.fillColor = UIColor.whiteColor;
        set1.highlightColor = [UIColor colorWithRed:244/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
        set1.drawCircleHoleEnabled = NO;
        set1.fillFormatter = [ChartDefaultFillFormatter withBlock:^CGFloat(id<ILineChartDataSet>  _Nonnull dataSet, id<LineChartDataProvider>  _Nonnull dataProvider) {
            return self.chartView.leftAxis.axisMinimum;
        }];
        
        set2 = [[LineChartDataSet alloc] initWithValues:yVals2 label:@"DataSet 2"];
        set2.axisDependency = AxisDependencyLeft;
        [set2 setColor:[UIColor colorWithRed:255/255.0 green:241/255.0 blue:46/255.0 alpha:1.0]];
        set2.drawCirclesEnabled = NO;
        set2.lineWidth = 2.0;
        set2.circleRadius = 3.0;
        set2.fillAlpha = 1.0;
        set2.drawFilledEnabled = YES;
        set2.fillColor = UIColor.whiteColor;
        set2.highlightColor = [UIColor colorWithRed:244/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
        set2.drawCircleHoleEnabled = NO;
        set2.fillFormatter = [ChartDefaultFillFormatter withBlock:^CGFloat(id<ILineChartDataSet>  _Nonnull dataSet, id<LineChartDataProvider>  _Nonnull dataProvider) {
            return self.chartView.leftAxis.axisMaximum;
        }];
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setDrawValues:NO];
        
        _chartView.data = data;
    }
}
- (void)set2DataCount:(int)count range:(double)range
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval hourSeconds = 3600.0;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    NSTimeInterval from = now - (count / 2.0) * hourSeconds;
    NSTimeInterval to = now + (count / 2.0) * hourSeconds;
    
    for (NSTimeInterval x = from; x < to; x += hourSeconds)
    {
        double y = arc4random_uniform(range) + 50;
        [values addObject:[[ChartDataEntry alloc] initWithX:x y:y]];
    }
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.values = values;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        set1.valueTextColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
        set1.lineWidth = 1.5;
        set1.drawCirclesEnabled = NO;
        set1.drawValuesEnabled = NO;
        set1.fillAlpha = 0.26;
        set1.fillColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
        set1.highlightColor = [UIColor colorWithRed:224/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
        set1.drawCircleHoleEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.whiteColor];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.0]];
        
        _chartView.data = data;
    }
}
@end
