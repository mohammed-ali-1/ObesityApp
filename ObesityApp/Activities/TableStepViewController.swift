//
//  TableStepViewController.swift
//  ObesityApp
//
//  Created by Mohammed Al Ameen on 4/17/18.
//  Copyright © 2018 uos. All rights reserved.
//

import UIKit
import ResearchKit

class TableStepViewController: ORKTableStepViewController {

    let myTableView: UITableView! = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = false
        return tv
    }()
    
    @IBOutlet weak var TableViewFromStoryboard: UITableView!
    
    let bandCellId = "bandCellId"
    
    let bandsArray = [Info(image: "metallica", title: "Metallica"),
                      Info(image: "slipknot", title: "Slipknot"),
                      Info(image: "nirvana", title: "Nirvana"),
                      Info(image: "acdc", title: "AC/DC"),
                      Info(image: "system", title: "System Of A Down")]
    
    let songsArray = [Info(image: "1", title: "The Unforgiven"),
                      Info(image: "2", title: "Snuff"),
                      Info(image: "3", title: "Smells Like Teen Spirit"),
                      Info(image: "4", title: "Back In Black"),
                      Info(image: "5", title: "Chop Suey")]
    
    func tableStep() -> TableStep {
        return self.step as! TableStep
    }
    
    let cellId = "conditionCellId"
    
    let condArray = [Condition(cond: "Condition"    ,   personal: true,     family:     false),
                     Condition(cond: "Diabetes"     ,   personal: true,     family:     false),
                     Condition(cond: "Depression"   ,   personal: true,     family:     true)]
    
    
    func setupTableView(){
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(ConditionCell.self, forCellReuseIdentifier: cellId)
        
//        view.addSubview(myTableView)
//        myTableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
            view.addSubview(TableViewFromStoryboard)
        TableViewFromStoryboard.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupNavigationBar()
        setupTableView()
    }
    
    
    func setupNavigationBar() {
        navigationItem.title = "Mohammed Al-Ameen"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 255, blue: 198, alpha: 0.7)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return condArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = myTableView.dequeueReusableCell(withIdentifier: bandCellId) as! BandCell
//        cell.pictureImageView.image = UIImage(named: bandsArray[indexPath.item].image!)
//        cell.titleLabel.text = bandsArray[indexPath.item].title
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: cellId) as! ConditionCell
        cell.conditionLabel.text = condArray[indexPath.item].cond
        cell.personalButton.setTitle(condArray[indexPath.item].personal! ? "YES" : "NO", for: .normal)
        cell.familyButton.setTitle(condArray[indexPath.item].family! ? "YES" : "NO", for: .normal)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Family and personal medical history"
    }
    
    
    
}

class ConditionCell: UITableViewCell {
    
    let condCell: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.setCellShadow()
        return view
    }()
    
    let conditionLabel: UILabel = {
        let ul = UILabel()
        ul.text = "Name"
        ul.textColor = UIColor.black
        ul.font = UIFont.boldSystemFont(ofSize: 16)
        return ul
    }()
    
    let personalButton: UIButton = {
        let pb = UIButton()
        pb.setTitle("Personal", for: .normal)
        pb.setTitleColor(UIColor.red, for: .normal)
        pb.layer.borderWidth = 1
        return pb
    }()
    
    let familyButton: UIButton = {
        let fb = UIButton()
        fb.setTitle("Family", for: .normal)
        fb.setTitleColor(UIColor.red, for: .normal)
        fb.layer.borderWidth = 1
        return fb
    }()
    
    let persLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal medical history"
        label.textColor = UIColor.red
        return label
    }()
    
    let famLabel: UILabel = {
        let label = UILabel()
        label.text = "Family medical history"
        label.textColor = UIColor.red
        return label
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        backgroundColor = UIColor.cyan
        addSubview(condCell)
        
        condCell.addSubview(conditionLabel)
        condCell.addSubview(personalButton)
        condCell.addSubview(familyButton)
        
        condCell.addSubview(persLabel)
        condCell.addSubview(famLabel)
        
        condCell.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 4, paddingRight: 8)
        
        conditionLabel.setAnchor(top: nil, left: condCell.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0)
        
        conditionLabel.centerYAnchor.constraint(equalTo: condCell.centerYAnchor).isActive = true
        
        familyButton.setAnchor(top: nil, left: personalButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        
        familyButton.centerYAnchor.constraint(equalTo: condCell.centerYAnchor).isActive = true
        
        personalButton.setAnchor(top: nil, left: conditionLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        
        personalButton.centerYAnchor.constraint(equalTo: condCell.centerYAnchor).isActive = true
        
//        persLabel.centerYAnchor.constraint(equalTo: personalButton.centerYAnchor).isActive = true
        persLabel.setAnchor(top: personalButton.bottomAnchor, left: condCell.leftAnchor, bottom: condCell.bottomAnchor, right: condCell.rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 0)
        
//        famLabel.centerYAnchor.constraint(equalTo: familyButton.centerYAnchor).isActive = true
//        famLabel.setAnchor(top: familyButton.bottomAnchor, left: nil, bottom: nil, right: condCell.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0)
    }
}


class BandCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.setCellShadow()
        return view
    }()
    
    let pictureImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup(){
        backgroundColor = UIColor(r: 245, g: 245, b: 245)
        addSubview(cellView)
        
        cellView.addSubview(pictureImageView)
        cellView.addSubview(titleLabel)
        
        cellView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 4, paddingRight: 8)
        
        pictureImageView.setAnchor(top: nil, left: cellView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        pictureImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        titleLabel.setAnchor(top: nil, left: pictureImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 40)
        
        titleLabel.centerYAnchor.constraint(equalTo: pictureImageView.centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implemented!")
    }

}
