//
//  LineChartViewController.swift
//  ChartsDemo
//
//  Created by emily on 2018/10/9.
//  Copyright © 2018 emily. All rights reserved.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {
    
    // 折线图
    var chartView: LineChartView!
    var chartView2: LineChartView!
    //所有点的颜色
    var circleColors: [UIColor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupUI2()
        setupButton()
    }
}

extension LineChartViewController {
    func setupUI() {
        view.backgroundColor = UIColor.white
        chartView = LineChartView()
        chartView.frame = CGRect.init(x: 20, y: 120, width: self.view.bounds.width - 40, height: 300)
        self.view.addSubview(chartView)
        
        chartView.delegate = self //设置代理
        
        // 折线图背景颜色
//        chartView.backgroundColor = UIColor.yellow
        
        // 折线图无数据时显示的提示文字
        chartView.noDataText = "暂无数据"
        // 折线图描述文字和样式
        chartView.chartDescription?.text = "考试成绩"
        chartView.chartDescription?.textColor = UIColor.red
        
        // 设置交互样式
        chartView.scaleYEnabled = false // 取消Y轴缩放
        chartView.doubleTapToZoomEnabled = true // 双击缩放
        chartView.dragEnabled = true // 启动拖动手势
        chartView.dragDecelerationEnabled = true // 拖动是否有惯性效果
        chartView.dragDecelerationFrictionCoef = 0.9 //拖拽后惯性效果摩擦系数(0~1)越小惯性越不明显
        
        chartView.drawGridBackgroundEnabled = true  //绘制图形区域背景
        chartView.drawBordersEnabled = true  //绘制图形区域边框
//        chartView.gridBackgroundColor = .yellow //背景改成黄色
//        chartView.borderColor = .blue  //边框为蓝色
//        chartView.borderLineWidth = 3  //边框线条大小为3
        chartView.legend.textColor = UIColor.purple // 图例文字颜色
        
        //生成第一条折线数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<100 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这50条数据作为1根折线里的所有数据
        let chartDataSet1 = LineChartDataSet(values: dataEntries, label: "图例1")
        //将线条颜色设置为橙色
        chartDataSet1.colors = [.orange]
        //修改线条大小
        chartDataSet1.lineWidth = 2
        //将线条颜色设置为3种颜色交替显示
//        chartDataSet1.colors = [.orange, .red, .yellow]
        chartDataSet1.circleColors = [.yellow]  //外圆颜色
        chartDataSet1.circleHoleColor = .red  //内圆颜色
        chartDataSet1.circleRadius = 6 //外圆半径
        chartDataSet1.circleHoleRadius = 2 //内圆半径
//        chartDataSet1.drawCirclesEnabled = false //不绘制转折点
        chartDataSet1.drawCircleHoleEnabled = false  //不绘制转折点内圆
        chartDataSet1.lineDashLengths = [4,2] //设置虚线各段长度
        chartDataSet1.mode = .horizontalBezier  //贝塞尔曲线
        chartDataSet1.drawValuesEnabled = false //不绘制拐点上的文字
        
        //生成第二条折线数据
        var dataEntries2 = [ChartDataEntry]()
        for i in 0..<100 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries2.append(entry)
            //每个点默认颜色都是蓝色
            circleColors.append(.cyan)
        }
        let chartDataSet2 = LineChartDataSet(values: dataEntries2, label: "王大锤")
        chartDataSet2.valueColors = [.blue] //拐点上的文字颜色
        chartDataSet2.valueFont = .systemFont(ofSize: 9) //拐点上的文字大小
        // 显示百分号
        let formatter = NumberFormatter()  //自定义格式
        formatter.positiveSuffix = "%"  //数字后缀单位
        chartDataSet2.valueFormatter = DefaultValueFormatter(formatter: formatter)
        chartDataSet2.drawFilledEnabled = true //开启填充色绘制
//        chartDataSet2.fillColor = .blue  //设置填充色
//        chartDataSet2.fillAlpha = 0.5 //设置填充色透明度
        //渐变颜色数组
        let gradientColors = [UIColor.orange.cgColor, UIColor.white.cgColor] as CFArray
        //每组颜色所在位置（范围0~1)
        let colorLocations:[CGFloat] = [1.0, 0.0]
        //生成渐变色
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: gradientColors, locations: colorLocations)
        //将渐变色作为填充对象s
        chartDataSet2.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        
        //两组颜色结合使用（共9色）
//        chartDataSet2.colors = ChartColorTemplates.pastel() + ChartColorTemplates.material()
//        let color = ChartColorTemplates.colorFromString("rgb(245,252,120)")
//        chartDataSet2.colors = [color]
        //使用绿色作为折线线条颜色
        chartDataSet2.colors = [ChartColorTemplates.colorful()[3]]
        
        //目前折线图包括2根折线
        let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2])
 
        // 设置折点颜色
        chartDataSet2.circleColors = circleColors
        //设置折现图数据
        chartView.data = chartData
        
        //图表最多显示10个点
        chartView.setVisibleXRangeMaximum(10)
        //默认显示最一个数据
        chartView.moveViewToX(99)
        
        chartView.xAxis.labelPosition = .bottom //x轴显示在下方
//        chartView.xAxis.labelPosition = .bottomInside //x轴显示在下方，且文字在内侧
        chartView.xAxis.axisLineWidth = 2 //x轴宽度
        chartView.xAxis.axisLineColor = .orange //x轴颜色
//        chartView.xAxis.axisMinimum = -15 //最小刻度值
//        chartView.xAxis.axisMaximum = 15 //最大刻度值
//        chartView.xAxis.granularity = 15 //最小间隔
        chartView.xAxis.labelTextColor = .orange //刻度文字颜色
        chartView.xAxis.labelFont = .systemFont(ofSize: 14) //刻度文字大小
        chartView.xAxis.labelRotationAngle = -30 //刻度文字倾斜角度
//        chartView.xAxis.gridColor = .orange //x轴对应网格线的颜色
//        chartView.xAxis.gridLineWidth = 2 //x轴对应网格线的大小
//        chartView.xAxis.gridLineDashLengths = [4,2]  //虚线各段长度
//        chartView.xAxis.drawGridLinesEnabled = false //不绘制网格线
        
        chartView.rightAxis.drawLabelsEnabled = false //不绘制右侧Y轴文字
//        chartView.rightAxis.enabled = false //禁用右侧的Y轴
        //chartView.rightAxis.drawLabelsEnabled = false //不绘制右侧Y轴文字
        //chartView.rightAxis.drawAxisLineEnabled = false //不显示右侧Y轴
//        chartView.leftAxis.inverted = true //刻度值反向排列
//        chartView.leftAxis.labelPosition = .insideChart  //文字显示在内侧
        chartView.leftAxis.axisLineWidth = 2 //左x轴宽度
        chartView.leftAxis.axisLineColor = .orange //左x轴颜色
//        chartView.leftAxis.axisMinimum = -100 //最小刻度值
//        chartView.leftAxis.axisMaximum = 100 //最大刻度值
//        chartView.leftAxis.granularity = 50 //最小间隔
        chartView.leftAxis.drawZeroLineEnabled = true //绘制0刻度线
//        chartView.leftAxis.zeroLineColor = .orange  //0刻度线颜色
//        chartView.leftAxis.zeroLineWidth = 2 //0刻度线线宽
        chartView.leftAxis.zeroLineDashLengths = [4, 2] //0刻度线使用虚线样式
//        chartView.leftAxis.labelTextColor = .orange //刻度文字颜色
//        chartView.leftAxis.labelFont = .systemFont(ofSize: 14) //刻度文字大小
//        chartView.leftAxis.gridColor = .orange //左Y轴对应网格线的颜色
//        chartView.leftAxis.gridLineWidth = 2 //右Y轴对应网格线的大小
//        chartView.xAxis.gridLineDashLengths = [4,2]  //虚线各段长度
//        chartView.leftAxis.drawGridLinesEnabled = false //不绘制网格线
//        let formatter3 = NumberFormatter()  //自定义格式
//        formatter3.positiveSuffix = "%"  //数字后缀
//        chartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter3)
        //界限1
        let limitLine1 = ChartLimitLine(limit: 85, label: "优秀")
        chartView.leftAxis.addLimitLine(limitLine1)
        
        //界限2
        let limitLine2 = ChartLimitLine(limit: 60, label: "合格")
        chartView.leftAxis.addLimitLine(limitLine2)
        //将限制线绘制在折线后面(默认情况下限制线是在图表的最上层)
        chartView.leftAxis.drawLimitLinesBehindDataEnabled = true
        
        // 修改限制线文字样式
        limitLine1.valueTextColor = UIColor.blue  //文字颜色
        limitLine1.valueFont = UIFont.systemFont(ofSize: 13)  //文字大小
        limitLine1.labelPosition = .leftTop //修改限制线文字位置(默认右上)
        limitLine2.drawLabelEnabled = false //不绘制文字
        limitLine2.lineWidth = 1 //线宽
        limitLine2.lineColor = .blue //线条颜色
        limitLine2.lineDashLengths = [4, 2] //虚线样式
        
//        let formatter2 = NumberFormatter()  //自定义格式
//        formatter2.positivePrefix = "#"  //数字前缀
//        chartView.xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter2)
//        //自定义刻度标签文字
//        let xValues = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月"]
//        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        
        highlightCenterValue()
        
        //播放x轴方向动画，持续时间5秒
        chartView.animate(xAxisDuration: 5)
        //播放y轴方向动画，持续时间1秒
        chartView.animate(yAxisDuration: 3)
    }
    
    //自动选中图表中央的数据点
    func highlightCenterValue() {
        //获取中点坐标
        let x = Double(chartView.bounds.width/2)
        let selectionPoint = CGPoint(x: x, y: 0)
        //获取最接近中点位置的数据点
        let h = chartView.getHighlightByTouchPoint(selectionPoint)
        //将这个数据点高亮（同时自动调用 chartValueSelected 这个代理方法）
        chartView.highlightValue(h, callDelegate: true)
    }
    
    func setupUI2() {
        //创建折线图组件对象
        chartView2 = LineChartView()
        chartView2.frame = CGRect(x: 20, y: 500, width: self.view.bounds.width - 40,
                                 height: 250)
        //半透明蓝色背景
        chartView2.gridBackgroundColor = UIColor(red: 51/255, green: 181/255, blue: 229/255,
                                                alpha: 150/255)
        chartView2.drawGridBackgroundEnabled = true
        
        self.view.addSubview(chartView2)
        
        //生成第一根折线的数据
        var dataEntries1 = [ChartDataEntry]()
        for i in 0..<20 {
            let y = arc4random()%10 + 20
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries1.append(entry)
        }
        let chartDataSet1 = LineChartDataSet(values: dataEntries1, label: "最高温度")
        chartDataSet1.drawCirclesEnabled = false
        chartDataSet1.fillAlpha = 1
        chartDataSet1.drawFilledEnabled = true
        chartDataSet1.fillColor = .white
        chartDataSet1.lineWidth = 2
        chartDataSet1.drawValuesEnabled = false //不绘制拐点上的文字
        chartDataSet1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.chartView.leftAxis.axisMaximum) //向上绘制填充区域
        }
        chartDataSet1.highlightColor = .blue //十字线颜色
        chartDataSet1.highlightLineWidth = 2 //十字线线宽
        chartDataSet1.highlightLineDashLengths = [4, 2] //使用虚线样式的十字线
//        chartDataSet1.drawHorizontalHighlightIndicatorEnabled = false //不显示横向十字线
//        chartDataSet1.highlightEnabled = false  //不启用十字线
        //生成二根折线的数据
        var dataEntries2 = [ChartDataEntry]()
        for i in 0..<20 {
            let y = arc4random()%10
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries2.append(entry)
        }
        let chartDataSet2 = LineChartDataSet(values: dataEntries2, label: "最低温度")
        chartDataSet2.colors = [.green]
        chartDataSet2.drawCirclesEnabled = false
        chartDataSet2.fillAlpha = 1
        chartDataSet2.drawFilledEnabled = true
        chartDataSet2.fillColor = .white
        chartDataSet2.lineWidth = 2
        chartDataSet2.drawValuesEnabled = false //不绘制拐点上的文字
        chartDataSet2.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.chartView.leftAxis.axisMinimum) //向下绘制填充区域
        }
        
        //目前折线图只包括2根折线
        let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2])
        
        
        
        //设置折现图数据
        chartView2.data = chartData
        
        //x轴、y轴方向动画一起播放，持续时间都是1秒
        chartView2.animate(xAxisDuration: 1, yAxisDuration: 1)
        //播放y轴方向动画，持续时间1秒，动画效果是先快后慢
        chartView2.animate(yAxisDuration: 1, easingOption: .easeOutCubic)
    }
    func setupButton()   {
        let button = UIButton(type:.custom)
        button.frame = CGRect(x:10, y:self.view.frame.height-50, width:100, height:30)
        button.setTitle("按钮", for:[])
        button.addTarget(self, action:#selector(buttonAction), for:.touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction() {
        //获取图片
        let image = chartView.getChartImage(transparent: false)
        //将其保存到系统相册中
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
}
// MARK:- 代理
extension LineChartViewController: ChartViewDelegate {
    //折线上的点选中回调
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry,
                            highlight: Highlight) {
        print("选中了一个数据")
        
        //将选中的数据点的颜色改成黄色
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        let values = chartDataSet.values
        let index = values.index(where: {$0.x == highlight.x})  //获取索引
        chartDataSet.circleColors = circleColors //还原
        chartDataSet.circleColors[index!] = .orange
        
        //重新渲染表格
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
        
        //显示该点的MarkerView标签
        self.showMarkerView(value: "\(entry.y)")
        
        //将该点居中（其实就是将该点左边第5个点移动道图表左侧）
        self.chartView.moveViewToAnimated(xValue: entry.x - 5 , yValue: 0,
                                          axis: .left, duration: 1)
    }
    //显示MarkerView标签
    func showMarkerView(value:String){
//        let marker = MarkerView(frame: CGRect(x: 20, y: 20, width: 80, height: 20))
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1), font: UIFont.systemFont(ofSize: 12), textColor: UIColor.white, insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        
        marker.chartView = self.chartView
        
        marker.minimumSize = CGSize(width: 80, height: 40)
        marker.setLabel("数据:\(value)")

//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
//        label.text = "数据：\(value)"
//        label.textColor = UIColor.white
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.backgroundColor = UIColor.gray
//        label.textAlignment = .center
//        marker.addSubview(label)
        self.chartView.marker = marker
    }
    //折线上的点取消选中回调
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("取消选中的数据")
        
        //还原所有点的颜色
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        chartDataSet.circleColors = circleColors
        
        //重新渲染表格
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
        
        
    }
    
    //图表通过手势缩放后的回调
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("图表缩放了")
    }
    
    //图表通过手势拖动后的回调
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        print("图表移动了")
        //自动选中图表中央的数据点
        highlightCenterValue()
    }
}
