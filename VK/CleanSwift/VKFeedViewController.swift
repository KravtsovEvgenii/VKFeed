//
//  VKFeedViewController.swift
//  VK
//
//  Created by User on 15.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol VKFeedDisplayLogic: class {
    func displayData(viewModel: VKFeed.Model.ViewModel.ViewModelData)
}

class VKFeedViewController: UIViewController, VKFeedDisplayLogic {
    @IBOutlet weak var feedTableView: UITableView!
    
    
    var interactor: VKFeedBusinessLogic?
    var router: (NSObjectProtocol & VKFeedRoutingLogic)?
    var postsArray = FeedViewModel(cells: [])
    private var titleView = TitleView()
    private lazy var footerView = FooterView()
    private var refreshControl: UIRefreshControl = {
       let refresh = UIRefreshControl()
        refresh.tintColor = .gray
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return refresh
    }()
    
    @objc func refreshAction() {
        interactor?.makeRequest(request: .getNewsFeed)
    }
    // MARK: Object lifecycle
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = VKFeedInteractor()
        let presenter             = VKFeedPresenter()
        let router                = VKFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    private func setupTableView() {
        feedTableView.contentInset.top = 8
        feedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        feedTableView.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseIdentifier)
        feedTableView.dataSource = self
        feedTableView.delegate = self
        footerView = FooterView(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
        feedTableView.tableFooterView = footerView
        feedTableView.separatorStyle = .none
        feedTableView.backgroundColor = .clear
        feedTableView.refreshControl = refreshControl
    }
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTopBars()
        setupTableView()
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: VKFeed.Model.Request.RequestType.getUser)
    }
    
    //MARK: Setup top Bar
    private func setupTopBars() {
        
        
        //Получаем фрейм статус бара
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let frame = window?.windowScene?.statusBarManager?.statusBarFrame
        
        
        let topBar = UIView(frame: frame!)
        topBar.backgroundColor = .white
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.4
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 8
        self.view.addSubview(topBar)
        
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    
    func displayData(viewModel: VKFeed.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        case .displayNewsFeed (let feed):
            self.postsArray = feed
            footerView.setTitle(feed.footerViewtext)
            feedTableView.reloadData()
            refreshControl.endRefreshing()
        case .displayUser(userModel: let userModel):
            titleView.set(userViewModel: userModel)
        case .displayFooter:
            footerView.showLoader()
        }
    }
    
}
//MARK: Table View
extension VKFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = feedTableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        let cell = feedTableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseIdentifier) as! NewsFeedCodeCell
        let post = postsArray.cells[indexPath.row]
        cell.selectionStyle = .none
        cell.setup(fromPost: post)
        cell.contentView.isUserInteractionEnabled = false
        cell.showDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = postsArray.cells[indexPath.row]
        return  viewModel.postSizes.totalHeight
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = postsArray.cells[indexPath.row]
        return  viewModel.postSizes.totalHeight
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.05 {
            interactor?.makeRequest(request: .getNextBatch)
        }
    }
    
    
}
//MARK: Show more text Delegation
extension VKFeedViewController: NewsfeedCodeCellDelegate {
    func revealPost(for cell: NewsFeedCodeCell) {
        guard let indexPath = feedTableView.indexPath(for: cell)    else{return}
        let item = postsArray.cells[indexPath.row]
        interactor?.makeRequest(request: VKFeed.Model.Request.RequestType.revealPostText(postID: item.postID))
    }
    
}

