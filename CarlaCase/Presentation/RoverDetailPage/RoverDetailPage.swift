//
//  RoverDetailPage.swift
//  CarlaCase
//
//  Created by Mina Namlı on 26.06.2024.
//

import UIKit

class RoverDetailPage: UIViewController {

    @IBOutlet weak var photosView: UIView!
    @IBOutlet weak var infoTableViw: UITableView!
    
    var roverTitle = ""
    var cameraNum = ""
    var photoNum = ""

    var pageViewController: UIPageViewController!
    var pageControl: UIPageControl!
    
    var roverDetail: [LatestPhoto] = []
    var roverPhotos: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = roverTitle
        setData()
        setPageView()
        setTableView()
        configurePageControl()
    }
    
    func setData(){
        for img in roverDetail {
            self.roverPhotos.append(img.imgSrc)
        }
    }

    func setPageView(){
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self

        if let firstVC = viewControllerAtIndex(0) {
            let viewControllers = [firstVC]
            pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        }
        
        addChild(pageViewController)
        photosView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.topAnchor.constraint(equalTo: photosView.topAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: photosView.bottomAnchor, constant: 20).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: photosView.leadingAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: photosView.trailingAnchor).isActive = true
    }
    
    func configurePageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = roverPhotos.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = AppStyle.color(for: .grayDFDFE7)
        pageControl.currentPageIndicatorTintColor = AppStyle.color(for: .yellowFFD159)
        
        photosView.addSubview(pageControl)
        
        pageControl.bottomAnchor.constraint(equalTo: photosView.bottomAnchor, constant: -10).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: photosView.centerXAnchor).isActive = true
        
    }
    
    func setTableView(){
        infoTableViw.delegate = self
        infoTableViw.dataSource = self
        infoTableViw.separatorStyle = .none
        infoTableViw.allowsSelection = false
        infoTableViw.register(UINib(nibName: "RoverDetailCell", bundle: nil), forCellReuseIdentifier: "RoverDetailCell")
        infoTableViw.register(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "LabelCell")
    }
    
}

extension RoverDetailPage: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PhotoVC,
              let index = viewController.index, index > 0 else {
            return nil
        }
        return viewControllerAtIndex(index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PhotoVC,
              let index = viewController.index, index < roverPhotos.count - 1 else {
            return nil
        }
        return viewControllerAtIndex(index + 1)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return roverPhotos.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = pageViewController.viewControllers?.first as? PhotoVC else {
            return 0
        }
        return firstViewController.index ?? 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let viewController = pageViewController.viewControllers?.first as? PhotoVC,
                  let index = viewController.index else {
                return
            }
            pageControl.currentPage = index
        }
    }
    
    func viewControllerAtIndex(_ index: Int) -> PhotoVC? {
        if roverPhotos.isEmpty || index >= roverPhotos.count {
            return nil
        }
        
        let photoViewController = PhotoVC()
        photoViewController.imgUrl = roverPhotos[index]
        photoViewController.index = index
        return photoViewController
    }
}

extension RoverDetailPage: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 70
        case 1:
            return 108
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return roverDetail.count
        default:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = infoTableViw.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! LabelCell
            cell.setupCell(firstText: Constants.AppStr.cameraNum + cameraNum, secondText: Constants.AppStr.photonum + photoNum, firstAlignment: .left, secondAlignment: .left, firstTextColor: AppStyle.color(for: .gray525266), secondTextColor: AppStyle.color(for: .gray525266), firstFont: AppStyle.interRegular, secondFont: AppStyle.interRegular, firstFontsize: 14, secondFontsize: 14)
            return cell
        case 1:
            let cell = infoTableViw.dequeueReusableCell(withIdentifier: "RoverDetailCell", for: indexPath) as! RoverDetailCell
            cell.setupCell(roverDet: self.roverDetail[indexPath.row], index: indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
