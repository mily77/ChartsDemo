//
//  CombinedChartViewController.swift
//  ChartsDemo
//
//  Created by emily on 2018/10/11.
//  Copyright © 2018 emily. All rights reserved.
//

import UIKit
import Charts

class CombinedChartViewController: UIViewController {

    var chartView: CombinedChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        //创建组合图组件对象
        chartView = CombinedChartView()
        chartView.frame = CGRect(x: 20, y: 100, width: self.view.bounds.width - 40,
                                 height: 260)
        self.view.addSubview(chartView)
        
        //各类型图表的显示次序（后面的覆盖前面的）
        chartView.drawOrder = [DrawOrder.bar.rawValue,DrawOrder.bubble.rawValue,DrawOrder.line.rawValue,DrawOrder.scatter.rawValue,DrawOrder.candle.rawValue]
        
        //组合图数据
        let chartData = CombinedChartData()
        chartData.barData = generateBarData()
        chartData.lineData = generateLineData()
        chartData.scatterData = generateScatterData()
        chartData.bubbleData = generateBubbleData()
        chartData.candleData = generateCandleData()
        
        //设置组合图数据
        chartView.data = chartData
        
    }
    
    //生成柱状图数据
    func generateBarData() -> BarChartData {
        //生成10条随机数据
        var dataEntries = [BarChartDataEntry]()
        for i in 0..<10 {
            let y = arc4random()%100
            let entry = BarChartDataEntry(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这10条数据作为柱状图的所有数据
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "柱状图")
        chartDataSet.colors = [.orange] //全部使用橙色
        //目前柱状图只包括1组立柱
        let chartData = BarChartData(dataSets: [chartDataSet])
        return chartData
    }
    
    //生成折线图数据
    func generateLineData() -> LineChartData {
        //生成10条随机数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<10 {
            let y = arc4random()%100
            let entry = ChartDataEntry(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这10条数据作为折线图的所有数据
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "折线图")
        chartDataSet.setColor(UIColor(red: 240/255, green: 238/255, blue: 70/255,
                                      alpha: 1))
        chartDataSet.lineWidth = 2.5
        chartDataSet.setCircleColor(UIColor(red: 240/255, green: 238/255, blue: 70/255,
                                            alpha: 1))
        chartDataSet.circleRadius = 5
        chartDataSet.circleHoleRadius = 2.5
        chartDataSet.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255,
                                         alpha: 1)
        //目前柱状图只包括1组折线
        let chartData = LineChartData(dataSets: [chartDataSet])
        return chartData
    }
    
    //生成散点图数据
    func generateScatterData() -> ScatterChartData {
        //生成10条随机数据
        let dataEntries = (0..<10).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(100) + 150)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let chartDataSet = ScatterChartDataSet(values: dataEntries, label: "散点图")
        chartDataSet.colors = [ChartColorTemplates.material()[0]]
        //目前散点图包括1组数据
        let chartData = ScatterChartData(dataSets: [chartDataSet])
        return chartData
    }
    
    //生成气泡图数据
    func generateBubbleData() -> BubbleChartData {
        //生成10条随机数据
        let dataEntries = (0..<10).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(100) + 300)
            let size = CGFloat(arc4random_uniform(10))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size)
        }
        let chartDataSet = BubbleChartDataSet(values: dataEntries, label: "散点图")
        chartDataSet.colors = [ChartColorTemplates.material()[1]]
        //目前气泡图包括1组数据
        let chartData = BubbleChartData(dataSets: [chartDataSet])
        return chartData
    }
    
    //生成烛形图数据
    func generateCandleData() -> CandleChartData {
        //生成10条随机数据
        let dataEntries = (0..<10).map { (i) -> CandleChartDataEntry in
            let val = Double(arc4random_uniform(100) + 10 + 400)
            let high = Double(arc4random_uniform(20) + 8)
            let low = Double(arc4random_uniform(20) + 8)
            let open = Double(arc4random_uniform(20) + 1)
            let close = Double(arc4random_uniform(20) + 1)
            let even = arc4random_uniform(2) % 2 == 0 //true表示开盘价高于收盘价
            return CandleChartDataEntry(x: Double(i),
                                        shadowH: val + high,
                                        shadowL: val - low,
                                        open: even ? val + open : val - open,
                                        close: even ? val - close : val + close)
        }
        let chartDataSet = CandleChartDataSet(values: dataEntries, label: "烛形图")
        chartDataSet.setColor(ChartColorTemplates.material()[2])
        //目前烛形图包括1组数据
        let chartData = CandleChartData(dataSets: [chartDataSet])
        return chartData
    }
}
