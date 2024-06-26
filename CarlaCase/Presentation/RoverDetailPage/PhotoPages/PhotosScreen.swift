//
//  PhotosScreen.swift
//  CarlaCase
//
//  Created by Mina Namlı on 26.06.2024.
//

import UIKit

class PhotosScreen: UIViewController {


    @IBOutlet weak var closeIcon: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    var imageUrls: [String] = []
    var initialIndex: Int = 0
    var pageVC: UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupPageVC()
        setupPageControl()
    }

    func setView(){
        view.backgroundColor = .black.withAlphaComponent(0.2)
        closeIcon.setSystemImage(imgName: "xmark", tintColor: .white)
        closeIcon.isUserInteractionEnabled = true
        let gest = UITapGestureRecognizer(target: self, action: #selector(closeClicked))
        closeIcon.addGestureRecognizer(gest)
    }
    
    func setupPageVC() {
        pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.dataSource = self
        pageVC.delegate = self
        
        if let firstVC = viewControllerAtIndex(initialIndex) {
            let viewControllers = [firstVC]
            pageVC.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        }
        
        addChild(pageVC)
        containerView.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageVC.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 250).isActive = true
        pageVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -250).isActive = true
        pageVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        pageVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }

    func setupPageControl() {
        pageControl.numberOfPages = imageUrls.count
        pageControl.currentPage = initialIndex
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
    }

    @objc func closeClicked() {
        dismiss(animated: true, completion: nil)
    }

    func viewControllerAtIndex(_ index: Int) -> PhotoVC? {
        if imageUrls.isEmpty || index >= imageUrls.count {
            return nil
        }

        let photoViewController = PhotoVC()
        photoViewController.imgUrl = imageUrls[index]
        photoViewController.index = index
        photoViewController.isFullScreen = true
        return photoViewController
    }
}

extension PhotosScreen: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PhotoVC,
              let index = viewController.index, index > 0 else {
            return nil
        }
        return viewControllerAtIndex(index - 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PhotoVC,
              let index = viewController.index, index < imageUrls.count - 1 else {
            return nil
        }
        return viewControllerAtIndex(index + 1)
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
}
