//
//  DashboardScreenViewModel.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

class DashboardScreenViewModel {
    private let store: Store
    private var currentState: DashboardScreenState?
    weak var view: DashboardView?
    
    private var dataModel: News?
    
    init(dependencies: Dependencies) {
        store = dependencies.store
        store.subscribe(observer: self)
    }
    // MARK: - View functions
    /// Connection view is loaded.
    func viewDidLoad() {
        update(store: store)
    }
    
    var numberOfRows: Int {
        return dataModel?.articles?.count ?? 0
    }
    
    func getCellData(forIndexPath indexPath: IndexPath) -> Article? {
        if let articles = dataModel?.articles, articles.count > indexPath.row {
            return articles[indexPath.row]
        }
        return nil
    }
    
    
    func fetchNews() {
        store.dispatch(action: DashboardScreenAction.fetchingNews)
        ServiceManager.sharedInstance.fetchArticle {[weak self] (news, error) in
            if error == nil {
                self?.dataModel = news
                self?.store.dispatch(action: DashboardScreenAction.reload)
            }
        }
    }
    
    func gotoLogin() {
        store.dispatch(action: LoginScreenAction.reset)
        store.dispatch(action: NavigationScreenAction.switchScreen(screen: .loginScreen, presentation: .replace))
    }
    
}

extension DashboardScreenViewModel: StoreObserver {
    func update(store: Store) {
        guard currentState != store.state.gui.dashboardScreen else {
            return
        }
        currentState = store.state.gui.dashboardScreen
        view?.update(state: store.state.gui.dashboardScreen)
    }
}
