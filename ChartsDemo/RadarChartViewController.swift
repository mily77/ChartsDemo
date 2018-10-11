//
//  RadarChartViewController.swift
//  ChartsDemo
//
//  Created by emily on 2018/10/11.
//  Copyright © 2018 emily. All rights reserved.
//

import UIKit
import Charts
class RadarChartViewController: UIViewController {

    //雷达图
    var chartView: RadarChartView!
    
    //雷达图每个维度的标签文字
    let activities = ["力量", "敏捷", "生命", "智力", "魔法", "幸运"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        //创建折线图组件对象
        chartView = RadarChartView()
        chartView.frame = CGRect(x: 20, y: 100, width: self.view.bounds.width - 40,
                                 height: 260)
        self.view.addSubview(chartView)
        
        //维度标签文字
        chartView.xAxis.valueFormatter = self as IAxisValueFormatter
        
        //最小、最大刻度值
        let yAxis = chartView.yAxis
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 100
        yAxis.labelCount = 4
        yAxis.drawLabelsEnabled = false //不显示刻度值
        
//        //生成6条随机数据
//        let dataEntries = (0..<6).map { (i) -> RadarChartDataEntry in
//            return RadarChartDataEntry(value: Double(arc4random_uniform(50) + 50))
//        }
//        let chartDataSet = RadarChartDataSet(values: dataEntries, label: "李大宝")
//        //目前雷达图只包括1组数据
//        let chartData = RadarChartData(dataSets: [chartDataSet])
        
        //随机数据生成方法
        let block: (Int) -> RadarChartDataEntry = { _ in
            return RadarChartDataEntry(value: Double(arc4random_uniform(50) + 50))
        }
        //生成两组数据
        let dataEntries1 = (0..<6).map(block)
        let chartDataSet1 = RadarChartDataSet(values: dataEntries1, label: "李大宝")
        chartDataSet1.setColor(ChartColorTemplates.joyful()[4])
        
        chartDataSet1.setColor(.orange) //线条颜色
        chartDataSet1.lineWidth = 2 //线条粗细
        chartDataSet1.fillColor = .orange //填充颜色
        chartDataSet1.fillAlpha = 0.4  //填充透明度
        chartDataSet1.drawFilledEnabled = true  //启用填充色绘制
        
        chartDataSet1.drawHighlightCircleEnabled = true //十字线的中央再显示个圆圈
        
//        chartView.webLineWidth = 2 //网格主干线粗细
//        chartView.webColor = .red //网格主干线颜色
//        chartView.webAlpha = 1  //网格线透明度
//        chartView.innerWebLineWidth = 1  //网格边线粗细
//        chartView.innerWebColor = .orange  //网格边线颜色
        
        let dataEntries2 = (0..<6).map(block)
        let chartDataSet2 = RadarChartDataSet(values: dataEntries2, label: "王小强")
        chartDataSet2.setColor(ChartColorTemplates.joyful()[1])
        chartDataSet2.drawHighlightCircleEnabled = true //选中后显示圆圈
        chartDataSet2.setDrawHighlightIndicators(false) //选中后不显示十字线
        
        //目前雷达图包括2组数据
        let chartData = RadarChartData(dataSets: [chartDataSet1, chartDataSet2])
//        chartData.setDrawValues(false) //不显示值标签
        chartData.setValueFont(.systemFont(ofSize: 8, weight: .light)) //数值文字字体
        chartData.setValueTextColor(.blue) //数值文字颜色
        
        
        //设置雷达图数据
        chartView.data = chartData
    }
}

extension RadarChartViewController: IAxisValueFormatter {
    //维度标签文字（x轴文字）
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return activities[Int(value) % activities.count]
    }
}
