/*
Copyright (c) 2015, Apple Inc. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1.  Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2.  Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3.  Neither the name of the copyright holder(s) nor the names of any contributors
may be used to endorse or promote products derived from this software without
specific prior written permission. No license is granted to the trademarks of
the copyright holders even if such marks are included in this software.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit
import ResearchKit

class DashboardTableViewController: UITableViewController {
    // MARK: Properties
    
    @IBOutlet var pieChart: ORKPieChartView!
    @IBOutlet var discreteGraph: ORKDiscreteGraphChartView!
    @IBOutlet var lineGraph: ORKLineGraphChartView!
    
    
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var allCharts: [UIView] {
        return [pieChart, discreteGraph, lineGraph]
    }
    
    let pieChartDataSource = PieChartDataSource()
    let discreteGraphDataSource = DiscreteGraphDataSource()
    let lineGraphDataSource = LineGraphDataSource()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source for each graph
        pieChart.dataSource = pieChartDataSource
        discreteGraph.dataSource = discreteGraphDataSource
        lineGraph.dataSource = lineGraphDataSource

        
        // Set the table view to automatically calculate the height of cells.
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Animate any visible charts
        let visibleCells = tableView.visibleCells
        let visibleAnimatableCharts = visibleCells.compactMap { animatableChartInCell($0) }
        
        for chart in visibleAnimatableCharts {
            chart.animateWithDuration(0.5)
        }
        
        
        statusView.center.x -= view.bounds.width
        
        if UserDefaults.standard.bool(forKey: "Survey_Completed") {
            switch UserDefaults.standard.integer(forKey: "Status") {
            case 0:
                statusView.backgroundColor = UIColor.green
                conditionLabel.text = "Normal"
                descriptionLabel.text = "1- Healthy meal plan\n2- Physical activity\n3- Health education\n4- Built environment"
                conditionLabel.sizeToFit()
                descriptionLabel.sizeToFit()
                break
            case 1:
                statusView.backgroundColor = UIColor.orange
                conditionLabel.text = "Overweight"
                descriptionLabel.text = "1- Lifestyle/behavioral therapy\n2- Pharmacotherapy"
                conditionLabel.sizeToFit()
                descriptionLabel.sizeToFit()
                break
            case 2:
                statusView.backgroundColor = UIColor.red
                conditionLabel.text = "Obese"
                descriptionLabel.text = "1- Lifestyle/behavioral therapy\n2- Pharmacotherapy\n3- Consider surgery"
                conditionLabel.sizeToFit()
                descriptionLabel.sizeToFit()
                break
            default:
                conditionLabel.text = "You haven't finished the survey yet!"
                descriptionLabel.text = ""
                conditionLabel.sizeToFit()
                descriptionLabel.sizeToFit()
                break
            }
        } else {
            conditionLabel.text = "You haven't finished the survey yet!"
            descriptionLabel.text = ""
            conditionLabel.sizeToFit()
            descriptionLabel.sizeToFit()
        }
        
        super.viewWillAppear(animated)
        pieChart.animate(withDuration: 0.5)
        discreteGraph.animate(withDuration: 0.5)
        UIView.animate(withDuration: 0.5) {
            self.statusView.center.x += self.view.bounds.width
        }
        
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Animate charts as they're scrolled into view.
        if let animatableChart = animatableChartInCell(cell) {
            animatableChart.animateWithDuration(0.5)
        }
    }
    
    // MARK: Convenience
    
    func animatableChartInCell(_ cell: UITableViewCell) -> AnimatableChart? {
        for chart in allCharts {
            guard let animatableChart = chart as? AnimatableChart , chart.isDescendant(of: cell) else { continue }
            return animatableChart
        }
        
        return nil
    }
}
