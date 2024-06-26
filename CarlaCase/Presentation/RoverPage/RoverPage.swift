//
//  RoverPage.swift
//  CarlaCase
//
//  Created by Mina Namlı on 25.06.2024.
//

import UIKit

class RoverPage: UIViewController {

    @IBOutlet weak var roversTableView: UITableView!
    
    var roverVM = RoverViewModel()
    var rovers: [Rover] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rovers"
        setTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRovers()
    }
    
    func setTableView(){
        roversTableView.delegate = self
        roversTableView.dataSource = self
        roversTableView.separatorStyle = .none
        roversTableView.allowsSelection = false
        roversTableView.register(UINib(nibName: "RoverCell", bundle: nil), forCellReuseIdentifier: "RoverCell")
        roversTableView.register(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "LabelCell")
    }
    
    func fetchRovers() {
        roversTableView.isHidden = true
        setLoading(startOrStop: .start)
        roverVM.getRovers { success, error in
            DispatchQueue.main.async { [self] in
                if success {
                    self.rovers = roverVM.roversArr
                    roversTableView.isHidden = false
                    roversTableView.reloadData()
                    setLoading(startOrStop: .stop)
                } else {
                    print(error as Any)
                    roversTableView.isHidden = false
                    setLoading(startOrStop: .stop)
                    self.makeAlert(title: Constants.AppStr.dataErrTitle, message: Constants.AppStr.dataErrDesc, buttonTitle: Constants.AppStr.ok)
                }
            }
        }
    }
}

extension RoverPage: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return rovers.count
        default:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = roversTableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! LabelCell
            cell.setupCell(firstText: Constants.AppStr.chooseRover, firstAlignment: .left, firstTextColor: AppStyle.color(for: .gray302F2C), firstFont: AppStyle.interRegular, firstFontsize: 14)
            return cell
        case 1:
            let cell = roversTableView.dequeueReusableCell(withIdentifier: "RoverCell", for: indexPath) as! RoverCell
            cell.delegate = self
            cell.setupCell(rover: self.rovers[indexPath.row],index: indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
}

extension RoverPage: RoverCellDelegate {
    func deactive() {
        self.makeAlert(title: Constants.AppStr.deactiveErrTitle, message: Constants.AppStr.deactiveErrDesc, buttonTitle: Constants.AppStr.ok)
    }
    
    func roverClicked(index: Int) {
        setLoading(startOrStop: .start)
        roverVM.getRoverDetail(roverName: self.rovers[index].name, completion: { success, err in
            if success {
                let vc = RoverDetailPage()
                vc.roverTitle = self.rovers[index].name
                vc.roverDetail = self.roverVM.roverDetail
                vc.cameraNum = " \(self.rovers[index].cameras.count)"
                vc.photoNum = " \(self.rovers[index].totalPhotos)"
                self.setLoading(startOrStop: .stop)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.setLoading(startOrStop: .stop)
            }
        })
    }
    
}
