//
//  AnalysisViewController.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/10.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import Charts

class AnalysisViewController: BaseViewController {
    @IBOutlet weak var chartView: BarChartView!
    var propertyDict = [
        ZJPickerViewPropertyCanceBtnTitleKey : "取消",
        ZJPickerViewPropertySureBtnTitleKey : "确定",
        ZJPickerViewPropertyTipLabelTextKey: "",
        ZJPickerViewPropertyIsShowSelectContentKey: true,
        ZJPickerViewPropertyIsScrollToSelectedRowKey : true,
        ZJPickerViewPropertyIsTouchBackgroundHideKey : true,
        ZJPickerViewPropertyCanceBtnTitleColorKey : UIColor.darkGray,
        ZJPickerViewPropertySureBtnTitleColorKey : UIColor.darkGray,
        ZJPickerViewPropertySelectRowTitleAttrKey : [NSAttributedString.Key.foregroundColor : UIColor.darkGray]
        ] as [String : Any]
    var stringDataList = [Int]()
    var dataController:AnalysisDataController!
    var selectTime = ""
    
    var barWidth:Double = 0.9
        var unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
//        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    var months = [String]()
    var spaceForBar:Double = 20
    var baseColors = [UIColor(hexString: "53bbb4")]
    var sumText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "分析统计"
        initData()
        initUI()
        
        getAnalysisData()
    }



}
extension AnalysisViewController{
    fileprivate func initData(){
        dataController = AnalysisDataController(delegate: self)
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy"
        selectTime = timeFormatter.string(from: date as Date) as String
        let time:Int = Int(selectTime)!
        for i in 2000...time{
            stringDataList.append(i)
        }
         self.propertyDict[ZJPickerViewPropertyTipLabelTextKey] = selectTime
        
    }
    
    fileprivate func initUI(){
        self.edgesForExtendedLayout = .top
        loadRightBarButtonItem()
        initchartView()
        
    }
    
    /**
     * 加载导航栏右侧按钮
     */
    fileprivate func loadRightBarButtonItem(){
        let button =   UIButton(type: .system)
        button.frame = CGRect(x:0, y:0, width:10, height:30)
        
        button.setTitle("年份", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.sizeToFit()
        button.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let rightBarBtn = UIBarButtonItem(customView: button)
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -5;
        self.navigationItem.rightBarButtonItems = [spacer,rightBarBtn]
    }
    
    @objc func rightItemClick(){
   
        ZJPickerView.zj_show(withDataList: stringDataList, propertyDict: propertyDict) { (str) in
            self.selectTime = str ?? ""
            self.propertyDict[ZJPickerViewPropertyTipLabelTextKey] = str
            self.getAnalysisData()
        }
        
    }
    //初始化图表
    func initchartView(){
        //如果显示不全是这个影响的
        chartView.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
        chartView.noDataText = "暂无数据"            //没有数据时的文字提示
        chartView.delegate = self
        chartView.chartDescription?.text = ""
        chartView.drawBarShadowEnabled = false     //阴影
        chartView.chartDescription?.enabled = true
        chartView.drawValueAboveBarEnabled = true
        chartView.drawGridBackgroundEnabled = false
        chartView.scaleXEnabled = true
        chartView.scaleYEnabled = true
        chartView.doubleTapToZoomEnabled = false   //双击放大
        //        chartView.legend.verticalAlignment = .bottom//图例在饼状图中的位置
        //        chartView.legend.horizontalAlignment = .right
//        chartView.legend.enabled = true
        chartView.maxVisibleCount = 13//调大点
        
        chartView.rightAxis.enabled = false
        
        //x轴
        let xAxis:XAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont.systemFont(ofSize: 9)
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = true          //网格
        xAxis.valueFormatter = self
        xAxis.granularity = 1
//                xAxis.axisMinimum = 0
        
        
        let legend = chartView.legend
        
        legend.enabled = true
        
        legend.horizontalAlignment = .left
        
        legend.verticalAlignment = .bottom
        
        legend.orientation = .horizontal
        
        legend.textColor = UIColor(hexString: "53bbb4")
        
        legend.font = UIFont.systemFont(ofSize: 11.0)
        
        
        //坐标在下面
        //左y轴
        let leftAxis:YAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0.0
        leftAxis.forceLabelsEnabled = true;//不强制绘制制定数量的label
        leftAxis.labelPosition = .outsideChart
        leftAxis.valueFormatter = self
        
        
        
        leftAxis.axisLineWidth = 0.5;//Y轴线宽
        
        
    
        
        
        
//        //右y轴
//        let rightAxis:YAxis = chartView.rightAxis
//        rightAxis.enabled = true
//        rightAxis.drawAxisLineEnabled = true
//        rightAxis.labelFont = UIFont.systemFont(ofSize: 10)
//        //        rightAxis.labelPosition = .outsideChart      //label位置
//        //        rightAxis.labelCount = 5
//        rightAxis.axisMinimum = 0.0                  //从0开始
//        //        rightAxis.axisMaximum = 100
//        //        leftAxis.spaceTop = 2
//        rightAxis.granularity = 10
//        rightAxis.valueFormatter = self
        
        chartView.fitBars = true
        chartView.animate(yAxisDuration: 2.5)
    }
    
    func setChart(_ dataPoints: [String], values: [Double]) {
        chartView.xAxis.labelCount = months.count
        
        
        var dataSets = [BarChartDataSet]()
        
        var yDataArray:[BarChartDataEntry] = []
        
       
        
        for i in 0..<dataPoints.count {
//            let barX =  spaceForBar  * Double(i)
                        let barX =  Double(i)

//            let dataEntry = BarChartDataEntry(x: barX, y: values[i], icon: UIImage(named: "icon_secright"))
//            let dataEntry = BarChartDataEntry(x:barX , y: values[i])
            let dataEntry = BarChartDataEntry.init(x: barX, y: values[i])

            yDataArray.append(dataEntry)
        }
        
        
        let set = BarChartDataSet(values: yDataArray, label: sumText)
//        set.drawValuesEnabled = true
//        set.drawIconsEnabled = true
        set.valueFormatter = self
        set.colors = baseColors as! [NSUIColor]
        dataSets.append(set)
        
        let data = BarChartData.init(dataSets: dataSets)
        chartView.data = data
        
        data.barWidth = barWidth
        chartView.animate(yAxisDuration: 2.5)
    }
    
   
}

extension AnalysisViewController:  IAxisValueFormatter, IValueFormatter,ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        var date = ""
        //201809格式
        if Int(entry.x) < 9{
            date = selectTime + "0" + String(Int(entry.x) + 1)
        }else{
            date = selectTime + String(Int(entry.x) + 1)
        }
        
        pushViewController("ComprehensiveQueryListViewController",sender:date)
    }
    //x轴坐标
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if (axis is XAxis) {
            if Int(value) <= months.count-1 {
                
                return String(months[Int(value)]) + "月"
                
            }
        }
        else{
            if value < 1{
                return String(format: "%.1f", value)
            }else{
                return String(format: "%.0f", value)
            }
        }
        return ""
//        if (axis is XAxis) {
//            let index = Int(value / (spaceForBar  ))
//            if index < 0 || index > months.count{
//                return ""
//            }else{
//                return months[index] + "月"
//            }
//        }else{
//            return String(format: "%.0f", value) + "%"
//        }
    }
    
    //柱形图上的值
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return NSString(format: "%.2f", value) as String
    }
}
extension AnalysisViewController{
   
    func getAnalysisData(){
        let parameter:NSMutableDictionary = [
            "loginName":MyConfig.shared().loginName,
            "stime":selectTime,
            
            ]
        dataController.goodsStatistics(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.months.removeAll()
                self.unitsSold.removeAll()
                self.sumText = self.selectTime + "年共发货" + String(self.dataController.model.data.sumNum) + "次"
                for i in 0..<self.dataController.dataArray.count{
                    self.months.append(String(i + 1))
                }
                
                
                self.unitsSold = self.dataController.dataArray
                self.setChart(self.months, values: self.unitsSold)
            }else {
                
            }
        }
    }
    
}
