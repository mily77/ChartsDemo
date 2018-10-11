//
//  ScatterChartViewController.swift
//  ChartsDemo
//
//  Created by emily on 2018/10/11.
//  Copyright © 2018 emily. All rights reserved.
//

import UIKit
import Charts

class ScatterChartViewController: UIViewController {
    // 散点图
    var chartView: ScatterChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupChartView()
    }

}


extension ScatterChartViewController {
    func setupChartView() {
        // 创建散点图组件对象
        chartView = ScatterChartView()
        chartView.frame = CGRect(x: 20, y: 100, width: self.view.bounds.width - 40, height: 260)
        self.view.addSubview(chartView)
        
        // 第一组散点图的10条随机数据
        let dataEntries1 = (0..<10).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(100) + 3)
            return ChartDataEntry(x: Double(i), y: val)
            
        }
        let chartDataSet1 = ScatterChartDataSet(values: dataEntries1, label: "图例1")
        
        // 修改散点大小
//        chartDataSet1.scatterShapeSize = 5
        //散点样式
       chartDataSet1.setScatterShape(ScatterChartDataSet.Shape.circle)
        
        
        // 第二组散点图的10条随机数据
        let dataEntries2 = (0..<10).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(100) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let chartDataSet2 = ScatterChartDataSet(values: dataEntries2, label: "图例2")
        chartDataSet2.setColor(.purple) //第二组数据使用橙色
        // 设置散点中心部分的颜色和大小
        chartDataSet2.scatterShapeHoleColor = .orange
        chartDataSet2.scatterShapeHoleRadius = 2.5
        
        //目前散点图包括2组数据
        let chartData = ScatterChartData(dataSets: [chartDataSet1, chartDataSet2])
        
        
        //设置散点图数据
        chartView.data = chartData
    }
    
}
