//
//  PieChartViewController.swift
//  ChartsDemo
//
//  Created by emily on 2018/10/11.
//  Copyright © 2018 emily. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {

    var chartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //创建饼图组件对象
        chartView = PieChartView()
        chartView.frame = CGRect(x: 20, y: 100, width: self.view.bounds.width - 40,
                                 height: 260)
        self.view.addSubview(chartView)
        
        // 扇形图 半饼形
//        chartView.maxAngle = 270 //整个扇形占2/3圆
//        chartView.rotationAngle = 135 //旋转角度让扇面左右对称
//        chartView.maxAngle = 180 //整个扇形占1/2圆
//        chartView.rotationAngle = 180 //旋转角度让饼图左右对称
        
        //生成5条随机数据
        let dataEntries = (0..<5).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(arc4random_uniform(50) + 10),
                                     label: "数据\(i)")
        }
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "数据分布")
        chartDataSet.selectionShift = 5 //修改选中扇区的伸出长度 0不会变化
        chartDataSet.sliceSpace = 3 //扇区间隔为3
        
        chartDataSet.xValuePosition = .insideSlice //标签显示在内
        chartDataSet.yValuePosition = .outsideSlice //数值显示在外
//        chartDataSet.xValuePosition = .outsideSlice //标签显示在外
//        chartDataSet.yValuePosition = .insideSlice //数值显示在内
//        chartDataSet.xValuePosition = .outsideSlice //标签显示在外
//        chartDataSet.yValuePosition = .outsideSlice //数值显示在外
        
        // 修改折线样式
        chartDataSet.valueLinePart1OffsetPercentage = 0.8 //折线中第一段起始位置相对于扇区偏移量（值越大距越远）
        chartDataSet.valueLinePart1Length = 0.55 //折线中第一段长度占比
        chartDataSet.valueLinePart2Length = 0.2 //折线中第二段长度最大占比
        chartDataSet.valueLineWidth = 1 //折线的粗细
        chartDataSet.valueLineColor = UIColor.brown //折线颜色
        
        //设置颜色
        chartDataSet.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
        let chartData = PieChartData(dataSet: chartDataSet)
        
        chartData.setValueFont(.systemFont(ofSize: 11, weight: .light)) //字体修改
        chartData.setValueTextColor(.red) //颜色修改
        
        //设置饼状图数据
        chartView.data = chartData
        
        chartView.rotationEnabled = false //禁用旋转功能
        chartView.centerText = "我是饼状图" //设置饼图中央的标题文字
        
//        let formatter = NumberFormatter()  //自定义格式
//        formatter.positivePrefix = "$"  //数字前缀单位
//        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        //将数值转化为百分比
        chartView.usePercentValuesEnabled = true
        
        //数值百分比格式化显示
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = "%"
        chartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
//        chartDataSet.drawValuesEnabled = false //不显示数值
        
        
        chartView.holeRadiusPercent = 0.382  //空心半径黄金比例
        chartView.holeColor = UIColor.purple //空心颜色设置为紫色
        chartView.transparentCircleRadiusPercent = 0.5  //半透明空心半径
        
        // 显示实心饼图 保持半透明
        chartView.holeRadiusPercent = 0  //空心半径为0
        chartView.transparentCircleRadiusPercent = 0.25  //半透明半径比例
        //显示实心饼图 无半透明
        chartView.drawHoleEnabled = false  //这个饼是实心的
        
        
    }

}
