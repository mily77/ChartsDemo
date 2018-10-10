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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

}

extension BarChartViewController {
    func setupUI() {
        //创建柱状图组件对象
        chartView = BarChartView()
        chartView.frame = CGRect(x: 20, y: 100, width: self.view.bounds.width - 40,
                                 height: 260)
        self.view.addSubview(chartView)
        
        //生成10条随机数据
        var dataEntries = [BarChartDataEntry]()
        for i in 0..<10 {
            let y = arc4random()%100
            let entry = BarChartDataEntry(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这20条数据作为柱状图的所有数据
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "图例1")
        //目前柱状图只包括1组立柱
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        //设置柱状图数据
        chartView.data = chartData
    }
}
