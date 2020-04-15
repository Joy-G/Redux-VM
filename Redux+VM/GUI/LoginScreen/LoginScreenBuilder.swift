
import UIKit

struct LoginScreenBuilder {
    func main(dependencies: Dependencies) -> UIViewController {
        let viewModel = LoginScreenViewModel(dependencies: dependencies)
        let loginScreen = LoginScreenViewController(viewModel: viewModel)
        viewModel.view = loginScreen
        return loginScreen
    }
}
