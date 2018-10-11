//
//  CandleStickChartViewController.swift
//  ChartsDemo
//
//  Created by emily on 2018/10/11.
//  Copyright © 2018 emily. All rights reserved.
//

import UIKit
import Charts

class CandleStickChartViewController: UIViewController {
    //烛形图
    var chartView: CandleStickChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //创建烛形图组件对象
        chartView = CandleStickChartView()
        chartView.frame = CGRect(x: 20, y: 100, width: self.view.bounds.width - 40,
                                 height: 260)
        self.view.addSubview(chartView)
        
        //第一组烛形图的10条随机数据
        let dataEntries1 = (0..<10).map { (i) -> CandleChartDataEntry in
            let val = Double(arc4random_uniform(40) + 10)
            let high = Double(arc4random_uniform(9) + 8)
            let low = Double(arc4random_uniform(9) + 8)
            let open = Double(arc4random_uniform(6) + 1)
            let close = Double(arc4random_uniform(6) + 1)
            let even = arc4random_uniform(2) % 2 == 0 //true表示开盘价高于收盘价
            return CandleChartDataEntry(x: Double(i),
                                        shadowH: val + high,
                                        shadowL: val - low,
                                        open: even ? val + open : val - open,
                                        close: even ? val - close : val + close)
        }
        let chartDataSet1 = CandleChartDataSet(values: dataEntries1, label: "图例1")
        // 同默认的刚好相反。
        chartDataSet1.decreasingFilled = false //开盘高于收盘则使用空心矩形
        chartDataSet1.increasingFilled = true //开盘低于收盘则使用实心矩形
        
//        chartDataSet1.shadowWidth = 4 // 修改线条宽度
        chartDataSet1.increasingColor = .red
        chartDataSet1.decreasingColor = .green
//        chartDataSet1.shadowColor = .darkGray //竖线统一设置为灰色
        chartDataSet1.shadowColorSameAsCandle = true //让竖线的颜色与方框颜色一样
//        chartDataSet1.showCandleBar = false //不显示方块
        //目前烛形图包括1组数据
        let chartData = CandleChartData(dataSets: [chartDataSet1])
        
        //设置烛形图数据
        chartView.data = chartData
    }
}
