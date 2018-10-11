//
//  ViewController.swift
//  ChartsDemo
//
//  Created by emily on 2018/10/9.
//  Copyright © 2018 emily. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView?
    var dataSource:Array<Any>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = ["折线图","柱状图","散点图","气泡图","烛形图","混合图表"]
        
        setupUI()
        
    }


}

extension ViewController {
    func setupUI() {
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        tableView?.tableFooterView = UIView.init()
        view.addSubview(tableView!)
        
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    //返回表格分区数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //返回表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource!.count
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "SwiftCell"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(
                withIdentifier: identify, for: indexPath) as UITableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = dataSource?[indexPath.row] as? String
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let lineChartVC = LineChartViewController()
            self.navigationController?.pushViewController(lineChartVC, animated: true)
        case 1:
            let barChartVC = BarChartViewController()
            self.navigationController?.pushViewController(barChartVC, animated: true)
        case 2:
            let scatterChartVC = ScatterChartViewController()
            self.navigationController?.pushViewController(scatterChartVC, animated: true)
        case 3:
            let bubbleChartVC = BubbleChartViewController()
            self.navigationController?.pushViewController(bubbleChartVC, animated: true)
        case 4:
            let candleStickChartVC = CandleStickChartViewController()
            self.navigationController?.pushViewController(candleStickChartVC, animated: true)
        case 5:
            let combinedChartVC = CombinedChartViewController()
            self.navigationController?.pushViewController(combinedChartVC, animated: true)
        default:
            break
        }
        
        
    }
}

