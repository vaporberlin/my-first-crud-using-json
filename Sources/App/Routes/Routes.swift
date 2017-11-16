import Vapor

extension Droplet {
  func setupRoutes() throws {
    
    let userController = UserController()
    get("user", handler: userController.list)
    post("user", handler: userController.create)
    patch("user", ":id", handler: userController.update)
    delete("user", ":id", handler: userController.delete)
  }
}
