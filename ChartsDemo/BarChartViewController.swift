//
//  BarChartViewController.swift
//  ChartsDemo
//
//  Created by emily on 2018/10/10.
//  Copyright © 2018 emily. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    var chartView: BarChartView!
    var chartView2: HorizontalBarChartView!
    
    //每个分组之间的间隔
    let groupSpace = 0.31
    
    //同一分组内柱子间隔
    let barSpace = 0.03
    
    //柱子宽度（ (0.2 + 0.03) * 3 + 0.31 = 1.00 -> interval per "group"）
    let barWidth = 0.2
    
    //每组数据条数
    let groupCount = 5
    
    //x轴标签文字
    let years = ["2001", "2002", "2003", "2004", "2005"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupChartView2()
    }

}

extension BarChartViewController {
    func setupUI() {
        //创建柱状图组件对象
        chartView = BarChartView()
        chartView.frame = CGRect(x: 20, y: 100, width: self.view.bounds.width - 40,
                                 height: 260)
        self.view.addSubview(chartView)
//        test1()
//        test2()
        test3()
    }
    // MARK:- 样式一
    func test1() {
         //生成10条随机数据
         var dataEntries = [BarChartDataEntry]()
         for i in 0..<10 {
         //            let y = Double(arc4random() % 100) - 50
         let y = arc4random()%100 + 50
         var entry:BarChartDataEntry
         //只要值超过80都会带有一个小图标
         //            if y > 80 {
         //                entry = BarChartDataEntry(x: Double(i), y: Double(y),
         //                                          icon: UIImage(named: "icon"))
         //            } else {
         entry = BarChartDataEntry(x: Double(i), y: Double(y))
         //            }
         dataEntries.append(entry)
         }
         
         //根据正负值生成每个立柱使用的颜色
         let red = UIColor(red: 211/255, green: 74/255, blue: 88/255, alpha: 1)
         let green = UIColor(red: 110/255, green: 190/255, blue: 102/255, alpha: 1)
         let colors = dataEntries.map { (entry) -> NSUIColor in
         return entry.y > 0 ? green : red
         }
         
         //这20条数据作为柱状图的所有数据
         let chartDataSet = BarChartDataSet(values: dataEntries, label: "图例1")
         
         //设置颜色
         chartDataSet.colors = colors
         
         //        chartDataSet.colors = [.orange] //全部使用橙色
         //        chartDataSet.colors = [.orange, .brown, .purple] //三种颜色交替使用
         // 立柱的边框颜色、线宽
         chartDataSet.barBorderWidth = 1
         chartDataSet.barBorderColor = .green
         
         
         //第二组数据
         var dataEntries2 = [BarChartDataEntry]()
         for i in 0..<10 {
         let y = arc4random()%50
         let entry = BarChartDataEntry(x: Double(i), y: Double(y))
         dataEntries2.append(entry)
         }
         let chartDataSet2 = BarChartDataSet(values: dataEntries2, label: "图例2")
         chartDataSet2.colors = [.orange]
         
         //目前柱状图
         let chartData = BarChartData(dataSets: [chartDataSet,chartDataSet2])
         
         //设置柱子宽度为刻度区域的一半
         chartData.barWidth = 0.5
         //开启阴背景阴影绘制
         //        chartView.drawBarShadowEnabled = true
         //立柱数值文字显示在内部
         //        chartView.drawValueAboveBarEnabled = false
         //不显示立柱数值文字标签
         //        chartDataSet.drawValuesEnabled = false
         
         //设置柱状图数据
         chartView.data = chartData

    }
    
    // MARK:- 样式二
    func test2() {
        /* 多组数据分组显示
         * 注意：这种显示方式的关键点在于设置好立柱的宽度、间隔，确保每个区块的宽度总和是 1。
         */
         //第一组数据
         var dataEntries1 = [BarChartDataEntry]()
         for i in 0..<groupCount {
         let y = arc4random()%100 + 50
         let entry = BarChartDataEntry(x: Double(i), y: Double(y))
         dataEntries1.append(entry)
         }
         let chartDataSet1 = BarChartDataSet(values: dataEntries1, label: "图例1")
         
         //第二组数据
         var dataEntries2 = [BarChartDataEntry]()
         for i in 0..<groupCount {
         let y = arc4random()%50
         let entry = BarChartDataEntry(x: Double(i), y: Double(y))
         dataEntries2.append(entry)
         }
         let chartDataSet2 = BarChartDataSet(values: dataEntries2, label: "图例2")
         chartDataSet2.colors = [.orange]
         
         //第三组数据
         var dataEntries3 = [BarChartDataEntry]()
         for i in 0..<groupCount {
         let y = arc4random()%50
         let entry = BarChartDataEntry(x: Double(i), y: Double(y))
         dataEntries3.append(entry)
         }
         let chartDataSet3 = BarChartDataSet(values: dataEntries3, label: "图例3")
         chartDataSet3.colors = [.green]
         
         //目前柱状图包括2组立柱
         let chartData = BarChartData(dataSets: [chartDataSet1, chartDataSet2,
         chartDataSet3])
         
         //设置柱子宽度
         chartData.barWidth = barWidth
         
         //对数据进行分组（不重叠显示）
         chartData.groupBars(fromX: Double(0), groupSpace: groupSpace, barSpace: barSpace)
         
         //设置X轴范围
         chartView.xAxis.axisMinimum = Double(0)
         chartView.xAxis.axisMaximum = Double(0) + chartData
         .groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(groupCount)
         chartView.xAxis.centerAxisLabelsEnabled = true  //文字标签居中
         chartView.xAxis.granularity = 1
         chartView.xAxis.labelPosition = .bottom
         chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:self.years)
         
         //设置y轴范围
         chartView.leftAxis.axisMinimum = 0
         chartView.rightAxis.axisMinimum = 0
         
         //设置柱状图数据
         chartView.data = chartData
 
    }
    
    func test3() {
        chartView.drawValueAboveBarEnabled = false
        //生成10条随机数据
        var dataEntries = [BarChartDataEntry]()
        for i in 0..<10 {
            //每个柱子由两部分数据组成
            let value1 = Double(arc4random()%100)
            let value2 = -Double(arc4random()%100)
            let entry = BarChartDataEntry(x: Double(i), yValues: [value1, value2])
            dataEntries.append(entry)
        }
        
        //这10条数据作为柱状图的所有数据
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "每日访问量")
        //堆叠柱形图每部分文字标签
        chartDataSet.stackLabels = ["线上", "线下"]
        //堆叠柱形图每部分使用的颜色
        chartDataSet.colors = [ChartColorTemplates.material()[0],
                               ChartColorTemplates.material()[1]]
        
        //目前柱状图只包括1组立柱
        let chartData = BarChartData(dataSets: [chartDataSet])
        //标签文字颜色为白色
        chartData.setValueTextColor(.white)
        
        //设置柱状图数据
        chartView.data = chartData
    }
    
    func setupChartView2() {
        // 创建柱状图组件对象
        chartView2 = HorizontalBarChartView()
        chartView2.frame = CGRect(x: 20, y: 400, width: self.view.bounds.width - 40, height: 260)
        self.view.addSubview(chartView2)
        
        // 不显示图例
        chartView2.legend.enabled = false
        //x轴显示在左侧
        chartView2.xAxis.labelPosition = .bottom
        //y轴起始刻度为0
//        chartView2.leftAxis.axisMinimum = 0
//        chartView2.rightAxis.axisMinimum = 0
        
        //生成10条随便数据
        var dataEntries = [BarChartDataEntry]()
        for i in 0..<10 {
//            let y = arc4random()%100
            let y = Double(arc4random() % 100) - 50
            let entry = BarChartDataEntry(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        ///根据正负值生成每个立柱使用的颜色
        let red = UIColor(red: 211/255, green: 74/255, blue: 88/255, alpha: 1)
        let green = UIColor(red: 110/255, green: 190/255, blue: 102/255, alpha: 1)
        let colors = dataEntries.map { (entry) -> NSUIColor in
            return entry.y > 0 ? green : red
        }
        
        //这10条数据作为柱状图的所有数据
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "图例1")
        //设置颜色
        chartDataSet.colors = colors
        
        
        
        //目前柱状图只包括1组立柱
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        //设置柱状图数据
        chartView2.data = chartData
        chartView2.fitScreen()
    }
}
